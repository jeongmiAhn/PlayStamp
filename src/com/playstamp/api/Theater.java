package com.playstamp.api;

public class Theater
{
	private String theaterCd;		//-- 공연장코드
	private String theater;			//-- 공연장명
	private int mseat;				//-- 특별관리여부
	public String getTheaterCd()
	{
		return theaterCd;
	}
	public void setTheaterCd(String theaterCd)
	{
		this.theaterCd = theaterCd;
	}
	public String getTheater()
	{
		return theater;
	}
	public void setTheater(String theater)
	{
		this.theater = theater;
	}
	public int getMseat()
	{
		return mseat;
	}
	public void setMseat(int mseat)
	{
		this.mseat = mseat;
	}
}