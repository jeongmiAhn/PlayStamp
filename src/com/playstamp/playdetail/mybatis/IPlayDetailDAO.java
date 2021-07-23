package com.playstamp.playdetail.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.playdetail.Jjim;
import com.playstamp.playdetail.MseatRevBlind;
import com.playstamp.playdetail.PlayDetail;
import com.playstamp.playdetail.PlayRevBlind;
import com.playstamp.playdetail.PlayRevPre;
import com.playstamp.playdetail.SeatRev;
import com.playstamp.playdetail.SeatRevBlind;
import com.playstamp.playreviewdetail.Like;

public interface IPlayDetailDAO
{
	// 5대 공연 좌석 리뷰인지 체크하는 메소드
	//(일종의 DelCheck 처럼 참조관계를 확인하는 메소드로, 0보다 클 경우 5대 공연 좌석 리뷰임을 의미)
	public Integer getMseatCheck(String play_cd) throws SQLException;

	// 일반 공연 좌석 리뷰인지 체크하는 메소드
	// (상동)
	public Integer getSeatCheck(String play_cd) throws SQLException;
	
	// getSeatCheck, getMseatCheck 값을 바탕으로
	// 해당 공연이 5대 공연장에서 진행될 경우, 5대 공연장  테이블을 조회해좌석 리뷰를 보여주는 메소드
	public ArrayList<SeatRev> getMseatRev(String play_cd);
	
	// getSeatCheck, getMseatCheck 값을 바탕으로
	// 해당 공연이 일반 공연장에서 진행될 경우, 일반 공연장 테이블을 조회해 좌석 리뷰를 보여주는 메소드
	public ArrayList<SeatRev> getSeatRev(String play_cd);
	
	// 공연 상세 조회 메소드
	public ArrayList<PlayDetail> getPlayDetail(String play_cd);
	
	// 해당 공연에 해당하는 공연 리뷰 프리뷰 조회 메소드
	public ArrayList<PlayRevPre> getPlayRevPre(String play_cd);
	
	//----------------------------------------------------------
	
	// 찜 추가 메소드
	public Integer addJjim(Jjim jjim);
	
	// 찜 중복 체크 메소드
	public Integer checkJjim(Jjim jjim);
	
	// 찜 제거 메소드
	public Integer delJjim(Jjim jjim);
	
	//----------------------------------------------------------
	
	// 공연 리뷰 블라인드 여부 체크 메소드
	public PlayRevBlind checkRepPlay(String play_rev_cd);
	// 일반 좌석 리뷰 신고 여부 체크 메소드
	public SeatRevBlind checkRepSeat(String seat_rev_cd);
	// 5대 좌석 리뷰 신고 여부 체크 메소드
	public MseatRevBlind checkRepMseat(String mseat_rev_cd);
	
	//---------------------------------------------------------
	
	// 공연 리뷰 최신순 하나만 출력하는 메소드 (뉴비, 어둠회원)
	public ArrayList<PlayRevPre> getPlayRevPreFirst(String play_cd);
	
	// 멤버 등급 얻어오는 메소드
	public String getUserGrade(String user_id);
	
	// 별점 평균 산출하는 메소드
	public Integer getRatingAvg(String play_cd);

}
