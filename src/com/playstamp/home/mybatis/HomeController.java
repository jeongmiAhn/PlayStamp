package com.playstamp.home.mybatis;


import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/home.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String mSeatMain(Model model, HttpServletRequest request)
	{
		IHomeDAO dao = sqlSession.getMapper(IHomeDAO.class);
		
		
		model.addAttribute("highReviewSorting", dao.highReviewSorting());
		model.addAttribute("highRateSorting", dao.highRateSorting());
		model.addAttribute("highLikeSorting", dao.highLikeSorting());
		
		String result = "";
		
		result = "/WEB-INF/views/main/Home.jsp";

		return result;
	}
}
