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
<title>MyReviewDetail.jsp</title>
<link href="<%=cp%>/css/header.css" rel="stylesheet">
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">

<!-- 부트스트랩 적용을 위한 3줄: 제이쿼리 스크립트 포함 -->
<%-- <link rel="stylesheet" href="<%=cp %>/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/bootstrap.min.js"></script> --%>

<!-- 별점 기능을 위한 아이콘을 CDN 방식으로 추가 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<!-- 별점 이미지 파일을 다운받은 뒤 css폴더에 추가해 경로 지정 -->
<link rel="stylesheet" href="<%=cp %>/css/fontawesome-stars.css">
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- 별점 콜백 함수 호출을 위해 js 폴더에 추가해 경로 지정 -->
<script src="<%=cp %>/js/jquery.barrating.min.js"></script>
<style type="text/css">
	#content 
	{
	    width: 1300px;
	    margin:0 auto;
	}
	#reviewdetail
	{
		display: block;
	    width: 100%;
	    height: 200px;
	    border: solid 1px #dadada;
	    padding: 10px 14px 10px 14px;
	    box-sizing: border-box;
	    background: #fff;
	    position: relative;
	}
	#seatreview
	{
		display: block;
	    width: 100%;
	    height: 100px;
	    border: solid 1px #dadada;
	    padding: 10px 14px 10px 14px;
	    box-sizing: border-box;
	    background: #fff;
	    position: relative;
	}
	#imagePreview 
	{
		width: 250px;
		height: 300px;
	  	background-position: center center;
	  	background-size: cover;
	  	-webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .3);
	  	text-align:center;
	}
	#rating
	{
		text-align: left;
	}
	.subtitle
	{
		width: 120px;
	}
	#reviewtitle
	{
		text-align: center;
		font-size: 30px;
	}
	table
	{
		border-spacing: 2px;
	}
	.seat
	{
		width: 50px;
		height: 23px;
		border: gray;
	}
	th
	{
		width: 115px;
	}
	.form-control
	{
		height: 30px;
	}
	#reviewTitle
	{
		font-size: 30px;
		text-align: center;
	}
	#info
	{
		font-size: 15px;
		text-align: right;
	}
    #img { text-align:center;} 
    #reviewdetailtable td { height:20px; }
    #reviewdetailtable { width:100%; margin: auto; }
    #uploadFile { text-align:center;}
    #updateBtn
	{
		width: 410px;
	}
	#deleteBtn
	{
		width: 410px;
	}
	.updateDeleteBtn
	{
		text-align: center;
	}
	#pageTitle { float: left; margin: 0; line-height: 60px;}
</style>
<script type="text/javascript">

   $(function(){
	   // 사용자가 작성한 리뷰의 공연별점 받아오기
	   var rating = ${reviewdetail.rating_cd};
	   var view = ${seatreview.view_rating};
	   var seat = ${seatreview.seat_rating};
	   var sound = ${seatreview.sound_rating};
	   var light = ${seatreview.light_rating};
	   
	    $('#rating').barrating({
	      theme: 'fontawesome-stars'
	      , initialRating: rating
	      , readonly: true
	    });
	    
	    $('#view').barrating({
		      theme: 'fontawesome-stars'
		      , initialRating: view
		      , readonly: true
		});
	    
	    $('#seat').barrating({
		      theme: 'fontawesome-stars'
		      , initialRating: seat
		      , readonly: true
		});
	    
	    $('#sound').barrating({
		      theme: 'fontawesome-stars'
		      , initialRating: sound
		      , readonly: true
		});
	    
	    $('#light').barrating({
		      theme: 'fontawesome-stars'
		      , initialRating: light
		      , readonly: true
		});
	 });
   
</script>
<script type="text/javascript">

	// 삭제 버튼 클릭시 확인 후 삭제 액션 수행
	$(function()
	{
		$("#deleteBtn").click(function()
		{
			if(confirm("선택한 공연 리뷰를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "removemyreview.action?rev_distin_cd="
                					+  $(this).val());
			}
		});
	});
	
</script>
</head>
<body>
<!-- 헤더 추가 -->
<div>
	<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
</div>
	
	
<div class="container">
	<div id="pageTitle" class="container">나의 리뷰 정보</div>
<div class="content">
	<form class="content" action="myreviewseatupdateform.action" method="post">
		<table class="table table-borderless" id="reviewdetailtable">
			<tr>
				<td colspan="6" id="info">작성일자: ${reviewdetail.playrev_dt }</td>
			</tr>
			<tr>
				<td colspan="2" rowspan="7" style="width:50px; margin:0 auto;">
					<!-- 포스터 사진 미리보기 -->
					<div>
						<img id="imagePreview" src="${reviewdetail.play_img }">
					</div>
				</td>
				<th colspan="4" id="reviewTitle" name="reviewTitle">${reviewdetail.title }</th>
			</tr>
			<tr>
				<th>공연명</th>
				<td colspan="3">${play.play_nm }</td>
			</tr>
			<tr>
				<th>공연 날짜</th>
				<td colspan="3">${reviewdetail.play_dt }</td>
			</tr>
			<tr>
				<th>공연 시간</th>
				<td colspan="3">${reviewdetail.play_time }</td>
			</tr>
			<tr>
				<th>공연 장소</th>
				<td colspan="3">${play.theater }</td>
			</tr>
			<tr>
				<th>출연진</th>
				<td colspan="3">${reviewdetail.play_cast }</td>
			</tr>
			<tr>
				<th>티켓 금액</th>
				<td colspan="3">${reviewdetail.play_money }</td>
			</tr>
			<tr>
				<th style="text-align:center;">공연 평점</th>
				<td>
					<select id="rating">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select>
				</td>
				<th>함께 본 사람</th>
				<td>${reviewdetail.companion }</td>
			</tr>
			<tr>
				<th colspan="2">좌석 위치</th>
				<th colspan="3">좌석 별점</th>
			</tr>
			<tr>
				<td>
					<input type="text" id="floor" class="seat" value="${seatreview.seat_flow }" readonly="readonly"> 층
				</td>
				<td>
					<input type="text" id="area" class="seat" value="${seatreview.seat_area }" readonly="readonly"> 구역
				</td>
				<td>시야</td>
				<td>
					<select id="view" name="view">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select>
				</td>
				<td>좌석</td>
				<td>
					<select id="seat" name="seat">
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
					<input type="text" id="line" class="seat" value="${seatreview.seat_line }" readonly="readonly"> 열
				</td>
				<td>
					<input type="text" id="num" class="seat" value="${seatreview.seat_num }" readonly="readonly"> 번호
				</td>
				<td>음향</td>
				<td>
					<select id="sound" name="sound">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select>
				</td>
				<td>조명</td>
				<td>
					<select id="light" name="light">
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
				<td colspan="6"><textarea id="seatreview" cols="55" rows="5"
				readonly="readonly" class="form-control">${seatreview.seat_rev }</textarea></td>
			</tr>
			<tr>
				<th colspan="6">공연 상세 리뷰</th>
			</tr>
			<tr>
				<td colspan="6"><textarea id="reviewdetail" cols="55" rows="10"
				readonly="readonly" class="form-control">${reviewdetail.contents}</textarea></td>
			</tr>
		</table>
		<input type="hidden" id="userImg" value="${reviewdetail.play_img}">
		<!-- 수정시 넘겨야 할 데이터: 좌석리뷰의 리뷰식별코드 -->
		<input type="hidden" id="rev_distin_cd" name="rev_distin_cd" value="${seatreview.rev_distin_cd }">
		
		<br><br>
		<div class="updateDeleteBtn">
			<button type="submit" id="updateBtn" class="btn btn-info" value="${seatreview.rev_distin_cd }">리뷰 수정하기</button>
			<button type="button" id="deleteBtn" class="btn btn-danger" value="${seatreview.rev_distin_cd }">리뷰 삭제하기</button>
		</div>
	</form>

</div><!-- close #content -->
</div>
<br><br><br><br><br><br><br><br>

</body>
</html>