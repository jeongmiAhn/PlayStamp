/*===========================
 	PlayListController.java
 	- 컨트롤러
============================*/
package com.playstamp.play.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.play.PlayList;

@Controller
public class PlayListController
{
	@Autowired
	private SqlSession sqlSession;
	
	//@@ 공연정보 페이지(뮤지컬 리스트)로 보내 주는 컨트롤러
	@RequestMapping(value="/musicallist.action")
	public String musicalHome()
	{
		return "WEB-INF/views/play/MusicalList.jsp";
	}
	
	//@@ 뮤지컬 리스트 출력 컨트롤러
	@RequestMapping(value="/musicalprint.action", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> getMusicalList(@RequestParam Map<String, Object> param) throws SQLException
	{
		IPlayListDAO dao = sqlSession.getMapper(IPlayListDAO.class);
		  
		Map<String, Object> map = new HashMap<String, Object>();
		  
		ArrayList<PlayList> list = dao.getMusicalList((String)param.get("playState"));
		map.put("result", list);
		  
		return map;	  
	}		 
	
	//@@ 공연정보 페이지(연극 리스트)로 보내 주는 컨트롤러
	@RequestMapping(value="/dramalist.action")
	public String dramaHome()
	{
		return "WEB-INF/views/play/DramaList.jsp";
	}
	
	//@@ 연극 리스트 출력 컨트롤러
	@RequestMapping(value="/dramaprint.action", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> getDramaList(@RequestParam Map<String, Object> param) throws SQLException
	{
		IPlayListDAO dao = sqlSession.getMapper(IPlayListDAO.class);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<PlayList> list = dao.getDramaList((String)param.get("playState"));
		map.put("result", list);
		
		return map;	  
	}		 
}
