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
<title>AddReviewDetailForm.jsp</title>
<!-- 달력 선택 기능을 위한 jquery UI 추가 -->
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
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
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/myspace.css">
<style type="text/css">
	.content 
	{
	    width: 1300px;
	    margin:0 auto;
	}
	.center 
	{
		margin: 0 auto;
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
	#imagePreview 
	{
		width: 210px;
		height: 270px;
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
		border-style: none;
		border-right:none;
		border-left:none;
		border-top:none;
		border-bottom:none;
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
	#finishBtn
	{
		width: 756px;
	}
	.finishBtn
	{
		text-align: center;
	}
   #img { text-align:center;}
   
   #reviewdetailtable td { height:20px; }
   #reviewdetailtable { width:60%; margin: auto; }
   #uploadFile { text-align:center;}
   
</style>
<script type="text/javascript">
	
	// 별점 선택하기
	$(function(){
	    $('#rating_cd').barrating({
	      theme: 'fontawesome-stars'
	      , initialRating: 5
	      , onSelect: function(value, text, event){
	    	  $('#rating_cd').val(value).prop("selected", true);
	  		}
	    });
	 });
   
</script>
<script type="text/javascript">

	// 날짜를 달력에서 선택할 수 있도록 설정
	$("#play_dt").datepicker(
	{
		dateFormat: "yy-mm-dd"
		, changeMonth: true
		, changeYear: true
	});

</script>
</head>
<body>
<!-- 헤더 추가 -->
<div>
	<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
</div>

<div id="wrapper">	
	<div class="container">
	
<div id="pageTitle" class="container">리뷰 수정하기</div>

<div class="content">
	<form action="addreviewdetail.action" method="post" class="content">
		<table class="table table_borderless" id="reviewdetailtable">
			<tr>
				<td colspan="2" rowspan="7"  style="width:50px; margin:0 auto;">
					<!-- 포스터 사진 미리보기 -->
					<div>
						<img id="imagePreview" src="${play.play_img }">
					</div>
				</td>
				<th>제목</th>
				<td>
					<input type="text" id="title" name="title" class="form-control" maxlength="50" required="required">
				</td>
			</tr>
			<tr>
				<th>공연명</th>
				<td><input type="text" id="playname" class="form-control"
					value="${play.play_nm }" readonly></td>
			</tr>
			<tr>
				<th>공연 날짜</th>
				<td><input type="text" id="play_dt" name="play_dt" class="form-control"
					required="required"></td>
			</tr>
			<tr>
				<th>공연 시간</th>
				<td><input type="text" id="play_time" name="play_time" class="form-control">
				</td>
			</tr>
			<tr>
				<th>공연 장소</th>
				<td><input type="text" id="place" class="form-control" value="${theater_nm }"
					readonly></td>
			</tr>
			<tr>
				<th>출연진</th>
				<td><input type="text" id="play_cast" name="play_cast" class="form-control" value="${play.play_cast }">
				</td>
			</tr>
			<tr>
				<th>티켓 금액</th>
				<td><input type="text" id="play_money" name="play_money" class="form-control">
				</td>
			</tr>
			<tr>
				<th style="text-align:center;">공연 평점</th>
				<td>
					<select id="rating_cd"" name="rating_cd">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select>
				</td>
				<th>함께 본 사람</th>
				<td>
				<select id="companion_cd" name="companion_cd" class="form-control">
				<c:forEach var="c" items="${companion}">
					<c:set var="a" value="${a+1 }"/>
					<option value="${a }">${c.companion }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<th colspan="4">공연 상세 리뷰</th>
			</tr>
			<tr>
				<td colspan="4"><textarea id="contents" name="contents" cols="55" rows="10" style="resize: none;" class="form-control"></textarea></td>
			</tr>
		</table>
		<br><br>
		<div class="finishBtn">
			<button type="submit" id="finishBtn" class="btn btn-info">리뷰 추가 완료하기</button>
		</div>
		<!-- 이전 페이지로 넘겨받은 데이터 -->
		<input type="hidden" id="rev_distin_cd" name="rev_distin_cd" value="${rev_distin_cd }">
		<input type="hidden" id="play_img" name="play_img" value="${play.play_img }">
	</form>
</div><!-- close #content -->
</div>
</div>

	
<br><br><br><br><br><br><br><br>
</body>
</html>