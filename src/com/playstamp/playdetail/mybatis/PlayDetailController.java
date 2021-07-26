/*===========================
 	PlayDetailController.java
 	- 컨트롤러
============================*/

package com.playstamp.playdetail.mybatis;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.playstamp.playdetail.Jjim;
import com.playstamp.playdetail.MseatRevBlind;
import com.playstamp.playdetail.PlayDetail;
import com.playstamp.playdetail.PlayRevBlind;
import com.playstamp.playdetail.PlayRevPre;
import com.playstamp.playdetail.SeatRev;
import com.playstamp.playdetail.SeatRevBlind;
import com.playstamp.playreviewdetail.Like;
import com.playstamp.playreviewdetail.mybatis.IPlayReviewDetailDAO;

@Controller
public class PlayDetailController
{
	@Autowired
	private SqlSession sqlSession;

	@RequestMapping(value = "playdetail.action", method = RequestMethod.GET)
	public String sendPlayDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws SQLException
	{
		IPlayDetailDAO dao = sqlSession.getMapper(IPlayDetailDAO.class);
		String play_cd = request.getParameter("play_cd");
		String user_cd = "";
		String user_id = "";
		
		//--------------------------------------------- 
		String theater_cd = "";
		
		ArrayList<PlayDetail> playDetailList = dao.getPlayDetail(play_cd);
		
		for (PlayDetail playDetail : playDetailList)
			theater_cd = playDetail.getTheater_cd();
		
		//-----------------------------------------------
		if ((String) session.getAttribute("code") != null)
			user_cd = (String) session.getAttribute("code");
		if ((String) session.getAttribute("id") != null)
			user_id = (String) session.getAttribute("id");

		// 변수 선언 및 초기화
		int mseatCheck = 0;
		int seatCheck = 0;

		// 신고 처리를 분기하기 위해 임의의 변수 추가
		int distin = 0;

		ArrayList<SeatRev> seatRev = new ArrayList<SeatRev>();

		// 어떤 seatRev 를 가지고 갈 것인지 판별
		// @@ 각각 널 체크를 해 줘야 함. 값이 없으면... 담으면서 널 익셉션 뜨기 때문.
		if (dao.getMseatCheck(play_cd) != null)
			mseatCheck = dao.getMseatCheck(play_cd);
		if (dao.getSeatCheck(play_cd) != null)
			seatCheck = dao.getSeatCheck(play_cd);

		// @@ 5대 좌석 리뷰일 시 distin 에 1을 대입
		if (mseatCheck > 0)
		{
			seatRev = dao.getMseatRev(theater_cd);
			distin = 1;
		}

		// @@ 일반 좌석 리뷰의 distin 은 0
		if (seatCheck > 0)
			seatRev = dao.getSeatRev(theater_cd);

		// @@ 좋아요 체크 메소드
		int checkJjim = 0;

		Jjim jjim = new Jjim();

		jjim.setPlay_cd(play_cd);
		jjim.setUser_cd(user_cd);

		// @@ 있을 경우 1, 없을 경우 0 반환
		if (dao.checkJjim(jjim) != 0)
			checkJjim = 1;

		// @@ 신고된 게시물 블라인드 처리 로직 ---------------------------------------------
		// 해당 공연의 공연 리뷰 코드들을 꺼내기 위해 리스트 선언
		ArrayList<PlayRevPre> playRevPreList = dao.getPlayRevPre(play_cd);

		int checkRepPlay = 0;
		int checkRepPlaySt = 0;
		ArrayList<Integer> checkRepPlayList = new ArrayList<Integer>();
		ArrayList<Integer> checkRepPlayStList = new ArrayList<Integer>();

		for (PlayRevPre playRevPre : playRevPreList)
		{
			// @@ 블라인드 객체 반환
			PlayRevBlind blindPlay = dao.checkRepPlay(playRevPre.getPlayrev_cd());

			// @@ 신고가 되었다면
			if (Integer.parseInt(blindPlay.getRep_rev_cd()) != 0)
				checkRepPlay = 1;
			else
				checkRepPlay = 0;

			// @@ 신고가 처리되었다면, 승인(1) 또는 반려(2)를 반환한다. 신고가 처리되지 않았다면 초기화된 값 0을 반환한다.
			if (Integer.parseInt(blindPlay.getRep_st_cd()) != 0)
				checkRepPlaySt = Integer.parseInt(blindPlay.getRep_st_cd());
			else
				checkRepPlaySt = 0;
			// 신고 o → 1
			// 신고 x → 0
			checkRepPlayList.add(checkRepPlay);
			// 승인 → 1
			// 반려 → 2
			// 신고 처리 x → 0
			checkRepPlayStList.add(checkRepPlaySt);
		}

		// @@ 신고된 좌석 리뷰 블라인드 처리 로직 ---------------------------------------------
		int checkRepSeat = 0;
		int checkRepSeatSt = 0;
		ArrayList<Integer> checkRepSeatList = new ArrayList<Integer>();
		ArrayList<Integer> checkRepSeatStList = new ArrayList<Integer>();

		if (distin == 0)
		{
			for (SeatRev seat : seatRev)
			{
				// @@ 블라인드 객체 반환
				SeatRevBlind blindSeat = dao.checkRepSeat(seat.getSeat_rev_cd());

				// @@ 신고가 되었다면
				if (Integer.parseInt(blindSeat.getRep_seat_cd()) != 0)
					checkRepSeat = 1;
				else
					checkRepSeat = 0;

				// @@ 신고가 처리되었다면, 승인(1) 또는 반려(2)를 반환한다. 신고가 처리되지 않았다면 초기화된 값 0을 반환한다.
				if (Integer.parseInt(blindSeat.getRep_st_cd()) != 0)
					checkRepSeatSt = Integer.parseInt(blindSeat.getRep_st_cd());
				else
					checkRepSeatSt = 0;
				// 신고 o → 1
				// 신고 x → 0
				checkRepSeatList.add(checkRepSeat);
				// 승인 → 1
				// 반려 → 2
				// 신고 처리 x → 0
				checkRepSeatStList.add(checkRepSeatSt);
			}
		}

		if (distin == 1)
		{
			for (SeatRev seat : seatRev)
			{
				// @@ 블라인드 객체 반환
				MseatRevBlind blindSeat = dao.checkRepMseat(seat.getMseat_rev_cd());

				// @@ 신고가 되었다면
				if (Integer.parseInt(blindSeat.getRep_mseat_cd()) != 0)
					checkRepSeat = 1;
				else
					checkRepSeat = 0;

				// @@ 신고가 처리되었다면, 승인(1) 또는 반려(2)를 반환한다. 신고가 처리되지 않았다면 초기화된 값 0을 반환한다.
				if (Integer.parseInt(blindSeat.getRep_st_cd()) != 0)
					checkRepSeatSt = Integer.parseInt(blindSeat.getRep_st_cd());
				else
					checkRepSeatSt = 0;
				// 신고 o → 1
				// 신고 x → 0
				checkRepSeatList.add(checkRepSeat);
				// 승인 → 1
				// 반려 → 2
				// 신고 처리 x → 0
				checkRepSeatStList.add(checkRepSeatSt);
			}
		}

		// @@ 신고되었는지 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepPlayList", checkRepPlayList);
		// @@ 신고 처리 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepPlayStList", checkRepPlayStList);
		// @@ 신고되었는지 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepSeatList", checkRepSeatList);
		// @@ 신고 처리 여부 확인하는 리스트를 모델에 담아 보낸다.
		model.addAttribute("checkRepSeatStList", checkRepSeatStList);

		// @@ 찜 여부도 담아 보낸다
		model.addAttribute("checkJjim", checkJjim);

		// addAttribute 를 통해 전송
		model.addAttribute("distin", distin);
		model.addAttribute("seatRevList", seatRev);
		model.addAttribute("playDetailList", playDetailList);
		model.addAttribute("playRevPreList", playRevPreList);

		// 테스트
		//System.out.println("값: " + ();
		return "WEB-INF/views/play/PlayDetail.jsp";
	}

	// @@ 찜 버튼 클릭시
	@RequestMapping(value = "/jjimclick.action", method =
	{ RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody Map<String, Object> addHeart(@RequestBody Jjim jjim, HttpSession session) throws SQLException
	{
		IPlayDetailDAO dao = sqlSession.getMapper(IPlayDetailDAO.class);
		Map<String, Object> result = new HashMap<String, Object>();

		int returnValue = 0;

		try
		{
			// @@ 이미 좋아요를 눌렀을 경우
			if (dao.checkJjim(jjim) != 0)
			{
				// 좋아요를 삭제하고
				dao.delJjim(jjim);
				// 0을 반환
				returnValue = 0;
			} else if (dao.checkJjim(jjim) == 0)
			{
				dao.addJjim(jjim);
				returnValue = 1;
			}

			result.put("returnValue", returnValue);

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return result;
	}
}
