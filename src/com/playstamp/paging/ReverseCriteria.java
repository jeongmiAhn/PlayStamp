package com.playstamp.paging;

public class ReverseCriteria
{
	// 특정 페이지 조회를 위한 페이징 처리 클래스
	//-- 게시글 조회 쿼리에 전달될 파라미터를 담을 클래스
	private int pageNum;		//-- 페이지 수
	private int amount;			//-- 한 페이지 당 보이게 할 게시글의 수
	private int total;			//-- 총 페이지 수
	
	private String user_cd;		//-- 자신이 한 활동에 대해서만 보여주기 위해 받는 사용자 코드
	private String user_id, grade, point;
	
	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public String getPoint()
	{
		return point;
	}

	public void setPoint(String point)
	{
		this.point = point;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public void setUser_id(String user_id)
	{
		this.user_id = user_id;
	}

	public ReverseCriteria()
	{
	}
	
	public ReverseCriteria(int pageNum, int amount, int total, String user_cd, String user_id)
	{
		this.pageNum = pageNum;
		this.amount = amount;
		this.total = total;
		this.user_cd = user_cd;
		this.user_id = user_id;
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

	public int getTotal()
	{
		return total;
	}

	public void setTotal(int total)
	{
		this.total = total;
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
