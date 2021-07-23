package com.playstamp.paging;

public class PageDTO
{
	private int startPage;			//-- 화면에서 보여지는 페이지의 시작 번호
	private int endPage;			//-- 화면에서 보여지는 페이지의 끝 번호
	private boolean prev, next;		//-- 이전과 다음으로 이동 가능한 링크의 표시 여부
	
	private int total;				//-- 전체 데이터 수
	private Criteria cri;			//-- 페이지에서 보여주는 데이터 수(amount) + 현재 페이지 번호(pageNum) 가진 객체
	
	public PageDTO(Criteria cri, int total)
	{
		this.cri = cri;
		this.total = total;
		
		// 페이징의 끝 번호 계산
		this.endPage = (int) (Math.ceil(cri.getPageNum()/10.0))*10;
		
		// 페이징의 시작 번호 계산
		this.startPage = this.endPage - 9;
		
		// 전체 데이터 수를 통한 페이징의 끝 번호 계산
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		if(realEnd < this.endPage)
		{
			this.endPage = realEnd;
		}
		
		// 이전 계산 (시작번호가 1보다 크다면 존재)
		this.prev = this.startPage >1;
		
		// 다음 계산 (끝 번호보다 realEnd가 더 큰 경우)
		this.next = this.endPage < realEnd;
	}

	// getter, setter 구성
	public int getStartPage()
	{
		return startPage;
	}

	public void setStartPage(int startPage)
	{
		this.startPage = startPage;
	}

	public int getEndPage()
	{
		return endPage;
	}

	public void setEndPage(int endPage)
	{
		this.endPage = endPage;
	}

	public boolean isPrev()
	{
		return prev;
	}

	public void setPrev(boolean prev)
	{
		this.prev = prev;
	}

	public boolean isNext()
	{
		return next;
	}

	public void setNext(boolean next)
	{
		this.next = next;
	}

	public int getTotal()
	{
		return total;
	}

	public void setTotal(int total)
	{
		this.total = total;
	}

	public Criteria getCri()
	{
		return cri;
	}

	public void setCri(Criteria cri)
	{
		this.cri = cri;
	}

	@Override
	public String toString()
	{
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + "]";
	}
}
