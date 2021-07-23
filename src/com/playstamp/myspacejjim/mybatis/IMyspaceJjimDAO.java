package com.playstamp.myspacejjim.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;

import com.playstamp.myspacejjim.MyspaceJjim;
import com.playstamp.playdetail.Jjim;

public interface IMyspaceJjimDAO
{	
	//@@ 찜 리스트 출력 메소드
	public ArrayList<MyspaceJjim> getMyspaceJjimList(Jjim jjim);
}
