package com.playstamp.review;

public class DistinctReview
{
	private String rev_distin_cd;	// 리뷰 식별 코드
	private String user_cd;			// 사용자 코드
	private String play_cd;			// 공연 코드
	
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
}
