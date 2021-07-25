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
<title>MSeatMain.jsp</title>
<link rel="stylesheet" href="<%=cp %>/css/mseat.css">
<script type="text/javascript" src="<%=cp%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="<%=cp %>/css/bootstrap.min.css">

<script type="text/javascript">

	// 모달창 구현 -----------------------------------------------------------
	var on_off = 0;
	var x_margin, y_margin;
	var popup, fullBackground;

	// 모달창 여는 기능
	function openFrame(x)
	{
		// 공연장 버튼을 클릭했을 때 받는 value값(sac, bc, ..)마다 다르게 div 내용 불러오기
		if (x == 1)
			popup = document.getElementById("sac");
		else if (x == 2)
			popup = document.getElementById("bs");
		else if (x == 3)
			popup = document.getElementById("sac");
		else if (x == 4)
			popup = document.getElementById("sac");
		else
			popup = document.getElementById("sac");

		fullBackground = document.getElementById("fullBackground");

		fullBackground.style.top = document.body.scrollTop; //-- y 축 방향으로 스크롤한 거리
		fullBackground.style.left = document.body.scrollLeft; //-- x 축 방향으로 스크롤한 거리

		popup.style.top = ((screen.height / 2) - 200 + document.body.scrollTop) + "px";
		popup.style.left = ((screen.width / 2) - 500) + "px";

		fullBackground.style.display = "block";
		popup.style.display = "block";
		//document.body.style.overflow = "hidden";
	}

	// 모달창 닫는 기능
	function closeFrame()
	{
		fullBackground.style.display = "none";
		popup.style.display = "none";
		document.body.style.overflow = "auto";
	}

	function move_onoff(chk, e)
	{
		if (chk == 1)
		{
			x_margin = e.clientX - popup.offsetLeft;
			y_margin = e.clientY - popup.offsetTop;
		}
		on_off = chk;
	}

	function moven(e)
	{
		if (on_off == 1)
		{
			var x_result = e.clientX - x_margin;
			var y_result = e.clientY - y_margin;

			if (x_result > 0)
				popup.style.left = x_result + "px";
			if (y_result > 0)
				popup.style.top = y_result + "px";
		}
	}
	// ----------------------------------------------------------- 모달창 구현 

	// AJAX 구현 -------------------------------------------------------------
	var listSac = ""; // ajax 가 반환하는 listSac 객체 받을 변수
	var params = ""; // seatName를 키값과 밸류값으로 갖는 자바스크립트 객체

	$(function()
	{
		// 처음 로드 했을 때는 평점 div는 숨겨져있는 상태
		$(".seatRating").hide();

		// 마우스 엔터했을 때
		$(".seatImg").mouseenter(function()
		{	
			// div 내용 초기화
			//$("#ratingSacDiv").html("");
			//$("#ratingBsDiv").html("");

			// seatName에 구역번호값 담기
			var seatName = $(this).val();

			// 어느 구역인지 표시하기 위해 A+구역번호
			$('.seatName').html("A" + seatName);

			// 마우스 엔터시 params 변수 해당 버튼의 value 값으로 초기화
			params = { "seatName" : seatName };

			$(".seatRating").show();
			
			if(seatName>=1 && seatName<=8)
				$(".seatRating").css("top", "100px").css("left", "40px");
			else if(seatName>=9 && seatName<=12)
			{
				$("#sacRating").css("top", "400px").css("left", "750px");
				$("#bsRating").css("top", "370px").css("left", "750px");
			}
			else if(seatName>=13)
			{
				$("#sacRating").css("top", "630px").css("left", "40px");
				$("#bsRating").css("top", "550px").css("left", "40px");
			}
			// 아작스 요청
			ajaxRequest(params);

			// 마우스 리브했을 때 평점 div 숨김
			$(".seatImg").mouseleave(function()
			{
				$("#ratingSacDiv").html("");
				$("#ratingBsDiv").html("");
				
				noReviewInfoRating();
				
				$(".seatRating").hide();
			});
		});

	});

	// 마우스 엔터시마다 호출됨
	function ajaxRequest(params)
	{
		// GET방식으로 요청해야 가능해짐
		$.ajax(
		{
			type : "GET",
			url : "seatratingprint.action",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			data : params,
			success : function(data)
			{
				listSac = data.listSac;

				for (var i=0; i<4; i++)
				{
					// listSac에 담아온 것을 테이블 형식에 맞게 뿌려줌 (예술의전당)
					$("<table class='tableRating'><tr><th>시야 : </th><td>&emsp;" + listSac[i].viewrating + " 점</td></tr>"
					+ "<tr><th>좌석 : </th><td>&emsp;" + listSac[i].seatrating + " 점</td></tr>"
					+ "<tr><th>조명 : </th><td>&emsp;" + listSac[i].lightrating + " 점</td></tr>"
					+ "<tr><th>음향 : </th><td>&emsp;" + listSac[i].soundrating + " 점</td></tr></table>").appendTo("#ratingSacDiv");
					
				}
				
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
		
		// GET방식으로 요청해야 가능해짐
		$.ajax(
		{
			type : "GET",
			url : "seatratingprint.action",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			data : params,
			success : function(data)
			{
				listBs = data.listBs;
				
				for (var i=0; i<4; i++)
				{
					if(listBs[i].seatrating != null)
					{	
						ReviewInfoRating();
						
						// listBs에 담아온 것을 테이블 형식에 맞게 뿌려줌 (블루스퀘어)
						$("<table class='tableRating'><tr><th>시야 : </th><td>&emsp;" + listBs[i].viewrating + " 점</td></tr>"
						+ "<tr><th>좌석 : </th><td>&emsp;" + listBs[i].seatrating + " 점</td></tr>"
						+ "<tr><th>조명 : </th><td>&emsp;" + listBs[i].lightrating + " 점</td></tr>"
						+ "<tr><th>음향 : </th><td>&emsp;" + listBs[i].soundrating + " 점</td></tr></table>").appendTo("#ratingBsDiv");
					}
					else
						noReviewInfoRating();
				}	
			}
			, error : function(e)
			{
				alert(e.responseText);
			}
		});
	}			
	// ------------------------------------------------------------- AJAX 구현 
	
	function noReviewInfoRating()
	{
		$(".infoRating").html("아직 남겨진 리뷰가 없습니다 T.T");
	}
	
	function ReviewInfoRating()
	{
		$(".infoRating").html("해당구역에서 관람한 회원님들이<br>남겨주신 평균 점수입니다 :)");
	}
	
</script>
</head>
<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
<body onmouseup="move_onoff(0, event);" onmousemove="moven(event);">

	<!-- 메인 화면 -->
	<br>
	<br>
	<!-- 공연장 버튼 -->
	<div class="theater" style="text-align: center;">
		<button type="button" onclick="javascript:openFrame(1);" class="btn btn-default">예술의전당</button>&emsp;
		<button type="button" onclick="javascript:openFrame(2);" class="btn btn-default">블루스퀘어</button>&emsp;
		<button type="button" onclick="javascript:openFrame(3);" class="btn btn-default">충무아트센터</button>&emsp;
		<button type="button" onclick="javascript:openFrame(4);" class="btn btn-default">디큐브아트센터</button>&emsp;
		<button type="button" onclick="javascript:openFrame(5);" class="btn btn-default">샤롯데씨어터</button>
	</div>

	<br />
	<br />
	<div class="intro" style="font-size: 10pt; font-weight: bold;">
		궁금하신 공연장을 선택하시고<br>좌석 구역에 마우스를 올려보세요 !
		<div class="mseatexample">
			<img src="images/mseatmainexamplefinal.JPG">
		</div>
	</div>


	<!-- 모달창 팝업시 배경 -->
	<div id='fullBackground'></div>

	<!----------------------------------------------------- 예술의전당 모달창 ------------------------------------------------------->
	<div id="sac">
		<div id="modal" class="titleBar" onmousedown="move_onoff(1, event);">
			<div class="title">::: 예술의전당 :::</div>
			<div class="titleClose">
				<a href="javascript:closeFrame();" style="cursor: hand;"> <img
					src="images/btn_close.gif" border="0" /></a>
			</div>
		</div>

		<div class="content">
			<!-- 예술의전당 좌석배치도 -->
			<img class="backgroundImg" src="images/sac/seoulArtsCenter_clean.png">

			<!-- 좌석배치도 위에 이미지에 맞게 구역(A1~A14) 설정 -->
			<input type="image" class="seatImg" value="1" src="images/sac/sac-a1.png" style="top: 88px; left: 392px; width: 21%;"> 
			<input type="image" class="seatImg" value="2" src="images/sac/sac-a2.png" style="top: 140px; left: 387px; width: 22%;"> 
			<input type="image" class="seatImg" value="3" src="images/sac/sac-a3.png" style="top: 200px; left: 433px; width: 13%;"> 
			<input type="image" class="seatImg" value="4" src="images/sac/sac-a4.png" style="top: 263px; left: 424px; width: 15%;"> 
			<input type="image" class="seatImg" value="5" src="images/sac/sac-a5.png" style="top: 128px; left: 320px; width: 10%;"> 
			<input type="image" class="seatImg" value="6" src="images/sac/sac-a6.png" style="top: 234px; left: 320px; width: 9%;"> 
			<input type="image" class="seatImg" value="7" src="images/sac/sac-a7.png" style="top: 128px; left: 570px; width: 10%;"> 
			<input type="image" class="seatImg" value="8" src="images/sac/sac-a8.png" style="top: 238px; left: 580px; width: 9%;"> 
			<input type="image" class="seatImg" value="9" src="images/sac/sac-a9.png" style="top: 480px; left: 375px; width: 26%;"> 
			<input type="image" class="seatImg" value="10" src="images/sac/sac-a10.png" style="top: 534px; left: 424px; width: 16%;"> 
			<input type="image" class="seatImg" value="11" src="images/sac/sac-a11.png" style="top: 392px; left: 324px; width: 9%;"> 
			<input type="image" class="seatImg" value="12" src="images/sac/sac-a12.png" style="top: 392px; left: 593px; width: 9%;"> 
			<input type="image" class="seatImg" value="13" src="images/sac/sac-a13.png" style="top: 686px; left: 370px; width: 27%;"> 
			<input type="image" class="seatImg" value="14" src="images/sac/sac-a14.png" style="top: 613px; left: 320px; width: 37%;">

			<div class="seatRating" id="sacRating">
				<div class="seatName"></div><br>
				<div style="font-family: 맑은 고딕;">해당구역에서 관람한 회원님들이<br>남겨주신 평균 점수입니다 :)</div><br>
				<div id="ratingSacDiv"></div>
			</div>
			<!-- close .seatRating -->
		</div>
		<!-- close .content -->
	</div>
	<!-- close #sac -->


	<!----------------------------------------------------- 블루스퀘어 모달창 ------------------------------------------------------->
	<div id="bs">
		<div id="modal" class="titleBar" onmousedown="move_onoff(1, event);">
			<div class="title">::: 블루스퀘어 :::</div>
			<div class="titleClose">
				<a href="javascript:closeFrame();" style="cursor: hand;"> <img
					src="images/btn_close.gif" border="0" /></a>
			</div>
		</div>

		<div class="content">
			<!-- 블루스퀘어 좌석배치도 -->
			<img class="backgroundImg" src="images/bs/blue.png" style="width: 550px;">

			<!-- 좌석배치도 위에 이미지에 맞게 구역(A1~A14) 설정 -->
			<input type="image" class="seatImg" src="images/bs/blue-a1.png" value="1"
				style="top: 90px; left: 442px; width: 11%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a2.png" value="2"
				style="top: 113px; left: 400px; width: 20%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a3.png" value="3"
				style="top: 185px; left: 384px; width: 23%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a4.png" value="4"
				style="top: 225px; left: 437px; width: 12%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a5.png" value="5"
				style="top: 105px; left: 330px; width: 9%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a6.png" value="6"
				style="top: 105px; left: 578px; width: 9%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a7.png" value="7"
				style="top: 174px; left: 321px; width: 10%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a8.png" value="8"
				style="top: 174px; left: 578px; width: 10%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a9.png" value="9"
				style="top: 415px; left: 368px; width: 26%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a10.png" value="10"
				style="top: 407px; left: 320px; width: 10%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a11.png" value="11"
				style="top: 458px; left: 442px; width: 11%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a12.png" value="12"
				style="top: 407px; left: 578px; width: 10%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a13.png"  value="13"
				style="top: 580px; left: 363px; width: 27%;"> <input
				type="image" class="seatImg" src="images/bs/blue-a14.png" value="14"
				style="top: 570px; left: 312px; width: 37%;">
		
			<div class="seatRating" id="bsRating">
				<div class="seatName"></div><br>
				<div class="infoRating" style="font-family: 맑은 고딕;">아직 남겨진 리뷰가 없습니다 T.T</div><br>
				<div id="ratingBsDiv"></div>
			</div>
		</div>
		<!-- close #modal -->
	</div>
	<!-- close #bs -->
</body>
</html>