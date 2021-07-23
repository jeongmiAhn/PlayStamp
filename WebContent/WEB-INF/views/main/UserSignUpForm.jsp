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
<title>회원가입</title>

<link href="<%=cp%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/css/usersignup.css" rel="stylesheet">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	var idFlag = false;
	var pwFlag = false;
	var mailFlag = false;
	var nameFlag = false;
	var telFlag = false;
	var checkCode = false;	// 인증번호 담는 변수
	var code = "";			// 이메일 인증코드 확인용

	
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
		
		if(checkCode==false)
		{
			alert("이메일 인증을 해주세요.");
			return false;
		}
		 
		if(!$("#chk").prop("checked"))
		{
			alert("약관 동의 후 가입 가능합니다.");
			return false;
		}
		
		return true;
	}
	
	$(function()
	{	
		//-- 폼 양식 작성 중 유효성 체크
		
		//-- 아이디 확인
		$("#userId").on("input", function()
		{	
			var idRegex = /^[A-Za-z0-9]{4,12}$/;
			var userId = $("#userId").val();
			
			// 입력 값이 변경되면 다시 중복확인 버튼 보이기위해서
			$("#idChkBtn").attr("disabled",false);
			
			// 잘못된 형식일 때
			if(!idRegex.test(userId)){
				 $("#checkId").text("4~20 글자 사이 영문, 숫자만 입력 가능합니다.").css("color", "red");
				 idFlag = false;
			}
			
			// 올바른 형식일 때
			else 
			{
				$("#checkId").text("유효한 아이디 형식입니다. 중복 체크를 해주세요.").css("color", "green");
				
				$("#idChkBtn").click(function() // 올바른 형식일 때 클릭해야 작동
				{
	   				$.ajax({
			   					url: "checkSignup.action"
			   				  , type: "POST"
			   				  , data: {"userId": $('#userId').val()}
			   				  , success : function(data)
			   				    {
			   					  if (data=="YES") // 중복이 아닌 경우 = submit 가능
			   					  {
			   						  $("#idChkBtn").attr("disabled",true);
			   						  $("#userId").css("border-color", "green");
			   						  $("#checkId").text("사용 가능한 아이디입니다.").css("color", "green");
			   						  idFlag = true;
			   					  }
			   					  else if(data=="NO")
			   					  {
			   						  $("#checkId").text("이미 사용중인 아이디입니다.").css("color", "red");
			   						  $("#userId").focus();
			   						  idFlag = false;
			   					  }
			   					},
			   					error : function(request,status,error)
			   					{
			   				        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			   				    }
			   				});//-- ajax 끝(클릭은 안하면 idFlag는 false인 상태)
			
				});//-- 아이디 중복 체크 끝
				
			}//-- else 끝
			
		});
		
		
		//-- 이름 확인
		$("#userNm").on("input", function()
		{
			var nameRegex = /^[가-힣]{2,6}$/;
			if(nameRegex.test($("#userNm").val())){
				$("#checkNm").text("")
				 nameFlag = true;
			}
			else {
				$("#checkNm").text("2~6글자의 한글만 입력 가능합니다.").css("color", "red");
				 nameFlag = false;
			}
		});
		
		
		//-- 전화번호 확인
		$("#userTel").on("input", function()
		{
			var telRegex = /^[0-9]{2,3}[0-9]{3,4}[0-9]{4}/;
			if(telRegex.test($("#userTel").val())){
				$("#checkTel").text("")
				 telFlag = true;
			}
			else {
				$("#checkTel").text("올바른 형식이 아닙니다.").css("color", "red");
				telFlag = false;
			}
		});
		
		
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
					pwFlag = true;
				}
			}
		 });
		

		//-- 이메일 확인
		
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
				url : "mailcheck.action",
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
					checkCode = true;
				} else {
					$("#mailCheckSuccess").hide();
					$("#mailCheckFail").show();
					checkCode = false;
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

	<div class="card">

		<!-- 상단 로고 이미지 -->
		<div class="formContent">
			<img onclick="location.href='home.action'" src="images/logo_typo.svg" style="cursor:pointer;">
		</div>

		
		<!-- 입력 폼 -->
		<form id="form" action="completesignup.action" class="container userSignUpForm" method="post" onsubmit="return checkForm()">
			<div id="content">
			
				<!-- 아이디/닉네임/이름/비밀번호 입력 및 확인 -->
				 <div class="form-inline">
				    <h3 class="joinTitle">아이디</h3>
				    <input type="text" class="form-control" id="userId" name="user_Id" placeholder="아이디를 입력하세요" required="required" 
				    style="width: 77%; margin-right:10px;">
				    <input type="button" class="btn" id="idChkBtn" name="unCheck" style="width: 20%;" value="중복확인">
				    <div class="checkText"><span id="checkId"></span></div>
				 </div>
				 
				 <div class="joinInputBox">
					<h3 class="joinTitle">이름</h3>
					<input type="text" id="userNm" name="user_Nm" class="form-control" maxlength="20" required="required">
					<div class="checkText"><span id="checkNm"></span></div>
				</div>

				<!-- 전화번호 입력 -->
				<div class="joinInputBox">
					<h3 class="joinTitle">
						<label for="id">전화번호('-' 없이 번호만 입력해주세요.)</label>
					</h3>
					<input type="text" id="userTel" name="user_Tel" class="form-control" maxlength="11" required="required"> 
					<div class="checkText"><span id="checkTel"></span></div>
				</div>
  
				<div class="joinInputBox">
					<h3 class="joinTitle">비밀번호</h3>
					<input type="password" id="userPw" name="user_Pw" class="form-control" maxlength="20" required="required">
					<div class="checkText"><span id="checkPw"></span></div>
				</div>

				<div class="joinInputBox">
					<h3 class="joinTitle">비밀번호 확인</h3>
					<input type="password" id="userPw2" name="user_Pw2" class="form-control" maxlength="20" required="required">
					<div class="checkText"><span id="checkPw2"></span></div>
				</div>
				
				<div class="joinInputBox">
					<h3 class="joinTitle">닉네임</h3>
					<input type="text" id="userNick" name="user_Nick" class="form-control" maxlength="20" required="required">
				</div>

				<div class="form-group">
					<h3 class="joinTitle">이메일 인증</h3>
					<input type="text" id="userMail" name="user_Mail" class="form-control" placeholder="Enter email">
					<div class="checkText"><span id="checkMail"></span></div>
				</div>
				<div class="form-inline mb-3">
					<div class="mail_check_input_box" id="mail_check_input_box_false">
						<input type="text" id="mailCheckNum" class="mail_check_input form-control col-8" disabled="disabled" style="width: 47%; margin-right:10px;">
						<input type="button" id="mailCheckBtn" class="btn" value="인증번호 전송" style="width: 50%;">
					</div>
				</div>
				
				<div class="alert alert-success" id="mailCheckSuccess">인증번호가 일치합니다.</div>
				<div class="alert alert-danger" id="mailCheckFail">인증번호가 일치하지 않습니다.</div>
		
				<label for="chk" style="margin: 0 0 16px 0 !important;'">
			    <input type="checkbox" type="checkbox" name="chk" id="chk" value="1" style="height: 16px !important; margin: 18px 0 0 0 !important;'">
			    &nbsp;이용약관, 개인정보 수집 및 이용에 모두 동의합니다. </label>
				<div>
					<input id="signUpBtn" type="submit" class="btn" 
						   style="margin: 20px 0 16px 0;" value="가입하기">
					<input id="cancelBtn" type="button" class="btn" onclick="location.href='home.action'" value="돌아가기">
				</div>
				<br>
				<hr>
				<br>
			</div>
			
		</form>
	
	</div>

</body>
</html>