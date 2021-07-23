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
<title>DramaList.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
	.play
	{
		text-align: center;
	}
	
	.playState
	{
		text-align: left;
	}
	
	#selectpicker
	{
	 	float:right;
	}
	
	#result
	{
		border-spacing: 20px;
  		border-collapse: separate;
  		margin-left: auto; margin-right: auto;

	}
	.playImg
	{
		width: 240px;
		height: 330px;
	}
	
	#td {float: left; margin: 0 20px 32px 0;  overflow: hidden;}
	#td > a:hover img 
	{
	  transform: scale(1.2);
	  transition: transform 1s;
	  filter: brightness(70%);
	}
</style>
<script type="text/javascript">
	
	var list = "";	// ajax 가 반환하는 list 객체 받을 변수
	var params = ""; // playstate를 키값과 밸류값으로 갖는 자바스크립트 객체
	var j = 0;		// 50개씩 출력해 주기 위해 반복문 변수에 곱해 줄 변수
	
	$(function()
	{	
		params = { "playState" : "공연중" };
		
		// 최초 요청시
		ajaxRequest(params);
		
		// 버튼 클릭시 상태 변경하며 이동
		$(".playState").click(function()		
		{   
			$("#result").html("");
			var playState = $(this);
		
			// 버튼 클릭시 params 변수 해당 버튼의 value 값으로 초기화
			var params = { "playState" : playState.val() };
			
			ajaxRequest(params);
			
		});
			
		// 버튼 클릭시마다 호출됨
		function ajaxRequest(params)
		{	
			$.ajax({
				type:"POST",
				url: "dramaprint.action",
				dataType: "json",
				data: params,
				success: function(data)
				{
					list = data.result;
					var temp = "";
					j=1;
							
					var dheight = $(document).height();
					
					$("<table>").appendTo("#result");
					
					// 초기 게시물 20 개 구성
					for(var i=0; i<50; i++)
					{
						// 한 줄에 다섯 개씩 출력
						if (i%5==0)
							$("<tr>").appendTo("#result");
						
						// get 방식으로 공연코드를 넘겨 줌으로써 클릭시 공연 상세정보로 이동할 수 있도록 함
						$("<div id='td'><td><a href='playdetail.action?play_cd="
								+ list[i].play_cd + "'>" + "<img src='"
								+ list[i].play_img + "' class='playImg'></a><td></div>").appendTo("#result");
								
						// 테스트 
						//$("<td>" + i + "<td>").appendTo("#result"); 
						
						if (i%5==4)
							$("</tr>").appendTo("#result");	
					} //→ ajax 는 초기 게시물 구성하고, 버튼을 새로 클릭하지 않는 이상 더이상 호출되지 않음
					
					// 자바스크립트 파라미터에 객체가 들어갈 수 없다고 함.
					// 때문에 자바스크립트 객체를 함수의 파라미터로 전달하기 위해서는
					// JSON.stringify 메소드를 통해.. String 형태로 바꾸어 주어야 한다고 함.
					var data = JSON.stringify(list);
					
					infinite(data);
					
					
					$("</table>").appendTo("#result");

				}, error : function(e)
				{
					alert(e.responseText);
				}
				
			});
		}
		
	});
	
	//@@ 무한스크롤 구현
	function infinite(data)
	{
		$(window).scroll(function()
		{					
			var dheight = $(document).height();
			var sheight = parseInt($(window).scrollTop()) + $(window).height() + 5;
			var length = list.length;
			
			// 스크롤이 바닥에 닿으면
			if(dheight <= sheight)
			{		
				for(var i=50*j ; i<(50*j)+50; i++)
				{
					// 데이터를 다 출력하면 무한 스크롤 이벤트 해제
					if (i == list.length)
						$(window).unbind("scroll");
					
					// 한 줄에 다섯 개씩 출력
					if (i%5==0)
						$("<tr>").appendTo("#result");
					
					// get 방식으로 공연코드를 넘겨 줌으로써 클릭시 공연 상세정보로 이동할 수 있도록 함
					$("<div id='td'><td><a href='playdetail.action?play_cd="
							+ list[i].play_cd + "'>" + "<img src='"
							+ list[i].play_img + "' class='playImg'></a><td></div>").appendTo("#result");
					
					// 테스트
					//$("<td>" + i + "<td>").appendTo("#result"); 
					
					if (i%5==4)
						$("</tr>").appendTo("#result");	
				}
				
				// 새로운 50개 데이터 모두 출력 후 다음 구간의 50 개 받아올 수 있도록 j를 증가시킴
				j = j + 1;
			}
			
		});
	}

</script>
</head>
<body>
<!-- 상단바 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	
<div style="width: 1300px; margin: 0 auto;">
	
	<!-- 뮤지컬/연극 버튼 -->
	<div class="play">
		<input type="button" class="btn btn-default" id="musical" name="musical" class="play" value="뮤지컬" onclick="location.href='musicallist.action'">
		<input type="button" class="btn btn-default" id="drama" name="drama" class="play" value="연극" onclick="location.href='dramalist.action'">
	</div>
	
	<!-- 공연중/공연예정/공연완료 버튼 -->
	<div>
		<button type="button" class="btn btn-default playState" id="ingPlay" name="ingPlay" class="playState" value="공연중">공연중</button>
		<button type="button" class="btn btn-default playState" id="ingPlay" name="willPlay" class="playState" value="공연예정">공연예정</button>
		<button type="button" class="btn btn-default playState" id="ingPlay" name="edPlay" class="playState" value="공연완료">공연완료</button>
	</div>
	
	<!-- 구분선 -->
	<hr/>
	
	<!-- 왼 -->
	<div id="playStateCheck">
	</div>

	<!-- 오 -->
	<!-- <div>
	<select id="sort" class="form-control">
		<option value="val1">최신순</option>
		<option value="val2">리뷰많은순</option>
	</select> 
	</div> -->
	<select class="selectpicker" style="margin-bottom: 32px;">
		<option value="val1">최신순</option>
		<option value="val2">리뷰많은순</option>
 	</select>
	
	<!-- 리스트 출력 예정 -->
	<div id="result">
	</div>
</div>

</body>
</html>