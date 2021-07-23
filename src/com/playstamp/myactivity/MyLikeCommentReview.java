package com.playstamp.myactivity;


public class MyLikeCommentReview
{
	// 보여 줄 게시글의 객체 클래스
	//-- 나의 활동에서 좋아요 누른 or 댓글 단 리뷰 글 목록에서 보여줄 게시글들의 정보
	//  : 목록에서 보여 줄 게시글 번호(rownum), 공연명, 제목, 작성자, 작성일, 조회수
	private String bno;
	private String playrev_cd;		//-- 공연 리뷰 상세글로 넘어가기 위해 필요한 파라미터1
	private String play_cd;			//-- 공연 리뷰 상세글로 넘어가기 위해 필요한 파라미터2
	private String play_nm;
	private String title;
	private String user_nick;
	private String playrev_dt;
	private String view_cnt;
	
	private String user_cd;			//-- 조회 시 파라미터로 넘기기 위해 필요한 사용자 코드
	
	private String rev_distin_cd;	//-- 제목 클릭시 정보 넘기기 위해 필요한 리뷰 식별코드
	
	// getter, setter
	public String getBno()
	{
		return bno;
	}
	public void setBno(String bno)
	{
		this.bno = bno;
	}
	public String getPlayrev_cd()
	{
		return playrev_cd;
	}
	public void setPlayrev_cd(String playrev_cd)
	{
		this.playrev_cd = playrev_cd;
	}
	public String getPlay_cd()
	{
		return play_cd;
	}
	public void setPlay_cd(String play_cd)
	{
		this.play_cd = play_cd;
	}
	public String getPlay_nm()
	{
		return play_nm;
	}
	public void setPlay_nm(String play_nm)
	{
		this.play_nm = play_nm;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getUser_nick()
	{
		return user_nick;
	}
	public void setUser_nick(String user_nick)
	{
		this.user_nick = user_nick;
	}
	public String getPlayrev_dt()
	{
		return playrev_dt;
	}
	public void setPlayrev_dt(String playrev_dt)
	{
		this.playrev_dt = playrev_dt;
	}
	public String getView_cnt()
	{
		return view_cnt;
	}
	public void setView_cnt(String view_cnt)
	{
		this.view_cnt = view_cnt;
	}
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
	
	
}
