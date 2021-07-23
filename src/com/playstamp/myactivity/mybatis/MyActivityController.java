package com.playstamp.myactivity.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.playstamp.myspace.Cash;
import com.playstamp.myspace.Point;
import com.playstamp.myspace.mybatis.IMyspaceDAO;
import com.playstamp.paging.Criteria;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;
import com.playstamp.user.User;

@Controller
public class MyActivityController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 나의 활동 내역 클릭 시 분기 화면 이동
   @RequestMapping(value="/myactivityhome.action", method=RequestMethod.GET)
   public String myActivityHome(ModelMap model, HttpSession session)
   {
      IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
      
      // 세션 객체 안에 있는 ID 정보 저장
      String userId = (String)session.getAttribute("id");
      String userCode = (String)session.getAttribute("code");


      // 회원 정보 조회
      User userInfo = null;
      try
      {
         userInfo = dao.searchUserInfo(userId);
      } catch (SQLException e)
      {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
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
      
      return "WEB-INF/views/myspace/MyActivityHome.jsp";
   }


	
	// 좋아요 누른 리뷰글 가져오기
	@RequestMapping(value="/mylikereviewlist.action", method=RequestMethod.GET)
	public String myLikeReviewlist(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IMyActivityDAO dao = sqlSession.getMapper(IMyActivityDAO.class);
		
		// 로그인 한 사용자 코드 가져오기
		String user_cd = (String) session.getAttribute("code");
		
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
		
		// 좋아요 한 리뷰의 전체 데이터 수 가져오기
		int total = dao.likeReviewCount(user_cd);
				
		// 페이지 번호 누를 때마다 그에 해당하는 글을 가져오기 위한 객체 준비
		ReverseCriteria rc = new ReverseCriteria();
		
		rc.setPageNum(Integer.parseInt(pageNum));
		rc.setAmount(Integer.parseInt(amount));
		rc.setTotal(total);
		rc.setUser_cd(user_cd);
		
		
		// 좋아요 한 리뷰의 전체 글 담기
		//-- 단, 페이지 클릭시마다 해당 내용만 가져올 수 있도록 Criteria를 매개변수로 받음
		model.addAttribute("likeList", dao.getLikeListWithPaging(rc));
		
		// 좋아요 한 리뷰의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("likePageMaker", new PageDTO(cri, total));
		
		
		return "WEB-INF/views/myspace/MyLikeReviewList.jsp";
	}
	
	// 댓글 단 리뷰 글 가져오기
	@RequestMapping(value="/mycommentreviewlist.action", method=RequestMethod.GET)
	public String myCommentReviewlist(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IMyActivityDAO dao = sqlSession.getMapper(IMyActivityDAO.class);
		
		// 로그인 한 사용자 코드 가져오기
		String user_cd = (String) session.getAttribute("code");
		
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
		
		// 좋아요 한 리뷰의 전체 데이터 수 가져오기
		int total = dao.commentReviewCount(user_cd);
				
		// 페이지 번호 누를 때마다 그에 해당하는 글을 가져오기 위한 객체 준비
		ReverseCriteria rc = new ReverseCriteria();
		
		rc.setPageNum(Integer.parseInt(pageNum));
		rc.setAmount(Integer.parseInt(amount));
		rc.setTotal(total);
		rc.setUser_cd(user_cd);
		
		// 댓글 단 리뷰의 전체 글 담기
		model.addAttribute("commentList", dao.getCommentListWithPaging(rc));
		
		// 댓글 단 리뷰의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("commentPageMaker", new PageDTO(cri, total));
		
		return "WEB-INF/views/myspace/MyCommentReviewList.jsp";
	}
	
	// 내가 신고한 글 확인하기
	@RequestMapping(value="/myreportinglist.action", method=RequestMethod.GET)
	public String myReportingList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IMyActivityDAO dao = sqlSession.getMapper(IMyActivityDAO.class);
		
		// 한 페이지에 보여지게 할 게시물 수, 특정한 페이지 조회시 사용하기 위해
		// Criteria 객체 생성 (매개변수로 받음)
		
		// 로그인 한 사용자 아이디 가져오기 (편의상 user_cd로 작성)
		String user_cd = (String) session.getAttribute("id");
		
		// 관리자가 처리 완료한 글들 개수 가져오기
		int total = dao.reportingTotal(user_cd);
		
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
		
		// 처리 완료한 전체 글 담기
		model.addAttribute("List", dao.myReportingList(rc));
		
		// 댓글 단 리뷰의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("PageMaker", new PageDTO(cri, total));
		
		
		return "WEB-INF/views/myspace/MyReportingList.jsp";
	}
	
	// 내가 신고 당한 글 확인하기
	@RequestMapping(value="/myreportedlist.action", method=RequestMethod.GET)
	public String myReportedList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IMyActivityDAO dao = sqlSession.getMapper(IMyActivityDAO.class);
		
		// 로그인 한 사용자 아이디 가져오기 (편의상 user_cd로 작성)
		String user_cd = (String) session.getAttribute("id");
		
		System.out.println(user_cd);
		// 내가 신고 당한 글 총 개수 가져오기
		int total = dao.reportedTotal(user_cd);
		
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
		
		// 처리 완료한 전체 글 담기
		model.addAttribute("List", dao.myReportedList(rc));
		
		// 댓글 단 리뷰의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("PageMaker", new PageDTO(cri, total));
		
		
		return "WEB-INF/views/myspace/MyReportedList.jsp";
	}
	
	
}
