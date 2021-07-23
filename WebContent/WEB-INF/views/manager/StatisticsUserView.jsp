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
<title>StatisticsUserView.jsp</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 차트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style type="text/css">

	.nav
	{
		flex-wrap:none; 
		display: block;
	}

</style>

<script type="text/javascript">

	// 현재 날짜 기준 연도 구하기
	now = new Date();	
	year = now.getFullYear();
	
	$(function()
	{
		$(".year").val(year);
		
		$.ajax({
					url: "statisticsmanager.action"
				  , type: "GET"
				  , data: {"userYear": year }
				  , success : function(data)
				    {
					  userTotal = data.userTotal;
					  
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
				url: "statisticsmanager.action"
			  , type: "GET"
			  , data: {"userYear": year }
			  , success : function(data)
			    {
				  userTotal = data.userTotal;
				  
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
						url: "statisticsmanager.action"
					  , type: "GET"
					  , data: {"userYear": year }
					  , success : function(data)
					    {
						  userTotal = data.userTotal;
						  
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
		var ctx = $('#myMChart').get(0).getContext("2d");
		window.myMChart = new Chart(ctx,
		{
			type : 'line',
			data : lineChartData, plugins: { legend: { display: false }}
		});
		
		myMChart.data.datasets[0].data = [userTotal.jan, userTotal.feb, userTotal.mar, userTotal.apr
			, userTotal.may, userTotal.jun, userTotal.jul, userTotal.aug, userTotal.sep, userTotal.oct
			, userTotal.nov, userTotal.dec];
		myMChart.update();
	}
	

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
	<c:import url="/WEB-INF/views/manager/ManagerHeader.jsp"></c:import>

	<div id="wrapper">
		<div class="container" style="align: left; width: 74%; height: 700px; top:30px;">
			<h3 class="container"><b>가입 회원 통계</b></h3><hr>
			
			<div class="btn-group-lg" role="group" aria-label="..." style="width: 30%;">
			  <button type="button" id="preBtn" class="btn btn-default">pre</button>
			  <input type="button" class="btn btn-primary year" value="2021" style="width: 22%;">
			  <button type="button" id="nextBtn" class="btn btn-default">next</button>
			</div>
			
			<br>
			<br>
				<div class="chart-container" style="flex:1; margin-bottom: 30px; width: 85%;">
					<div>
						<canvas id="myMChart"></canvas>
					</div>
			</div>
		</div>
	</div>
</body>
</html>