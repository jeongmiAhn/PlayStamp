package com.playstamp.manager.home.mybatis;

import java.util.ArrayList;

import com.playstamp.manager.home.ManagerHome;
import com.playstamp.manager.report.ManagerReport;

public interface IManagerHomeDAO
{
	// 총 사용자 수 구하기
	public int countUser();
	
	// 총 리뷰 수 구하기
	public int countPlayRev();
	
	// 가입 회원 통계
	public ManagerHome statisticsUserTotal(String year);
	
	// 방문 회원 통계
	public ManagerHome statisticsVisitorTotal(String year);
	
	// 신고 처리 필요한 총 개수
	public int fiveCheckTotal();
	
	// 신고 처리 필요리스트 (최신 5개 조회)
	public ArrayList<ManagerReport> fiveCheckList(int total);
}
