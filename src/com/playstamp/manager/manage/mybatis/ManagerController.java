package com.playstamp.manager.manage.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.manager.manage.ManagerList;
import com.playstamp.manager.manage.Manager;


@Controller
public class ManagerController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 관리자 리스트 조회
	@RequestMapping("/managerlist.action")
	public String managerList(ModelMap model) throws SQLException
	{
		String result = "";
		
		// 리스트 담아오기
		IManager dao = sqlSession.getMapper(IManager.class);
		ArrayList<ManagerList> managerList = dao.managerList();
		
		// addAttribute 를 통해 전송
		model.addAttribute("managerList", managerList);
		
		result = "/WEB-INF/views/manager/ManagerList.jsp";
		return result;
	}
	
	// 관리자 중복 아이디 확인
	@ResponseBody
	@RequestMapping(value="/checkmngid.action", method=RequestMethod.POST)
	public String managerIdCheck(@RequestParam("mngId") String mngId)
	{
		String str = "";
		
		IManager dao = sqlSession.getMapper(IManager.class);
		
		int result = 0;
		try
		{
			result = dao.managerIdCheck(mngId);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		if(result!=0) // 이미 존재하는 아이디
			str = "NO";
		else
			str = "YES";
		
		return str;
	}
	
	@RequestMapping("/managerinsertform.action")
	public String managerInsertFrom()
	{
		String result = "";
		
		result = "/WEB-INF/views/manager/ManagerInsertForm.jsp";
		
		return result;
	}
	
	// 관리자 등록
	@RequestMapping("/managerinsert.action")
	public String managerInsert(@ModelAttribute("manager") Manager manager) throws ClassNotFoundException, SQLException
	{
		String result = "";
		IManager dao = sqlSession.getMapper(IManager.class);
	 
		dao.managerInsert(manager);
	
		result = "redirect:managerlist.action";
		return result;
	}
	
	// 관리자 수정 폼
	@RequestMapping(value="/managerupdateform.action", method = RequestMethod.GET)
	public String managerUpdateForm(String mng_id, Model model)
	{
		String result = "";
		IManager dao = sqlSession.getMapper(IManager.class);
	 
		Manager managerInfo = dao.managerInfo(mng_id);
		
		model.addAttribute("manager", managerInfo);
	
		result = "/WEB-INF/views/manager/ManagerUpdateForm.jsp";
		return result;
	}
	
	// 관리자 수정
	@RequestMapping(value="/managerupdate.action", method = RequestMethod.POST)
	public void managerUpdate(@ModelAttribute("manager") Manager manager, HttpServletResponse response) throws SQLException, IOException
	{
		IManager dao = sqlSession.getMapper(IManager.class);
	 
		dao.managerUpdate(manager);
	
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		printwriter.print("<script>alert('관리자 정보 수정이 완료됐습니다.');"
				+ "location.href='managerlist.action'</script>");
		printwriter.flush();
		printwriter.close();
	}
	
	// 관리자 삭제
	@RequestMapping(value="/managerdelete.action", method = RequestMethod.POST)
	public void managerDelete(@RequestParam("checkManager") String[] checkManager, HttpServletResponse response) throws IOException
	{
		IManager dao = sqlSession.getMapper(IManager.class);
		
		for (String mng_id : checkManager)
		{
			System.out.println("사용자 삭제 : " + mng_id);
			dao.managerDelete(mng_id);
		}
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		printwriter.print("<script>alert('관리자 삭제가 완료됐습니다.');"
				+ "location.href='managerlist.action'</script>");
		printwriter.flush();
		printwriter.close();
	}
	
}
