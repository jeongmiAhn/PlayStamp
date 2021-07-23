<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 캐시</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
		<style>
			p { margin:20px 0px; }
		</style>
</head>
<body>
<!-- 메뉴 영역 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	
	<div id="wrapper">
		<div class="container">
			<div id="pageTitle" class="container">탈퇴 안내</div>
			
			<h4>
				<mark>고객님이 충전한 캐시가 남아 있어요.</mark><br>
				탈퇴 후에는 캐시 환불이 불가능하니<br>
				마이프로필 - 캐시 내역에서 [출금하기] 를 먼저 진행해 주시기 바랍니다.<br>
			</h4>
					
			<br>
			
			<button type="button" onclick="location.href='cashlist.action'" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto; " value="">내 캐시 내역 확인하기</button>
		</div>
	
	</div>
	
	
	
	
	
	
</body>
</html>