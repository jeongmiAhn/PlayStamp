package com.playstamp.home.mybatis;

import java.util.ArrayList;

import com.playstamp.home.Home;

public interface IHomeDAO
{
	// 리뷰 많은순 공연 리스트 출력
	public ArrayList<Home> highReviewSorting();
	
	// 평점 높은순 공연 리스트 출력
	public ArrayList<Home> highRateSorting();
	
	// 좋아요 많은순 리뷰 리스트 출력
	public ArrayList<Home> highLikeSorting();
}
