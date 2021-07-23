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
<title>운영진 정보 수정</title>
<link href="<%=cp%>/css/usersignup.css" rel="stylesheet">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	var pwFlag = false;
	var nameFlag = false;
	var telFlag = false;

	
	function checkForm()
	{
		if(idFlag==false) {
			alert("아이디 중복체크를 해주세요.");
	        return false;
	    }
		
		if(nameFlag==false) {
			alert("이름을 다시 확인 해주세요.");
	        return false;
	    }
		
		return true;
	}
	
	$(function()
	{	
		//-- 폼 양식 작성 중 유효성 체크
		
		//-- 이름 확인
		$("#mngNm").on("input", function()
		{
			var nameRegex = /^[가-힣]{2,6}$/;
			if(nameRegex.test($("#mngNm").val())){
				$("#checkNm").text("")
				 nameFlag = true;
			}
			else {
				$("#checkNm").text("2~6글자의 한글만 입력 가능합니다.").css("color", "red");
				 nameFlag = false;
			}
		});
		
		
		//-- 전화번호 확인
		$("#mngTel").on("input", function()
		{
			var telRegex = /^[0-9]{2,3}[0-9]{3,4}[0-9]{4}/;
			if(telRegex.test($("#mngTel").val())){
				$("#checkTel").text("")
				 telFlag = true;
			}
			else {
				$("#checkTel").text("올바른 형식이 아닙니다.").css("color", "red");
				telFlag = false;
			}
		});
		
		
		//-- 비밀번호 확인 ① 최소 8글자 / 소문자, 특수문자 포함
		$("#mngPw").on("input", function()
		{
			var pwRegex = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
			if(pwRegex.test($("#mngPw").val())){
				$("#checkPw").text("올바른 형식입니다.").css("color", "green");
				 pwFlag = true;
			}
			else {
				$("#checkPw").text("소문자/특수문자를 포함한 최소 8글자 이상 입력해주세요.").css("color", "red");
				pwFlag = false;
			}
		});
		
		//-- 비밀번호 확인 ② 비밀번호 1,2차 입력 동일한지 확인
		$("#mngPw2").blur(function()
		{
			
			if($('#mngPw').val() != $('#mngPw2').val())
			{
				$("#checkPw2").text("비밀번호가 일치하지 않습니다.").css("color", "red");
			    
				$('#mngPw2').val('');
				$('#mngPw2').css("border-color", "red");
				pwFlag = false;
			}
			else if($('#mngPw').val() == $('#mngPw2').val())
			{
				if(!$('#mngPw2').val()=="")
				{
					$("#checkPw2").text("비밀번호가 일치합니다.").css("color", "green");
					$('#mngPw2').css("border-color", "green");
					pwFlag = true;
				}
			}
		 });
	});
</script>
<style>
#wrapper {width:100%; display: flex;}
		#pageTitle 
		{
			margin-top: 60px; 
			font-size: 30px; 
			font-weight: bold; 
			margin: 0 auto; 
			line-height: 66px; 
			width: 70%;
			float: left;
		}
		
		.inBox 
		{ 
			background-color: #999;  
			height: 96px; 
			border-radius: 20px; 
			background-color: #fafafa; 
			padding: 15px 25px 15px 25px;
			margin: 40px 0 16px 0;
			text-align: left;
		}
		
		#signUpBtn {margin: 10px 0 10px 0;}
		#adminTel {margin-bottom: 8px;}
</style>
</head>
<body>
	<div id="wrapper">
	
		<!-- 메뉴 영역 -->
		<div id="Left" style="flex:0; margin-right:360px;">
			<c:import url="/WEB-INF/views/manager/ManagerHeader.jsp"></c:import>
		</div>
		
		<div id="Right" style="flex:1; margin-right:120px;">
			<div class="inBox">
				<div id="pageTitle">운영진 수정</div>
			</div>
			<br>
			
		<!-- 입력 폼 -->
		<form id="form" action="managerupdate.action" class="container managerSignUpForm" method="post" 
		style="float: left;" onsubmit="return checkForm()">
			<div id="content" style="margin: 0; width:600px;">
			
				<!-- 아이디/닉네임/이름/비밀번호 입력 및 확인 -->
				 <div class="form-inline">
				    <h3 class="joinTitle">아이디</h3>
				    <input type="text" class="form-control" id="mngId" name="mng_id" 
					    value="${manager.mng_id }" placeholder="${manager.mng_id }" readonly="readonly" 
					    style="width: 100%; margin-right:10px;">
				 </div>
				 
				 <div class="joinInputBox">
					<h3 class="joinTitle">닉네임</h3>
					<input type="text" id="mngNick" name="mng_nick" class="form-control" 
						value="${manager.mng_nick }" placeholder="${manager.mng_nick }" maxlength="20" >
				</div>
  
				<div class="joinInputBox">
					<h3 class="joinTitle">이름</h3>
					<input type="text" id="mngNm" name="mng_nm" class="form-control" 
						value="${manager.mng_nm }" placeholder="${manager.mng_nm }" maxlength="20">
					<div class="checkText"><span id="checkNm"></span></div>
				</div>

				<div class="joinInputBox"> 
					<h3 class="joinTitle">
						<label for="id">전화번호('-' 없이 번호만 입력해주세요.)</label>
					</h3>
					<input type="text" id="mngTel" name="mng_tel" class="form-control" 
						value="${manager.mng_tel }" placeholder="${manager.mng_tel }" maxlength="11"> 
					<div class="checkText"><span id="checkTel"></span></div>
				</div>
				
				<div class="joinInputBox">
					<h3 class="joinTitle">비밀번호</h3>
					<input type="password" id="mngPw" name="mng_pw" class="form-control" maxlength="20" 
						placeholder="Password" required="required">
					<div class="checkText"><span id="checkPw"></span></div>
				</div>

				<div class="joinInputBox">
					<h3 class="joinTitle">비밀번호 확인</h3>
					<input type="password" id="mngPw2" name="mng_pw2" class="form-control" maxlength="20" 
						placeholder="Password" required="required">
					<div class="checkText"><span id="checkPw2"></span></div>
				</div>

				<div>
					<input id="signUpBtn" type="submit" class="btn" value="수정하기">
				</div>
			</div>
			
		</form>
		</div>
	</div>
</body>
</html>