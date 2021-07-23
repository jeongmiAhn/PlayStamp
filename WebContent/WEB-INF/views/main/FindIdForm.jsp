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
<title>아이디 찾기</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	var checkCode = false;	// 인증번호 담는 변수
	var code = "";			// 이메일 인증코드 확인용

	$(function()
	{	
		
		//-- 인증번호 체크 안내창 가리기
		$("#mailCheckSuccess").hide();
		$("#mailCheckFail").hide();
		
		$("#userMail").on("input", function()
		{
			var mailRegex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			if(mailRegex.test($("#userMail").val())){
				 $("#checkMail").text("올바른 형식입니다.").css("color", "green");
			}
			else{
				 $("#checkMail").text("올바른 형식이 아닙니다.").css("color", "red");
				 mailFlag = false;
			}
		});
	
		//-- 인증메일 전송
		$("#mailCheckBtn").on("click", function()
		{
			
			$.ajax({
				type:"POST",
				url : "checkfindid.action",
				data : {"email" : $("#userMail").val()},
				success : function(data){ 						// 인증번호 반환
					$("#mailCheckNum").attr("disabled",false);  // 인증번호 입력할 수 있도록 활성화
					$("#mailCheckNum").val('');
					$("#mailCheckSuccess").hide();
					$("#mailCheckFail").hide();
					checkCode = false;
					code = data; 								// 인증번호 담기
				},
				error : function(request,status,error) {
					alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			    }
			});
		});
		
		//-- 인증코드 확인
		$("#mailCheckNum").keyup(function() {
			var inputCode = $("#mailCheckNum").val();
			if (inputCode != "" || code != "") {
				if (inputCode == code) {
					$("#mailCheckSuccess").show();
					$("#mailCheckFail").hide();
					$("#mailCheckNum").attr("disabled",true); // 인증번호 동일하면 비활성화
					$("#findIdBtn").attr("disabled",false);
				} else {
					$("#mailCheckSuccess").hide();
					$("#mailCheckFail").show();
				}
			}
		});
		
	});

</script>
<style>
.checkText {padding-top: 5px;}
</style>
</head>
<body>
<!-- 메뉴 영역 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	<div class="container">
		<div id="pageTitle" class="container">아이디 찾기</div>
		
				<h3 class="joinTitle">이메일 인증</h3><br>
				회원가입 당시 입력했던 이메일로 인증을 진행해주세요.
				<hr>
				
			<form action="selectfindid.action">
				<div class="form-group">
					<input type="text" id="userMail" name="user_Mail" class="form-control" placeholder="Enter email" >
					<div class="checkText"><span id="checkMail"></span></div>
					<br>
				  
					<div class="form-inline mail_check_input_box" id="mail_check_input_box_false">
					    <input type="text" id="mailCheckNum"  class="form-control mail_check_input" disabled="disabled" style="margin-right:10px; width: 60%;">
					    <input type="button" id="mailCheckBtn" class="btn" value="인증번호 전송" style="width: 39%;">
					</div>
				</div>
				  
				<div class="alert alert-success" id="mailCheckSuccess">인증번호가 일치합니다.</div>
				<div class="alert alert-danger" id="mailCheckFail">인증번호가 일치하지 않습니다.</div>
				
				<hr>
				<input id="findIdBtn" type="submit" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto;" value="나의 아이디 확인하기" disabled="disabled">
			</form>
			
	</div>
	
	
	
	
</body>
</html>