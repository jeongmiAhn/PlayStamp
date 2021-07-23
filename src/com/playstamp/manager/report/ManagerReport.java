package com.playstamp.manager.report;

public class ManagerReport
{
	// 관리자 확인이 필요한 신고된 내용+신고 처리된 내용을 담는 DTO 클래스
	//-- 리뷰댓글, 리뷰글, 좌석리뷰글, 5대 좌석 리뷰글 테이블들에서 모두 값을 가져와야 한다.
	//   각 테이블마다 신고 처리 현황/신고사유/신고내용(제목, 댓글)를 보여주는 View를 생성한 뒤
	//   그 View들로부터 DTO를 가져온다.
	
	// 관리자의 신고 관리 - 확인 필요+처리 완료 탭에서 보여줄 내용들
	private String bno;				//-- 게시판 목록에서 보여 줄 번호 (신고 코드: rep_cd 기준)
	private String rep_contents;	//-- 신고 당한 대상의 신고 내용
	private String writer;			//-- 신고 대상 작성자
	private String reporter;		//-- 신고자
	private String rep_y;			//-- 신고 카테고리 (관리자가 결정하는 최종 신고 사유)
	private String rep_dt;			//-- 신고 일시
	private String boardCategory;	//-- 게시판 분류
	
	// 신고 처리 완료 탭에서 추가로 더 보여줄 내용들
	private String rep_st;			//-- 신고 처리 현황 내용 (승인, 반려)
	private String rep_ch_dt;		//-- 처리 일시

	// 신고 내용 클릭 시 넘겨 줄 값: 게시판 카테고리, 신고 코드
	private String rep_cd;			//-- 상세 내용 조회 시 사용할 신고 코드(댓글, 리뷰글, 좌석글, 5대 좌석글 번호)
	private String reported_cd;		//-- 글 클릭 시 이동시킬 원래 글 코드 (리뷰식별코드, 댓글코드)
	
	// getter, setter 구성
	public String getBno()
	{
		return bno;
	}

	public void setBno(String bno)
	{
		this.bno = bno;
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

	public String getReporter()
	{
		return reporter;
	}

	public void setReporter(String reporter)
	{
		this.reporter = reporter;
	}

	public String getRep_y()
	{
		return rep_y;
	}

	public void setRep_y(String rep_y)
	{
		this.rep_y = rep_y;
	}

	public String getRep_dt()
	{
		return rep_dt;
	}

	public void setRep_dt(String rep_dt)
	{
		this.rep_dt = rep_dt;
	}

	public String getBoardCategory()
	{
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory)
	{
		this.boardCategory = boardCategory;
	}

	public String getRep_st()
	{
		return rep_st;
	}

	public void setRep_st(String rep_st)
	{
		this.rep_st = rep_st;
	}

	public String getRep_ch_dt()
	{
		return rep_ch_dt;
	}

	public void setRep_ch_dt(String rep_ch_dt)
	{
		this.rep_ch_dt = rep_ch_dt;
	}

	public String getRep_cd()
	{
		return rep_cd;
	}

	public void setRep_cd(String rep_cd)
	{
		this.rep_cd = rep_cd;
	}

	public String getReported_cd()
	{
		return reported_cd;
	}

	public void setReported_cd(String reported_cd)
	{
		this.reported_cd = reported_cd;
	}
	

}
