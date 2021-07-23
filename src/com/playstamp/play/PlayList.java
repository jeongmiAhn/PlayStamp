package com.playstamp.play;

public class PlayList
{
	private String play_cd, play_img;
	
	PlayList(String play_cd, String play_img)
	{
		this.play_cd = play_cd;
		this.play_img = play_img;
	}
	
	public String getPlay_cd()
	{
		return play_cd;
	}

	public void setPlay_cd(String play_cd)
	{
		this.play_cd = play_cd;
	}

	public String getPlay_img()
	{
		return play_img;
	}

	public void setPlay_img(String play_img)
	{
		this.play_img = play_img;
	}	
}