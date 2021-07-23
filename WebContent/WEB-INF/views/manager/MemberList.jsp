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
<title>MemberList.jsp</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">

<style type="text/css">

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
	
	.paginate_button, .pagination, .pagingButton
	{
		text-align: center !important;
		margin: 0 auto !important;
		position: relative;
		border: none;
		height: 40px;
		right: 130px;
		margin-top: 5px;
	}
	
</style>

<script type="text/javascript">
	
	$(function()
	{	
		$(".modifyBtn").click(function()
		{
			var url = "/playstamp_final/modifypointpopup.action?user_id=" + $(this).val();
			var name = "포인트수정팝업";
			var options = 'top=200, left=540, width=500, height=200, status=no, menubar=no, toolbar=no, resizable=no';
			
			window.open(url, name, options);
		});
		
	});
	
	function gotomanaginpointlist()
	{
		$("#userTable tbody").on("click", "tr", function()
		{
			var user_id = $(this).find("td:eq(1)").text();
			var grade = $(this).find("td:eq(5)").text();
			var point = $(".pointInput").val();
		
			/* $(location).attr("href", "managingpointlist.action?user_id=" + user_id + "&grade=" + grade + "&point=" + point); */
			$(location).attr("href", "managingpointlist.action?user_id=" + user_id);
			
		});
	}
	
	// 페이지 번호만 속성값으로 가지도록 <a> 태그가 작동하지 못하도록 처리
   //-- 실제 페이지를 클릭하면 동작하는 부분은 <form> 태그를 이용해 처리함
   $(document).ready(function()
   {
      var likeForm = $("#likeForm");
      
      $(".paginate_button a").on("click", function(e)
      {
         // <a> 태그 선택해도 페이지 이동 없도록 처리
         e.preventDefault();
         
         // <form> 태그 내 pageNum 속성 값은 href 속성값(클릭한 페이지 번호)으로 변경
         likeForm.find("input[name='pageNum']").val($(this).attr("href"));
         likeForm.submit();
      });
   });
	   
</script>


</head>
<body>

<!-- 헤더 추가 -->
<c:import url="/WEB-INF/views/manager/ManagerHeader.jsp"></c:import>

<div class="container" style="width: 72%; height: 700px; top:50px;">
	<h2> 회원 관리 </h2>
	<hr>
		<div class="container">
			<div id="reportListIntro"><img style="width: 20px; margin-right: 5px;" src="images/boardicon.png">회원 목록 조회</div>
			<div class="row">
				<table class="table table-striped" id="userTable" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">아이디</th>
							<th style="background-color: #eeeeee; text-align: center;">닉네임</th>
							<th style="background-color: #eeeeee; text-align: center;">이메일</th>
							<th style="background-color: #eeeeee; text-align: center;">가입일</th>
							<th style="background-color: #eeeeee; text-align: center;">등급</th>
							<th style="background-color: #eeeeee; text-align: center;">잔여 포인트</th>
						</tr>
					</thead>
					<tbody>
						<!-- c:foreach문으로 리스트 반복 뿌려주기 -->
						<c:forEach var="member" items="${memberlist }" varStatus="status">
						<tr>
							<td>${member.membernum }</td>
							<td class="userid"><a href="managingpointlist.action?user_id=${member.user_id }&point=${member.point}&grade=${member.grade}">
							${member.user_id }</a></td>
							<td>${member.user_nick }</td>
							<td>${member.user_mail }</td>
							<td>${member.join_dt }</td>
							<td>${member.grade }</td>
							<td><input type="text" class="pointInput" readonly="readonly" value="${member.point }">&emsp;
							<button type="button" class="modifyBtn" value="${member.user_id }&point=${member.point}">변경</button></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<!--  페이징 추가 -->
                  <div class="pull-right">
                     <ul class="pagination">
                     <c:if test="${PageMaker.prev }">
                        <li class="paginate_button previous"><a href="${PageMaker.startPage-1 }">Previous</a>
                        </li>
                     </c:if>
                     
                     <c:forEach var="num" begin="${PageMaker.startPage }" end="${PageMaker.endPage }">
                        <li class="paginate_button"><a class="pagingButton" href="${num }">${num }</a></li>
                     </c:forEach>
                     
                     <c:if test="${PageMaker.next }">
                        <li class="paginate_button next"><a class="pagingButton" href="${PageMaker.endPage+1 }">Next</a></li>
                     </c:if>
                     </ul>
                  </div><!-- close .pull-right -->
                  <!-- 페이지 번호 클릭시 이동을 위한 hidden form 구성 -->
                  <form id="likeForm" action="memberlist.action" method="get">
                     <input type="hidden" name="pageNum" value="${PageMaker.cri.pageNum }">
                     <input type="hidden" name="amount" value="${PageMaker.cri.amount }">
                  </form>
			</div>
			<br><br>
			<div class="searchContainer">
				<input type="text" class="searchMember" placeholder="검색할 회원의 아이디를 입력하세요.">
				<button type="button" class="glyphicon glyphicon-search">검색</button>
			</div>
		</div>
</div>

</body>
</html>