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
<title>아이디 찾기</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<style>
.checkText {padding-top: 5px;}
</style>
</head>
<body>
<!-- 메뉴 영역 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	<div class="container">
		<div id="pageTitle" class="container">아이디 확인</div>
		
			<h4>인증된 메일로 확인된 아이디입니다.</h4>
			<c:forEach var="id" items="${idList}" varStatus="status">
			    <li><c:out value="${id}" /></li>
			</c:forEach>

			<%--
				<c:forEach var="id" items="${idList}" varStatus="status">
			   	 	<li> ${status.count} : <c:out value="${id}" /></li>
				</c:forEach>
			--%>
			<hr>
		<a href="signinform.action">
			<button type="button" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto;">로그인하기</button>
		</a>
	</div>
</body>
</html>