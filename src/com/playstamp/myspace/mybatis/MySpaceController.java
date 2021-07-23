
package com.playstamp.myspace.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.myspace.Cash;
import com.playstamp.myspace.MySpace;
import com.playstamp.myspace.MySpaceComp;
import com.playstamp.myspace.Point;
import com.playstamp.paging.Criteria;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;
import com.playstamp.user.User;
import com.playstamp.user.mybatis.IUserDAO;


@Controller
public class MySpaceController
{
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/myspace.action")
	public String myspaceView(HttpSession session, ModelMap model) throws SQLException
	{
		String result = "";
		
		// 세션 객체 안에 있는 ID 정보 저장
		String userId = (String)session.getAttribute("id");
		String userCode = (String)session.getAttribute("code");

		// 회원 정보 조회
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		User userInfo = dao.searchUserInfo(userId);
		
		// 나의 포인트 조회
		int userPoint = 0;
		if(dao.userPoint(userCode) != 0)
			userPoint = dao.userPoint(userCode);

		// 나의 캐시 조회
		int userCash = 0;
		if(dao.userCash(userCode) != 0)
			userCash = dao.userCash(userCode);

		// 나의 리뷰 개수 조회
		int userRev = 0;
		if(dao.countingRev(userCode) != 0)
			userRev = dao.countingRev(userCode);

		// 나의 찜 개수 조회
		int userJjim = 0;
		if(dao.countingJjim(userCode) != 0)
			userJjim = dao.countingJjim(userCode);

		
		// 얻어온 정보 저장
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("userPoint", userPoint);
		model.addAttribute("userCash", userCash);
		model.addAttribute("userRev", userRev);
		model.addAttribute("userJjim", userJjim);
		
		result = "/WEB-INF/views/myspace/MySpaceHome.jsp";
		return result;
	}
	
	// 사용자 포인트 내역
	@RequestMapping(value="/pointlist.action", method=RequestMethod.GET)
	public String userPointList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		// 포인트 리스트 받아오기
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		
		// 유저 코드 받아오기
		String user_cd = (String)session.getAttribute("code");
		
		// 포인트 총 개수 받아오기
		int total = dao.userPointListTotal(user_cd);
		
		// 현재 포인트 받아오기
		int userPoint = 0;
		if(dao.userPoint(user_cd) != 0)
			userPoint = dao.userPoint(user_cd);
		
		// 페이지로부터 pageNum, amount 받아오기
		String pageNum = request.getParameter("pageNum");
		String amount = request.getParameter("amount");
						
		// 처음 페이지가 로드되었을 때는 pageNum, amount가 null 이므로
		// (사용자가 아직 페이지 번호를 누르지 않았기 때문에)
		// 1페이지에 10개의 글이 보이도록 설정한다.
		if(pageNum==null || amount==null)
		{
			pageNum="1";
			amount="10";
		}
		
		// 페이지 번호 누를 때마다 그에 해당하는 글을 가져오기 위한 객체 준비
		ReverseCriteria rc = new ReverseCriteria();
		
		rc.setPageNum(Integer.parseInt(pageNum));
		rc.setAmount(Integer.parseInt(amount));
		rc.setTotal(total);
		rc.setUser_cd(user_cd);
		
		ArrayList<Point> plist = dao.userPointList(rc);
		
		model.addAttribute("checkList", plist);
		model.addAttribute("checkPageMaker", new PageDTO(cri, total));
		model.addAttribute("userPoint", userPoint);
				
		return "/WEB-INF/views/myspace/PointList.jsp";

	}
	
	// 사용자 캐시 내역
	@RequestMapping(value="/cashlist.action", method=RequestMethod.GET)
	public String userCashList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		
		// 캐시 리스트 받아오기
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		
		// 유저 코드 받아오기
		String user_cd = (String)session.getAttribute("code");
		
		// 캐시 총 개수 받아오기
		int total = dao.userCashListTotal(user_cd);

		// 현재 캐시 받아오기
		int userCash = 0;
		if(dao.userCash(user_cd) != 0)
			userCash = dao.userCash(user_cd);
		
		// 페이지로부터 pageNum, amount 받아오기
		String pageNum = request.getParameter("pageNum");
		String amount = request.getParameter("amount");
						
		// 처음 페이지가 로드되었을 때는 pageNum, amount가 null 이므로
		// (사용자가 아직 페이지 번호를 누르지 않았기 때문에)
		// 1페이지에 10개의 글이 보이도록 설정한다.
		if(pageNum==null || amount==null)
		{
			pageNum="1";
			amount="10";
		}
		
		// 페이지 번호 누를 때마다 그에 해당하는 글을 가져오기 위한 객체 준비
		ReverseCriteria rc = new ReverseCriteria();
		
		rc.setPageNum(Integer.parseInt(pageNum));
		rc.setAmount(Integer.parseInt(amount));
		rc.setTotal(total);
		rc.setUser_cd(user_cd);
		
		ArrayList<Cash> clist = dao.userCashList(rc);
		
		model.addAttribute("checkList", clist);
		model.addAttribute("checkPageMaker", new PageDTO(cri, total));
		model.addAttribute("userCash", userCash);
		
		return "/WEB-INF/views/myspace/CashList.jsp";

	}
	
	// 사용자 정보 조회
	@RequestMapping("/myprofile.action")
	public String searchUserInfo(HttpSession session, Model model) throws SQLException
	{
		String result = "";
		
		// 세션 객체 안에 있는 ID 정보 저장
		String userId = (String)session.getAttribute("id");
		String userCode = (String)session.getAttribute("code");
		//System.out.println("회원 세션에서 얻은 아이디 : " + userId);
		
		// 회원 정보 보기 호출
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		User userInfo = dao.searchUserInfo(userId);
		
		// 나의 포인트 조회
		int userPoint = 0;
		userPoint = dao.userPoint(userCode);
	
				
		// addAttribute 를 통해 전송
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("userPoint", userPoint);
		
		result = "/WEB-INF/views/myspace/MyProfileForm.jsp";

		return result;
	}
	
	// 사용자 정보 업데이트
	@ResponseBody
	@RequestMapping(value="/update.action", method=RequestMethod.POST)
	public void updateUserInfo(User user, Model model, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException
	{
		
		System.out.println("업데이트 진입");
		System.out.println("닉네임 : " + user.getUser_Nick());
		System.out.println("아이디 : " + user.getUser_Id());
		System.out.println("메일 : " + user.getUser_Mail());

		// 회원 정보 업데이트 호출
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		dao.updateUserInfo(user);
		
		HttpSession session = request.getSession();
		session.setAttribute("nick", user.getUser_Nick());
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		printwriter.print("<script>alert('정보 수정이 완료됐습니다.');"
				+ "location.href='myprofile.action'</script>");
		printwriter.flush();
		printwriter.close();
		
	}
	
	// 사용자 프로필 사진 수정
	@RequestMapping("/uploadimg.action")
    public void uploadUserImg(HttpSession session, HttpServletResponse response) throws SQLException, IOException
	{
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		String userId = (String)session.getAttribute("id");
		String userImg = (String)session.getAttribute("userProfile");
		
		dao.updateUserImg(userId, userImg);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		printwriter.print("<script>alert('정보 수정이 완료됐습니다.');"
				+ "location.href='myprofile.action'</script>");
		printwriter.flush();
		printwriter.close();
	}
	
	// 관람 통계 페이지로 이동
	@RequestMapping("/mystatisticlist.action")
	public String statisticView()
	{
		String result = "";
		
		result = "/WEB-INF/views/myspace/MyStatisticList.jsp";

		return result;
	}
	
	
	// 관람 통계 페이지로 이동
	@ResponseBody
	@RequestMapping(value="mystatistic.action", method=RequestMethod.GET)
	public Map<String, Object> statisticYear(@RequestParam("userYear") String year, HttpSession session)
	{
		
		// 이동할 때 다 조회하고 담아서 가져가야 함
		// 데이터 조회를 위해 넘겨줄 현재 년도와 사용자 코드 얻어오기
		String code = (String)session.getAttribute("code");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		
		// 전체 관람 횟수 얻어오기
		MySpace statisticRevTotal = dao.statisticRevTotal(year);
		// 사용자 관람 횟수 얻어오기
		MySpace statisticRevUser = dao.statisticRevUser(year, code);
		
		// 전체 사용자 수 얻어오기
		int totalUser = dao.totalUser();
		
		// 사용자 동행인 얻어오기
		MySpaceComp comp = dao.statisticCompanion(year, code);
		
		// 사용자 관람 금액 얻어오기
		MySpace statisticMoney = dao.statisticMoney(year, code);
		
		
		map.put("revTotal", statisticRevTotal);
		map.put("revUser", statisticRevUser);
		map.put("u", totalUser);
		map.put("comp", comp);
		map.put("revMoney", statisticMoney);
		
		return map;
	}

	
	// 탈퇴 페이지로 이동
	@RequestMapping("/dropform.action")
	public String dropView()
	{
		String result = "";
		
		result = "/WEB-INF/views/myspace/DropForm.jsp";

		return result;
	}
	
	
	// 탈퇴하기 전 체크
	@RequestMapping(value="/userdrop.action", method=RequestMethod.POST)
	public void dropCheck(Model model, HttpSession session , HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException
	{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		int y = Integer.parseInt(request.getParameter("backup_y"));
		String pw = request.getParameter("user_Pw");
		
		// 사용자 정보 담아두기
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		
		// 비밀번호 확인
		IUserDAO userDao = sqlSession.getMapper(IUserDAO.class);
		String str = userDao.userLogin(id, pw);
		
		// 탈퇴용
		IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
		
		if(str!=null) // 비밀번호가 맞다면 탈퇴 진행
		{
			// 탈퇴 진행 전 캐시 값 확인
			
			// 캐시 리스트 받아오기
			ArrayList<Cash> cashList = new ArrayList<Cash>();
			//cashList = dao.userCashList(id);
			
			// 리스트 제일 앞에 있는 값 꺼내기 = 현재 캐시
			int userCash = 0;
			if( cashList.size()!=0){
				userCash = Integer.parseInt(cashList.get(0).getUser_cash());
			}
			
			if(userCash==0)
			{
				// 유저 테이블에서 삭제
				dao.userDropProcedure(code, y);
				System.out.println("테이블 내 삭제 성공");
				
				// 세션 털어주기
				session.invalidate();
				System.out.println("세션 털어잇");
				
				// 안내 후 메인으로 이동
				printwriter.print("<script>alert('탈퇴가 완료됐습니다. 플레이스탬프를 이용해주셔서 감사합니다.');"
						+ "location.href='home.action'</script>");
				printwriter.flush();
				printwriter.close();
			}
			else
			{
				printwriter.print("<script>alert('캐시 잔액이 있어 탈퇴를 진행할 수 없습니다.');"
						+ "location.href='dropcashcheck.action'</script>");
				printwriter.flush();
				printwriter.close();
			}
			
		}
		else
		{
			printwriter.print("<script>alert('비밀번호를 다시 확인해주세요.');"
					+ "location.href='dropform.action'</script>");
			printwriter.flush();
			printwriter.close();
		}
		
		
	}
	
	// 탈퇴하기 전 캐시 잔액 안내
	@RequestMapping("/dropcashcheck.action")
	public String dropCashCheckView()
	{
		String result = "";
		
		result = "/WEB-INF/views/myspace/DropCashCheck.jsp";

		return result;
	}
}
