package com.playstamp.review;

import java.sql.Date;

public class Play
{
	private String play_cd, theater_cd;	//-- 공연 코드, 공연장 코드
	private String theater;				//-- 공연장 명
	private int genre_cd;				//-- 공연 장르 코드
	private String mng_cd, play_nm;		//-- 관리자코드, 공연명
	private Date play_start, play_end; 	//-- 공연 시작일자, 공연 종료일자
	private String play_img, play_cast;	//-- 포스터, 출연진
	private Date playRegister;			//-- 등록일
	
	// getter, setter 구성
	public String getPlay_cd()
	{
		return play_cd;
	}
	public void setPlay_cd(String play_cd)
	{
		this.play_cd = play_cd;
	}
	public String getTheater_cd()
	{
		return theater_cd;
	}
	public void setTheater_cd(String theater_cd)
	{
		this.theater_cd = theater_cd;
	}
	public int getGenre_cd()
	{
		return genre_cd;
	}
	public void setGenre_cd(int genre_cd)
	{
		this.genre_cd = genre_cd;
	}
	public String getMng_cd()
	{
		return mng_cd;
	}
	public void setMng_cd(String mng_cd)
	{
		this.mng_cd = mng_cd;
	}
	public String getPlay_nm()
	{
		return play_nm;
	}
	public void setPlay_nm(String play_nm)
	{
		this.play_nm = play_nm;
	}
	public Date getPlay_start()
	{
		return play_start;
	}
	public void setPlay_start(Date play_start)
	{
		this.play_start = play_start;
	}
	public Date getPlay_end()
	{
		return play_end;
	}
	public void setPlay_end(Date play_end)
	{
		this.play_end = play_end;
	}
	public String getPlay_img()
	{
		return play_img;
	}
	public void setPlay_img(String play_img)
	{
		this.play_img = play_img;
	}
	public String getPlay_cast()
	{
		return play_cast;
	}
	public void setPlay_cast(String play_cast)
	{
		this.play_cast = play_cast;
	}
	public Date getPlayRegister()
	{
		return playRegister;
	}
	public void setPlayRegister(Date playRegister)
	{
		this.playRegister = playRegister;
	}
	public String getTheater()
	{
		return theater;
	}
	public void setTheater(String theater)
	{
		this.theater = theater;
	}
}
