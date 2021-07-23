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
<title>Insert title here</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
</head>
<body>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="header.jsp"></c:import>
	</div>
	
	<div id="wrapper">
		<div class="container">
		<div style="margin:0 auto;"><img style="width: 100%;" alt="" src="<%=cp%>/images/welcome.png"></div>
			<div>
				<h4 style="text-align: center; line-height: 200%; margin-bottom:20px;">
					<mark><b>회원가입이 완료됐습니다!</b><br>
					로그인 후 플레이 스탬프의 다양한 서비스를 경험해보세요!:></mark>
				</h4>
			<a href="signinform.action">
				<button type="button" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto;">로그인하기</button>
			</a>
			</div>
		</div>
	</div>
	
	<!-- 푸터 임포트 -->
	<c:import url="/WEB-INF/views/main/Footer.jsp"></c:import>
	
</body>
</html>