package com.playstamp.notice.mybatis;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.playstamp.faq.mybatis.IFaqDAO;
import com.playstamp.notice.Notice;

@Controller
public class NoticeController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/notice.action", method = RequestMethod.GET)
	public String getNoticeList(ModelMap model)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class); 
		
		model.addAttribute("list", dao.getNoticeList());
		
		return "WEB-INF/views/manager/Notice.jsp";
	}
	
	@RequestMapping(value="/usernotice.action", method = RequestMethod.GET)
	public String getUserNoticeList(ModelMap model)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class); 
		
		model.addAttribute("list", dao.getNoticeList());
		
		return "WEB-INF/views/main/UserNotice.jsp";
	}
	
	@RequestMapping(value="noticeinsert.action", method=RequestMethod.POST)
	public String noticeInsert(Notice notice)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
		
		String contents = notice.getContents();
		contents = contents.replace("\r\n","<br>");
		
		notice.setContents(contents);
		
		dao.addNotice(notice);
		
		return "redirect:notice.action";
	}
	
	//@@ GET 방식으로 데이터 받아 왔으므로 method 에 GET 적어 줘야 함.
	@RequestMapping(value="noticedelete.action", method=RequestMethod.GET)
	public String noticeDelete(Notice notice)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
		
		dao.deleteNotice(notice);
		
		return "redirect:notice.action";
	}
	
	@RequestMapping(value="noticeupdate.action", method=RequestMethod.POST)
	public String noticeUpdate(Notice notice, HttpServletRequest request)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
		
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n","<br>");
		
		notice.setContents(contents);
		
		//System.out.println(notice.getContents());
		dao.updateNotice(notice);
		
		
		return "redirect:notice.action";
	}
	
	@RequestMapping(value="noticeinsertform.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String noticeInsertForm()
	{
		String result = "";
		
		result = "WEB-INF/views/manager/NoticeInsertForm.jsp";
				
		return result;
	}

	@RequestMapping(value="noticeupdateform.action", method= RequestMethod.GET)
	public String noticeUpdateForm(Notice notice, ModelMap model)
	{
		INoticeDAO dao = sqlSession.getMapper(INoticeDAO.class);
		String result = "";
			
		result = "WEB-INF/views/manager/NoticeUpdateForm.jsp";
		model.addAttribute("notice", dao.searchNotice(notice));
		
		return result;
	}
	
	
}
