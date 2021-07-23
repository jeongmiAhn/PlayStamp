package com.playstamp.review;

public class MyReviewPoster
{
	// 나의 리뷰를 포스터(갤러리) 형식으로 조회할 수 있는 페이지
	private String rev_distin_cd;		//-- 리뷰식별코드
	private String user_cd;				//-- 사용자 코드
	private String play_cd;				//-- 공연 코드
	private String title;				//-- 리뷰 제목 (상세 리뷰 제목)
	private String play_img;			//-- 공연 포스터
	
	public String getRev_distin_cd()
	{
		return rev_distin_cd;
	}
	public void setRev_distin_cd(String rev_distin_cd)
	{
		this.rev_distin_cd = rev_distin_cd;
	}
	public String getUser_cd()
	{
		return user_cd;
	}
	public void setUser_cd(String user_cd)
	{
		this.user_cd = user_cd;
	}
	public String getPlay_cd()
	{
		return play_cd;
	}
	public void setPlay_cd(String play_cd)
	{
		this.play_cd = play_cd;
	}
	public String getPlay_img()
	{
		return play_img;
	}
	public void setPlay_img(String play_img)
	{
		this.play_img = play_img;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}

}
