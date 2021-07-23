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
<title>StatisticsVisitorView.jsp</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>
<div style="width:60%">

	<div>

		<canvas id="canvas" height="450" width="600"></canvas>

	</div>

</div>

<script

	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script

	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.js"></script>

<script>

var chartLabels = [];

var chartData = [];



$.getJSON("http://localhost:8080/incomeList", function(data){

	

	$.each(data, function(inx, obj){

		chartLabels.push(obj.dd);

		chartData.push(obj.income);

	});

	createChart();

	console.log("create Chart")

});



var lineChartData = {

		labels : chartLabels,

		datasets : [

			{

				label : "Date Income",

				fillColor : "rbga(151,187,205,0.2)",

				strokeColor : "rbga(151,187,205,1)",

				pointColor : "rbga(151,187,205,1)",

				pointStrokeColor : "#fff",

				pointHighlightFill : "#fff",

				pointHighlightStroke : "rbga(151,187,205,1)",

				data : chartData

			

		}

			]

}



function createChart(){

	var ctx = document.getElementById("canvas").getContext("2d");

	LineChartDemo = Chart.Line(ctx,{

		data : lineChartData,

		options :{

			scales : {

				yAxes : [{

					ticks :{

						beginAtZero : true

					}

				}]

			}

		}

	})

}

</script>

</body>
</html>