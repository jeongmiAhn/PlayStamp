/*==============================
     AddReviewController.java
     - 컨트롤러 객체
     - Annotation으로 구성
===============================*/

package com.playstamp.review.mybatis;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.SessionScope;

import com.playstamp.myspace.mybatis.IMyspaceDAO;
import com.playstamp.review.Companion;
import com.playstamp.review.DistinctReview;
import com.playstamp.review.MSeatReview;
import com.playstamp.review.ModifyPoster;
import com.playstamp.review.MyReviewPoster;
import com.playstamp.review.Play;
import com.playstamp.review.ReviewDetail;
import com.playstamp.review.SeatReview;


@Controller
public class AddReviewController
{
	@Autowired
	private SqlSession sqlSession;
	
	// 리뷰 입력 전, 공연 정보를 모두 조회해서 페이지로 가져오는 메소드
	@RequestMapping(value="/addreviewsearchform.action", method=RequestMethod.GET)
	public String searchedPlay(Model model)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);

		model.addAttribute("list", dao.playList());
		
		return "WEB-INF/views/review/AddReviewSearchForm.jsp";
	}
	
	
	// 리뷰 검색 후 공연을 선택하면
	// 리뷰 식별 코드 테이블에 Insert 한 뒤,
	// 선택한 공연 관련 정보를 가지고 좌석 리뷰 입력 페이지로 이동
	@RequestMapping(value="/addreviewseatform.action", method=RequestMethod.POST)
	public String addDistinctReview(Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		String rev_distin_cd = null;
		
		// 검색 페이지(AddReviewSearchForm.jsp)로부터 정보 수신
		String user_cd = (String)session.getAttribute("code");
		String play_nm = request.getParameter("play_nm");
		
		// 사용자가 선택한 공연명+공연기간으로 공연코드 가져오기
		String play_cd = dao.searchPlayCd(play_nm);
		
		// 공연코드로 공연장코드 가져오기
		String theater_cd = dao.searchTheater(play_cd);
				
		// 기존에 같은 사용자, 같은 공연코드에 대한 리뷰 입력 내용 있는지 확인
		DistinctReview distinctReview = new DistinctReview();
		distinctReview.setPlay_cd(play_cd);
		distinctReview.setUser_cd(user_cd);
		
		rev_distin_cd = dao.searchRevDistinCd(distinctReview);
		
		// 기존에 입력된 리뷰 내용이 있다면
		if(rev_distin_cd!=null)
		{
			// 기존 리뷰 존재함 안내
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printwriter = null;
			
			try
			{
				printwriter = response.getWriter();
			} catch (IOException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			printwriter.print("<script>alert('기존에 작성하신 리뷰글로 이동합니다.');"
					+ "location.href='myreviewdetail.action?play_cd=" + play_cd + "&rev_distin_cd="
					+ rev_distin_cd + "&theater_cd=" + theater_cd + "'</script>");
			printwriter.flush();
			printwriter.close();
			
			
			// 리뷰 조회 페이지로 이동 (리뷰 식별코드, 공연장 코드 넘기기)
			//String redirect = "redirect:myreviewdetail.action?play_cd=" + play_cd + "&rev_distin_cd=" + rev_distin_cd
			//		+ "&theater_cd=" + theater_cd;
			
		}else
		{	
			// 리뷰 식별 테이블에 Insert (리뷰식별코드, 공연코드, 사용자코드)
			dao.addDistinctReview(distinctReview);
			
			// insert 된 리뷰 식별 코드 가져오기
			rev_distin_cd = dao.searchRevDistinCd(distinctReview);
			
			// 페이지로 이동하면서 리뷰식별코드 전달
			model.addAttribute("rev_distin_cd", rev_distin_cd);
			
			// 선택한 공연에 대한 모든 정보(공연객체) 전달
			Play play = new Play();
			play = dao.searchPlay(play_cd);
			
			model.addAttribute("play", play);
			model.addAttribute("theater_cd", theater_cd);
			
			// 좌석 리뷰 입력 페이지로 이동
			return "WEB-INF/views/review/AddReviewSeatForm.jsp";
		}
		
		return "WEB-INF/views/review/AddReviewSeatForm.jsp";
	}
	
	//-------------------------- 아래부터 좌석 리뷰 입력
	
	// 좌석 리뷰 입력 후 버튼을 클릭하면
	// 일반 공연장인지, 5대 공연장인지 판별하여 리뷰 입력
	@RequestMapping(value="/addreviewdetailform.action", method=RequestMethod.POST)
	public String addReviewSeat(Model model, HttpServletRequest request)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		// 좌석 리뷰 입력 페이지(AddReviewSeatForm.jsp)로부터 수신
		String play_cd = request.getParameter("play_cd");				// 공연 코드 (사용자가 선택한)
		String theater_cd = request.getParameter("theater_cd");			// 공연장 코드
		String rev_distin_cd = request.getParameter("rev_distin_cd");   // 리뷰 식별 코드
		
		//-- selectbox: name 속성을 통해 배열로 받는다.
		String[] viewArr = request.getParameterValues("view_rating");		// 시야 평점
		String[] seatArr = request.getParameterValues("seat_rating");		// 좌석 평점
		String[] lightArr = request.getParameterValues("light_rating");		// 조명 평점
		String[] soundArr = request.getParameterValues("sound_rating");		// 음향 평점
		
		String view_rating = "";
		String seat_rating = "";
		String light_rating = "";
		String sound_rating = "";
		
		// 선택한 평점들 꺼내기
		if(viewArr != null)
		{
			for(String list : viewArr)
				view_rating += list;
		}
		if(seatArr != null)
		{
			for(String list : seatArr)
				seat_rating += list;
		}
		if(lightArr != null)
		{
			for(String list : lightArr)
				light_rating += list;
		}
		if(soundArr != null)
		{
			for(String list : soundArr)
				sound_rating += list;
		}
		
		String seat_flow = request.getParameter("seat_flow");			// 층 (좌석정보)
		String seat_area = request.getParameter("seat_area");			// 구역
		String seat_line = request.getParameter("seat_line");			// 열
		String seat_num = request.getParameter("seat_num");				// 번호
		String seat_rev = request.getParameter("seat_rev");				// 좌석 상세 리뷰
		
		
		// 좌석 리뷰 테이블에 Insert (일반/5대 공연장 확인)
		if(theater_cd.equals("FC000011") || theater_cd.equals("FC000031") || theater_cd.equals("FC000012")
				|| theater_cd.equals("FC000001") || theater_cd.equals("FC000014"))
		{
			String mseat_sort_cd = request.getParameter("mseat_sort_cd");  // 좌석 구분 코드 (A1~A14 구역)
			
			// 5대 공연장 좌석 리뷰 객체 생성해 정보 담고 넘기기
			MSeatReview mseatreview = new MSeatReview();
			
			mseatreview.setRev_distin_cd(rev_distin_cd);
			mseatreview.setMseat_sort_cd(mseat_sort_cd);
			mseatreview.setView_rating(view_rating);
			mseatreview.setSeat_rating(seat_rating);
			mseatreview.setLight_rating(light_rating);
			mseatreview.setSound_rating(sound_rating);
			mseatreview.setSeat_flow(seat_flow);
			mseatreview.setSeat_area(seat_area);
			mseatreview.setSeat_line(seat_line);
			mseatreview.setSeat_num(seat_num);
			mseatreview.setSeat_rev(seat_rev);
			
			// 5대 공연장 좌석 리뷰에 insert
			dao.addMSeatReview(mseatreview);
			
		}else
		{
			// 일반 공연장 좌석 리뷰 객체 생성해 정보 담고 넘기기
			SeatReview seatreview = new SeatReview();
			
			seatreview.setRev_distin_cd(rev_distin_cd);
			seatreview.setView_rating(view_rating);
			seatreview.setSeat_rating(seat_rating);
			seatreview.setLight_rating(light_rating);
			seatreview.setSound_rating(sound_rating);
			seatreview.setSeat_flow(seat_flow);
			seatreview.setSeat_area(seat_area);
			seatreview.setSeat_line(seat_line);
			seatreview.setSeat_num(seat_num);
			seatreview.setSeat_rev(seat_rev);
			
			// 일반 공연장 좌석 리뷰에 insert
			dao.addSeatReview(seatreview);
		}
		
		// 다음 페이지에 Play 객체 넘기기 (공연코드 가져와서 넘기기)
		Play play = new Play();
		play = dao.searchPlay(play_cd);
		
		model.addAttribute("play", play);
		model.addAttribute("rev_distin_cd", rev_distin_cd);
		
		// 함께 본 사람 리스트 넘기기
		ArrayList<Companion> companion = dao.companion();
		model.addAttribute("companion", companion);
		
		// 공연장소 이름 넘기기
		model.addAttribute("theater_nm", dao.searchTheaterName(theater_cd));
		
		return "WEB-INF/views/review/AddReviewDetailForm.jsp";
	}
	
	//-- 공연 리뷰 테이블에 Insert
	@RequestMapping(value="/addreviewdetail.action", method=RequestMethod.POST)
	public String addReviewDetail(Model model, HttpServletRequest request, HttpSession session)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		String user_cd = (String)session.getAttribute("code");
		
		// 좌석 리뷰 페이지로부터 수신한 데이터
		String rev_distin_cd = request.getParameter("rev_distin_cd");
		
		// select는 배열로 구성한 뒤 반복문으로 select 된 값 받기
		String[] companionArr = request.getParameterValues("companion_cd");
		String companion_cd = "";
		
		if(companionArr != null)
		{
			for(String list : companionArr)
				companion_cd += list;
		}
		
		String title = request.getParameter("title");
		
		// 사용자가 선택한 평점 값
		String[] ratingArr = request.getParameterValues("rating_cd");
		String rating_cd = "";
		
		if(ratingArr != null)
		{
			for(String list : ratingArr)
				rating_cd += list;
		}
		
		// String 타입을 Date 타입으로 받기 위한 준비
		//SimpleDateFormat fm = new SimpleDateFormat("yy-MM-dd");
		
		String contents = request.getParameter("contents");
		String play_img = request.getParameter("play_img");
		String play_dt = request.getParameter("play_dt");
		/*
		Date play_dt = null;
		try
		{
			play_dt = new Date(fm.parse(request.getParameter("play_dt")).getTime());
			
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
		*/
		String play_time = request.getParameter("play_time");
		String play_money = request.getParameter("play_money");
		String play_cast = request.getParameter("play_cast");
		
		// 수신한 데이터들을 ReviewDetail 객체에 set하여 전달
		ReviewDetail rd = new ReviewDetail();
		
		rd.setRev_distin_cd(rev_distin_cd);
		rd.setCompanion_cd(companion_cd);
		rd.setTitle(title);
		rd.setRating_cd(rating_cd);
		rd.setContents(contents);
		rd.setPlay_img(play_img);
		rd.setPlay_dt(play_dt);
		rd.setPlay_time(play_time);
		rd.setPlay_money(play_money);
		rd.setPlay_cast(play_cast);
		
		// 공연 리뷰 테이블에 insert
		dao.addReviewDetail(rd);
		
		// 리뷰 작성 완료 시 포인트 증가
		dao.plusPoint(user_cd);
		
		// 나의 공연 리스트로 리다이렉트 (포스터)
		return "redirect:myreviewlistposter.action";
	}
	
	// 포스터 형식으로 사용자의 리뷰 조회하는 페이지
	//-- 사용자 코드로 리뷰 식별 테이블에서 리뷰식별코드, 공연코드 조회 → 이미지 url 가져오기
	@RequestMapping(value="/myreviewlistposter.action", method=RequestMethod.GET)
	public String myReviewPoster(Model model, HttpServletRequest request, HttpSession session)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		String user_cd = (String)session.getAttribute("code");
		
		ArrayList<MyReviewPoster> myreviewposter = dao.myReviewPoster(user_cd);
		
		model.addAttribute("myreviewposter", myreviewposter);
		
		return "WEB-INF/views/review/MyReviewListPoster.jsp";
	}

	// 포스터 클릭시, 나의 공연리뷰 (좌석 리뷰+상세리뷰 같이) 조회 페이지
	@RequestMapping(value="/myreviewdetail.action", method=RequestMethod.GET)
	public String myReviewDetail(Model model, HttpServletRequest request)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		// 포스터를 통해 넘어오는 데이터 받기
		String play_cd = request.getParameter("play_cd");
		String rev_distin_cd = request.getParameter("rev_distin_cd");
		
		// 공연 코드 받아서 공연장이 5대 공연장인지 확인해서 분기
		String theater_cd = dao.searchTheater(play_cd);
		
		// 리뷰식별코드로 리뷰 상세 내용도 가져오기
		ReviewDetail reviewdetail = dao.getReviewDetail(rev_distin_cd);
		model.addAttribute("reviewdetail", reviewdetail);
		
		// 공연코드로 공연 정보 가져오기
		Play play = dao.searchPlay(play_cd);
		model.addAttribute("play", play);
		
		// 공연장 코드가 5대 공연장에 해당한다면
		if(theater_cd.equals("FC000011") || theater_cd.equals("FC000031") || theater_cd.equals("FC000012")
				|| theater_cd.equals("FC000001") || theater_cd.equals("FC000014"))
		{
			MSeatReview seatreview = dao.getMSeatReview(rev_distin_cd);
			model.addAttribute("seatreview", seatreview);
			
			return "WEB-INF/views/review/MyMReviewDetail.jsp";
		}
		else
		{
			SeatReview seatreview = dao.getSeatReview(rev_distin_cd);
			model.addAttribute("seatreview", seatreview);
			
			return "WEB-INF/views/review/MyReviewDetail.jsp";
		}
	}
	
	// 처음 수정 버튼 클릭 시 좌석 정보 수정 페이지 이동
	//-- 일반 공연장, 5대 공연장 페이지 분기
	@RequestMapping(value="/myreviewseatupdateform.action", method=RequestMethod.POST)
	public String myReviewSeatUpdateForm(Model model, HttpServletRequest request)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		// 상세 조회 페이지(MyReviewDetail.jsp) 에서 넘어오는 정보
		//-- 리뷰 식별코드
		String rev_distin_cd = request.getParameter("rev_distin_cd");
		
		// 리뷰 식별코드로 공연 코드 받아서 공연장이 5대 공연장인지 확인해서 분기
		String theater_cd = dao.searchTheaterCd(rev_distin_cd);
		model.addAttribute("theater_cd", theater_cd);

		// 공연장 코드가 5대 공연장에 해당한다면
		if(theater_cd.equals("FC000011") || theater_cd.equals("FC000031") || theater_cd.equals("FC000012")
				|| theater_cd.equals("FC000001") || theater_cd.equals("FC000014"))
		{
			MSeatReview mseatreview = dao.getMSeatReview(rev_distin_cd);
			model.addAttribute("mseatreview", mseatreview);
			return "WEB-INF/views/review/MyReviewMSeatUpdateForm.jsp";
		}
		else
		{
			SeatReview seatreview = dao.getSeatReview(rev_distin_cd);
			model.addAttribute("seatreview", seatreview);
			return "WEB-INF/views/review/MyReviewSeatUpdateForm.jsp";
		}
	}
	
	// 두 번째 수정 버튼 클릭 시 좌석 정보 수정 후 상세 리뷰 수정 페이지 이동
	@RequestMapping(value="/myreviewdetailupdateform.action", method=RequestMethod.POST)
	public String myReviewDetailUpdateForm(Model model, HttpServletRequest request)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		//--------------------수정한 좌석 정보 update 처리--------------------------
		// 이전 페이지로부터 필요한 정보 얻어오기
		//-- 리뷰 식별코드, 시야, 좌석, 음향, 조명 별점, 층, 구역, 열, 번호 좌석위치, 좌석 리뷰, 공연장코드
		//   + 5대 공연장인 경우 구역 선택
		String theater_cd = request.getParameter("theater_cd");
		String rev_distin_cd = request.getParameter("rev_distin_cd");

		//-- selectbox: name 속성을 통해 배열로 받는다.
		String[] viewArr = request.getParameterValues("view_rating");		// 시야 평점
		String[] seatArr = request.getParameterValues("seat_rating");		// 좌석 평점
		String[] lightArr = request.getParameterValues("light_rating");		// 조명 평점
		String[] soundArr = request.getParameterValues("sound_rating");		// 음향 평점
		
		String view_rating = "";
		String seat_rating = "";
		String light_rating = "";
		String sound_rating = "";
		
		// 선택한 평점들 꺼내기
		if(viewArr != null)
		{
			for(String list : viewArr)
				view_rating += list;
		}
		if(seatArr != null)
		{
			for(String list : seatArr)
				seat_rating += list;
		}
		if(lightArr != null)
		{
			for(String list : lightArr)
				light_rating += list;
		}
		if(soundArr != null)
		{
			for(String list : soundArr)
				sound_rating += list;
		}
		
		String seat_flow = request.getParameter("seat_flow");			// 층 (좌석정보)
		String seat_area = request.getParameter("seat_area");			// 구역
		String seat_line = request.getParameter("seat_line");			// 열
		String seat_num = request.getParameter("seat_num");				// 번호
		String seat_rev = request.getParameter("seat_rev");				// 좌석 상세 리뷰

		// 공연장 코드에 따른 분기
		// 5대 공연장인 경우 구역까지 받아서 수정하기
		if(theater_cd.equals("FC000011") || theater_cd.equals("FC000031") || theater_cd.equals("FC000012")
				|| theater_cd.equals("FC000001") || theater_cd.equals("FC000014"))
		{
			String mseat_sort_cd = request.getParameter("mseat_sort_cd");  // 좌석 구분 코드 (A1~A14 구역)
			
			// 5대 공연장 좌석 리뷰 객체 생성해 정보 담고 넘기기
			MSeatReview mseatreview = new MSeatReview();
			
			mseatreview.setRev_distin_cd(rev_distin_cd);
			mseatreview.setMseat_sort_cd(mseat_sort_cd);
			mseatreview.setView_rating(view_rating);
			mseatreview.setSeat_rating(seat_rating);
			mseatreview.setLight_rating(light_rating);
			mseatreview.setSound_rating(sound_rating);
			mseatreview.setSeat_flow(seat_flow);
			mseatreview.setSeat_area(seat_area);
			mseatreview.setSeat_line(seat_line);
			mseatreview.setSeat_num(seat_num);
			mseatreview.setSeat_rev(seat_rev);
			
			// 5대 공연장 좌석 리뷰 수정 액션 처리
			dao.modifyMSeatReview(mseatreview);
			
		}else
		{
			// 일반 공연장 좌석 리뷰 객체 생성해 정보 담고 넘기기
			SeatReview seatreview = new SeatReview();
			
			seatreview.setRev_distin_cd(rev_distin_cd);
			seatreview.setView_rating(view_rating);
			seatreview.setSeat_rating(seat_rating);
			seatreview.setLight_rating(light_rating);
			seatreview.setSound_rating(sound_rating);
			seatreview.setSeat_flow(seat_flow);
			seatreview.setSeat_area(seat_area);
			seatreview.setSeat_line(seat_line);
			seatreview.setSeat_num(seat_num);
			seatreview.setSeat_rev(seat_rev);
			
			// 일반 공연장 좌석 리뷰 수정 액션 처리
			dao.modifySeatReview(seatreview);
		}
		
		//--------------------수정한 좌석 정보 update 처리 끝 ----------------------
		
		
		//---------------상세 리뷰 수정 페이지에 전달할 정보 가져오기---------------
		
		// 다음 페이지에 Play 객체 넘기기 (공연코드 가져와서 넘기기)
		
		// 이 리뷰에 해동하는 공연코드
		String play_cd = dao.playCdByDistin(rev_distin_cd);
		
		// 1. 공연 정보 다 넘기기
		Play play = new Play();
		play = dao.searchPlay(play_cd);
		
		model.addAttribute("play", play);
		
		// 2. 리뷰식별코드 session에 담기 (리뷰 사진 수정 시, form으로 같이 제출하기 위해)
        HttpSession session = request.getSession();
        session.setAttribute("rev_distin_cd", rev_distin_cd);
        // model 에도 담기
		model.addAttribute("rev_distin_cd", rev_distin_cd);
		
		// 3. 함께 본 사람 리스트 넘기기
		ArrayList<Companion> companion = dao.companion();
		model.addAttribute("companion", companion);
		
		// 4. 공연장소 이름 넘기기
		model.addAttribute("theater_nm", dao.searchTheaterName(theater_cd));
		
		// 5. 리뷰식별코드로 리뷰 상세 내용 가져오기
		ReviewDetail reviewdetail = dao.getReviewDetail(rev_distin_cd);
		model.addAttribute("reviewdetail", reviewdetail);
		
		//---------------상세 리뷰 수정 페이지에 전달할 정보 가져오기---------------
		
		return "WEB-INF/views/review/MyReviewDetailUpdateForm.jsp";
	}
	
	// 상세 리뷰 수정 액션 처리 후 조회 페이지(포스터 리스트)로 이동
	@RequestMapping(value="/myreviewdetailupdate.action", method=RequestMethod.POST)
	public String myReviewDetailUpdate(Model model, HttpServletRequest request)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		// 이전 페이지로부터 넘어온 필요한 정보들 가져오기
		//-- 같이 관람한 사람, 제목, 공연날짜, 공연시간, 출연진, 티켓금액, 공연평점, 공연 상세리뷰, 첨부파일
		//   리뷰 식별코드
		String rev_distin_cd = request.getParameter("rev_distin_cd");
		
		//-- selectbox: name 속성을 통해 배열로 받는다.
		String[] companionArr = request.getParameterValues("companion_cd");		// 함께 본 사람
		String[] ratingArr = request.getParameterValues("rating_cd");			// 공연 평점
		String companion_cd = "";
		String rating_cd = "";
		
		// 선택한 selectbox 꺼내기
		if(companionArr != null)
		{
			for(String list : companionArr)
				companion_cd += list;
		}
		if(ratingArr != null)
		{
			for(String list : ratingArr)
				rating_cd += list;
		}
		
		String title = request.getParameter("title");			// 제목
		String play_dt = request.getParameter("play_dt");		// 공연 날짜
		String play_time = request.getParameter("play_time");	// 공연 시간
		String play_cast = request.getParameter("play_cast");	// 출연진
		String play_money = request.getParameter("play_money");	// 티켓 금액
		String contents = request.getParameter("contents");		// 공연 상세리뷰
		//String play_img = request.getParameter("play_img");	// 첨부파일 -- 따로 폼 제출해 수정받기
		
		// 가져온 값 객체에 세팅하기
		ReviewDetail reviewdetail = new ReviewDetail();
		reviewdetail.setRev_distin_cd(rev_distin_cd);
		reviewdetail.setCompanion_cd(companion_cd);
		reviewdetail.setTitle(title);
		reviewdetail.setRating_cd(rating_cd);
		reviewdetail.setContents(contents);
		//reviewdetail.setPlay_img(play_img);
		reviewdetail.setPlay_dt(play_dt);
		reviewdetail.setPlay_time(play_time);
		reviewdetail.setPlay_money(play_money);
		reviewdetail.setPlay_cast(play_cast);
		
		// 수정 액션 처리
		dao.modifyReviewDetail(reviewdetail);
		
		return "redirect:myreviewlistposter.action";
	}
	
	
	// 삭제 액션 수행
	@RequestMapping(value="/removemyreview.action", method=RequestMethod.GET)
	public String removeMyReview(Model model, HttpServletRequest request, HttpSession session)
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		String user_cd = (String)session.getAttribute("code");
		
		// 삭제 할 리뷰 식별 코드, 공연 코드 가져오기
		String rev_distin_cd = request.getParameter("rev_distin_cd");
		String theater_cd = dao.searchTheaterCd(rev_distin_cd);
		
		// 공연장 코드가 5대 공연장에 해당한다면
		if(theater_cd.equals("FC000011") || theater_cd.equals("FC000031") || theater_cd.equals("FC000012")
				|| theater_cd.equals("FC000001") || theater_cd.equals("FC000014"))
		{
			// 5대 공연장 리뷰 테이블에서 삭제
			dao.removeMSeatReview(rev_distin_cd);
		}
		else
		{
			// 일반 공연장 리뷰 테이블에서 삭제
			dao.removeSeatReview(rev_distin_cd);
		}
		
		// 해당 공연 식별코드와 연결된 공연 상세 리뷰도 삭제
		dao.removeReviewDetail(rev_distin_cd);
		
		// 리뷰 식별코드 삭제
		dao.removeReviewDistin(rev_distin_cd);
		
		// 삭제 시 포인트 차감 액션
		dao.minusPoint(user_cd);
		
		// 모두 삭제 후 조회 화면으로 이동
		return "redirect:myreviewlistposter.action";
	}
	
	// 사용자가 리뷰 수정 시 사진 업로드(수정)하는 경우
	@RequestMapping(value="/modifyPosterImg.action", method=RequestMethod.GET)
    public void uploadPoster(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException
	{
		IAddReviewDAO dao = sqlSession.getMapper(IAddReviewDAO.class);
		
		// 수정할 리뷰의 리뷰식별코드, 수정할 이미지 값 받기
		String rev_distin_cd = (String)session.getAttribute("rev_distin_cd");
		String play_img = (String)session.getAttribute("play_img");
		
		System.out.println(rev_distin_cd);
		System.out.println(play_img);
		
		//String rev_distin_cd = (String) request.getAttribute("rev_distin_cd");
		//String play_img = (String) request.getAttribute("play_img");
		
		ModifyPoster mp = new ModifyPoster();
		mp.setRev_distin_cd(rev_distin_cd);
		mp.setPlay_img(play_img);
		
		int success = dao.modifyPosterImg(mp);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter printwriter = response.getWriter();
		
		if(success==1)
		{
			printwriter.print("<script>alert('정보 수정이 완료됐습니다.');"
					+ "history.back();</script>");
		}
		printwriter.flush();
		printwriter.close();
	}
	
}
