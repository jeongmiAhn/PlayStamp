package com.playstamp.manager.memberlist.mybatis;

import java.util.ArrayList;

import com.playstamp.manager.memberlist.ManagingPointList;
import com.playstamp.manager.memberlist.MemberList;
import com.playstamp.paging.PageDTO;
import com.playstamp.paging.ReverseCriteria;

public interface IMemberListDAO
{
	// 회원 리스트 조회 + 페이징 
	public ArrayList<MemberList> memberlist(ReverseCriteria cri);
	
	// 회원 정보 
	public ArrayList<MemberList> memberlist();
	
	// 총 회원 수 조회
	public int membercount();
	
	// 특정 회원 포인트 내역 조회
	public ArrayList<ManagingPointList> managingpointlist(ReverseCriteria cri);

	// 특정 회원의 포인트 내역 갯수 조회
	public int countmanagingpointlist(String user_id);
	
	// 회원 리스트 페이징
	public PageDTO page(int total);
	
	// 포인트 수정
	public void modifypoint(String user_id, String point);
}
