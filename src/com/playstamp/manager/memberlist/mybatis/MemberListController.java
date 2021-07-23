package com.playstamp.manager.memberlist.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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

import com.playstamp.manager.memberlist.ManagingPointList;
import com.playstamp.manager.memberlist.MemberList;
import com.playstamp.paging.Criteria;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;

@Controller 
public class MemberListController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 전체 회원 리스트 조회
	@RequestMapping(value = "/memberlist.action", method= RequestMethod.GET)
	public String memberlist(Criteria cri, Model model, HttpSession session, HttpServletRequest request)
	{	
		IMemberListDAO dao = sqlSession.getMapper(IMemberListDAO.class);
		
		int total = dao.membercount();
		
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
		
		model.addAttribute("memberlist", dao.memberlist(rc));
		model.addAttribute("PageMaker", new PageDTO(cri, total));
		
		return "WEB-INF/views/manager/MemberList.jsp";
		
	}
	
	// 회원의 포인트 변경 팝업 띄우기
	@RequestMapping(value = "/modifypointpopup.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String modifypointpopup()
	{	
		return "/WEB-INF/views/manager/ModifyPointPopup.jsp";
	}
	
	
	// 회원의 포인트 변경
	@RequestMapping(value = "/modifypoint.action", method= {RequestMethod.GET, RequestMethod.POST})
	public void modifypoint(HttpServletRequest request, HttpServletResponse response) throws IOException
	{	
		String user_id = request.getParameter("user_id");
		String point = request.getParameter("point");
		
		IMemberListDAO dao = sqlSession.getMapper(IMemberListDAO.class);
		
		dao.modifypoint(user_id, point);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		printwriter.print("<script>alert('수정이 완료되었습니다!');"
	               + "window.opener.location.reload();window.close();</script>");
		printwriter.flush();
		printwriter.close();
		
	}
	
	// 특정 회원의 포인트 내역 조회
	@RequestMapping(value = "/managingpointlist.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String managingpointlist(String user_id, String point, String grade, HttpServletRequest request, ModelMap model, Criteria cri, HttpSession session)
	{
		String result = "";

		String pageNum = request.getParameter("pageNum");
		String amount = request.getParameter("amount");
		
		IMemberListDAO dao = sqlSession.getMapper(IMemberListDAO.class);
		/*
		MemberList memberlist = new MemberList();
		memberlist.setUser_id(user_id);
		*/
		int total = dao.countmanagingpointlist(user_id);
		
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
		rc.setUser_id(user_id);
		
		rc.setPageNum(Integer.parseInt(pageNum));
		rc.setAmount(Integer.parseInt(amount));
		
		// addAttribute 를 통해 전송
		model.addAttribute("user_id", user_id);
		model.addAttribute("point", point);
		model.addAttribute("grade", grade);
		model.addAttribute("pointList", dao.managingpointlist(rc));
		model.addAttribute("PageMaker", new PageDTO(cri, total));
				
		result = "/WEB-INF/views/manager/ManagingPointList.jsp";

		return result;
	}

}
