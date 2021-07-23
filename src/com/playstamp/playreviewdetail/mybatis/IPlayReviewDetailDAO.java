package com.playstamp.playreviewdetail.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.playstamp.playdetail.SeatRevBlind;
import com.playstamp.playreviewdetail.Comment;
import com.playstamp.playreviewdetail.CommentBlind;
import com.playstamp.playreviewdetail.CommentPoint;
import com.playstamp.playreviewdetail.Like;
import com.playstamp.playreviewdetail.PlayReviewDetail;

public interface IPlayReviewDetailDAO
{
	//@@ 공연리뷰 상세에 정보를 뿌려 줄 메소드
	public ArrayList<PlayReviewDetail> getPlayReviewDetail(String playrev_cd);
	
	//@@ 댓글 목록 출력 메소드
	public ArrayList<Comment> getCommentList(String playrev_cd);
	
	//@@ 댓글 추가 메소드
	public int addComment(Comment comment);
	
	//@@ 댓글 코드로 댓글을 삭제하는 메소드
	public int removeComment(Comment comment);
	
	//@@ 좋아요 추가 메소드
	public int addHeart(Like like);
	
	//@@ 좋아요 카운트 메소드
	public int countHeart(Like like);
	
	//@@ 좋아요 중복 체크 메소드
	public int checkHeart(Like like);
	
	//@@ 좋아요 제거 메소드
	public int delHeart(Like like);
	
	// 일반 좌석 리뷰 신고 여부 체크 메소드
	public CommentBlind checkRepCom(String comment_cd);
	
	// 멤버 등급 얻어오는 메소드
	//public String getUserGrade(String user_id);
	
	// 별점 평균 산출하는 메소드
	public Integer getRatingAvg(String play_cd);
	
	// 좋아요 눌렀을 때 포인트 적립 메소드
	public int addHeartPoint(String user_cd);
	
	// 좋아요 삭제했을 때 포인트 차감 메소드
	public int delHeartPoint(String user_cd);
	
	// 좋아요 적립 제한 카운트 메소드
	public int countAddHeart(String user_cd);
	
	// 해당 리뷰 좋아요로 포인트를 적립받았는지 확인하는 메소드
	public String ifUserAddHeart(@Param("user_cd")String user_cd, @Param("playrev_cd")String playrev_cd);
	
	// 댓글 달았을 때 포인트 적립 메소드
	public int addCommentPoint(String user_cd);
	
	// 댓글 삭제했을 때 포인트 차감 메소드
	public int delCommentPoint(String user_cd);
	
	// 댓글 포인트 적립 제한 카운트 메소드
	public int countAddComment(String user_cd);
	
	// 해당 댓글로 포인트를 적립받았는지 확인하는 메소드
	public CommentPoint ifUserAddComment(@Param("comment_cd")String comment_cd);
}
