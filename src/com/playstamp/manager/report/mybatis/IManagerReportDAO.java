package com.playstamp.manager.report.mybatis;

import java.util.ArrayList;

import com.playstamp.manager.report.DetailReport;
import com.playstamp.manager.report.ManagerReport;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;

public interface IManagerReportDAO
{
	// 전체 데이터 수를 파라미터로 받아 총 페이지 구성하기
	//-- (PageDTO): 이전, 다음, 마지막 페이지 구성
	public PageDTO page(int total);
		
	// 사용자들이 신고한 글들(관리자가 처리 필요한) 개수 가져오기
	public int checkListTotal();
	
	// 사용자들이 신고한 내역 (확인 필요 리스트) 모두 가져오기
	public ArrayList<ManagerReport> checkList(ReverseCriteria rc);
	
	// 관리자가 처리한 글들 개수 가져오기
	public int doneListTotal();
	
	// 관리자가 처리한 내역 (처리 완료 리스트) 모두 가져오기
	public ArrayList<ManagerReport> doneList(ReverseCriteria rc);

	// 신고된 댓글의 상세 내역 가져오기
	public DetailReport commentReport(String rep_cd);
	
	// 신고된 리뷰 글의 상세 내역 가져오기
	public DetailReport reviewReport(String rep_cd);
	
	// 신고된 일반/5대 공연장 좌석 리뷰글의 상세 내역 가져오기
	public DetailReport seatReport(String rep_cd);
		
	// 신고된 5대 공연장 좌석 리뷰글의 상세 내역 가져오기
	public DetailReport mseatReport(String rep_cd);
	
	// 신고자 포인트 차감 (신고 반려)
	public int reporterPointMinus(String reporter_cd);
	
	// 피신고자 포인트 차감 (신고 승인)
	public int writerPointMinus(String writer_cd);
	
	// 댓글 신고 처리 액션
	public int commentDone(DetailReport dr);
	
	// 리뷰 신고 처리 액션
	public int reviewDone(DetailReport dr);
	
	// 좌석 리뷰 신고 처리 액션
	public int seatDone(DetailReport dr);
	
	// 5대 좌석 리뷰 신고 처리 액션
	public int mseatDone(DetailReport dr);

	
}
