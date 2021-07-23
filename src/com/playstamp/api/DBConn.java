/*=============
  DBConn.java
===============*/

/*
※ 싱글톤(Singleton) 디자인 패턴을 이용한 Database 연결 객체 생성 전용 클래스
   → DB 연결 과정이 가장 부하가 크기 때문에
      한 번 연결된(생성된) 객체를 계속 사용하는 것이 좋다.
*/

package com.playstamp.api;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn
{
	//@@ 전역 변수 선언 - information hiding
	//@@ Connection 이라는 객체 타입을 취하는 변수 dbConn 
	private static Connection dbConn;
	//-- 객체는 자동 null 초기화
	
	// 메소드 정의 → 연결 
	// Connection 타입을 반환
	public static Connection getConnection()
	{
		// 한 번 연결된 객체를 계속 사용(@@ 화장실 갈 때 이 열쇠를 계속 사용)
		// 즉, 연결되지 않은 경우에만 연결을 시도하겠다는 의미
		// → 싱글톤(디자인 패턴)
		//@@ 프로그램 설계 에서 이런 설계 기법을 적용하면 좋다, 하고 하는 걸 수학에서의 공식과 같이 '디자인 패턴'이라고 한다.
		if (dbConn == null)
		{
			try
			{
				String url = "jdbc:oracle:thin:@211.238.142.163:1521:xe";
				//-- 『211.238.142.175』 는 오라클 서버 ip 주소를 기재하는 부분
				//    원격지의 오라클이 아니라 로컬의 오라클 서버일 경우는
				//   『localhost』 이나 『127.0.0.1』과 같이 loop back address 로 기재하는 것도 가능
				//   『1521』은 오라클 리스너 기본 Port Number
				//   『xe』는 오라클 SID(Express Edition 은 xe)
				
				String user = "playstamp";			//-- 오라클 사용자 계정 이름
				String pwd = "java006$";			//-- 오라클 사용자 계정 암호
				
				//@@ ① Oracle Driver 를 Java 에서 사용하기 위해 JVM 에 로딩
				//@@ type 1, 2, 3, 4 ... 다양하게 있으나 4에 해당하는 thin driver 사용
				Class.forName("oracle.jdbc.driver.OracleDriver");
				//-- OracleDriver 클래스에 대한 객체 생성
				//@@ "oracle.jdbc.driver.OracleDriver" < 요러한 클래스를 찾아라. 
				
				//@@ ② 커넥션 할당받기 
				dbConn = DriverManager.getConnection(url, user, pwd);
				//@@ DriverManager 는 여러 드라이버를 관리하는 객체 
				//-- 오라클 서버 실제 연결
				//   갖고 있는 인자값(매개변수)은 오라클주소, 계정명, 패스워드
				
			} catch(Exception e) // ClassNotFoundException, SQLException
			//@@ "oracle.jdbc.driver.OracleDriver" 얘를 잘못 넘겨서 못 찾을 경우, ClassNotFoundException
			//@@ getConnection(url, user, pwd); 매개 변수를 잘못 넘겼을 경우, SQLException
			{
				System.out.println(e.toString());
				//-- 오라클 서버 연결 실패 시 오류 메시지 출력 부분
			}	
		}
		return dbConn;
		//-- 구성된 연결 객체 반환
	}
	
	// getConnection() 메소드의 오버로딩 → 연결 
	public static Connection getConnection(String url, String user, String pwd)
	{
		if (dbConn == null)
		{
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				dbConn = DriverManager.getConnection(url, user, pwd);
			}catch (Exception e)
			{
				System.out.println(e.toString());
			}				
		}
		return dbConn;		
	}
	
	// 메소드 정의 →연결 종료
	public static void close()
	{
		// dbConn 변수(멤버 변수)는
		// Database 가 연결된 상태일 경우 Connection 을 갖는다.
		// 연결되지 않은 상태라면... null 을 갖는다. 
		if(dbConn != null) //@@ 연결되어 있다면 연결을 끊어라. 
		{
			try
			{
				// 연결 객체의 isClosed() 메소드를 통해 연결 상태 확인
				//-- 연결이 닫혀 있는 경우 true 반환
				//   연결이 닫혀 있지 않은 경우 false 반환
				//@@ 정말로 닫혀 있는 건지 확인
				if(!dbConn.isClosed())
					dbConn.close();
				  //-- 연결 객체의 close() 메소드를 통해 연결 종료
				
			}catch(Exception e)
			{
				System.out.println(e.toString());
			}
		}
		dbConn = null;
		//-- 연결 객체 초기화
	}
}