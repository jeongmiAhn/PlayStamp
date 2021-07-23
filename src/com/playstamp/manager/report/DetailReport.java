package com.playstamp.manager.report;

public class DetailReport
{
	// 신고 당한 내역의 상세 내용을 보여주기 위한 클래스 (확인 필요 신고내용)
	private String title;				//-- 리뷰글인 경우 리뷰 제목
	private String rep_contents;		//-- 신고 내용(댓글내용, 좌석리뷰 내용..)
	private String writer;				//-- 글 작성자
	private String wr_dt;				//-- 글 작성 일자
	private String rep_y;				//-- 신고자가 선택한 사유
	
	// 신고 처리 테이블에 insert 시 필요한 정보 추가 + 포인트 처리 위해 필요한 정보
	private String rep_cd;				//-- 신고 코드
	private String writer_cd;			//-- 글 작성자 사용자 코드
	private String reporter_cd;			//-- 신고자 사용자 코드
	private String rep_y_cd;			//-- 최종 선택 신고 사유
	private String rep_st_cd;			//-- 승인(1), 반려(2)
	
	// getter, setter
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getRep_contents()
	{
		return rep_contents;
	}
	public void setRep_contents(String rep_contents)
	{
		this.rep_contents = rep_contents;
	}
	public String getWriter()
	{
		return writer;
	}
	public void setWriter(String writer)
	{
		this.writer = writer;
	}
	public String getWr_dt()
	{
		return wr_dt;
	}
	public void setWr_dt(String wr_dt)
	{
		this.wr_dt = wr_dt;
	}
	public String getRep_y()
	{
		return rep_y;
	}
	public void setRep_y(String rep_y)
	{
		this.rep_y = rep_y;
	}
	public String getRep_cd()
	{
		return rep_cd;
	}
	public void setRep_cd(String rep_cd)
	{
		this.rep_cd = rep_cd;
	}
	public String getWriter_cd()
	{
		return writer_cd;
	}
	public void setWriter_cd(String writer_cd)
	{
		this.writer_cd = writer_cd;
	}
	public String getReporter_cd()
	{
		return reporter_cd;
	}
	public void setReporter_cd(String reporter_cd)
	{
		this.reporter_cd = reporter_cd;
	}
	public String getRep_y_cd()
	{
		return rep_y_cd;
	}
	public void setRep_y_cd(String rep_y_cd)
	{
		this.rep_y_cd = rep_y_cd;
	}
	public String getRep_st_cd()
	{
		return rep_st_cd;
	}
	public void setRep_st_cd(String rep_st_cd)
	{
		this.rep_st_cd = rep_st_cd;
	}

}
