package com.playstamp.review;

import java.sql.Date;

public class ReviewDetail
{
	// 공연리뷰 테이블과 동일한 구조
	// 단, 편의상 number는 String으로 받음
	
	private String playrev_cd;		//-- 리뷰 코드
	private String rev_distin_cd;	//-- 리뷰 식별 코드
	private String companion_cd;	//-- 동행인 분류 코드
	private String companion;		//-- 동행인명
	private String playrev_dt;		//-- 작성일자
	private String title;			//-- 제목
	private String rating_cd;		//-- 평점 코드
	private String contents;		//-- 리뷰 내용
	private String play_img;		//-- 첨부 사진
	private String play_dt;			//-- 공연 날짜
	private String play_time;		//-- 공연 시간(관람 시간)
	private String play_money;		//-- 티켓 금액
	private String play_cast;		//-- 출연진
	private String view_cnt;		//-- 조회수
	
	public String getPlayrev_cd()
	{
		return playrev_cd;
	}
	public void setPlayrev_cd(String playrev_cd)
	{
		this.playrev_cd = playrev_cd;
	}
	public String getRev_distin_cd()
	{
		return rev_distin_cd;
	}
	public void setRev_distin_cd(String rev_distin_cd)
	{
		this.rev_distin_cd = rev_distin_cd;
	}
	public String getCompanion_cd()
	{
		return companion_cd;
	}
	public void setCompanion_cd(String companion_cd)
	{
		this.companion_cd = companion_cd;
	}
	public String getPlayrev_dt()
	{
		return playrev_dt;
	}
	public void setPlayrev_dt(String playrev_dt)
	{
		this.playrev_dt = playrev_dt;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getRating_cd()
	{
		return rating_cd;
	}
	public void setRating_cd(String rating_cd)
	{
		this.rating_cd = rating_cd;
	}
	public String getContents()
	{
		return contents;
	}
	public void setContents(String contents)
	{
		this.contents = contents;
	}
	public String getPlay_img()
	{
		return play_img;
	}
	public void setPlay_img(String play_img)
	{
		this.play_img = play_img;
	}
	public String getPlay_dt()
	{
		return play_dt;
	}
	public void setPlay_dt(String play_dt)
	{
		this.play_dt = play_dt;
	}
	public String getPlay_time()
	{
		return play_time;
	}
	public void setPlay_time(String play_time)
	{
		this.play_time = play_time;
	}
	public String getPlay_money()
	{
		return play_money;
	}
	public void setPlay_money(String play_money)
	{
		this.play_money = play_money;
	}
	public String getPlay_cast()
	{
		return play_cast;
	}
	public void setPlay_cast(String play_cast)
	{
		this.play_cast = play_cast;
	}
	public String getView_cnt()
	{
		return view_cnt;
	}
	public void setView_cnt(String view_cnt)
	{
		this.view_cnt = view_cnt;
	}
	public String getCompanion()
	{
		return companion;
	}
	public void setCompanion(String companion)
	{
		this.companion = companion;
	}
}
