<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ManagerPointList.jsp</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">

<style type="text/css">
	
	#nopoint
	{
		text-align: center;
		font-size: 15pt;
	}
	
	.paginate_button, .pagination, .pagingButton
	{
		text-align: center !important;
		margin: 0 auto !important;
		position: relative;
		border: none;
		height: 40px;
		right: 130px;
	}
	
	.mTitle
	{
		width:990px !important;
		font-size: 15pt !important;
	}
	
</style>

<script type="text/javascript">

	$(function()
	{
		if($("#pointTable").find("td:eq(1)").text()=="")
		{
			$("#nopoint").text("포인트 내역이 존재하지 않습니다.");
		}
	});
	
	// 페이지 번호만 속성값으로 가지도록 <a> 태그가 작동하지 못하도록 처리
   //-- 실제 페이지를 클릭하면 동작하는 부분은 <form> 태그를 이용해 처리함
   $(document).ready(function()
   {
      var pointForm = $("#pointForm");
      
      $(".paginate_button a").on("click", function(e)
      {
         // <a> 태그 선택해도 페이지 이동 없도록 처리
         e.preventDefault();
         
         // <form> 태그 내 pageNum 속성 값은 href 속성값(클릭한 페이지 번호)으로 변경
         pointForm.find("input[name='pageNum']").val($(this).attr("href"));
         pointForm.submit();
      });
   });

</script>
</head>
<body>

<!-- 헤더 추가 -->
<c:import url="/WEB-INF/views/manager/ManagerHeader.jsp"></c:import>

<div id="wrapper">
	<div class="container"  style="width: 72% !important; height: 700px; top:50px;">
	<h2> 회원 관리 </h2>
	<hr>
		<div id="topBox" class="inBox">
			<div class="mTitle" style="text-align:right; ">
				현재 ${user_id }님의 포인트 : ${point }P&emsp;(<b> ${grade }</b> 등급)
			</div>
		</div>
		<table id="pointTable" class="table table-hover">
		<tr>
			<th>번호</th>
			<th>적립/차감</th>
			<th></th>
			<th>적립/차감 포인트</th>
			<th>총 포인트</th>
		</tr>
		
		<c:forEach var="point" items="${pointList}">
			<tr>
				<td>${point.pointnum }</td>
				<td>${point.point_y }</td>
				<td style="color: #bfbfbf;">${point.point_dt }</td>
				<c:choose>

					<c:when test = "${fn:contains(point.point, '-')}">
				        <td style="color: red;">${point.point }</td>
				    </c:when>
				    <c:otherwise>
				     	<td style="color: blue;">${point.point }</td>
				    </c:otherwise>
			    
			    </c:choose>
				<td style="font-weight: 500;">${point.user_point }</td>
			</tr>
		</c:forEach>
		</table>
		<br><br><div id="nopoint"></div>
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
         <form id="pointForm" action="managingpointlist.action" method="get">
            <input type="hidden" name="pageNum" value="${PageMaker.cri.pageNum }">
            <input type="hidden" name="amount" value="${PageMaker.cri.amount }">
            <input type="hidden" name="user_id" value="${user_id }">
            <input type="hidden" name="point" value="${point }">
            <input type="hidden" name="grade" value="${grade }">
         </form>
	</div>
</div>

</body>
</html>