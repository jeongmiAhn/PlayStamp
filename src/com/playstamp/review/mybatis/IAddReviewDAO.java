/*======================
     IAddReviewDAO.java
     - 인터페이스
=======================*/

package com.playstamp.review.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.playstamp.review.Companion;
import com.playstamp.review.DistinctReview;
import com.playstamp.review.MSeatReview;
import com.playstamp.review.ModifyPoster;
import com.playstamp.review.MyReviewPoster;
import com.playstamp.review.Play;
import com.playstamp.review.ReviewDetail;
import com.playstamp.review.SeatReview;

public interface IAddReviewDAO
{
	public ArrayList<Play> playList();  							//-- 공연 정보를 모두 조회해서 가져오는 메소드
	public String searchPlayCd(String play_nm);						//-- 사용자가 선택한 공연명에 대한 공연 코드를 가져오는 메소드
	public int addDistinctReview(DistinctReview distinctReview);    //-- 리뷰 식별 테이블에 Insert하는 메소드
	public String searchRevDistinCd(DistinctReview distinctReview); //-- 리뷰 식별코드 가져오는 메소드
	public Play searchPlay(String play_cd);							//-- 공연코드로 모든 공연 정보를 가져오는 메소드
	public String playCdByDistin(String rev_distin_cd);				//-- 리뷰식별코드로 공연 코드 가져오는 메소드
	public String searchTheater(String play_cd);					//-- 공연코드로 공연장 코드를 가져오는 메소드
	public String searchTheaterCd(String rev_distin_cd);			//-- 리뷰식별코드로 공연장 코드 가져오는 메소드
	
	
	public int addSeatReview(SeatReview seatreview);				//-- 일반 공연장의 좌석 리뷰 테이블에 Insert 하는 메소드
	public int addMSeatReview(MSeatReview mseatreview);				//-- 5대 공연장의 좌석 리뷰 테이블에 Insert 하는 메소드
	
	
	public String searchTheaterName(String theater_cd);				//-- 공연장 코드로 공연장 명 가져오기
	public ArrayList<Companion> companion();						//-- 함께 본 사람 select 리스트 가져오기
	public int addReviewDetail(ReviewDetail reviewdetail);			//-- 공연 리뷰 테이블에 Insert 하는 메소드
	
	public ArrayList<MyReviewPoster> myReviewPoster(String user_cd);//-- 포스터 형식으로 해당 사용자의 리뷰만 뿌려주기

	public SeatReview getSeatReview(String rev_distin_cd);       	//-- 리뷰식별코드의 좌석 리뷰 내용 가져오기 (일반공연장)
	public MSeatReview getMSeatReview(String rev_distin_cd);     	//-- 5대 공연장 좌석 리뷰 내용 가져오기
	public ReviewDetail getReviewDetail(String rev_distin_cd);		//-- 리뷰식별코드의 상세 공연 리뷰 내용 가져오기
	public int modifySeatReview(SeatReview seatreview);				//-- 좌석 리뷰의 수정 액션처리 (일반 공연장)
	public int modifyMSeatReview(MSeatReview mseatreview);			//-- 좌석 리뷰의 수정 액션처리 (5대 공연장)
	public int modifyReviewDetail(ReviewDetail reviewdetail);		//-- 공연 리뷰의 수정 액션처리
	
	public int removeSeatReview(String rev_distin_cd);				//-- 삭제 액션처리(일반 공연장)
	public int removeMSeatReview(String rev_distin_cd);				//-- 삭제 액션처리(5대 공연장)
	public int removeReviewDetail(String rev_distin_cd);			//-- 공연 상세 리뷰 삭제 액션처리
	public int removeReviewDistin(String rev_distin_cd);			//-- 리뷰 식별코드 삭제 액션처리
	
	public int modifyPosterImg(ModifyPoster modifyposter);			//-- 리뷰 수정 시 첨부 파일 업로드 처리
	
	public int plusPoint(String user_cd);							//-- 리뷰 작성 시 포인트 추가	
	public int minusPoint(String user_cd);							//-- 리뷰 삭제 시 포인트 차감
	
	//-- 트랜잭션 처리
	

}


