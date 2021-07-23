package com.playstamp.mseat.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.mseat.MSeat;
import com.playstamp.myspace.Point;
import com.playstamp.myspace.mybatis.IMyspaceDAO;

@Controller
public class MSeatController
{
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "/mseat.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String mSeatMain(HttpServletRequest request, HttpServletResponse response) throws IOException	
	{	
		HttpSession session = request.getSession();
		String grade = null;
		grade = (String)session.getAttribute("grade");
		
		try
		{
			if(grade!=null)
			{
				if(grade.equals("우수회원") || grade.equals("준회원") || grade.equals("일반회원"))
				{
					return "WEB-INF/views/MSeatMain.jsp";
				}
				else if(grade.equals("어둠회원") || grade.equals("뉴비"))
				{
					response.setContentType("text/html;charset=utf-8");
					PrintWriter printwriter = response.getWriter();
						
					printwriter.print("<script>alert('일반회원등급 이상 이용이 가능합니다.');history.back();</script>");
					printwriter.flush();
					printwriter.close();
				}
			}	
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	
		return "WEB-INF/views/MSeatMain.jsp";

	}
	
	@RequestMapping(value = "/seatratingprint.action",method= {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String, Object> listSac(@RequestParam Map<String, Object> param) throws SQLException 
	{
		IMSeatDAO dao = sqlSession.getMapper(IMSeatDAO.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		  
		ArrayList<MSeat> listSac = dao.listSac((String)param.get("seatName"));
		ArrayList<MSeat> listBs = dao.listBs((String)param.get("seatName"));
		
		// 테스트
		//System.out.println((String)param.get("seatName"));
		
		map.put("listSac", listSac);
		map.put("listBs", listBs);
		
		return map;	  
	}		 
}
