package com.playstamp.user;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Interceptor extends HandlerInterceptorAdapter
{
	// 로그인체크 제외 리스트 
	static final String[] excludeCheckUrl = {"/signupform.action","/signinform.action", "/home.action", "/login.action", "/logout.action"
											, "/musicallist.action", "/dramalist.action", "/musicalprint.action", "/dramaprint.action"
											, "/memberlist.action", "/modifypointpopup.action", "/modifypoint.action"
											, "/mailcheck.action", "/completesignup.action", "/checkSignup.action", "/managingpointlist.action"
											, "/managerhome.action", "/faq.action", "/notice.action"
											, "/findpw.action", "/selectidpw.action", "/userchangepwform.action", "/userchangepw.action"
											, "/selectfindid.action", "/checkfindidpw.action", "/findid.action"
											, "/statisticsvisitorview.action", "/statisticsuserview.action", "/statisticsmanager.action"
											, "/myreviewlistposter.action", "/managerreport.action"
											, "/checkmngid.action", "/managerinsertform.action", "/managerinsert.action"
											, "/managerupdateform.action", "/managerupdate.action", "/managerdelete.action"
											, "/donemanagerreport.action", "/commentreport.action", "/reviewreport.action"
											, "/seatreport.action", "/mseatreport.action", "/checkcommreport.action"
											, "/checkreviewreport.action", "/checkseatreport.action", "/checkmseatreport.action"
											, "/managerlogout.action", "/userfaq.action", "/usernotice.action"};
	
	// → 고객센터, 검색 결과도 추가해야 함
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		 String reqUrl = request.getRequestURL().toString(); 

		 for( String target : excludeCheckUrl )
		 {
			 if(reqUrl.indexOf(target)>-1)
			 { 
				 //indexOf 이용 URL주소에 로그인체크 제외 주소가 포함되어 있는지 확인
				 return true;
			 }
		 }
		  
		 HttpSession session = request.getSession();
		 String userId = (String)session.getAttribute("id");
		  
		 if(userId==null || userId.trim().equals(""))
		 {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printwriter = response.getWriter();
			
			System.out.println("비회원 등장");
			printwriter.print("<script>alert('로그인 후 이용해주세요');"
		               + "location.href='signinform.action'</script>");
			printwriter.flush();
			printwriter.close();
		 }
		  
		 return true;
	}

}	

