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
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
 integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
<script type="text/javascript">
	$(function()
	{
		$(".delBtn").click(function()
		{
			if (confirm("정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "noticedelete.action?notice_cd=" + $(this).val());
			}
		});
		
		$(".upBtn").click(function()
		{
			$(location).attr("href", "noticeupdateform.action?notice_cd=" + $(this).val());
		});	
	});
	
</script>
<style type="text/css">

.panel-heading { padding: 0;}
.panel-heading a { padding: 10px 15px; display:block; text-decoration: none;}
.btn { float: right;}
</style>
</head>
<body>
<!-- 헤더 추가 -->
<c:import url="ManagerHeader.jsp"></c:import>

<div class="container">
	<h2>공지사항 관리</h2>
	<hr>
	<button type="button" class="btn btn-default" onclick="location.href='noticeinsertform.action'">&nbsp;공지사항 작성하기</button>
	<br><br><br>
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
	<c:set var="i" value="0"></c:set>
	<c:forEach var="list" items="${list }">
	
	  <div class="panel panel-default">
	    <div class="panel-heading" role="tab" id="heading${i }">
	      <h4 class="panel-title">
		<a data-toggle="collapse" href="#collapse${i }" aria-expanded="true" aria-controls="collapse${i }">
		  <span style="color: #0080FF"><i class="far fa-bell"></i></span>&nbsp; ${list.title}
		</a>
	      </h4>
	    </div>
	    <div id="collapse${i }" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading${i }">
	      <div class="panel-body">
	      ${list.contents }
	      <br>
	      <button type="button" class="btn btn-default delBtn" value="${list.notice_cd }">삭제</button>
	      &nbsp;<button type="button" class="btn btn-default upBtn" value="${list.notice_cd }">수정</button>
	      </div>
	    </div>
	  </div>
	  <c:set var="i" value="${i+1}"></c:set>
	  </c:forEach>	  
	</div>
</div>
</body>
</html>