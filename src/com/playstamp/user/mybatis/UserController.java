package com.playstamp.user.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.faq.mybatis.IFaqDAO;
import com.playstamp.myspace.Point;
import com.playstamp.myspace.mybatis.IMyspaceDAO;
import com.playstamp.notice.mybatis.INoticeDAO;
import com.playstamp.user.User;


@Controller
public class UserController
{
   @Autowired
   private SqlSession sqlSession;
   
   @Autowired
   private JavaMailSender mailSender;
   
   //-- 로그인 페이지로 이동
   @RequestMapping("/signinform.action")
   public String signInForm()
   {
      String result = "";
      
      result = "/WEB-INF/views/main/LoginForm.jsp";

      return result;
   }
   
      
   //-- 회원가입 페이지로 이동
   @RequestMapping("/signupform.action")
   public String signUpForm()
   {
      String result = "";
      
      result = "/WEB-INF/views/main/UserSignUpForm.jsp";

      return result;
   }
   
   //-- 아이디 중복체크
   @ResponseBody
   @RequestMapping(value="/checkSignup.action", method=RequestMethod.POST)
   public String userIdCheck(@RequestParam("userId") String userId)
   {
      String str = "";
      
      IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
      
      int result = 0;
      try
      {
         result = dao.userIdCheck(userId);
         
      } catch (Exception e)
      {
         System.out.println(e.toString());
      }
      
      if(result!=0) // 이미 존재하는 아이디
         str = "NO";
      else
         str = "YES";
      
      return str;
   }
   
   // 이메일 인증
   @ResponseBody
   @RequestMapping(value="/mailcheck.action", method=RequestMethod.POST)
   public String mailCheck(@RequestParam("email") String email)
   {
      //System.out.println("이메일 데이터 전송확인");
      //System.out.println("인증 메일 : " + email);
      
      Random random = new Random();
      int checkNum = random.nextInt(888888)+111111; // 111111 - 999999
      //System.out.println("인증번호 : " + checkNum);
      
       String setFrom = "shyunnkk@gmail.com";
      String toEmail = email;
      String title = "플레이스탬프 인증코드";
      String content = "플레이스탬프 인증코드입니다." 
                  + "<br/><br/>" + "인증 번호 : " + checkNum + "<br/>"
                  + "회원가입 페이지에 인증코드를 입력해주세요:>";
        try {
           
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toEmail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        //System.out.println("인증번호 : " + num);
        return num;
   }
   
   
   // 사용자 회원가입 완료
   @RequestMapping(value="/completesignup.action", method=RequestMethod.POST)
   public String userInsert(@ModelAttribute("user") User user) throws ClassNotFoundException, SQLException 
   { 
      String result = "";
      
      IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
      //dao.userInsert(user);
    
      dao.userInsertProcedure(user);
      
      result = "WEB-INF/views/main/Welcome.jsp";
   
      return result; 
   }
   
   // 사용자 로그인
   @RequestMapping(value="/login.action", method=RequestMethod.POST)
   public String userLogin(HttpServletRequest request, Model model) throws SQLException
   { 
      String result = ""; 
      
      // 넘어온 값 받아오기
      String id = request.getParameter("userId");
      String pw = request.getParameter("userPw");
      String admin = request.getParameter("admin");
      
      // ! 세션은 사용자의 프로필 / 모델은 페이지에서 사용할 데이터
      
      // 테스트(admin 체크 안 하면 null 로 넘어오는 것 확인)
      //System.out.println("admin="+ admin);
      
      IUserDAO userDao = sqlSession.getMapper(IUserDAO.class);
      String str = "";
      
      if (admin!=null) // 관리자로 로그인 시도
      {
         System.out.println("관리자로 로그인 시도");
         
         // 관리자 테이블 조회
         str = userDao.managerLogin(id, pw);
         
         if (str!=null)
         {
            System.out.println("관리자 로그인 성공");

               HttpSession session = request.getSession();
               session.setAttribute("id", id);
               session.setAttribute("nick", str);

               String code = userDao.userCode(id);
               session.setAttribute("code", code);
               
            // 추후 관리자 페이지로 변경
            result = "redirect:managerhome.action";
         }
         else
         {
            System.out.println("관리자 로그인 실패");
            request.setAttribute("msg", "fail");
            result = "redirect:loginform.action";
         }
         
      }
      else // 사용자로 로그인 시도
      {
         System.out.println("사용자로 로그인 시도");
         
         // 유저 테이블 조회
         str = userDao.userLogin(id, pw);
         
         if(str!=null) // 테이블 정보가 일치 == 로그인 성공
         {
            System.out.println("사용자로 로그인 성공");


              HttpSession session = request.getSession();
              session.setAttribute("id", id);
              session.setAttribute("nick", str);
              
              String code = userDao.userCode(id);
              session.setAttribute("code", code);
     
           /* 포인트 적립 */
              /* 로그인 테이블에 남기기 */
              int checkLogin = userDao.checkLogin(code);
              
              if(checkLogin==0)
              {
                 userDao.addLoginPoint(code);
                 userDao.addLogin(code);
              }
              
           /* 등급 처리 */
           // 세션 객체 안에 있는 ID 얻어오기
           String userId = (String)session.getAttribute("id");
           
           // 현재 포인트 얻어오기
           IMyspaceDAO dao = sqlSession.getMapper(IMyspaceDAO.class);
           
           int userPoint = 0;
           userPoint = dao.userPoint(code);
           
           // 좋아요 개수 받아오기
           int countingLike = dao.countingLike(userId);
           
           // 등급 확인
           String grade = null;
           
           if(countingLike >= 20 && userPoint >= 200)
              grade = "우수회원";
           else if(countingLike >= 10 && userPoint >= 100)
              grade = "일반회원";
           else if(countingLike >= 3 && userPoint >= 30)
              grade = "준회원";
           else if(userPoint < 0)
              grade = "어둠회원";
           else if(countingLike == 0 || userPoint == 0 )
              grade = "뉴비";
           
           System.out.println("포인트 : " + userPoint + " | 좋아요 : " + countingLike + " | 등급 : " + grade);
           
           
           // 세션에 담아놓기
           session.setAttribute("grade", grade);
           
           //System.out.println(str);
           model.addAttribute("msg", "success");
           
           result = "redirect:home.action";
        }
        else // 로그인 실패
        {
           System.out.println("로그인 실패");
           request.setAttribute("msg", "fail");
           result = "/WEB-INF/views/main/LoginForm.jsp";
        }
     }
     
     return result; 
  }
   
   // 아이디 찾기 버튼 클릭
   @RequestMapping("/findid.action")
   public String findId()
   {
      String result = "";
      
      result = "/WEB-INF/views/main/FindIdForm.jsp";

      return result;
   }
   
   // 비밀번호 찾기 버튼 클릭
   @RequestMapping("/findpw.action")
   public String findPw()
   {
      String result = "";
      
      result = "/WEB-INF/views/main/FindPwForm.jsp";

      return result;
   }
   
   // 아이디 찾기 폼 페이지
   @ResponseBody
   @RequestMapping(value="/checkfindidpw.action", method=RequestMethod.POST)
   public String findId(@RequestParam("email") String email)
   {
      Random random = new Random();
      int checkNum = random.nextInt(888888)+111111; // 111111 - 999999
      //System.out.println("인증번호 : " + checkNum);
      
       String setFrom = "shyunnkk@gmail.com";
      String toEmail = email;
      String title = "플레이스탬프 인증코드";
      String content = "플레이스탬프 인증코드입니다." 
                  + "<br/><br/>" + "인증 번호 : " + checkNum + "<br/>"
                  + "플레이스탬프로 돌아가 인증코드를 입력해주세요:>";
        try {
           
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toEmail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String num = Integer.toString(checkNum);
        
        //System.out.println("인증번호 : " + num);
        return num;
   }
   
   // 찾은 아이디 확인하기
   @RequestMapping("/selectfindid.action")
   public String selectFindId(Model model, HttpServletRequest request)
   {
      String result = "";
      String[] idList;
      
      String mail = request.getParameter("user_Mail");
      
      IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
      idList = dao.selectFindId(mail);
      
      model.addAttribute("idList", idList);
      System.out.println(idList[0]);
   
      result = "/WEB-INF/views/main/ConfirmId.jsp";
      return result;
   }
   
   // 아이디와 메일 일치하는 계정있는지 확인하기
   @ResponseBody
   @RequestMapping(value="/selectidpw.action", method=RequestMethod.POST)
   public String selectIdMail(@RequestParam("userId") String userId, @RequestParam("userMail") String userMail
         , HttpServletRequest request, Model model)
   {
      String str = "";
      
      IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
      int result = 0;
      
      try
      {
         result = dao.selectIdMail(userId, userMail);
         //System.out.println(result);
         
      } catch (Exception e)
      {
         System.out.println(e.toString());
      }
      
      if(result!=0) // 이미 존재하는 아이디
         str = "NO";
      else
      {
         model.addAttribute("userId", userId);
         str = "YES";
      }
      
      return str;
   }
   
   // 비밀번호 재설정 전 확인

   @RequestMapping(value="/userchangepwform.action", method=RequestMethod.POST)
   public String changePwForm(@RequestParam("user_Id") String userId, Model model)
   {
      String result = "";
      
      model.addAttribute("userId", userId);
      
      System.out.println("아이디" + userId);
      result = "/WEB-INF/views/main/ChangePwForm.jsp";
      return result;
   }
   
   // 비밀번호 재설정
   @RequestMapping(value="/userchangepw.action", method=RequestMethod.POST)

   public void changePw(@RequestParam("user_Pw") String userPw, @RequestParam("user_Id") String userId, HttpServletResponse response) throws IOException
   {
      
      IUserDAO dao = sqlSession.getMapper(IUserDAO.class);
      dao.changePw(userPw, userId);
      
      System.out.println("아이디" + userId + "비번" + userPw);
      
      response.setContentType("text/html;charset=utf-8");
      PrintWriter printwriter = response.getWriter();
      
      printwriter.print("<script>alert('비밀번호 변경이 완료됐습니다.');"
            + "location.href='home.action'</script>");
      printwriter.flush();
      printwriter.close();
   }
   
   
   // 사용자 로그아웃
   @RequestMapping("/logout.action")
   public String userLogout(HttpSession session)
   { 
      String result = ""; 
      session.invalidate();

      result = "redirect:home.action";
      
      return result;
   }
   
   
   // 고객센터로 이동 (공지+faq 내용 모두 가지고 가기)
   @RequestMapping("/usernoticefaq.action")
   public String userNoticefaq(Model model)
   { 
	  // 공지사항 dao
      INoticeDAO noticedao = sqlSession.getMapper(INoticeDAO.class); 
      
      // FAQ dao
      IFaqDAO faqdao = sqlSession.getMapper(IFaqDAO.class);
	  
      // 공지사항 글 내용 가져오기
	  model.addAttribute("list", noticedao.getNoticeList());
      
	  // FAQ 글 내용 가져오기
	  model.addAttribute("flist", faqdao.getFaqList());
	  
	  
      return "/WEB-INF/views/main/UserNoticeFaq.jsp";
   }
   
}