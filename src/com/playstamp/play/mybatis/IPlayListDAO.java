package com.playstamp.play.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.play.PlayList;

// 공연정보 인터페이스
public interface IPlayListDAO
{
	// 공연중인 뮤지컬 출력 메소드
	public ArrayList<PlayList> getMusicalList(String playState) throws SQLException;

	// 공연완료인 연극 출력 메소드
	public ArrayList<PlayList> getDramaList(String playState) throws SQLException;	
}
