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
<title>PlayReviewDetail.jsp</title>
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

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
 integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

<style type="text/css">	
	#img { text-align:center;}
	
	#playTable td {	width:100px; height:20px;
					text-align: center; }
		
	#tab { width: 60%; margin: auto; }
	
	.tab-content { border: 0.3px solid gray; }
	
	.subContainer { text-align: center; }
	#pageTitle { float: left; font-size: 20px;}	
	#dtTitle { float: right;}	
	#reviewTitle { display:inline-block;zoom:1;.display:inline; font-size: 25px;}	
	
	.container { width: 1300px; }
	
	#header { margin: auto; }
	
	#table { margin: auto; width: 80%; }	
	
	#playReview { text-align: left; }
	div#playReview > table > tbody > tr > td:nth-child(1) { width: 10px; }
	div#playReview > table > tbody > tr > td:nth-child(2) { height: 10px; }
	
	#report { float: right;}
	
	#reviewEnter{ font-weight: bold;}
	
	#commentAddBtn{ width: 15%; float: right;}
	
	#newReplyText{width: 82%;}
	
	.form-group{width: 100%; margin:auto;}
	
	.commentWriter{float: left; font-size: 15pt; font-weight: bold;}
	.comment {float: left;}
	
	.btn{float: right; height: 40px;}
	.commentDt{float: right; height: 40px;}
	
	#newReplyWriter {font-weight: bold;}


</style>
<script type="text/javascript">	
	//@@ 그,, 신고랑 삭제 분기하는 거 테스트용 전역 변수 
	var test = "";
	//@@ 공연 평점 받을 변수(제이쿼리에서 써먹어야 하기 때문에 따로 선언)
	var playRev = "";
	
	//@@ 현재 url 가져오기 
	var url = location.href;
	//@@ 자르기.. 
	var parameters = (((url.split("?"))[1].split("&"))[0]).split("=")[1];
	var parameters2 = (((url.split("?"))[1].split("&"))[1]).split("=")[1];
	
	var articleNo = parameters;
	
	//@@ 좋아요 여부 확인
	//var checkHeart = ${checkHeart};
	
	//@@ 신고 루트 분기 위한...
	var reportWhat = 0;
	
	<c:forEach var="playReviewDetail" items="${playReviewDetail }">
		playRev = "${playReviewDetail.rating_cd}"
	</c:forEach> 
	
	$(function()
	{
		//@@ 공연상세 별점
		$("#playRev").barrating({
			theme: "fontawesome-stars"
	        , initialRating: playRev
	        , readonly: true
	    });
	});
	
	//@@ 댓글 기능 처리
	$(function()
	{
		//@@ 댓글 목록 출력
		getComments();
		
		//@@ 좋아요 버튼을 눌렀을 때
		$("#heart").on("click", function()
		{
			var hiddenUser = $("#hiddenUser");
		    var hiddenUserVal = hiddenUser.val();
		    
		  	//@@ 빈 하트
		    var str0 = "<i class='far fa-heart fa-lg'></i>";
		    //@@ 꽉 찬 하트
		    var str1 = "<i class='fas fa-heart fa-lg'></i>";
		 	

	    	$.ajax({
			        type : "post",
			        url : "heartclick.action",
			        contentType: "application/json; charset=utf-8;",
			        dataType : "json",
			        data : JSON.stringify
			        ({
			            "playrev_cd" : articleNo,
			            "user_cd" : hiddenUserVal
			        }),
			        success : function (result)
			        {
			        	//console.log(result.lcount);
			        	
			        	//@@ 좋아요가 삭제되었을 경우
			        	if (result.returnValue == 0)
						{
			        		$("#lcount").html("");
				        	$("#lcount").html(result.lcount);
				        	$("#heart").html("");
							$("#heart").html(str0);
						}
			        	else if(result.returnValue ==1)
			        	{
			        		$("#lcount").html("");
				        	$("#lcount").html(result.lcount);
				        	$("#heart").html("");
							$("#heart").html(str1);
			        	}

		        	}
	    		});

		    
		});
		
		//@@ 댓글 달기 버튼을 눌렀을 때
		$("#commentAddBtn").on("click", function()
		{
			var replyText = $("#newReplyText");
		    var replyWriter = $("#newReplyWriter");
		    var hiddenUser = $("#hiddenUser");
		    
		    var replyTextVal = replyText.val();
		    var replyWriterVal = replyWriter.val();
		    var hiddenUserVal = hiddenUser.val();
		    
		 	// AJAX 통신 : POST
		    $.ajax({
		        type : "post",
		        url : "commentadd.action",
		        contentType: "application/json",
		        dataType : "text",
		        data : JSON.stringify({
		            "playrev_cd" : articleNo,
		            "comments" : replyTextVal,
		            "user_nick" : replyWriterVal,
		            "user_cd" : hiddenUserVal
		        }),
		        success : function (result) {
		        	
		        	if (result=="success")
					{
		        		getComments(); // 댓글 목록 출력 함수 호출
			            replyText.val(""); // 댓글 내용 초기화
			            replyWriter.val(""); // 댓글 작성자 초기화
					}
		        }
		    });
		});
		
		//@@ 댓글 삭제 버튼을 눌렀을 때 
		$("#comments").on("click", ".replyLi button", function()
		{
			var reply = $(this).parent();
			
			var replyNo = reply.attr("data-replyNo");
			
			//@@ 한 번 확인해 주고
			var check = confirm("정말 삭제하시겠어요?");
			
			//@@ 확인값이 true 라면
			if (check)
			{
			    $.ajax({
			        type : "post",
			        url : "commentremove.action",
			        contentType: "application/json",
			        dataType : "text",
			        data : JSON.stringify({
			            "comment_cd" : replyNo
			        }),
			        success : function (result) {
			        	
			        	if (result=="success")
						{
			        		getComments(); // 댓글 목록 출력 함수 호출
						}
			        }
			    });
			}
			else
				return;
		});
	});
	
	var check = new Array();
	var checkSt = new Array();
	<c:forEach var="checkRepComList" items="${checkRepComList }">
		check.push("${checkRepComList}");
	</c:forEach>
		
	<c:forEach var="checkRepComSt" items="${checkRepComStList }">
		checkSt.push("${checkRepComSt}");
	</c:forEach>
		

	
	//@@ 댓글 목록 출력 함수
	function getComments()
	{
		test = 1;
		
		$.getJSON("comment.action?playrev_cd=" + articleNo, function (data) {
			   
			console.log(data); 
			
			var str = "";
			var j = 0;
			
			$.each(data, function(i, item){
				//console.log(item.comment_cd);

				// 그대루 출력하는 경우
				// 신고 o + 처리 2 / 신고 x
				//console.log(checkSt[j]);
				
				if ((check[j]==1 && checkSt[j]==2) || check[j]==0)
				{
					//@@ 댓글을 작성한 사용자일 때만 삭제 버튼 활성화
					if ($("#hiddenUser").val()==item.user_cd)
					{
						str += "<div data-replyNo='" + item.comment_cd + "' class='replyLi'>"
						+ "<span class='commentWriter'>" + item.user_nick + "</span>"
						+ "<button type='button' class='btn btn-default'>삭제</button><br><br>"
						+ "<span class='comment'>" + item.comments + "</span>"
						+ "<span class='commentDt'>" + item.wr_dt + "</span><br>"          
		                + "<hr>"
						+ "</div>"
		                + "<br>";
	
				        $("#ccount").html(data.length);
						$("#comments").html(str);
					}
		 	
					//@@ 아닐 경우는 신고 버튼 활성화. replyLi2 아래의 버튼을 눌렀을 때는 신고 액션이 일어나야 함. 
					if ($("#hiddenUser").val()!=item.user_cd)
					{
						str += "<div data-replyNo='" + item.comment_cd + "' class='replyLi2'>"
						+ "<span class='commentWriter'>" + item.user_nick + "</span>"
						+ "<br><br>"
						+ "<span class='comment'>" + item.comments + "</span>"
						+ "<span class='commentDt'>" + item.wr_dt + "</span><br>"          
		                + "<hr>"
						+ "</div>"
		                + "<br>";
	
				    	$("#ccount").html(data.length);
						$("#comments").html(str);
					}
				}
				//@@ 블라인드 처리 하는 경우
				else if ((check[j]==1 && checkSt[j]==1) || (check[j]==1 && checkSt[j]==0))
				{	
					str += "<div data-replyNo='" + item.comment_cd + "' class='replyLi2'>"
					+ "<span class='commentWriter'>" + item.user_nick + "</span><br><br>"
					+ "<span class='comment'>" + '신고에 의해 블라인드 처리된 댓글입니다.' + "</span>"
					+ "<span class='commentDt'></span><br>"          
	                + "<hr>"
					+ "</div>"
	                + "<br>";
	                
					$("#comments").html(str);
				}
				
			 	j++;
			});
		});
	}
	
	//@@ 자식창을 저장할 변수
	var popup;

	
	var comment_cd = 0;
	
	$(function()
	{
		
		$("#reportPlayRev").click(function()
		{
			popup = window.open("reportform.action", "reportform", "width=570, height=350, resizable = no, scrollbars = no");
			reportWhat = 0;
			
		});
		
		$("#comments").on("click", ".replyLi2 button", function()
		{
			var reply = $(this).parent();
			
			var replyNo = reply.attr("data-replyNo");
			
			popup = window.open("reportform.action", "reportform", "width=570, height=350, resizable = no, scrollbars = no");
			reportWhat = 1;
			comment_cd = replyNo;
		});
	
		window.report = function(data)
		{ 
			// 자식창에서 얻어 온 신고 사유 값 rep_y_cd 에 담기
			var rep_y_cd = data;
			
			// report.action 으로 컨트롤러 호출
			if (reportWhat==0)
			{
				$(location).attr("href", "report.action?playrev_cd=" + articleNo + "&rep_y_cd=" + rep_y_cd + "&play_cd=" + parameters2);	
			}
			else if (reportWhat==1)
			{
				$(location).attr("href", "report.action?playrev_cd=" + articleNo + "&comment_cd=" + comment_cd + "&rep_y_cd=" + rep_y_cd +"&play_cd=" + parameters2);
			}
			
		}
	});
	

	
</script>
</head>

<body>
<div class="container">
<!-- 상단바 -->
	<div id="header">
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
<!-- 내용 출력 시작 -->	
	<div id="wrapper">
		<div>
		
		<!-- 상단 -->
		<div class="subContainer">
			<span id="pageTitle">리뷰 정보</span>
			<c:forEach var="playReviewDetail" items="${playReviewDetail }">
			<span id="reviewTitle">${playReviewDetail.title }</span>
			<hr>
			<span id="dtTitle">작성일자: ${playReviewDetail.playrev_dt }</span>
			</c:forEach>
		</div>
		<br><br>
			
			
		<!-- 리뷰 상세 출력 -->
		<div id="table">
			<table class="table table-borderless" id="playTable">
			<c:forEach var="playReviewDetail" items="${playReviewDetail }">
				<tr>
					<td rowspan="5">
					<div id="img"><img src="${playReviewDetail.play_img }" style="height: 240px;"></div>
					</td>
					<td>공연명</td>
					<td><input type="text" disabled="disabled" value="${playReviewDetail.play_nm }" ></td>
				</tr>
				<tr>
					<td>공연날짜</td>
					<td>
					<input type="text" disabled="disabled" value="${playReviewDetail.play_dt }" style="width: 100px;">
					</td>
				</tr>
				<tr>
					<td>공연시간</td>
					<td><input type="text" disabled="disabled" value="${playReviewDetail.play_time }"></td>
				</tr>
				<tr>
					<td>공연장소</td>
					<td><input type="text" disabled="disabled" value="${playReviewDetail.theater }"></td>
				</tr>
				<tr>
					<td>출연진</td>
					<td><input type="text" disabled="disabled" value="${playReviewDetail.play_cast }"
					style="width: 450px;"></td>
				</tr>
				<tr>
					<td>
						<select id="playRev">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</td>
					<td>함께 본 사람</td>
					<td><input type="text" disabled="disabled" value="${playReviewDetail.companion }"></td>
				</tr>
				<tr>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td id="reviewEnter">공연 상세 리뷰</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="3"><textarea rows="5%" cols="100%" disabled="disabled">${playReviewDetail.contents }</textarea></td>
				</tr>				
				</c:forEach>
			</table>
		</div>
		<br>
			
		<!-- 댓글 전 -->
		<div class="subContainer2">
			<c:forEach var="playReviewDetail" items="${playReviewDetail }">
			<span id="count">
			<span style="color: #0080FF"><i class="fa fa-comment fa-lg" aria-hidden="true"></i></span>&nbsp;<span id="ccount"></span>
			<span style="color: #FE2E2E"><i class="fas fa-heart fa-lg"></i></span>&nbsp;<span id="lcount">${playReviewDetail.lcount }</span>
			&nbsp;&nbsp;작성자: ${playReviewDetail.user_nick }			
			</span>
			<!-- 리뷰 작성자가 본인일 경우 신고 버튼 뜨지 않도록 처리 -->
			<hr>
			</c:forEach>
		</div>
		
		<!-- 댓글 ^^ -->

        <div class="box-footer">
            <div id="comments">

            </div>
        </div>
        <div class="box-footer">
            <div class="text-center">
                <ul class="pagination pagination-sm no-margin">

                </ul>
            </div>
        </div>
    </div>
  </div>
</div>
</body>
</html>