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
<title>ManagerHome.jsp</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp %>/css/managerhome.css">
</head>
<body>

<!-- 헤더 추가 -->
<c:import url="ManagerHeader.jsp"></c:import>

<div class="container" style="align: left; width: 74%; height: 700px; top:50px;">
	<div class="container">	
		<div class="infoContainer">
			<div id="userInfoContainer" class="userInfo">
				<div class="userInfo">
					<div id="userTotal">총 회원 수</div>
					<div id="userCount "><img class="graphicon" src="images/usericon.png">&emsp;${countUser }명</div>
				</div>
			</div>
			<div id="reviewInfoContainer" class="userInfo">
				<div class="userInfo">
					<div id="reviewTotal">총 리뷰 수</div>
					<div id="reviewCount"><img class="graphicon" src="images/boardicon.png">&emsp;${countPlayRev }개</div>
				</div>
			</div>
		</div>
		<table id="graphTable">
			<tr>
				<td><a href="statisticsuserview.action"><img class="graph" src="images/graph1.png"></a></td>
				<td><a href="statisticsvisitorview.action"><img class="graph" src="images/graph2.png"></a></td>
			</tr>
			<tr>
				<td>가입 회원 통계</td>
				<td>방문 회원 통계</td>
			</tr>
		</table>
	</div>
	
	<!-- 처리해야 할 신고 리스트 -->
	<div id="reportList">
		<div class="container">
			<div id="reportListIntro"><img id="alerticon" src="images/alerticon.png">처리해야 할 신고 리스트</div>
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">내용</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 분류</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">신고자</th>
							<th style="background-color: #eeeeee; text-align: center;">신고 일시</th>
							<th style="background-color: #eeeeee; text-align: center;">게시판 분류</th>
						</tr>
					</thead>
					<tbody>
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
							<td>${checkList.rep_y }</td>
							<td>${checkList.writer }</td>
							<td>${checkList.reporter }</td>
							<td>${checkList.rep_dt }</td>
							<td>${checkList.boardCategory }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

</div>

</body>
</html>