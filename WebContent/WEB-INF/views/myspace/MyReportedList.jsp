<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyReportedList.jsp</title>
<link href="<%=cp%>/css/header.css" rel="stylesheet">
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

	#content
	{
		margin: 0 auto;
		text-align: center;
		width: 1300px;
	}
	#textbox
	{
		font-size: 50px;
		text-align: center;
	}
	th
	{
		background-color: #eeeeee;
		text-align: center;
	}
	.pull-right
	{
		margin: 0 auto;
		text-align: center;
	}
	.pagination > li > a
	{
		float: none;
		margin-left: -5px;
	}
	.table-striped
	{
		margin-left: 15px;
	}
	
	#reportListIntro
	{
		margin-bottom: 5px;
		font-size: 12pt;
		font-weight: bold;
	}
	
	.pointInput
	{
		width: 50px;
		text-align: center;
		background-color: transparent;
		border-color: #d9d9d9;
	}
	
	.modifyBtn
	{
		background-color: #2688f4;
		color: white;
		border-color: #2688f4;
	}
	
	.searchMember
	{
		width:300px;
	}
	
	.searchContainer, .pagingcenter, .paginate_button, .pagination, .pull-right
	{
		text-align: center;
		margin: 0 auto;		
	}
	
	.userid
	{
		text-decoration: underline;
		color: #2688f4;
	}
	
</style>
<script type="text/javascript">

	// 페이지 번호만 속성값으로 가지도록 <a> 태그가 작동하지 못하도록 처리
	//-- 실제 페이지를 클릭하면 동작하는 부분은 <form> 태그를 이용해 처리함
	$(document).ready(function()
	{
		var reportForm = $("#reportForm");
		
		$(".paginate_button a").on("click", function(e)
		{
			// <a> 태그 선택해도 페이지 이동 없도록 처리
			e.preventDefault();
			
			// <form> 태그 내 pageNum 속성 값은 href 속성값(클릭한 페이지 번호)으로 변경
			reportForm.find("input[name='pageNum']").val($(this).attr("href"));
			reportForm.submit();
		});
	});

</script>
</head>
<body>
<div>
	<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
</div>
<div class="container" style="width: 72%; height: 700px; top:50px;">
	<div class="container">
	<div id="pageTitle" class="container">신고 당한 내역</div>
			<div class="row">
				<table class="table table-hover" id="userTable" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">신고내용</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 카테고리</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 일시</th>
							<th style="background-color: #eeeeee; text-align: center;">게시판 분류</th>
							<th style="background-color: #eeeeee; text-align: center;">처리 현황</th>
							<th style="background-color: #eeeeee; text-align: center;">처리 일시</th>
						</tr>
					</thead>
					<tbody>
					<!--  BNO, REP_CONTENTS, REPORTER, REP_Y, REP_DT, 
					BOARDCATEGORY, REP_CD, REPORTED_CD, REP_ST, REP_CH_DT -->
					<c:forEach var="List" items="${List }">
					<tr>	
						<td>${List.bno }</td>
						<td>${List.rep_contents }</td>
						<td>${List.rep_y }</td>
						<td>${List.rep_dt }</td>
						<td>${List.boardCategory }</td>
						<c:choose>
							<c:when test="${List.rep_st eq '승인'}">
								<td style="font-weight:bold; color:red;">${List.rep_st }</td>
							</c:when>
							<c:when test="${List.rep_st eq '반려'}">
								<td style="font-weight:bold; color:green;">${List.rep_st }</td>
							</c:when>
							<c:when test="${List.rep_st eq '확인중'}">
								<td style="font-weight:bold; color:black;">${List.rep_st }</td>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${List.rep_ch_dt eq '2999-12-31 00:00:00'}">
								<td>확인중</td>
							</c:when>
							<c:otherwise>
								<td>${List.rep_ch_dt }</td>
							</c:otherwise>
						</c:choose>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			<!--  페이징 추가 -->
			<div class="text-center">
				<ul class="pagination">
				<c:if test="${PageMaker.prev }">
					<li class="paginate_button previous">
						<a href="${PageMaker.startPage-1 }">Previous</a>
					</li>
				</c:if>
				
				<c:forEach var="num" begin="${PageMaker.startPage }" end="${PageMaker.endPage }">
					<li class="paginate_button">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>
				
				<c:if test="${PageMaker.next }">
					<li class="paginate_button next">
						<a href="${PageMaker.endPage+1 }">Next</a>
					</li>
				</c:if>
				</ul>
			</div><!-- close .pull-right -->
			<div>
				<button type="button" class="btn btn-info" onclick="location='myreportinglist.action'">내가 신고한 내역</button>
			</div>
			<!-- 페이지 번호 클릭시 이동을 위한 hidden form 구성 -->
			<form id="reportForm" action="myreportedlist.action" method="get">
				<input type="hidden" name="pageNum" value="${PageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${PageMaker.cri.amount }">
			</form>
		</div>
	</div>
</div>

</body>
</html>