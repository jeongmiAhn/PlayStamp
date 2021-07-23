package com.playstamp.manager.home.mybatis;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.manager.home.ManagerHome;
import com.playstamp.manager.report.mybatis.IManagerReportDAO;
import com.playstamp.myspace.MySpace;
import com.playstamp.myspace.MySpaceComp;
import com.playstamp.myspace.mybatis.IMyspaceDAO;

@Controller
public class ManagerHomeController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 관리자 홈페이지 로드 및 총 회원 수, 총 리뷰 수 조회, 신고 처리 필요 리스트 조회
	@RequestMapping(value = "/managerhome.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String managerhome(Model model)
	{
		IManagerHomeDAO dao = sqlSession.getMapper(IManagerHomeDAO.class);
		
		int total = dao.fiveCheckTotal();
		
		try
		{
			model.addAttribute("countUser", dao.countUser());
			model.addAttribute("countPlayRev", dao.countPlayRev());
			model.addAttribute("checkList", dao.fiveCheckList(total));  //-- 확인 필요 신고 리스트
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return "/WEB-INF/views/manager/ManagerHome.jsp";
	}
	
	
	// 가입 회원 통계 페이지
	@RequestMapping(value = "/statisticsuserview.action", method= RequestMethod.GET)
	public String statisticsuserview()
	{	
		String result = "";
		
		result =  "WEB-INF/views/manager/StatisticsUserView.jsp";
		
		return result;
	}
	
	// 방문 회원 통계 페이지
	@RequestMapping(value = "/statisticsvisitorview.action", method= RequestMethod.GET)
	public String statisticsvisitorview()
	{	
		String result = "";
		
		result =  "WEB-INF/views/manager/StatisticsVisitorView.jsp";
		
		return result;
	}
	
	// 사용자 통계 페이지 액션
	@ResponseBody
	@RequestMapping(value="/statisticsmanager.action", method=RequestMethod.GET)
	public Map<String, Object> statisticYear(@RequestParam("userYear") String year)
	{
		// 이동할 때 다 조회하고 담아서 가져가야 함
		// 데이터 조회를 위해 넘겨줄 현재 년도 얻어오기
		Map<String, Object> map = new HashMap<String, Object>();
		
		IManagerHomeDAO dao = sqlSession.getMapper(IManagerHomeDAO.class);
		
		// 전체 가입 회원 수 얻어오기
		ManagerHome statisticsUserTotal = dao.statisticsUserTotal(year);
		
		// 전체 방문 회원 수 얻어오기
		ManagerHome statisticsVisitorTotal = dao.statisticsVisitorTotal(year);
		
		map.put("userTotal", statisticsUserTotal);
		map.put("visitorTotal", statisticsVisitorTotal);
		
		return map;
	}
	

	// 관리자 로그아웃
	@RequestMapping("/managerlogout.action")
	public String managerLogout(HttpSession session)
	{ 
		String result = ""; 
		session.invalidate();

		result = "redirect:home.action";
		
		return result;
	}

}