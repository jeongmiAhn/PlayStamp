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
<title>PlayDetail.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<!-- 별점 기능을 위한 아이콘을 CDN 방식으로 추가 -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<!-- 별점 이미지 파일을 다운받은 뒤 css폴더에 추가해 경로 지정 -->
<link rel="stylesheet" href="<%=cp %>/css/fontawesome-stars.css">
<!-- 별점 콜백 함수 호출을 위해 js 폴더에 추가해 경로 지정 -->
<script src="<%=cp %>/js/jquery.barrating.min.js"></script>

<link href="<%=cp%>/css/myspace.css" rel="stylesheet">

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
 integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

<style type="text/css">	
		
	#tab { width: 60%; margin: auto; }
	
	.tab-content { border: 0.3px solid gray; }
	
	.subContainer { text-align: center; }
	#pageTitle { float: left; margin: 0; line-height: 60px;}	
	#backList { float: right;}
		
	.container { width: 1300px; }
	
	#header { margin: auto; }
	
	#infoTable th {text-align: left; width:120px; height: 40px;}
	#infoTable td {text-align: left; height: 40px;}
	#playInfo {
		margin-bottom: 40px; 
		background-color: #fafafa;
	    border-radius: 20px;
	    padding: 30px;
	    text-align: center;
	}
	.infoTd {height: 24px;}
	
	#poster { height: 280px; margin: 0 200px 20px 200px; }
	
	#playReview { text-align: left; }
	div#playReview > table > tbody > tr > td:nth-child(1) { width: 100px; }
	div#playReview > table > tbody > tr > td:nth-child(2) { height: 10px; }
	
	div#seatReview > table > tbody > tr > td:nth-child(2) { text-align: center; }

</style>
<script type="text/javascript">	
	
	//@@ 현재 url 가져오기 
	var url = location.href;
	//@@ 자르기.. 
	var parameters = ((url.split("?"))[1].split("="))[1];
	
	var articleNo = parameters;
	
	//@@ 공연리뷰 평점
	var playRevPre = new Array();
		
	//@@ 공연 평균 평점
	var playRevTot = 0;
	var playRevCount = 0;
	var playRevAvg = 0;
	
	//@@ 각 평점 값 list 에 담기(playRevPre)
	<c:forEach var="playRevPre" items="${playRevPreList}">	
		playRevPre.push("${playRevPre.rating_cd}");
		playRevTot += ${playRevPre.rating_cd};
		playRevCount += 1;
	</c:forEach>
	
	//@@ 테스트
	//alert(playRevPre[1]);
		
	// 평균 연산(편의상 몫만 취함..)
	//var playRevAvg = parseInt(playRevTot/playRevCount);
	
	//@@ 목록으로 클릭시 이동
	$(function()
	{
		$("#backList").click(function()
		{
			$(location).attr("href", "musicallist.action");
		});
	});
	
	//@@ 별점 제이쿼리
	$(function()
	{
		for (var i = 0; i < playRevPre.length; i++)
		{
			//@@ 공연 별점
			$("#playRevPre"+i).barrating(
			{
				theme: "fontawesome-stars"
		        , initialRating: playRevPre[i]
		        , readonly: true
		    });
		    
		}

		//@@ 공연 평균 별점
		$(".playRev").barrating(
		{
			theme: "fontawesome-stars"
	        , initialRating: $("#playReview").attr("data-avg")
	        , readonly: true
	    });
	}); 
	
	$(function()
	{
		$("#jjim").on("click", function()
		{
			var hiddenUser = $("#hiddenUser");
		    var hiddenUserVal = hiddenUser.val();
		    
		  	//@@ 빈 하트
		    var str0 = "<i class='far fa-heart fa-lg'></i>";
		    //@@ 꽉 찬 하트
		    var str1 = "<i class='fas fa-heart fa-lg'></i>";
		 	
	
	    	$.ajax({
			        type : "post",
			        url : "jjimclick.action",
			        contentType: "application/json; charset=utf-8;",
			        dataType : "json",
			        data : JSON.stringify
			        ({
			            "play_cd" : articleNo,
			            "user_cd" : hiddenUserVal
			        }),
			        success : function (result)
			        {			        	
			        	//@@ 찜이 삭제되었을 경우
			        	if (result.returnValue == 0)
						{
				        	$("#jjim").html("");
							$("#jjim").html(str0);
						}
			        	//@@ 찜이 추가되었을 경우
			        	else if(result.returnValue ==1)
			        	{
				        	$("#jjim").html("");
							$("#jjim").html(str1);
			        	}
	
		        	}
	    		});
	
		    
		});
	});
</script>
</head>

<body>
<!-- 상단바 -->
	<div id="header">
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
<div class="container">
<!-- 내용 출력 시작 -->	
	<div id="wrapper" >
		<div>

		<!-- 메뉴 -->
		
			<div id="topBox" class="inBox" style="background-color: #fff;">
				<div id="pageTitle">공연상세 정보</div>
				<div class="btn-group btn-group-lg" role="group" aria-label="..." style="float: right;">
				  <button type="button" class="btn btn-default" id="backList">목록으로</button>
				</div>
			</div>
			
			
		<!-- 공연 상세 출력 -->
			<div id="playInfo">
				<div id="playTable" style="display: flex;">
				<c:forEach var="playDetail" items="${playDetailList }">
					<div style="flex:0; width: 50%;">
						<img src="${playDetail.play_img }" id="poster">
						<div style="text-align: center;">
							<select class="playRev">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
						</div>
					</div>
					<div style="flex:1; width: 40%;">
						<table id="infoTable">
							<tr>
								<th class="infoTd">공연명</th>
								<td class="infoTd">${playDetail.play_nm}</td>
							</tr>
							<tr>
								<th class="infoTd">공연기간</th>
								<td class="infoTd">${playDetail.play_start} ~ ${playDetail.play_end}</td>
							</tr>
							<tr>
								<th class="infoTd">공연장소</th>
								<td class="infoTd">${playDetail.theater}</td>
							</tr>
							<tr>
								<th class="infoTd">출연진</th>
								<td class="infoTd">${playDetail.play_cast}</td>
							</tr>
		
							<tr>
								<td><input type="hidden" id="hiddenUser" value="${sessionScope.code }"></td>
								<c:set var="checkJjim" value="${checkJjim}"></c:set>
								<c:choose>
								<c:when test="${checkJjim eq 0}">
									<td>찜리스트에 저장&nbsp;<span id="jjim" style="color: #FE2E2E"><i class='far fa-heart fa-lg'></i></span></td>
								</c:when>
								<c:when test="${checkJjim eq 1}">
									<td>찜리스트에 저장&nbsp;<span id="jjim" style="color: #FE2E2E"><i class="fas fa-heart fa-lg"></i></span></td>
								</c:when>
								</c:choose>
								</tr>
							</table>
						</div>
				</c:forEach>			
				</div>
			</div>
			
			<!-- 탭 -->
			<div id="tab">
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link active" data-toggle="tab" href="#playReview">공연리뷰</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#seatReview" id="seatRev">좌석리뷰</a>
				  </li>
				</ul>
				
				<div class="tab-content">
				
				<!-- 공연 리뷰  -->
					  <div class="tab-pane fade show active" data-avg="${ratingAvg }" id="playReview">
					  	<table class="table table-borderless">
					  		<!--@@ 반복문 돌면서 id 값을 달리하기 위한 i -->
					  		<c:set var="i" value="0"></c:set>
					  		<c:forEach var="playRevPre" items="${playRevPreList }">
					  		<c:set var="checkRepPlay" value="${checkRepPlayList}"></c:set>
					  		<c:set var="checkRepPlaySt" value="${checkRepPlayStList}"></c:set>
						  		<c:choose>
						  			<%-- (신고 O +  처리 결과 2) OR (신고 X)  --%>
						  			<c:when test="${(checkRepPlay[i] eq 1 && checkRepPlaySt[i] eq 2) || (checkRepPlay[i] eq 0) }">
								  		<tr>
											<td rowspan="2"><img src="${playRevPre.play_img}" width="100px;"></td>
											<td colspan="2" id="reviewTitle"
											onclick="location.href='playreviewdetail.action?playrev_cd=${playRevPre.playrev_cd}&play_cd=${playRevPre.play_cd}'">${playRevPre.title }</td>
								  		</tr>
								  		<tr>
								  			<td colspan="2">${playRevPre.contents}</td>
								  		</tr>
								  		<tr>
								  			<td>
									  			<select id="playRevPre${i }">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</td>
								  			<td>
								  			<span style="color: #0080FF"><i class="fa fa-comment fa-sm" aria-hidden="true"></i></span> ${playRevPre.ccount}
								  			&nbsp;<span style="color: #FE2E2E"><i class="fas fa-heart fa-sm"></i></span> ${playRevPre.lcount}
								  			</td>
								  			<td>${playRevPre.user_nick}</td>
								  		</tr>	
						  			</c:when>
						  			<%-- (신고 O +  처리 결과 1) OR (신고 O +  처리 결과 0) AND--%>
						  			<c:when test="${(checkRepPlay[i] eq 1 && checkRepPlaySt[i] eq 1) || (checkRepPlay[i] eq 1 && checkRepPlaySt[i] eq 0)}">
							  			<tr>
											<td colspan="3"></td>
										</tr>
										<tr>
											<td colspan="3" style="text-align: center;">신고에 의해 블라인드 처리된 게시글입니다.</td>
										</tr>
										<tr>
											<td colspan="3"></td>
										</tr>
						  			</c:when>
							  	</c:choose>  
							  	<!--@@ 한 턴 반복이 끝나면 i 를 증가! -->
							  	<c:set var="i" value="${i+1}"></c:set>
						  	</c:forEach>
						  	<div>
					  			<tr>
									<td colspan="3"></td>
								</tr>
								<tr>
									<td colspan="3" style="text-align: center;">
									더 많은 리뷰 정보를 확인하고 싶다면?<br>
									보다 더 활발한 활동을 통해 '준회원'으로 등급을 올려 주세요!
									</td>
								</tr>
								<tr>
									<td colspan="3" style="text-align: center;"><button type="button" class="btn btn-default" onclick="">내 포인트/등급 확인하러 가기</td>
								</tr>
						  	</div>
					  	</table>
					  
					  <!-- 좌석리뷰  -->		
					  </div>
					  <div class="tab-pane fade" id="seatReview">
					  	<br>
						<p style="text-align: center;">좌석 리뷰는 일반 회원부터 조회 가능합니다.</p>
					  </div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 푸터 임포트 -->
<c:import url="/WEB-INF/views/main/Footer.jsp"></c:import>

</body>
</html>