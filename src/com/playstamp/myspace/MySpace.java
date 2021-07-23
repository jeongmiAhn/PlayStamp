/*
	MySpace.java
	- 사용자 주요 속성 구성(DTO)
*/
package com.playstamp.myspace;

import org.springframework.stereotype.Repository;

@Repository
public class MySpace
{
	// 월별 통계 받기 위해 12개
	private int jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec;

	public int getJan()
	{
		return jan;
	}

	public void setJan(int jan)
	{
		this.jan = jan;
	}

	public int getFeb()
	{
		return feb;
	}

	public void setFeb(int feb)
	{
		this.feb = feb;
	}

	public int getMar()
	{
		return mar;
	}

	public void setMar(int mar)
	{
		this.mar = mar;
	}

	public int getApr()
	{
		return apr;
	}

	public void setApr(int apr)
	{
		this.apr = apr;
	}

	public int getMay()
	{
		return may;
	}

	public void setMay(int may)
	{
		this.may = may;
	}

	public int getJun()
	{
		return jun;
	}

	public void setJun(int jun)
	{
		this.jun = jun;
	}

	public int getJul()
	{
		return jul;
	}

	public void setJul(int jul)
	{
		this.jul = jul;
	}

	public int getAug()
	{
		return aug;
	}

	public void setAug(int aug)
	{
		this.aug = aug;
	}

	public int getSep()
	{
		return sep;
	}

	public void setSep(int sep)
	{
		this.sep = sep;
	}

	public int getOct()
	{
		return oct;
	}

	public void setOct(int oct)
	{
		this.oct = oct;
	}

	public int getNov()
	{
		return nov;
	}

	public void setNov(int nov)
	{
		this.nov = nov;
	}

	public int getDec()
	{
		return dec;
	}

	public void setDec(int dec)
	{
		this.dec = dec;
	}

}
