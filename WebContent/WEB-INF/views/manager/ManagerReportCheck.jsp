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
<title>ManagerReportCheck.jsp</title>
<link rel="stylesheet" href="<%=cp %>/css/managerhome.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="css/bootstrap.min.css">
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
<!-- 헤더 추가 -->
<c:import url="ManagerHeader.jsp"></c:import>

<div class="container" style="width: 72%; height: 700px; top:50px;">
	<h2>신고 관리</h2>
	<hr>
	<div class="container">
		<div id="reportListIntro"><img style="width: 20px; margin-right: 5px;" src="images/boardicon.png">확인 필요 신고 리스트</div>
			<br>
			<div class="row">
				<table class="table table-striped" id="userTable" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">신고내용</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">신고자</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 카테고리</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 일시</th>
							<th style="background-color: #eeeeee; text-align: center;">게시판 분류</th>
						</tr>
					</thead>
					<tbody>
					<!-- c:foreach문으로 리스트 반복 뿌려주기 -->
					<c:forEach var="checkList" items="${checkList }">
					<tr>
						<td>${checkList.bno }</td>
						<c:choose>
							<c:when test="${checkList.boardCategory eq '댓글' }">
								<td onclick="window.open('commentreport.action?rep_cd=${checkList.rep_cd }'
								, '댓글 신고 내용', 'width=350,hieght=400,status=no, resizable=no, toolbar=no, menubar=no')">
								${checkList.rep_contents }
								</td>
							</c:when>
							<c:when test="${checkList.boardCategory eq '공연 리뷰' }">
								<td onclick="window.open('reviewreport.action?rep_cd=${checkList.rep_cd }'
								, '리뷰 신고 내용', 'width=350,hieght=400,status=no, resizable=no, toolbar=no, menubar=no')">
								${checkList.rep_contents }
								</td>
							</c:when>
							<c:when test="${checkList.boardCategory eq '좌석 리뷰' }">
								<td onclick="window.open('seatreport.action?rep_cd=${checkList.rep_cd }'
								, '좌석 리뷰 신고 내용', 'width=350,hieght=400,status=no, resizable=no, toolbar=no, menubar=no')">
								${checkList.rep_contents }
								</td>
							</c:when>
							<c:when test="${checkList.boardCategory eq '5대 좌석 리뷰' }">
								<td onclick="window.open('mseatreport.action?rep_cd=${checkList.rep_cd }'
								, '좌석 리뷰 신고 내용', 'width=350,hieght=400,status=no, resizable=no, toolbar=no, menubar=no')">
								${checkList.rep_contents }
								</td>
							</c:when>
						</c:choose>
						<td>${checkList.writer }</td>
						<td>${checkList.reporter }</td>
						<td>${checkList.rep_y }</td>
						<td>${checkList.rep_dt }</td>
						<td>${checkList.boardCategory }</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>

			<!--  페이징 추가 -->
			<div class="text-center">
				<ul class="pagination">
				<c:if test="${checkPageMaker.prev }">
					<li class="paginate_button previous"><a href="${checkPageMaker.startPage-1 }">Previous</a></li>
				</c:if>
				
				<c:forEach var="num" begin="${checkPageMaker.startPage }" end="${checkPageMaker.endPage }">
					<li class="paginate_button"><a href="${num }">${num }</a></li>
				</c:forEach>
				
				<c:if test="${checkPageMaker.next }">
					<li class="paginate_button next"><a href="${checkPageMaker.endPage+1 }">Next</a></li>
				</c:if>
				</ul>
			</div><!-- close .text-center -->
			<!-- 페이지 번호 클릭시 이동을 위한 hidden form 구성 -->
			<form id="reportForm" action="managerreport.action" method="get">
				<input type="hidden" name="pageNum" value="${checkPageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${checkPageMaker.cri.amount }">
			</form>
	    </div><!-- row -->
	</div><!-- container -->
		<div>
			<button type="button" class="btn btn-info" onclick="location='donemanagerreport.action'">처리 완료 신고 리스트</button>
		</div>
</div><!-- container -->


<br><br><br><br>
</body>
</html>