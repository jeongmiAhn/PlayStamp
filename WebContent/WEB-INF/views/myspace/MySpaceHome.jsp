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
<title>마이스페이스</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

</head>
<body>
<!-- 메뉴 영역 -->
<div>
	<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
</div>
	
	<div id="wrapper">
		<!-- 1층 -->
		
		<div id="firstArea" class="container">
			<div id="profile" class="myspace">
				<div class="profileBox"><img class="profileImg" onerror="this.src='<%=cp%>/images/default_profile.png'" src="<%=cp%>/profile/${userInfo.user_Img }"></div>
				<div class="userInfoBox">
					<span class="sTitle">${userInfo.user_Nick }</span><span class="label label-primary">${sessionScope.grade }</span>
					<div class="userMail">${userInfo.user_Mail }</div>
					<div class="listArea"><a href="myprofile.action">더보기</a></div>
				</div>
			</div>
			
			<div class="line"></div>
			
			<div id="listArea" class="myspace">
				<div id="list1" style="display: flex; align-items: center;">
						<div class="listArea sTitle">현재 내 포인트 ></div>
						<div class="listArea aTitle"><a href="pointlist.action">${userPoint } P</a></div>
				</div>
			</div>
			
			<div class="line"></div>
			
			<div id="listArea" class="myspace">
					<div id="list1" style="display: flex; align-items: center;">
						<div class="listArea sTitle">현재 내 캐시 ></div>
						<div class="listArea aTitle"><a href="cashlist.action">${userCash } 원</a></div>
					</div>
			</div>
		</div>
		
		<!-- 리뷰 추가하기 -->
		<div id="addReview" class="container">
				<button type="button" class="btn btn-primary btn-lg btn-block"
				style="margin-bottom: 50px;" onclick="location.href='addreviewsearchform.action'">+ 리뷰 추가하기</button>
		</div>
		
		<!-- 2층 -->
		<div id="secondArea" class="container">
			<div class="outBox">
				<div id="box1" class="inBox inBox1">
					<div class="sTitle"><a>나의 관람 리뷰></a></div>
					<div class="aTitle"><a href="myreviewlistposter.action">${userRev }개</a></div>
				</div>
				<div id="box2" class="inBox inBox2">
					<div class="sTitle"><a>나의 찜리스트></a></div>

					<div class="aTitle"><a href="myspacejjim.action">${userJjim }개</a></div>

				</div>
			</div>
			<div class="outBox">
				<div id="box1" class="inBox inBox1">
					<div class="bTitle"><a href="myactivityhome.action" style="color: #444;">나의 활동 / 신고 관리</a></div>
				</div>
				
				<div id="box2" class="inBox inBox2">
					<div class="bTitle"><a href="mystatisticlist.action" style="color: #444;">나의 관람 통계</a></div>
				</div>
			</div>
		</div>
		
	</div>
	
</body>
</html>