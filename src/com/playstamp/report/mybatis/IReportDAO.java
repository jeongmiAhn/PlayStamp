package com.playstamp.report.mybatis;

import com.playstamp.report.ReportComment;
import com.playstamp.report.ReportMseatRev;
import com.playstamp.report.ReportPlayRev;
import com.playstamp.report.ReportSeatRev;

public interface IReportDAO
{
	//@@ 신고 추가 메소드
	public int addReportPlayRev(ReportPlayRev reportPlayRev);
	
	public int addReportComment(ReportComment reportComment);

	public int addReportSeatRev(ReportSeatRev reportSeatRev);
	
	public int addReportMseatRev(ReportMseatRev reportMseatRev);
}
