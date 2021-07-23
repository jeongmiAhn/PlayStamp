package com.playstamp.mseat;

public class MSeat
{
	private String viewrating, lightrating, soundrating, seatrating;
	
	MSeat(String viewrating, String lightrating, String soundrating, String seatrating)
	{
		this.viewrating = viewrating;
		this.lightrating = lightrating;
		this.soundrating = soundrating;
		this.seatrating = seatrating;
	}

	public String getViewrating()
	{
		return viewrating;
	}

	public void setViewrating(String viewrating)
	{
		this.viewrating = viewrating;
	}

	public String getLightrating()
	{
		return lightrating;
	}

	public void setLightrating(String lightrating)
	{
		this.lightrating = lightrating;
	}

	public String getSoundrating()
	{
		return soundrating;
	}

	public void setSoundrating(String soundrating)
	{
		this.soundrating = soundrating;
	}

	public String getSeatrating()
	{
		return seatrating;
	}

	public void setSeatrating(String seatrating)
	{
		this.seatrating = seatrating;
	}
	
}
