package com.playstamp.myspacejjim.mybatis;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.playstamp.myspacejjim.MyspaceJjim;
import com.playstamp.play.mybatis.IPlayListDAO;
import com.playstamp.playdetail.Jjim;


@Controller
public class MyspaceJjimController
{
	@Autowired
	private SqlSession sqlSession;
	
	//@@ 
	@RequestMapping(value="/myspacejjim.action")
	public String getMyspaceJjim(HttpSession session, ModelMap model)
	{
		IMyspaceJjimDAO dao = sqlSession.getMapper(IMyspaceJjimDAO.class);
		
		String user_cd = (String)session.getAttribute("code");
		
		Jjim jjim = new Jjim();
		
		jjim.setUser_cd(user_cd);
		model.addAttribute("myspaceJjim", dao.getMyspaceJjimList(jjim));
		
		return "WEB-INF/views/myspace/MyspaceJjim.jsp";
	}	 
}

