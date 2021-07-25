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
<title>MSeat.jsp</title>
<style>
.container 
{
  width: 500px;
  margin: 20px auto;
}

.theaterBtn 
{
	border-radius: 10px;
	width: 100pt;
	height: 30pt;
	margin-left: 10px;
	margin-right: 10px;
	font-family: 맑은고딕;
	background-color: #d9d9d9;
	border-color: #d9d9d9;
}

.tab_title
{
	text-align: center;
	margin: 0 auto;
	
}

.tab_cont {
  clear: both;
  border: none;
  height: 130px;
  background-color: white;
}

.tab_cont div {
  display: none;
  text-align: center;
}

.tab_cont div.on {
  display: block;
}
 
#blank
{
	height: 30px;
}

#myDIV
{
	border: 2px solid black;
	width : 500px;
 	height: 100px;
 	 
}

.backgroundImg
{
	width: 50%;
    position:absolute;
    z-index:1;
	left: 50%;
	top: 20%;
	transform: translate(-50%, 0%);

}

.seatImg
{
    position:absolute;
    z-index:2;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function()
	{
		$(".tab_title input").click(function()
		{
			var idx = $(this).index();
			$(".tab_title input").removeClass("on");
			$(".tab_title input").eq(idx).addClass("on");
			$(".tab_cont > div").hide();
			$(".tab_cont > div").eq(idx).show();
			$(this).css("background-color", "blue");
			$(this).css("color", "white");
			$(".tab_title input").not(this).css('color', 'black');
			$(".tab_title input").not(this).css('background-color', '#d9d9d9');
			
		});
		
		$(".seatImg").mouseenter(function () {
			
			$(".myDiv").show();
			var name = $(this).val(); 
			$('.seatName').html(name);
			
			/* 
			$("#importStart").html("<c:forEach var='theater' items='${listSac}'>");
			$("#importEnd").html("</c:forEach>");
			 */
			
		});
	
		$(".seatImg").mouseleave(function () {
			$(".myDiv").hide();
		});
		 
	});
	
	// 
	
	$(function()
	{
		var sac = new Array();  //-- 배열이 공연장 5개 하나씩 있고

		// 사용자에게는 play 객체의 play_nm(=value1, 공연명+기간) 만 보여준다.
		// 해당 공연명을 클릭하면 하단에서는 같은 객체의 공연 코드 값도 저장한다.
		$("input[name=sacview]", "input[name=sacsound]", "input[name=sacview]").each(function(index, item)	//-- 14개*5?
		{
			sac.push($(item).attr("value1"));
			sac.push()
		});

	});

	/* 
		function showRating()
		{
			var con = document.getElementById("myDiv");
			if(con.style.display=='none')
				con.style.display='block';
			else
				con.style.display='none';
		};
	 */
</script>
</head>
<body>
<c:import url="header.jsp"></c:import>
<div id="blank"></div>
<div class="container">
  <div class="tab_title">
    <input type="button" id="seoulArtsCenter" class="theaterBtn" value="예술의전당" style="color: white; background-color: blue;">
	<input type="button" id="blueSquare" class="theaterBtn" value="블루스퀘어">
	<input type="button" id="chungmuArtsCenter" class="theaterBtn" value="충무아트센터">
	<input type="button" id="dCubeArtsCenter" class="theaterBtn" value="디큐브아트센터">
	<input type="button" id="charLotteTheater" class="theaterBtn" value="샤롯데씨어터">
  </div>
  <div id="blank"></div>
  <div class="tab_cont">
    <div class="on">
		<span>
			<img class="backgroundImg" src="images/seoulArtsCenter_clean.png"></img>
		</span>
		<span>
			<input class="seatImg" type="image" name="seatName" value="1" src="images/sac-a1.png" style=" top: 115px; left: 500px; width:20%;">
			<input class="seatImg" type="image" name="seatName" value="2" src="images/sac-a2.png" style=" top: 178px; left: 500px; width:20%;">
		</span>
	 
		<div id="myDiv" style="display: none; position: absolute; top: 100px; left: 1100px; border: 1pt;">
			<span class="seatName" style="font-size: 20pt; color: red; font-weight: bold;"></span><br>
			<span>해당구역에서 관람한 회원님들이<br>남겨주신 평균 별점입니다 :)</span><br>
			<span id="importStart"></span>
			<%-- 
			<c:forEach var="theater" items="${list }"> 
          	  	<input type="hidden" id="sacview" name="sacview" value1="${theater.sacview }" value2="${theater.play_cd }"/>
           		<input type="hidden" id="sacseat" name="sacseat" value="${theater.sacseat }"/>
         	</c:forEach>
         	
         	<c:forEach var="play" items="${list }"> 
           	 	<input type="hidden" id="play_nm" name="play_nm" value1="${play.play_nm }" value2="${play.play_cd }"/>
            	<input type="hidden" id="theater_cd" name="theater_cd" value="${play.theater_cd }"/>
         	</c:forEach>
			 --%>
			
			<c:forEach var="theater" items="${listSac }">
				<table>
					<tr>
						<th>시야</th>
						<td>${theater.sacview}</td>
					</tr>
					<tr>
						<th>좌석</th>
						<td>${theater.sacseat}</td>
					</tr>
					<tr>
						<th>조명</th>
						<td>${theater.saclight}</td>
					</tr>
					<tr>
						<th>음향</th>
						<td>${theater.sacsound}</td>
					</tr>
				</table>
			</c:forEach>
			<span id="importEnd"></span>
		</div>
  </div>
    <div>
		<c:import url="BlueSquare.jsp"></c:import>
    </div>
    <div>
    </div>
    <div>
    </div>
    <div>
    </div>
  </div>
</div>

</body>
</html>