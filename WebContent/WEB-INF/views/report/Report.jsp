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
<title>Report.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript">
	function sendRepY()
	{
		//@@ 라디오버튼 값 수신
		var report = document.getElementsByName("report");
		var rep_y_cd = 0;
		
		for(var i=0; i<report.length; i++)
		{
		    if(report[i].checked)
		        rep_y_cd = report[i].value;
		}
		
		if (rep_y_cd > 0 ) // rep_y_cd 가 존재한다면
		{
			if (confirm("정말로 신고하시겠습니까?"))
			{			
				//@@ 부모창에 값 전송하기
				opener.report(rep_y_cd);
				window.close();	
			}
			else
				return;	
		}
		else
			alert("사유를 선택해 주세요.");
	}
</script>
</head>
<body>
	<div class="container">
		<div class="reportTitle">
			<h3>신고 사유 선택</h3>
			<hr>
		</div>
		<div class="reportWhy">
			<label><input type= "radio" name = "report" value="1">사기 및 가격 정책 위반</label><br>
			<label><input type= "radio" name = "report" value="2">욕설, 비방, 차별, 혐오</label><br>
			<label><input type= "radio" name = "report" value="3">홍보, 영리 목적</label><br>
			<label><input type= "radio" name = "report" value="4">개인정보 노출, 유포, 거래</label><br>
			<label><input type= "radio" name = "report" value="5">음란, 청소년 유해</label><br>
			<label><input type= "radio" name = "report" value="6">도배, 스팸</label><br>
			<button type="button" class="btn btn-default" onclick="sendRepY()">확인</button>
		</div>
	</div>
</body>
</html>