/*
	Point.java
	- 사용자 주요 속성 구성(DTO)
*/
package com.playstamp.myspace;

import org.springframework.stereotype.Repository;

@Repository
public class Cash
{
	// 캐시 적립/차감 사유, 캐시 적립/차감 날짜, 적립/차감된 캐시, 현재 사용자 캐시
	private String bno;
	private String cash_y, cash_dt, cash, user_cash;

	public String getBno()
	{
		return bno;
	}

	public void setBno(String bno)
	{
		this.bno = bno;
	}

	public String getCash_y()
	{
		return cash_y;
	}

	public void setCash_y(String cash_y)
	{
		this.cash_y = cash_y;
	}

	public String getCash_dt()
	{
		return cash_dt;
	}

	public void setCash_dt(String cash_dt)
	{
		this.cash_dt = cash_dt;
	}

	public String getCash()
	{
		return cash;
	}

	public void setCash(String cash)
	{
		this.cash = cash;
	}

	public String getUser_cash()
	{
		return user_cash;
	}

	public void setUser_cash(String user_cash)
	{
		this.user_cash = user_cash;
	}

}
