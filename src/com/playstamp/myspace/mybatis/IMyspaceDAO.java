package com.playstamp.myspace.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.myspace.Cash;
import com.playstamp.myspace.MySpace;
import com.playstamp.myspace.MySpaceComp;
import com.playstamp.myspace.Point;
import com.playstamp.paging.ReverseCriteria;
import com.playstamp.user.User;

public interface IMyspaceDAO
{
	public User searchUserInfo(String userId) throws SQLException;
	public void updateUserInfo(User user) throws SQLException;
	public void updateUserImg(String userId, String userImg) throws SQLException;
	
	//public ArrayList<Point> userPointList(String userId);
	public int countingLike(String userId);
	
	// 캐시 리스트, 총 개수, 현재 캐시
	public ArrayList<Cash> userCashList(ReverseCriteria rc);
	public Integer userCashListTotal(String user_cd);
	public Integer userCash(String user_cd);
	
	// 포인트 리스트, 총 개수, 현재 포인트
	public ArrayList<Point> userPointList(ReverseCriteria rc);
	public Integer userPointListTotal(String user_cd);
	public Integer userPoint(String user_cd);
	
	public void userDropProcedure(String user, int y) throws SQLException;
	public Integer countingRev(String userCode);
	public Integer countingJjim(String userCode);
	
	// 통계
	public MySpace statisticRevTotal(String year);
	public MySpace statisticRevUser(String year, String code);
	public Integer totalUser();
	public MySpaceComp statisticCompanion(String year, String code);
	public MySpace statisticMoney(String year, String code);
}
