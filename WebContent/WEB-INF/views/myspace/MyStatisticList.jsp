<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 관람 통계</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 차트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">

	// 현재 날짜 기준 연도 구하기
	now = new Date();	
	year = now.getFullYear();
	
	$(function()
	{
		$(".year").val(year);
		
		$.ajax({
					url: "mystatistic.action"
				  , type: "GET"
				  , data: {"userYear": year }
				  , success : function(data)
				    {
					  revTotal = data.revTotal;
					  revUser = data.revUser;
					  u = data.u;
					  comp = data.comp;
					  revMoney = data.revMoney;
					  
					  createChart();
					  
				    },  
					error : function(request,status,error)
					{
				        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				    }
			  	}); 
		
		$("#preBtn").on("click", function()
		{
		  
			year = year - 1;
			$(".year").val(year);
			
			$.ajax({
				url: "mystatistic.action"
			  , type: "GET"
			  , data: {"userYear": year }
			  , success : function(data)
			    {
				  revTotal = data.revTotal;
				  revUser = data.revUser;
				  u = data.u;
				  comp = data.comp;
				  revMoney = data.revMoney;
				  
				  myChart.destroy();
				  myDChart.destroy();
				  myMChart.destroy();
				  createChart();
			    },  
				error : function(request,status,error)
				{
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			    }
		  	}); 
			
		});
		
		$("#nextBtn").on("click", function()
				{
				  
					year = year + 1;
					$(".year").val(year);
					
					$.ajax({
						url: "mystatistic.action"
					  , type: "GET"
					  , data: {"userYear": year }
					  , success : function(data)
					    {
						  revTotal = data.revTotal;
						  revUser = data.revUser;
						  comp = data.comp;
						  u = data.u;
						  revMoney = data.revMoney;
						  
						  //alert(year  + "6월 : " + revTotal.jun);
						  myChart.destroy();
						  myDChart.destroy();
						  myMChart.destroy();
						  createChart();
					    },  
						error : function(request,status,error)
						{
					        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
					    }
				  	}); 
					
				});
	});
	
	function createChart()
	{
		var ctx = $('#myChart').get(0).getContext("2d");
		window.myChart = new Chart(ctx,
		{
			type : 'bar',
			data : barChartData, plugins: { legend: { display: false }}
		});
		
		// 전체 사용자
		myChart.data.datasets[0].data = [revTotal.jan/u, revTotal.feb/u, revTotal.mar/u, revTotal.apr/u
			, revTotal.may/u, revTotal.jun/u, revTotal.jul/u, revTotal.aug/u, revTotal.sep/u, revTotal.oct/u,
			revTotal.nov/u, revTotal.dec/u];
		
		// 특정 사용자
		myChart.data.datasets[1].data = [revUser.jan, revUser.feb, revUser.mar, revUser.apr
			, revUser.may, revUser.jun, revUser.jul, revUser.aug, revUser.sep, revUser.oct,
			revUser.nov, revUser.dec];
		myChart.update();
		
		
		var ctx = $('#myDChart').get(0).getContext("2d");
		window.myDChart = new Chart(ctx,
		{
			type : 'doughnut',
			data : dnChartData, plugins: { legend: { display: false }}
		});
		
		myDChart.data.datasets[0].data = [comp.c1, comp.c2, comp.c3, comp.c4, comp.c5, comp.c6];
		myDChart.update();
		
		
		var ctx = $('#myMChart').get(0).getContext("2d");
		window.myMChart = new Chart(ctx,
		{
			type : 'line',
			data : lineChartData, plugins: { legend: { display: false }}
		});
		
		myMChart.data.datasets[0].data = [revMoney.jan, revMoney.feb, revMoney.mar, revMoney.apr
			, revMoney.may, revMoney.jun, revMoney.jul, revMoney.aug, revMoney.sep, revMoney.oct
			, revMoney.nov, revMoney.dec];
		myMChart.update();
	}
	
	
	
	var barChartData =
	{
		labels : [ "1월", "2월", "3월", "4월", "5월", "6월",
				"7월", "8월", "9월", "10월", "11월", "12월" ],
		datasets : [
				{
					label : 'total',
					backgroundColor : "#eeeff0",
					data : []
				},
				{
					label : 'user',
					backgroundColor : "#007bff",
					data : []
				} ]
	};
	
	var dnChartData =
	{
		labels : [ "없음", "친구", "부모님", "애인", "형제", "기타" ],
		datasets : [
				{
					data : [],
					backgroundColor: [
					      'rgb(255, 99, 132)',
					      'rgb(54, 162, 235)',
					      'rgb(255, 205, 86)',
					      '#007bff',
					      '#eeeff0',
					      'rgb(255, 205, 86)'
					    ],
					    hoverOffset: 4
				}]
	};
	
	var lineChartData =
	{
		labels : [ "1월", "2월", "3월", "4월", "5월", "6월",
				   "7월", "8월", "9월", "10월", "11월", "12월" ],
		datasets : [
				{
					data : [],
					label : 'user',
					backgroundColor: [
					      'rgb(255, 99, 132)'
					    ],
				}]
	};

</script>
</head>
<body>
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>

	<div id="wrapper">
		<div class="container" style="margin-bottom: 100px;">
			<div id="pageTitle" class="container">나의 관람 통계</div>
			
			<div class="btn-group-lg" role="group" aria-label="..." style="width: 100%">
			  <button type="button" id="preBtn" class="btn btn-default">pre</button>
			  <input type="button" class="btn btn-primary year" value="2021">
			  <button type="button" id="nextBtn" class="btn btn-default">next</button>
			  연도별로 나의 관람 통계를 확인해보세요 :)
			</div>
			
			<br>
			<br>
			<div style="margin-bottom: 40px;">
				<h3>월별 관람 횟수</h3>
				<hr>
				<h5>${sessionScope.nick }님! 다른 사용자들과 월별 관람 통계를 비교해보세요!</h5>
				<br>
				<canvas id="myChart"></canvas>
			</div>
			<br>
			<br>
			
			<div style="display:flex; width: 100%;">
				<div class="chart-container" style="flex:0; margin-right: 80px;">
					<h3>동행인 비율</h3>
					<hr>
					<div style="width: 400px;">
						<h5><input type="button" class="btn-default year" value="2021">년에는
						누구와 가장 많이 함께했나요?</h5>
						<canvas id="myDChart"></canvas>
					</div>
				</div>
				
				<div class="chart-container" style="flex:1;">
					<h3>관람 금액 통계</h3>
					<hr>
					<div>	
						<h5><input type="button" class="btn-default year" value="2021">년에는
						얼마를 사용했을까요?</h5>
						<canvas id="myMChart"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>








</body>
</html>