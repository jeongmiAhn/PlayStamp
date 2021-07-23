/*
	MySpace.java
	- 사용자 주요 속성 구성(DTO)
*/
package com.playstamp.myspace;

import org.springframework.stereotype.Repository;

@Repository
public class MySpaceComp
{
	// 월별 통계 받기 위해 12개
	private int c1,c2,c3,c4,c5,c6;

	public int getC1()
	{
		return c1;
	}

	public void setC1(int c1)
	{
		this.c1 = c1;
	}

	public int getC2()
	{
		return c2;
	}

	public void setC2(int c2)
	{
		this.c2 = c2;
	}

	public int getC3()
	{
		return c3;
	}

	public void setC3(int c3)
	{
		this.c3 = c3;
	}

	public int getC4()
	{
		return c4;
	}

	public void setC4(int c4)
	{
		this.c4 = c4;
	}

	public int getC5()
	{
		return c5;
	}

	public void setC5(int c5)
	{
		this.c5 = c5;
	}

	public int getC6()
	{
		return c6;
	}

	public void setC6(int c6)
	{
		this.c6 = c6;
	}
	

}
