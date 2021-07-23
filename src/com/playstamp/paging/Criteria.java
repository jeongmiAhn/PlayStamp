package com.playstamp.paging;

public class Criteria
{
	// 특정 페이지 조회를 위한 페이징 처리 클래스
	//-- 게시글 조회 쿼리에 전달될 파라미터를 담을 클래스
	private int pageNum;		//-- 페이지 수
	private int amount;			//-- 한 페이지 당 보이게 할 게시글의 수
	
	
	// 생성자를 통해 기본값을 1페이지, 10개로 지정해 처리
	public Criteria()
	{
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount)
	{
		this.pageNum = pageNum;
		this.amount = amount;
	}
	

	// getter, setter 구성
	public int getPageNum()
	{
		return pageNum;
	}

	public void setPageNum(int pageNum)
	{
		this.pageNum = pageNum;
	}

	public int getAmount()
	{
		return amount;
	}

	public void setAmount(int amount)
	{
		this.amount = amount;
	}


	@Override
	public String toString()
	{
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + "]";
	}
}
