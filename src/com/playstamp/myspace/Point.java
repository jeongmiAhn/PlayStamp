/*
	Point.java
	- 사용자 주요 속성 구성(DTO)
*/
package com.playstamp.myspace;

import org.springframework.stereotype.Repository;

@Repository
public class Point
{
	// 포인트 적립/차감 사유, 포인트 적립/차감 날짜, 적립/차감된 포인트, 현재 사용자 포인트
	private String bno;
	private String point_y, point_dt, point, user_point;

	
	public String getBno()
	{
		return bno;
	}

	public void setBno(String bno)
	{
		this.bno = bno;
	}

	public String getPoint_y()
	{
		return point_y;
	}

	public void setPoint_y(String point_y)
	{
		this.point_y = point_y;
	}

	public String getPoint_dt()
	{
		return point_dt;
	}

	public void setPoint_dt(String point_dt)
	{
		this.point_dt = point_dt;
	}

	public String getPoint()
	{
		return point;
	}

	public void setPoint(String point)
	{
		this.point = point;
	}

	public String getUser_point()
	{
		return user_point;
	}

	public void setUser_point(String user_point)
	{
		this.user_point = user_point;
	}

}
