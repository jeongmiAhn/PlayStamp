package com.playstamp.manager.manage.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.manager.manage.ManagerList;
import com.playstamp.manager.manage.Manager;

public interface IManager
{
	public ArrayList<ManagerList> managerList() throws SQLException;
	
	// 운영진 등록할 때 중복 아이디 체크
	public int managerIdCheck(String managerId);
	
	// 운영진 등록
	public void managerInsert(Manager manager) throws SQLException, ClassNotFoundException;

	// 특정 운영진 정보 조회
	public Manager managerInfo(String mng_id);
	
	// 운영진 정보 수정
	public void managerUpdate(Manager manager);
	
	// 운영진 정보 삭제
	public void managerDelete(String mng_id);
}
