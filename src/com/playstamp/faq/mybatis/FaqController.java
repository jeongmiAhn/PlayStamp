package com.playstamp.faq.mybatis;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.playstamp.faq.Faq;

@Controller
public class FaqController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="/faq.action", method = RequestMethod.GET)
	public String getFaqList(ModelMap model)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class); 
		
		model.addAttribute("list", dao.getFaqList());
		
		return "WEB-INF/views/manager/Faq.jsp";
	}

	@RequestMapping(value="/userfaq.action", method = RequestMethod.GET)
	public String getUserFaqList(ModelMap model)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class); 
		
		model.addAttribute("list", dao.getFaqList());
		
		return "WEB-INF/views/main/UserFaq.jsp";
	}
	
	
	@RequestMapping(value="faqinsert.action", method=RequestMethod.POST)
	public String faqInsert(Faq faq)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class);
		
		String contents = faq.getContents();
		contents = contents.replace("\r\n","<br>");
		
		faq.setContents(contents);
		
		dao.addFaq(faq);
		
		return "redirect:faq.action";
	}
	
	//@@ GET 방식으로 데이터 받아 왔으므로 method 에 GET 적어 줘야 함.
	@RequestMapping(value="faqdelete.action", method=RequestMethod.GET)
	public String faqDelete(Faq faq)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class);
		
		dao.deleteFaq(faq);
		
		return "redirect:faq.action";
	}
	
	@RequestMapping(value="faqupdate.action", method=RequestMethod.POST)
	public String faqUpdate(Faq faq, HttpServletRequest request)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class);
		
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n","<br>");
		
		faq.setContents(contents);
		
		//System.out.println(Faq.getContents());
		dao.updateFaq(faq);
		
		
		return "redirect:faq.action";
	}
	
	@RequestMapping(value="faqinsertform.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String faqInsertForm()
	{
		String result = "";
		
		result = "WEB-INF/views/manager/FaqInsertForm.jsp";
				
		return result;
	}

	@RequestMapping(value="faqupdateform.action", method= RequestMethod.GET)
	public String faqUpdateForm(Faq faq, ModelMap model)
	{
		IFaqDAO dao = sqlSession.getMapper(IFaqDAO.class);
		String result = "";
			
		result = "WEB-INF/views/manager/FaqUpdateForm.jsp";
		model.addAttribute("faq", dao.searchFaq(faq));
		
		return result;
	}
	
	
}
