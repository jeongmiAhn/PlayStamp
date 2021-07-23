package com.playstamp.notice.mybatis;

import java.util.ArrayList;

import com.playstamp.notice.Notice;

public interface INoticeDAO
{
	//@@ 공지 목록 출력 메소드
	public ArrayList<Notice> getNoticeList();
	
	//@@ 공지 추가 메소드
	public int addNotice(Notice notice);
	
	//@@ 공지 수정 메소드
	public int updateNotice(Notice notice);
	
	//@@ 공지 코드로 공지 삭제하는 메소드
	public int deleteNotice(Notice notice);	
	
	//@@ 공지 코드로 공지 객체를 찾는 메소드
	public Notice searchNotice(Notice notice);
}
