package com.playstamp.playreviewdetail.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.play.PlayList;
import com.playstamp.play.mybatis.IPlayListDAO;
import com.playstamp.playdetail.PlayRevBlind;
import com.playstamp.playdetail.PlayRevPre;
import com.playstamp.playreviewdetail.Comment;
import com.playstamp.playreviewdetail.CommentBlind;
import com.playstamp.playreviewdetail.CommentPoint;
import com.playstamp.playreviewdetail.Like;

@Controller
public class PlayReviewDetailController
{
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="playreviewdetail.action", method=RequestMethod.GET)
	public String sendPlayReviewDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws SQLException
	{
		IPlayReviewDetailDAO dao = sqlSession.getMapper(IPlayReviewDetailDAO.class);
		
		String playrev_cd = request.getParameter("playrev_cd");
		String play_cd = request.getParameter("play_cd");
		
		String user_cd = (String)session.getAttribute("code");
		String user_id = (String)session.getAttribute("id");
		
		Like like = new Like();
		
		like.setPlayrev_cd(playrev_cd);
		like.setUser_cd(user_cd);
		
		//@@ 좋아요 체크 메소드 
		int checkHeart = 0;
		
		//@@ 있을 경우 1, 없을 경우 0 반환
		if (dao.checkHeart(like) != 0)
			checkHeart = 1;
		
		model.addAttribute("checkHeart",checkHeart);
		
		//----------------------------------------- 댓글 블라인드
		// 해당 공연의 공연 리뷰 코드들을 꺼내기 위해 리스트 선언 
		//ArrayList<PlayRevPre> playRevPreList = dao.getPlayRevPre(play_cd);
		ArrayList<Comment> commentList = dao.getCommentList(playrev_cd);
		
		int checkRepCom = 0;
		int checkRepComSt = 0;
		ArrayList<Integer> checkRepComList = new ArrayList<Integer>();
		ArrayList<Integer> checkRepComStList = new ArrayList<Integer>();
		
		for (Comment comment : commentList)
		{		
			//@@ 블라인드 객체 반환
			//PlayRevBlind blindPlay = dao.checkRepPlay(playRevPre.getPlayrev_cd());
			CommentBlind blindCom = dao.checkRepCom(comment.getComment_cd());
			
			//@@ 신고가 되었다면 
			if (Integer.parseInt(blindCom.getRep_com_cd()) != 0)
				checkRepCom = 1;
			else
				checkRepCom = 0;
					
			//@@ 신고가 처리되었다면, 승인(1) 또는 반려(2)를 반환한다. 신고가 처리되지 않았다면 초기화된 값 0을 반환한다. 
			if (Integer.parseInt(blindCom.getRep_st_cd()) != 0)
				checkRepComSt = Integer.parseInt(blindCom.getRep_st_cd());
			else
				checkRepComSt = 0;
			// 신고 o → 1
			// 신고 x → 0
			checkRepComList.add(checkRepCom);
			// 승인 → 1 
			// 반려 → 2
			// 신고 처리 x → 0
			checkRepComStList.add(checkRepComSt);			
		}
		/*
		  if (dao.getUserGrade(user_id).equals("어둠회원")) { 
			  //@@ 신고되었는지 여부 확인하는 리스트를 모델에 담아 보낸다. 
			  model.addAttribute("checkRepComList", checkRepComList); 
			  //@@ 신고 처리 여부 확인하는 리스트를 모델에 담아 보낸다. 
			  model.addAttribute("checkRepComStList",checkRepComStList);
		  
		  //System.out.println(playrev_cd); // addAttribute 를 통해 전송
		  model.addAttribute("playReviewDetail", dao.getPlayReviewDetail(playrev_cd));
		  
		  //@@ 코멘트 리스트 전송 구문도 추가 model.addAttribute("commentList",
		  dao.getCommentList(playrev_cd);
		  
		  model.addAttribute("ratingAvg", dao.getRatingAvg(play_cd));
		  
		  return "WEB-INF/views/play/PlayReviewDetailForDark.jsp"; }
		 */
		
		//@@ 신고되었는지 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepComList", checkRepComList);
		//@@ 신고 처리 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepComStList", checkRepComStList);
				
		//System.out.println(playrev_cd);
		// addAttribute 를 통해 전송
		model.addAttribute("playReviewDetail", dao.getPlayReviewDetail(playrev_cd));
		
		//@@ 코멘트 리스트 전송 구문도 추가
		model.addAttribute("commentList", dao.getCommentList(playrev_cd));
	
		return "WEB-INF/views/play/PlayReviewDetail.jsp";
	}
	
	@RequestMapping(value="/reportform.action")
	public String reportForm()
	{
		return "WEB-INF/views/report/Report.jsp";
	}
	
	//@@ ajax 로 댓글 리스트 전송
	@RequestMapping(value="/comment.action", method= RequestMethod.GET)
	public @ResponseBody ArrayList<Comment> getCommentList(@RequestParam("playrev_cd") String playrev_cd) throws SQLException
	{
		IPlayReviewDetailDAO dao = sqlSession.getMapper(IPlayReviewDetailDAO.class);
		
		//String playrev_cd = request.getParameter("playrev_cd");
		
		//Map<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<Comment> result = dao.getCommentList(playrev_cd);
		//map.put("result", list);
		
		return result;	  
	}	
	
	//@@ 댓글 추가
	@RequestMapping(value="/commentadd.action", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String addComment(@RequestBody Comment comment, HttpSession session) throws SQLException
	{
		IPlayReviewDetailDAO dao = sqlSession.getMapper(IPlayReviewDetailDAO.class);	
		
		//System.out.println("닉:" + comment.getUser_nick());
		String user_cd = (String)session.getAttribute("code");
		int count = 0;
		
		// 댓글을 추가할 경우 포인트 적립 횟수가 3회를 초과하지 않았는지 확인
		try
		{	
			count = dao.countAddComment(user_cd); 
			
			// 당일 적립 횟수가 3회를 초과하지 않았다면, 포인트 적립!
			if (count < 3)
				dao.addCommentPoint(user_cd);
			
			// 적립 횟수가 3회를 초과했다면, 포인트 적립하지 않고 코멘트만 추가
			dao.addComment(comment);		
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return "success";
	}	
	
	//@@ 댓글 삭제
	@RequestMapping(value="/commentremove.action", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody String removeComment(@RequestBody Comment comment, HttpSession session) throws SQLException
	{
		IPlayReviewDetailDAO dao = sqlSession.getMapper(IPlayReviewDetailDAO.class);	
		String user_cd = (String)session.getAttribute("code");
		String point_cd = "";
		
		CommentPoint commentPoint = new CommentPoint();
		
		//System.out.println("댓글코드: " + comment.getComment_cd());
		//System.out.println(comment.getComment_cd());
		
		//@@ 댓글을 삭제할 경우, 해당 댓글로 포인트를 적립받았었는지 확인
		try
		{	
			commentPoint = dao.ifUserAddComment(comment.getComment_cd());
			
			//@@ 적립받았다면 포인트 차감
			if (!commentPoint.getPoint_cd().equals("0"))
				dao.delCommentPoint(user_cd);
			
			//@@ 적립받지 않았다면, 코멘트만 삭제
			dao.removeComment(comment);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		System.out.println("값 : " + point_cd);
		return "success";
	}	
	
	//@@ 좋아요 버튼 클릭시 
	@RequestMapping(value="/heartclick.action", method= {RequestMethod.POST, RequestMethod.GET})
	public @ResponseBody Map<String, Object> addHeart(@RequestBody Like like, HttpSession session, HttpServletRequest request) throws SQLException
	{
		IPlayReviewDetailDAO dao = sqlSession.getMapper(IPlayReviewDetailDAO.class);	
		Map<String, Object> result = new HashMap<String, Object>(); 
		
		String user_cd = (String)session.getAttribute("code");
		//String playrev_cd = request.getParameter("playrev_cd");
		
		//System.out.println(like.getPlayrev_cd());
		int returnValue = 0;
		String point_cd = "";
		int count = 0;

		try
		{			
			//@@ 이미 좋아요를 눌렀을 경우
			if (dao.checkHeart(like)!=0)
			{
				// 해당 좋아요로 포인트 적립받았는지 확인
				if ((dao.ifUserAddHeart(user_cd, like.getPlayrev_cd())) != null && (dao.ifUserAddHeart(user_cd, like.getPlayrev_cd()).length() != 0))
					point_cd = dao.ifUserAddHeart(user_cd, like.getPlayrev_cd());
				
				//System.out.println(user_cd);
				//System.out.println(like.getPlayrev_cd());
				//System.out.println("값: " + point_cd);
				
				//@@ 적립받았다면
				if (!point_cd.equals(""))
					// 포인트 차감
					dao.delHeartPoint(user_cd);
				
				//@@ 적립받지 않았다면 포인트 차감 x
				
				// 좋아요를 삭제하고 
				dao.delHeart(like);
				// 0을 반환
				returnValue = 0;
			}
			
			//@@ 좋아요를 처음 눌렀을 경우
			else if(dao.checkHeart(like)==0)
			{
				// 오늘 3회를 소진했는지 확인
				count = dao.countAddHeart(user_cd);
				
				//@@ 카운트가 3보다 작다면 
				if (count < 3)
					//@@ 포인트 추가
					dao.addHeartPoint(user_cd);
				
				//@@ 아니라면 하트 추가만
				dao.addHeart(like);
				returnValue = 1;
			}
			
			
			result.put("lcount", dao.countHeart(like));
			result.put("returnValue", returnValue);

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return result;
	}	
}
