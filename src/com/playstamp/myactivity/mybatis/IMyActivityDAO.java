package com.playstamp.myactivity.mybatis;

import java.util.ArrayList;


import com.playstamp.myactivity.MyLikeCommentReview;
import com.playstamp.myactivity.MyReportList;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;

public interface IMyActivityDAO
{
	// 나의 활동 내역 - 좋아요한 리뷰 글, 댓글 단 리뷰 글 조회, 신고 된 글, 신고한 글 조회 관련 메소드
	
	// 전체 데이터 수를 파라미터로 받아 총 페이지 구성하기
	//-- (PageDTO): 이전, 다음, 마지막 페이지 구성
	public PageDTO page(int total);
	
	// 내가 좋아요 한 리뷰 글 개수 가져오기
	public int likeReviewCount(String user_cd);
	
	// 내가 댓글 단 리뷰 글 개수 가져오기
	public int commentReviewCount(String user_cd);
	
	//테스트
	//public int playCount();
	
	// 내가 좋아요 한 리뷰 글 목록 가져오기
	public ArrayList<MyLikeCommentReview> getLikeListWithPaging(ReverseCriteria rc);
	
	// 내가 댓글 단 리뷰 글 목록 가져오기
	public ArrayList<MyLikeCommentReview> getCommentListWithPaging(ReverseCriteria rc);
	

	// 내가 신고한 글 개수 가져오기
	public int reportingTotal(String user_cd);
	
	// 내가 신고 당한 글 개수 가져오기
	public int reportedTotal(String user_cd);
		
	// 내가 신고한 글 목록 가져오기
	public ArrayList<MyReportList> myReportingList(ReverseCriteria rc);
	
	// 내가 신고 당한 내역 글 목록 가져오기
	public ArrayList<MyReportList> myReportedList(ReverseCriteria rc);
	

}
