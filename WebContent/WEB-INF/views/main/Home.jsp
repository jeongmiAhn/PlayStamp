<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home.jsp</title>
<link rel="stylesheet" href="<%=cp %>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp %>/css/myspace.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- 별점 기능을 위한 아이콘을 CDN 방식으로 추가 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<!-- 별점 이미지 파일을 다운받은 뒤 css폴더에 추가해 경로 지정 -->
<link rel="stylesheet" href="<%=cp %>/css/fontawesome-stars.css">
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- 별점 콜백 함수 호출을 위해 js 폴더에 추가해 경로 지정 -->
<script type="text/javascript" src="<%=cp %>/js/jquery.barrating.min.js"></script>
<link rel="stylesheet" href="<%=cp %>/css/home.css">

<script type="text/javascript">

   // 공연 평점을 담을 배열
   var array = new Array();
       
    // 평점 값 list 에 담기
    <c:forEach var="list" items="${highLikeSorting}" begin="0" end="6">   
       array.push("${list.rating_cd}");
    </c:forEach>
    
    // 별점 제이쿼리
    $(function()
    {
       for (var i=0; i<array.length; i++)
       {
          // 공연 평점을 별점으로 변환
          $("#rating"+i).barrating(
          {
             theme: "fontawesome-stars"
               , initialRating: array[i]
               , readonly: true
           });
       }
    }); 
       
</script>
<script type="text/javascript">

   // 페이지를 처음 로드했을 때는 second 클래스와 prev 버튼을 숨김
    $( document ).ready( function() {
       
      $(".secondReview").hide();
      $(".secondLike").hide();
      $(".secondRating").hide();
      

        $("#prevReview").hide();
        $("#prevLike").hide();
        $("#prevRating").hide();
     });

   // 리뷰 많은 공연순 리스트 prev/next 버튼 기능
   function moveReview(menu_id)
   {
      // next 버튼 눌렀을 때
      if(menu_id==1)
      {
         $(".secondReview").show();
         $(".firstReview").hide();
         
         $("#prevReview").show();
         $("#nextReview").hide();
      }
      
      // prev 버튼 눌렀을 때
      if(menu_id==0)
      {
         $(".firstReview").show();
         $(".secondReview").hide();
         
         $("#nextReview").show();
         $("#prevReview").hide();
      }
   }
   
   // 좋아요 많은 리뷰순 리스트 prev/next 버튼 기능
   function moveLike(menu_id)
   {
      // next 버튼 눌렀을 때
      if(menu_id==1)
      {
         $(".secondLike").show();
         $(".firstLike").hide();
         
         $("#prevLike").show();
         $("#nextLike").hide();
      }
      
      // prev 버튼 눌렀을 때
      if(menu_id==0)
      {
         $(".firstLike").show();
         $(".secondLike").hide();
         
          $("#nextLike").show();
         $("#prevLike").hide();
      }
   }
   
   // 평점 높은 공연순 리스트 prev/next 버튼 기능
   function moveRating(menu_id)
   {
      // next 버튼 눌렀을 때
      if(menu_id==1)
      {
         $(".firstRating").hide();
         $(".secondRating").show();
         
         $("#prevRating").show();
         $("#nextRating").hide();
      }
      
      // prev 버튼 눌렀을 때
      if(menu_id==0)
      {
         $(".firstRating").show();
         $(".secondRating").hide();
         
         $("#nextRating").show();
         $("#prevRating").hide();
      }
   }

</script>
<style type="text/css">
.reviewContent {height: 80px;}

</style>
</head>
<body>

<!-- 헤더 임포트 -->
<c:import url="/WEB-INF/views/main/header.jsp"></c:import><br><br><br>
   <%
      Object user = session.getAttribute("id");
      String userId = (String)user;
      
      Object nick = request.getAttribute("userNick");
      String userNick = (String)nick;
   
   %>

<div id="wrapper">

   <div class="container">
      
      <div class="jumbotron" style="margin: 0 0 40px 0 !important;">
        <h1>Welcome to Play Stamp!</h1>
        <p>공연 관람을 기록하고 공유해보세요</p>

        <p><a class="btn btn-primary btn-lg" href="addreviewsearchform.action" role="button">리뷰 작성하기</a></p>
        </div>
   </div><br><br>

   <!-- 리뷰 많은 공연순 리스트 출력 -->
    <div id="highReviewSorting" class="container">
       <div id="pageTitle1" class="container"><img src="images/smileicon.png" style="width:2%;"> 리뷰 많은 공연순</div>
       <div id="imgContainer" class="row">
       		<c:forEach var="listReview" items="${highReviewSorting }" begin="0" end="3">
	          <div class="col-lg-3 col-xs-6 col-md-3 firstReview" id="firstReview">
	             <a href="playdetail.action?play_cd=${listReview.play_cd }" class="thumbnail playthumbnail" style="width: 235px; height: 313.33px;">
	               <img class="playPoster" src="${listReview.play_img }" style="width: 100%; height: 100%;">
	             </a>
	             <div class="playTitle">${listReview.play_nm }</div>
	          </div>
	         </c:forEach>
	         <c:forEach var="listReview" items="${highReviewSorting }" begin="4" end="7">
	          <div class="col-lg-3 col-xs-6 col-md-3 secondReview" id="secondReview">
	             <a href="playdetail.action?play_cd=${listReview.play_cd }" class="thumbnail playthumbnail" style="width: 235px; height: 313.33px;">
	               <img class="playPoster"  src="${listReview.play_img }" style="width: 100%; height: 100%;">
	             </a>
	             <div class="playTitle">${listReview.play_nm }</div>
	          </div>
	         </c:forEach>

       </div>
    </div>
    
   <!-- 리뷰 많은 공연순 리스트를 컨트롤 할 엘리먼트 -->
   <div style="margin-left: 110px;">
   <a href="#" class="prev" id="prevReview" onclick="moveReview(0);return false;">prev</a>
   <a href="#" class="next" id="nextReview" onclick="moveReview(1);return false;">next</a>
   </div>


    <br><br><br><br><br><br>
    
    <!-- 좋아요 많은 리뷰순 리스트 출력 -->
    <div id="highLikeSorting" class="container">
       <div id="pageTitle2" class="container"><img src="images/hearticon.png" style="width:2%;"> 좋아요 많은 리뷰순<br><br></div>
       <div id="reviewContainer" class="row">


           <c:set var="i" value="0"></c:set>
           <c:forEach var="listLike" items="${highLikeSorting }" begin="0" end="2">
              <div class="col-lg-4 col-xs-6 col-md-3 firstLike" id="firstLike">
                <a href="playreviewdetail.action?playrev_cd=${listLike.playrev_cd }&play_cd=${listLike.play_cd}" class="thumbnail">
                    <span class="user">
                      <img id="userImage" onerror="this.src='<%=cp%>/images/default_profile.png'" src="<%=cp%>/profile/${listLike.user_img }">
                   <input type="text" class="userName" value="${listLike.user_nick }" readonly="readonly"><br>
                </span>
                <input type="text" class="playName" value="${listLike.play_nm }" readonly="readonly"><br>
                <input type="text" class="reviewTitle" value="${listLike.title }" readonly="readonly"><br>
                <span class="ratingContainer" style="display: block">
                <select id="rating${i}">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                </select>
                </span>
                <span class="reviewContent">${listLike.contents }</span><br>
                <span class="likecomment">
                   <img src="images/heartblack.png" style="width: 25px;"><input type="text" class="reviewLike" value="${listLike.like_count }" readonly="readonly">
                   <img src="images/commenticon.png" style="width: 20px;"><input type="text" class="reviewComment" value="${listLike.comment_count }" readonly="readonly"><br>
                </span>
                </a>
            </div>
        <c:set var="i" value="${i+1}"></c:set>
         </c:forEach>
         
         <c:set var="i" value="3"></c:set>
       	 <c:forEach var="listLike" items="${highLikeSorting }" begin="3" end="5">
	       	 <div class="col-lg-4 col-xs-6 col-md-3 secondLike" id="secondLike">
	             <a href="playreviewdetail.action?playrev_cd=${listLike.playrev_cd }&play_cd=${listLike.play_cd}" class="thumbnail">
	             	 <span class="user">
			             <img id="userImage" onerror="this.src='<%=cp%>/images/default_profile.png'" src="<%=cp%>/profile/${listLike.user_img }">
						 <input type="text" class="userName" value="${listLike.user_nick }" readonly="readonly"><br>
					 </span>
					 <input type="text" class="playName" value="${listLike.play_nm }" readonly="readonly"><br>
					 <input type="text" class="reviewTitle" value="${listLike.title }" readonly="readonly"><br>
					 <span class="ratingContainer" style="display: block">
					 <select id="rating${i}">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					 </select>
					 </span>
					 <span class="reviewContent">${listLike.contents }</span><br>
					 <span class="likecomment">
						 <img src="images/heartblack.png" style="width: 25px;"><input type="text" class="reviewLike" value="${listLike.like_count }" readonly="readonly">
						 <img src="images/commenticon.png" style="width: 20px;"><input type="text" class="reviewComment" value="${listLike.comment_count }" readonly="readonly"><br>
					 </span>
	             </a>
	         </div>
	     <c:set var="i" value="${i+1}"></c:set>

         </c:forEach>
       </div>
    </div><!-- clsoe #highLikeSorting -->
    
    <!-- 좋아요 많은 리뷰순 리스트를 컨트롤 할 엘리먼트 -->

    <div style="margin-left: 110px;">
   <a href="#" class="prev" id="prevLike" onclick="moveLike(0);return false;">prev</a>
   <a href="#" class="next" id="nextLike" onclick="moveLike(1);return false;">next</a>
   </div>


    
    <br><br><br><br><br><br>
    
    <!-- 평점 높은 공연순 리스트 출력 -->
    <div id="highRateSorting" class="container">
       <div id="pageTitle3" class="container"><img src="images/goodicon.png" style="width:2%;"> 평점 높은 공연순<br><br></div>
       <div id="imgContainer" class="row">
          <c:forEach var="listRate" items="${highRateSorting }" begin="0" end="3">

             <div class="col-lg-3 col-xs-6 col-md-3 firstRating" id="firstRating">
                <a href="playdetail.action?play_cd=${listRate.play_cd }" class="thumbnail playthumbnail" style="width: 235px; height: 313.33px;">
                  <img class="playPoster"  src="${listRate.play_img }" style="width: 100%; height: 100%;">
                </a>
                <div class="playTitle">${listRate.play_nm }</div>
             </div>
         </c:forEach>
         
         <c:forEach var="listRate" items="${highRateSorting }" begin="4" end="7">
             <div class="col-lg-3 col-xs-6 col-md-3 secondRating" id="secondRating">
                <a href="playdetail.action?play_cd=${listRate.play_cd }" class="thumbnail playthumbnail" style="width: 235px; height: 313.33px;">
                  <img class="playPoster"  src="${listRate.play_img }" style="width: 100%; height: 100%;">
                </a>
                <div class="playTitle">${listRate.play_nm }</div>
             </div>
         </c:forEach>

       </div>
    </div><!-- close #highRateSorting -->
    
    <!-- 평점 높은 공연순 리스트를 컨트롤 할 엘리먼트 -->


	<div style="margin-left: 110px;">
	   <a href="#" class="prev" id="prevRating" onclick="moveRating(0);return false;">prev</a>
	   <a href="#" class="next" id="nextRating" onclick="moveRating(1);return false;">next</a>
            </div>

    
    <br><br><br>
    
</div><!-- close #wrapper -->

<!-- 푸터 임포트 -->
<c:import url="/WEB-INF/views/main/Footer.jsp"></c:import>
</body>
</html>