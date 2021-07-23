package com.playstamp.manager.report.mybatis;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.playstamp.manager.report.DetailReport;
import com.playstamp.paging.Criteria;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;

@Controller
public class ManagerReportController
{
	@Autowired
	private SqlSession sqlSession;
	
	// PageDTO를 사용할 수 있도록 Model에 담아서 화면에 전달하는 메소드
	// 신고된 글 (확인 필요) 가져오기
	@RequestMapping(value="/managerreport.action", method=RequestMethod.GET)
	public String adminReportList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
	
		
		// 한 페이지에 보여지게 할 게시물 수, 특정한 페이지 조회시 사용하기 위해
		// Criteria 객체 생성 (매개변수로 받음)
		
		// 신고당한 글들 개수 가져오기 (처리 안 된 것만)
		int total = dao.checkListTotal();
		
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
	
		model.addAttribute("checkList", dao.checkList(rc));
		
		// 신고당한 글의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("checkPageMaker", new PageDTO(cri, total));
	
		return "WEB-INF/views/manager/ManagerReportCheck.jsp";
	}

	
	// 처리 완료 신고글 가져오기
	@RequestMapping(value="/donemanagerreport.action", method=RequestMethod.GET)
	public String doneAdminReportList(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 한 페이지에 보여지게 할 게시물 수, 특정한 페이지 조회시 사용하기 위해
		// Criteria 객체 생성 (매개변수로 받음)
		
		// 관리자가 처리 완료한 글들 개수 가져오기
		int total = dao.doneListTotal();
		
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
		
		// 처리 완료한 전체 글 담기
		model.addAttribute("doneList", dao.doneList(rc));
		
		// 댓글 단 리뷰의 전체 데이터 수 받아 PageDTO 구성해서 넘기기
		model.addAttribute("donePageMaker", new PageDTO(cri, total));
		
		
		return "WEB-INF/views/manager/ManagerReportDone.jsp";
	}
	
	// 확인 필요 리스트에서 신고된 댓글 정보 확인하기
	@RequestMapping(value="/commentreport.action", method=RequestMethod.GET)
	public String commentReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 글 번호 받기
		String rep_cd = request.getParameter("rep_cd");
		
		System.out.println(rep_cd);
		
		// 받은 글 번호(댓글 코드)로 댓글 상세 내용 가져와 전달하기
		model.addAttribute("commentReport", dao.commentReport(rep_cd));
		
		
		return "WEB-INF/views/manager/CommentReport.jsp";
	}
	
	// 확인 필요 리스트에서 신고된 게시판이 공연 리뷰인 경우 리뷰 상세글로 이동
	@RequestMapping(value="/reviewreport.action", method=RequestMethod.GET)
	public String reviewReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 리뷰 식별 번호 받기
		String rep_cd = request.getParameter("rep_cd");
		
		// 받은 글 번호(댓글 코드)로 댓글 상세 내용 가져와 전달하기
		model.addAttribute("reviewReport", dao.reviewReport(rep_cd));
		
		return "WEB-INF/views/manager/ReviewReport.jsp";
	}
	
	// 확인 필요 리스트에서 신고된 게시판이 좌석 리뷰인 경우 좌석 내용 가져오기
	@RequestMapping(value="/seatreport.action", method=RequestMethod.GET)
	public String seatReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 리뷰 식별 번호 받기
		String rep_cd = request.getParameter("rep_cd");
		
		
		// 받은 글 번호(댓글 코드)로 댓글 상세 내용 가져와 전달하기
		model.addAttribute("seatReport", dao.seatReport(rep_cd));
		
		return "WEB-INF/views/manager/SeatReport.jsp";
	}
	
	// 확인 필요 리스트에서 신고된 게시판이 5대 좌석 리뷰인 경우 리뷰 상세글로 이동
	@RequestMapping(value="/mseatreport.action", method=RequestMethod.GET)
	public String mseatReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 리뷰 식별 번호 받기
		String rep_cd = request.getParameter("rep_cd");
		
		System.out.println(rep_cd);
		
		// 받은 글 번호(댓글 코드)로 댓글 상세 내용 가져와 전달하기
		model.addAttribute("seatReport", dao.mseatReport(rep_cd));
		
		return "WEB-INF/views/manager/MSeatReport.jsp";
	}
	
	// 신고된 댓글 내역에서 관리자가 확인 처리한 경우
	@RequestMapping(value="/checkcommreport.action", method=RequestMethod.POST)
	public String checkCommReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);

		// 이전 페이지로부터 정보 받아오기
		String rep_cd = request.getParameter("rep_cd");
		String writer_cd = request.getParameter("writer_cd");
		String reporter_cd = request.getParameter("reporter_cd");
		
		// 최종 신고 사유, 신고 승인 여부는 select 선택이므로 배열으로 받을 준비
		String rep_st_cd = "";
		String rep_y_cd = "";
		
		String[] repSTarr = request.getParameterValues("rep_st_cd");   //-- 승인(1) 반려(2)
		String[] repYarr = request.getParameterValues("rep_y_cd");	   //-- 최종 신고 사유

		// 선택한 것 꺼내기
		if(repSTarr != null)
		{
			for(String list : repSTarr)
				rep_st_cd += list;
		}
		if(repYarr != null)
		{
			for(String list : repYarr)
				rep_y_cd += list;
		}
		
		// 가져온 정보 담기
		DetailReport dr = new DetailReport();
		dr.setRep_cd(rep_cd);
		dr.setRep_st_cd(rep_st_cd);
		dr.setRep_y_cd(rep_y_cd);
		
		// 댓글 신고 처리 테이블에 insert
		dao.commentDone(dr);
		
		// 승인인 경우, 피신고자(글작성자) 포인트 차감
		if(rep_st_cd=="1")
			 dao.writerPointMinus(writer_cd);
			
		// 반려인 경우, 신고자 포인트 차감
		if(rep_st_cd=="2")
			dao.reporterPointMinus(reporter_cd);
		
		// 관리자의 처리 완료 페이지로 이동
		return "redirect:donemanagerreport.action";
	}
	
	// 신고된 리뷰 내역에서 관리자가 확인 처리한 경우
	@RequestMapping(value="/checkreviewreport.action", method=RequestMethod.POST)
	public String checkReviewReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);
		
		// 이전 페이지로부터 정보 받아오기
		String rep_cd = request.getParameter("rep_cd");
		String writer_cd = request.getParameter("writer_cd");
		String reporter_cd = request.getParameter("reporter_cd");
		
		// 최종 신고 사유, 신고 승인 여부는 select 선택이므로 배열으로 받을 준비
		String rep_st_cd = "";
		String rep_y_cd = "";
		
		String[] repSTarr = request.getParameterValues("rep_st_cd");   //-- 승인(1) 반려(2)
		String[] repYarr = request.getParameterValues("rep_y_cd");	   //-- 최종 신고 사유

		// 선택한 것 꺼내기
		if(repSTarr != null)
		{
			for(String list : repSTarr)
				rep_st_cd += list;
		}
		if(repYarr != null)
		{
			for(String list : repYarr)
				rep_y_cd += list;
		}
		
		// 가져온 정보 담기
		DetailReport dr = new DetailReport();
		dr.setRep_cd(rep_cd);
		dr.setRep_st_cd(rep_st_cd);
		dr.setRep_y_cd(rep_y_cd);
		
		// 리뷰 신고 처리 테이블에 insert
		dao.reviewDone(dr);
		
		// 승인인 경우, 피신고자(글작성자) 포인트 차감
		if(rep_st_cd=="1")
			 dao.writerPointMinus(writer_cd);
			
		// 반려인 경우, 신고자 포인트 차감
		if(rep_st_cd=="2")
			dao.reporterPointMinus(reporter_cd);
		
		
		return "redirect:donemanagerreport.action";
	}
	
	// 신고된 좌석 리뷰 내에서 관리자가 확인 처리한 경우
	@RequestMapping(value="/checkseatreport.action", method=RequestMethod.POST)
	public String checkSeatReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);

		// 이전 페이지로부터 정보 받아오기
		String rep_cd = request.getParameter("rep_cd");
		String writer_cd = request.getParameter("writer_cd");
		String reporter_cd = request.getParameter("reporter_cd");
		
		// 최종 신고 사유, 신고 승인 여부는 select 선택이므로 배열으로 받을 준비
		String rep_st_cd = "";
		String rep_y_cd = "";
		
		String[] repSTarr = request.getParameterValues("rep_st_cd");   //-- 승인(1) 반려(2)
		String[] repYarr = request.getParameterValues("rep_y_cd");	   //-- 최종 신고 사유

		// 선택한 것 꺼내기
		if(repSTarr != null)
		{
			for(String list : repSTarr)
				rep_st_cd += list;
		}
		if(repYarr != null)
		{
			for(String list : repYarr)
				rep_y_cd += list;
		}
		
		// 가져온 정보 담기
		DetailReport dr = new DetailReport();
		dr.setRep_cd(rep_cd);
		dr.setRep_st_cd(rep_st_cd);
		dr.setRep_y_cd(rep_y_cd);
		
		// 좌석 리뷰 신고 처리 테이블에 insert
		dao.seatDone(dr);
		
		// 승인인 경우, 피신고자(글작성자) 포인트 차감
		if(rep_st_cd=="1")
			 dao.writerPointMinus(writer_cd);
			
		// 반려인 경우, 신고자 포인트 차감
		if(rep_st_cd=="2")
			dao.reporterPointMinus(reporter_cd);
		
		return "redirect:donemanagerreport.action";
	}
	
	// 신고된 5대 좌석 리뷰 내에서 관리자가 확인 처리한 경우
	@RequestMapping(value="/checkmseatreport.action", method=RequestMethod.POST)
	public String checkMseatReport(Model model, HttpServletRequest request)
	{
		IManagerReportDAO dao = sqlSession.getMapper(IManagerReportDAO.class);

		// 이전 페이지로부터 정보 받아오기
		String rep_cd = request.getParameter("rep_cd");
		String writer_cd = request.getParameter("writer_cd");
		String reporter_cd = request.getParameter("reporter_cd");
		
		// 최종 신고 사유, 신고 승인 여부는 select 선택이므로 배열으로 받을 준비
		String rep_st_cd = "";
		String rep_y_cd = "";
		
		String[] repSTarr = request.getParameterValues("rep_st_cd");   //-- 승인(1) 반려(2)
		String[] repYarr = request.getParameterValues("rep_y_cd");	   //-- 최종 신고 사유

		// 선택한 것 꺼내기
		if(repSTarr != null)
		{
			for(String list : repSTarr)
				rep_st_cd += list;
		}
		if(repYarr != null)
		{
			for(String list : repYarr)
				rep_y_cd += list;
		}
		
		// 가져온 정보 담기
		DetailReport dr = new DetailReport();
		dr.setRep_cd(rep_cd);
		dr.setRep_st_cd(rep_st_cd);
		dr.setRep_y_cd(rep_y_cd);
		
		// 5대 좌석 리뷰 신고 처리 테이블에 insert
		dao.mseatDone(dr);
		
		// 승인인 경우, 피신고자(글작성자) 포인트 차감
		if(rep_st_cd=="1")
		   dao.writerPointMinus(writer_cd);
		
		// 반려인 경우, 신고자 포인트 차감
		if(rep_st_cd=="2")
			dao.reporterPointMinus(reporter_cd);
		
		return "redirect:donemanagerreport.action";
	}
}
