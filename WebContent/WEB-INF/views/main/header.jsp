<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	Object user = session.getAttribute("id");
	String userId = (String)user;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="bootstrap/assets/favicon.ico" />

<!-- <link rel="stylesheet" href="css/bootstrap.min.css">-->
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">

</head>
<body>

<!-- header -->
<header class="header">
	<!-- Top Bar -->
	<div class="top_bar">
		<div class="container">
			<div class="row">
				<div class="col d-flex flex-row">
					<div class="top_bar_content ml-auto">
					<div class="top_bar_user">
						<%if(userId == null) {%>
							<div class="bar_line">
								<a href="signupform.action">회원가입</a>
							</div>
							<div class="bar_line">
								<a href="signinform.action">로그인</a>
							</div>
						<%} else{ %>
							<div class="bar_line">
								<a href="myspace.action"><b>${sessionScope.nick }</b>님</a>
							</div>
							<div class="bar_line">
								<a href="logout.action">로그아웃</a>
							</div>
						<%} %>
							<div class="bar_line">
								<a href="usernotice.action">공지사항</a>
							</div>
							<div class="bar_line">
								<a href="userfaq.action">FAQ</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Header Main -->
	<div class="header_main" style="margin-top: 20px;">
		<div class="container">
			<div class="row">
				<!-- Logo -->
				<div class="col-lg-2 order-1 logo_container">
					<div class="logo_container1">
						<a href="home.action"><img alt="로고" src="<%=cp%>/images/logo_typo.svg"></a>
					</div>
				</div>

				<!-- Main Nav Menu -->
				<div class="col-lg-5 order-2">
					<div class="main_nav_menu">
						<ul class="standard_dropdown main_nav_dropdown">					
							<li><a href="myspace.action">마이스페이스</a></li>
							<li><a href="musicallist.action">공연정보</a></li>
							<li><a href="mseat.action">좌석정보</a></li>
							<li><a href="contact.html">티켓 양도</a></li>
						</ul>
					</div>
				</div>

				<!-- Search -->
				<div class="col-lg-4 order-3 text-right">
					<div class="header_search">
						<div class="header_search_content">
							<div class="header_search_form_container">
								<form action="#" class="header_search_form">
									<input type="search" required="required"
										class="header_search_input"
										placeholder="공연을 검색해보세요!">
									<button type="submit" class="header_search_button" value="Submit">
										<img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1560918770/search.png" alt="">
									</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>

</body>
</html>

