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
<title>MyReviewSeatUpdateForm.jsp</title>
<link href="<%=cp%>/css/header.css" rel="stylesheet">
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 별점 기능을 위한 아이콘을 CDN 방식으로 추가 -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<!-- 별점 이미지 파일을 다운받은 뒤 css폴더에 추가해 경로 지정 -->
<link rel="stylesheet" href="<%=cp %>/css/fontawesome-stars.css">
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- 별점 콜백 함수 호출을 위해 js 폴더에 추가해 경로 지정 -->
<script src="<%=cp %>/js/jquery.barrating.min.js"></script>
<style type="text/css">
	.center 
	{
		width: 1300px;
		margin: 0 auto;
		text-align: center;
	}
	#center 
	{
		margin: 0 auto;
		text-align: center;
		width: 411px;
	}
	.reviewleft
	{
		margin-left: 430px;
	}
	#container 
	{
		margin: 0 auto;
		max-width: 1300px;
	}
	#seat_num 
	{
		width: 9px;
		height: 38px;
	}
	th, td 
	{
		padding: 3px;
	}
	
	#highlight
	{
		font-size: 20px;
		font-style: bold;
	}
	.img { text-align:center;}
    #reviewseattable td { height:20px; }
	#reviewseattable { width:60%; margin: auto; text-align: center; }
	th
	{
		width: 115px;
	}
	.form-control
	{
		height: 30px;
	}
	#nextBtn
	{
		width: 756px;
	}
	.nextBtn
	{
		text-align: center;
	}
	.hidden
	{
		display: none;
	}
	#pageTitle { float: left; margin: 0; line-height: 60px;}
</style>
<script type="text/javascript">

   // 추가한 제이쿼리 플러그인의 콜백함수 호출
   $(function(){
	   var view_rating = ${seatreview.view_rating};
	   
      $("#view_rating").barrating({
        theme: 'fontawesome-stars'
        , initialRating: view_rating
        , onSelect: function(value, text, event){
    		// value 로 받은 클릭한 별점을 selectbox에 전달
        	$("#view_rating").val(value).prop("selected", true);
    	}
      });
   });
   
   $(function() {
	   
	   var seat_rating = ${seatreview.seat_rating};
		   
      $("#seat_rating").barrating({
        theme: 'fontawesome-stars'
        , initialRating: seat_rating
        , onSelect: function(value, text, event){
        	// value 로 받은 클릭한 별점을 selectbox에 전달
        	$("#seat_rating").val(value).prop("selected", true);
    	}
      });
   });
   
   $(function() {
	   
	   var sound_rating = ${seatreview.sound_rating};
	   
      $("#sound_rating").barrating({
        theme: 'fontawesome-stars'
        , initialRating: sound_rating
        , onSelect: function(value, text, event){
        	// value 로 받은 클릭한 별점을 selectbox에 전달
        	$("#sound_rating").val(value).prop("selected", true);
    	}
      });
   });
 
   
   $(function() { 
	   var light_rating = ${seatreview.light_rating};
	   
      $("#light_rating").barrating({
        theme: 'fontawesome-stars'
        , initialRating: light_rating
        , onSelect: function(value, text, event){
        	// value 로 받은 클릭한 별점을 selectbox에 전달
        	$("#light_rating").val(value).prop("selected", true);
    	}
      });
   });
   
</script>
<script type="text/javascript">

	// 좌석 위치 (층, 구역, 열) selectbox 값 선택되어있도록 만들기
	$(function()
	{   
	  var seat_flow = $("#getseat_flow").val();
	  $("#seat_flow").val(seat_flow).prop("selected", true);
	});

	$(function()
	{  
		var seat_area = $("#getseat_area").val();
	  	$("#seat_area").val(seat_area).prop("selected", true);
	});
	
	$(function()
	{  
		var seat_line = $("#getseat_line").val();
	  	$("#seat_line").val(seat_line).prop("selected", true);
	});
	
</script>

</head>
<body>
	<!-- 헤더 추가 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	
	<div class="container">
	<div id="pageTitle" class="container">좌석 리뷰 수정하기</div>
	
	</div><br><br><br>
	<div class="center">
		<h5>좌석 정보를 수정해주세요.</h5>
		<h5>수정사항이 없다면 하단의 상세리뷰 수정하러가기 버튼을 클릭해주세요.</h5>
	</div>
	<br>
	<br>
	<div id="container">
		<form action="myreviewdetailupdateform.action" method="post">
			<table class="table table-borderless" id="reviewseattable">
				<tr>
					<th colspan="2">좌석 위치</th>
					<th colspan="4">좌석 별점</th>
				</tr>
				<tr>
					<td>
						<div class="input-group">
						<select class="form-control" id="seat_flow" name="seat_flow" aria-describedby="sizing-addon2">
							<c:forEach var="a" begin="1" end="5" step="1">
								<option value="${a }">${a }</option>
							</c:forEach>
						</select>
						<span class="input-group-addon"> 층</span>
						</div>
					</td>
					<td>
						<div class="input-group">
						<select class="form-control" id="seat_area" name="seat_area" aria-describedby="sizing-addon2">
							<option>-</option>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
							<option value="E">E</option>
							<option value="F">F</option>
							<option value="G">G</option>
							<option value="H">H</option>
							<option value="OP">OP</option>
							<option value="가">가</option>
							<option value="나">나</option>
							<option value="다">다</option>
							<option value="라">라</option>
							<option value="마">마</option>
							<option value="바">바</option>
							<option value="사">사</option>
							<option value="아">아</option>
						</select>
						<span class="input-group-addon"> 구역</span>
						</div>
					</td>
					<td>시야</td>
					<td>
						<select id="view_rating" name="view_rating">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</td>
					<td>좌석</td>
					<td>
						<select id="seat_rating" name="seat_rating">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
							<div class="input-group">
						<select class="form-control" id="seat_line" name="seat_line"  aria-describedby="sizing-addon2">
						<option>-</option>
						<c:forEach var="a" begin="1" end="30" step="1">
							<option value="${a }">${a }</option>
						</c:forEach>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
							<option value="E">E</option>
							<option value="F">F</option>
							<option value="G">G</option>
							<option value="H">H</option>
							<option value="I">I</option>
							<option value="J">J</option>
							<option value="K">K</option>
							<option value="L">L</option>
							<option value="M">M</option>
							<option value="N">N</option>
							<option value="O">O</option>
							<option value="P">P</option>
							<option value="Q">Q</option>
							<option value="R">R</option>
							<option value="S">S</option>
							<option value="T">T</option>
							<option value="U">U</option>
							<option value="V">V</option>
							<option value="W">W</option>
							<option value="X">X</option>
							<option value="Y">Y</option>
							<option value="Z">Z</option>
							<option value="OP">OP</option>
						</select>
						<span class="input-group-addon"> 열</span>
						</div>
					</td>
					<td>
						<div class="input-group">
							<input type="text" id="seat_num" name="seat_num" class="form-control" value="${seatreview.seat_num }">
						<span class="input-group-addon"> 번호</span>
						</div>
					</td>
					<td>음향</td>
					<td>
						<select id="sound_rating" name="sound_rating">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</td>
					<td>조명</td>
					<td>
						<select id="light_rating" name="light_rating">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<th colspan="6">좌석 리뷰</th>
				</tr>
				<tr>
					<td colspan="6">
						<textarea id="seat_rev" name="seat_rev" cols="120" rows="5" style="resize: none;">${seatreview.seat_rev }</textarea>
					</td>
				</tr>
			</table>

			<br>
			<br>
			<br>
			<!-- 다음페이지에 전달할 값/자바스크립트에서 제어할 값 -->
			<input type="hidden" id="theater_cd" name="theater_cd" value="${theater_cd }">
			<input type="hidden" id="rev_distin_cd" name="rev_distin_cd" value="${seatreview.rev_distin_cd }">
			<input type="hidden" id="getseat_flow" name="getseat_flow" value="${seatreview.seat_flow }">
			<input type="hidden" id="getseat_area" name="getseat_area" value="${seatreview.seat_area }">
			<input type="hidden" id="getseat_line" name="getseat_line" value="${seatreview.seat_line }">
			<div class="nextBtn">
				<button type="submit" id="nextBtn" class="btn btn-info nextBtn">상세 리뷰 수정하러 가기</button>
			</div>
		</form>
	</div>
<br><br><br><br>

</body>
</html>