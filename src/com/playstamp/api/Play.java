package com.playstamp.api;

import java.sql.Date;

public class Play
{
	String playCd, theaterCd;	//-- 공연 코드, 공연장 코드
	int genreCd;				//-- 공연 장르 코드
	int stateCd;				//-- 공연 상태코드
	String mngCd, playNm;		//-- 관리자코드, 공연명
	Date playStart, playEnd; 	//-- 공연 시작일자, 공연 종료일자
	String playImg, playCast;	//-- 포스터, 출연진
	Date playRegister;			//-- 등록일
	
	public String getPlayCd()
	{
		return playCd;
	}
	public void setPlayCd(String playCd)
	{
		this.playCd = playCd;
	}
	public String getTheaterCd()
	{
		return theaterCd;
	}
	public void setTheaterCd(String theaterCd)
	{
		this.theaterCd = theaterCd;
	}
	public int getGenreCd()
	{
		return genreCd;
	}
	public void setGenreCd(int genreCd)
	{
		this.genreCd = genreCd;
	}
	public int getStateCd()
	{
		return stateCd;
	}
	public void setStateCd(int stateCd)
	{
		this.stateCd = stateCd;
	}
	public String getMngCd()
	{
		return mngCd;
	}
	public void setMngCd(String mngCd)
	{
		this.mngCd = mngCd;
	}
	public String getPlayNm()
	{
		return playNm;
	}
	public void setPlayNm(String playNm)
	{
		this.playNm = playNm;
	}
	public Date getPlayStart()
	{
		return playStart;
	}
	public void setPlayStart(Date playStart)
	{
		this.playStart = playStart;
	}
	public Date getPlayEnd()
	{
		return playEnd;
	}
	public void setPlayEnd(Date playEnd)
	{
		this.playEnd = playEnd;
	}
	public String getPlayImg()
	{
		return playImg;
	}
	public void setPlayImg(String playImg)
	{
		this.playImg = playImg;
	}
	public String getPlayCast()
	{
		return playCast;
	}
	public void setPlayCast(String playCast)
	{
		this.playCast = playCast;
	}
	public Date getPlayRegister()
	{
		return playRegister;
	}
	public void setPlayRegister(Date playRegister)
	{
		this.playRegister = playRegister;
	}
}
