package com.playstamp.manager.memberlist;

public class MemberList
{
	// 회원의 번호, 아이디, 이름, 닉네임, 이메일, 가입일자, 등급, 포인트 
	private String membernum, user_id, user_nm, user_nick, user_mail, join_dt, grade, point;
	
	public String getMembernum()
	{
		return membernum;
	}

	public void setMembernum(String membernum)
	{
		this.membernum = membernum;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public String getPoint()
	{
		return point;
	}

	public void setPoint(String point)
	{
		this.point = point;
	}

	public void setUser_id(String user_id)
	{
		this.user_id = user_id;
	}

	public String getUser_nm()
	{
		return user_nm;
	}

	public void setUser_nm(String user_nm)
	{
		this.user_nm = user_nm;
	}

	public String getUser_nick()
	{
		return user_nick;
	}

	public void setUser_nick(String user_nick)
	{
		this.user_nick = user_nick;
	}

	public String getUser_mail()
	{
		return user_mail;
	}

	public void setUser_mail(String user_mail)
	{
		this.user_mail = user_mail;
	}

	public String getJoin_dt()
	{
		return join_dt;
	}

	public void setJoin_dt(String join_dt)
	{
		this.join_dt = join_dt;
	}
	
}
