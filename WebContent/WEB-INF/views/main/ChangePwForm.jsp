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

	$(function ()
	{
		//-- 비밀번호 확인 ① 최소 8글자 / 소문자, 특수문자 포함
		$("#userPw").on("input", function()
		{
			var pwRegex = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
			if(pwRegex.test($("#userPw").val())){
				$("#checkPw").text("올바른 형식입니다.").css("color", "green");
				 pwFlag = true;
			}
			else {
				$("#checkPw").text("소문자/특수문자를 포함한 최소 8글자 이상 입력해주세요.").css("color", "red");
				pwFlag = false;
			}
		});
		
		//-- 비밀번호 확인 ② 비밀번호 1,2차 입력 동일한지 확인
		$("#userPw2").blur(function()
		{
			
			if($('#userPw').val() != $('#userPw2').val())
			{
				$("#checkPw2").text("비밀번호가 일치하지 않습니다.").css("color", "red");
			    
				$('#userPw2').val('');
				$('#userPw2').css("border-color", "red");
				pwFlag = false;
			}
			else if($('#userPw').val() == $('#userPw2').val())
			{
				if(!$('#userPw2').val()=="")
				{
					$("#checkPw2").text("비밀번호가 일치합니다.").css("color", "green");
					$('#userPw2').css("border-color", "green");
					$("#updatePwBtn").attr("disabled",false);
					pwFlag = true;
				}
			}
		 });
	})

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
		<div id="pageTitle" class="container">비밀번호 변경하기</div>
		
				새로 설정할 비밀번호를 입력해주세요.
				<hr>
				<form action="userchangepw.action" method="post">
				
					<div class="joinInputBox">
						<input type="hidden" id="userId" name="user_Id" value="${userId }">
						<input type="password" id="userPw" name="user_Pw" class="form-control" maxlength="20" required="required"
						placeholder="비밀번호" style="padding-bottom: 10px;">
						<div class="checkText"><span id="checkPw"></span></div>
					</div>
					<div class="joinInputBox">
						<input type="password" id="userPw2" name="user_Pw2" class="form-control" maxlength="20" required="required"
						placeholder="비밀번호 확인">
						<div class="checkText"><span id="checkPw2"></span></div>
					</div>
					<hr>
						<input id="updatePwBtn" type="submit" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto;"
						value="비밀번호 변경하기" disabled="disabled">
						
				</form>
			
	</div>
	
</body>
</html>