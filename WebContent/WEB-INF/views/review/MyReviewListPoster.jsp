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
<title>MyReviewListPoster.jsp</title>
<link rel="stylesheet" href="<%=cp %>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp %>/css/myspace.css">
<link rel="stylesheet" href="<%=cp %>/css/home.css">

<link rel="stylesheet" href="css/header.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style type="text/css">
	
	.reviewComment, .reviewLike
	{
		width: 25px;
		border: none;
		align: left;
		color: black;
	}
	
	.userName
	{
		font-weight: bold;
		font-size: 20px;
		border: none;
		background-color: #fafafa;
		color: black;
		padding: 5px;
	}
	
	#userImage
	{
		border-radius: 70%;
    	overflow: hidden;
    	width: 26px; 
    	height: 26px;
    	vertical-align: middle;
	}
	
	.playName
	{
		border: 1px solid;
		text-align: center;
		padding: 1px;
		border-radius: 1em;
		font-size: 15pt;
		font-weight: bold;
		color: black;
		padding: 5px;
	}
	
	#pageTitle1, #pageTitle2, #pageTitle3
	{
		font-size: 18px;
		font-weight: bold;
		left: 70px;
		margin-bottom: 0px;
		height: 34px;
	}
	
	.reviewContent
	{
		height: 90px;
		width: 280px;
		background-color: #fafafa;
		font-size: 10pt;
		color: black;
		padding: 10px;
	}
	
	#imgContainer, #reviewContainer
	{
		width: 1100px;
		text-align: center;
		margin: 0 auto;
		height: 370px;
	}
	
	.reviewContainer
	{
		margin-bottom: 0px;
	}
	
	.thumbnail
	{
		margin-top: 10px;
		margin-bottom: 2px;
		background-color: #fafafa;
	}
	
	.playTitle
	{
		font-size: 15px;
		font-weight: bold;
	}
		
	.reviewTitle
	{
		font-size: 25px;
		font-weight: bold;
		border: none;
		background-color: #fafafa;
		width: 280px;
		color: black;
		padding-top: 10px;
		text-align: left;
	}
	
	.playRating
	{
		border: none;
		background-color: #fafafa;
		font-size: 40px;
		font-weight: bold;
		color: black;
		margin: 0 auto;
		width: 280px;
		padding: 0 0 0 0;
		line-height: 32px;
		
	}
	
	input:focus
	{
		outline: none;
	}
	
	.likecomment
	{
		text-align: left;
		align: left;
		background-color: #fafafa;
	}
	.posterImg
	{
		height: 312px;
	}
	#pageTitle { float: left; margin: 0; line-height: 60px;}
	
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<!-- 헤더 추가 -->
<div>
	<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
</div>

<div id="wrapper">
<div class="container">
	<div id="pageTitle" class="container">나의 관람 리뷰</div>
	<br><br>

	<!-- 사용자의 리뷰 목록: 사진 클릭 시 공연장코드, 리뷰 식별코드 넘겨주기 -->
    <div id="highReviewSorting" class="container">
       		<c:forEach var="myreviewposter" items="${myreviewposter }">
          	<div class="col-lg-3 col-xs-6 col-md-3">
             	<a href="myreviewdetail.action?play_cd=${myreviewposter.play_cd }&rev_distin_cd=${myreviewposter.rev_distin_cd}" 
             	class="thumbnail">
               		<img src="${myreviewposter.play_img }" class="playPoster" style="width: 100%; height: 100%;">
             	</a>
             	<div class="playTitle">${myreviewposter.title }</div>
          	</div>
          	</c:forEach>
       	</div>
</div>
	
    <br><br>
</div><!-- close #wrapper -->

</body>
</html>