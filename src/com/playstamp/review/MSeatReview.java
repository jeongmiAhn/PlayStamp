package com.playstamp.review;

import java.sql.Date;

public class MSeatReview
{
	// 5대 공연장 좌석 리뷰 테이블과 구조 동일
	// 단, int 형은 편의상 string으로 통일
	
	private String mseat_rev_cd;			// 5대 공연장 좌석 리뷰 코드
	private String rev_distin_cd;			// 리뷰 식별 코드
	private String mseat_sort_cd;			// 좌석 구분 코드 (A1~A14 구역)
	private String view_rating, seat_rating, light_rating, sound_rating;	// 시야, 좌석, 조명, 음향 평점
	private String seat_flow;				// 층 (좌석정보)
	private String seat_area, seat_line;	// 구역, 열 (좌석정보)
	private String seat_num;				// 번호 (좌석정보)
	private String seat_rev;				// 좌석 리뷰
	private Date seat_rev_dt;				// 좌석 리뷰 등록일자
	
	
	public String getMseat_rev_cd()
	{
		return mseat_rev_cd;
	}
	public void setMseat_rev_cd(String mseat_rev_cd)
	{
		this.mseat_rev_cd = mseat_rev_cd;
	}
	public String getRev_distin_cd()
	{
		return rev_distin_cd;
	}
	public void setRev_distin_cd(String rev_distin_cd)
	{
		this.rev_distin_cd = rev_distin_cd;
	}
	public String getMseat_sort_cd()
	{
		return mseat_sort_cd;
	}
	public void setMseat_sort_cd(String mseat_sort_cd)
	{
		this.mseat_sort_cd = mseat_sort_cd;
	}
	public String getView_rating()
	{
		return view_rating;
	}
	public void setView_rating(String view_rating)
	{
		this.view_rating = view_rating;
	}
	public String getSeat_rating()
	{
		return seat_rating;
	}
	public void setSeat_rating(String seat_rating)
	{
		this.seat_rating = seat_rating;
	}
	public String getLight_rating()
	{
		return light_rating;
	}
	public void setLight_rating(String light_rating)
	{
		this.light_rating = light_rating;
	}
	public String getSound_rating()
	{
		return sound_rating;
	}
	public void setSound_rating(String sound_rating)
	{
		this.sound_rating = sound_rating;
	}
	public String getSeat_flow()
	{
		return seat_flow;
	}
	public void setSeat_flow(String seat_flow)
	{
		this.seat_flow = seat_flow;
	}
	public String getSeat_area()
	{
		return seat_area;
	}
	public void setSeat_area(String seat_area)
	{
		this.seat_area = seat_area;
	}
	public String getSeat_line()
	{
		return seat_line;
	}
	public void setSeat_line(String seat_line)
	{
		this.seat_line = seat_line;
	}
	public String getSeat_num()
	{
		return seat_num;
	}
	public void setSeat_num(String seat_num)
	{
		this.seat_num = seat_num;
	}
	public String getSeat_rev()
	{
		return seat_rev;
	}
	public void setSeat_rev(String seat_rev)
	{
		this.seat_rev = seat_rev;
	}
	public Date getSeat_rev_dt()
	{
		return seat_rev_dt;
	}
	public void setSeat_rev_dt(Date seat_rev_dt)
	{
		this.seat_rev_dt = seat_rev_dt;
	}
}
