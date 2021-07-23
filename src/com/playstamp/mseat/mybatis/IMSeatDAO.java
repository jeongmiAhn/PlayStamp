package com.playstamp.mseat.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.mseat.MSeat;

public interface IMSeatDAO
{
	// 예술의전당 좌석평점 리스트
	public ArrayList<MSeat> listSac(String seatName) throws SQLException;
	
	
	// 블루스퀘어 좌석평점 리스트
	public ArrayList<MSeat> listBs(String seatName) throws SQLException;
	
	/*
	// 충무아트센터 좌석평점 리스트
	public ArrayList<MSeatDTO> listCac(String seatName) throws SQLException;
	
	// 디큐브아트센터 좌석평점 리스트
	public ArrayList<MSeatDTO> listDca(String seatName) throws SQLException;
	
	// 샤롯데씨어터 좌석평점 리스트
	public ArrayList<MSeatDTO> listClt(String seatName) throws SQLException;
	*/
}
