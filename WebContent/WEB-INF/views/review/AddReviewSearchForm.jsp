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
<title>AddReviewSearchForm.jsp</title>
<!-- 부트스트랩, 제이쿼리 -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- jQuery UI CDN 추가 3줄 (autocomplete, 자동 완성 기능 구현용) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="css/header.css">
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
	
<style type="text/css">

#wrapper .container{
	width:1300px;
}

#pageTitle { float: left; margin: 0; line-height: 60px;}	

h3, div {
	text-align: center;
}

#search {
	width: 95%;
	margin: 0 auto;
}
#nextBtn{
	width: 95%;
	margin: 0 auto;
}

#btn {
	width: 95%;
	margin: auto;
	display: block;
}

#list {
	border: 1px solid gray;
	width: 500px;
	position: absolute;
	left: 70px;
	top: 134px;
	display: none;
}

#list .tem {
	padding: 3px;
}
</style>
<script type="text/javascript">

	// jQuery UI: autocomplete 사용
	//-- 키보드를 누를 때마다 데이터를 가져오는 ajax 와 달리
	//   한 번에 데이터를 가져와서 키보드 입력 값에 따라 보여주는 정보를 달리 한다.
	$(function()
	{
		var arr = new Array();		//-- 사용자가 선택한 공연 객체가 담길 배열
		
		// 사용자에게는 play 객체의 play_nm(=value1, 공연명+기간) 만 보여준다.
		// 해당 공연명을 클릭하면 하단에서는 같은 객체의 공연 코드 값도 저장한다.

		$("input[name=playlist]").each(function(index, item)
		{
			arr.push($(item).attr("value"));		//-- 공연명 배열에 넣기
		});
		
		$("#search").autocomplete
		({
			source: arr,
			minLength: 2,
			select : function(event, ui)
			{
				// 하단의 숨겨진 공연명 속성에 사용자가 선택한 공연명 전달
				$("#play_nm").val(ui.item.value);
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


<div id="wrapper">
	<div class="container">
	
	<div id="topBox" class="inBox" style="background-color: #fff;">
		<div id="pageTitle">리뷰 추가하기</div>
	</div>
	
			<!-- 다음 단계로 이동 버튼 클릭 시 사용자가 선택한 공연코드를 가지고 좌석 리뷰 작성 페이지로 이동 -->
		<form action="addreviewseatform.action" method="post">
			<h2>관람하신 공연명을 검색하여 선택해주세요</h2>
		    <br>
			<br>
			<input type="text" id="search" class="form-control"
			style="height: 48px; font-size: 18px; font-weight: 400;" placeholder="공연을 검색해보세요!">
			
			<!-- 스크립트 단에 전달할 공연정보 hidden 속성으로 구성 -->
			 
			<c:forEach var="play" items="${list }">
				<input type="hidden" id="playlist" name="playlist" value="${play.play_nm }"/>
			</c:forEach>
			<br><br>
			<input type="hidden" id="play_nm" name="play_nm">
			<!-- 임시로 유저아이디 다음 페이지에 넘기기 -->
			<input type="hidden" id="user_cd" name="user_cd" value="U00001">
			
			<button type="submit" id="nextBtn" style="height: 48px; font-size: 18px; font-weight: 400;" class="btn btn-primary btn-lg btn-block">다음 단계로</button>
		</form>
	</div>
</div>

<!-- 푸터 임포트 -->
<c:import url="/WEB-INF/views/main/Footer.jsp"></c:import>

</body>
</html>