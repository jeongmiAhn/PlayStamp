package com.playstamp.api;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;


public class TheaterDAO
{
	// 주요 변수 선언 → DB 연결 객체
	private Connection conn;

    // 생성자 정의
	public TheaterDAO() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
	}

	public int addTheater(Theater theater) throws SQLException
	{
		int result = 0;
		
		String sql = "INSERT INTO TBL_THEATER(THEATER_CD, THEATER, MSEAT) VALUES(?, ?, 0)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, theater.getTheaterCd());
		pstmt.setString(2, theater.getTheater());
		
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
}
