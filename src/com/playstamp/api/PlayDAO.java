package com.playstamp.api;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PlayDAO
{
	private Connection conn;
	
	public PlayDAO() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
	}
	
	// 공연 코드 임시 테이블에 공연 코드만 먼저 추가
	public int addCodeOnly(String playCode) throws SQLException
	{
		int result = 0;
		
		String sql = "INSERT INTO PLAY_CD VALUES (?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, playCode);
		
		result = pstmt.executeUpdate();
		pstmt.close();
		//conn.close();
		
		return result;
	}
	
	// 공연 코드 다 조회해서 가져오기
	public ArrayList listPlayCode() throws SQLException
	{
		ArrayList result = new ArrayList();
		
		String sql = "SELECT PLAY_CD FROM PLAY_CD";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
		{
			String playCd= rs.getString("PLAY_CD");
			result.add(playCd);
		}
		pstmt.close();
		
		return result;
	}
	

	// 공연 정보 테이블에 데이터 추가
	public int addPlay(Play play) throws SQLException
	{
		int result = 0;
		
		String sql = "INSERT INTO TBL_PLAY(PLAY_CD, THEATER_CD, GENRE_CD, MNG_CD, PLAY_NM,"
				+ " PLAY_START, PLAY_END, PLAY_IMG, PLAY_CAST)"
				+ " VALUES (?, ?, ?, ?,"
				+ " TO_DATE(?, 'YYYY-MM-DD'),"
				+ " TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, play.getPlayCd());
		pstmt.setString(2, play.getTheaterCd());
		pstmt.setInt(3, play.getGenreCd());
		pstmt.setString(4, play.getMngCd());
		pstmt.setString(5, play.getPlayNm());
		pstmt.setDate(6, play.getPlayStart());
		pstmt.setDate(7, play.getPlayEnd());
		pstmt.setString(8, play.getPlayImg());
		pstmt.setString(9, play.getPlayCast());
		
		result = pstmt.executeUpdate();
		pstmt.close();
		//conn.close();
		
		return result;
		
	}
}
