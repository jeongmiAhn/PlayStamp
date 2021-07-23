/*
	User.java
	- 사용자 주요 속성 구성(DTO)
*/
package com.playstamp.user;

import org.springframework.stereotype.Repository;

@Repository
public class User
{
	private String user_Id, user_Nm, user_Tel, user_Pw
			     , user_Nick, user_Mail, join_Dt, user_Img, user_join;

	public String getUser_Id()
	{
		return user_Id;
	}

	public void setUser_Id(String user_Id)
	{
		this.user_Id = user_Id;
	}

	public String getUser_Nm()
	{
		return user_Nm;
	}

	public void setUser_Nm(String user_Nm)
	{
		this.user_Nm = user_Nm;
	}

	public String getUser_Tel()
	{
		return user_Tel;
	}

	public void setUser_Tel(String user_Tel)
	{
		this.user_Tel = user_Tel;
	}

	public String getUser_Pw()
	{
		return user_Pw;
	}

	public void setUser_Pw(String user_Pw)
	{
		this.user_Pw = user_Pw;
	}

	public String getUser_Nick()
	{
		return user_Nick;
	}

	public void setUser_Nick(String user_Nick)
	{
		this.user_Nick = user_Nick;
	}

	public String getUser_Mail()
	{
		return user_Mail;
	}

	public void setUser_Mail(String user_Mail)
	{
		this.user_Mail = user_Mail;
	}

	public String getJoin_Dt()
	{
		return join_Dt;
	}

	public void setJoin_Dt(String join_Dt)
	{
		this.join_Dt = join_Dt;
	}

	public String getUser_Img()
	{
		return user_Img;
	}

	public void setUser_Img(String user_Img)
	{
		this.user_Img = user_Img;
	}

	public String getUser_join()
	{
		return user_join;
	}

	public void setUser_join(String user_join)
	{
		this.user_join = user_join;
	}

	
	
	
}
