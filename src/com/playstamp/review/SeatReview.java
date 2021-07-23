package com.playstamp.review;

import java.sql.Date;

public class SeatReview
{
	// 좌석리뷰 테이블 구조와 동일
	// 단, int 형은 편의상 string으로 통일
	
	private String seat_rev_cd;				// 좌석 리뷰 코드
	private String rev_distin_cd;			// 리뷰 식별 코드
	private String view_rating, seat_rating, light_rating, sound_rating;	// 시야, 좌석, 조명, 음향 평점
	private String seat_flow;				// 층 (좌석정보)
	private String seat_area, seat_line;	// 구역, 열 (좌석정보)
	private String seat_num;				// 번호 (좌석정보)
	private String seat_rev;				// 좌석 리뷰
	private Date seat_rev_dt;				// 좌석 리뷰 등록일자
	
	
	public String getSeat_rev_cd()
	{
		return seat_rev_cd;
	}
	public void setSeat_rev_cd(String seat_rev_cd)
	{
		this.seat_rev_cd = seat_rev_cd;
	}
	public String getRev_distin_cd()
	{
		return rev_distin_cd;
	}
	public void setRev_distin_cd(String rev_distin_cd)
	{
		this.rev_distin_cd = rev_distin_cd;
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
