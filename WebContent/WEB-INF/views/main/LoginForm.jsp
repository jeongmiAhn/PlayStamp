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
<title>LoginForm.jsp</title>
<link href="<%=cp %>/css/login.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

	var msg = "${msg}";
	
	$(function ()
	{
		if(msg=="fail")
			$("#loginFail").text("아이디 또는 비밀번호가 잘못됐습니다.").css("color", "red");
		
		if(msg=="nonUser")
			alert("로그인 후 이용 가능한 서비스입니다.");
	});

</script>
</head>
<body>


<div class="card">
    <div class="text-center intro"> 
    	<br><img onclick="location.href='home.action'" src="images/logo_typo.svg" style="cursor:pointer; width:300px;"><br> 
    </div>
    <br>
    <br>
    <form action="login.action" id="loginForm" method="post">
	    <div class="mt-4 text-center">
	        <div class="mt-3 inputbox"> 
	        	<input type="text" class="form-control" name="userId" id="userId" placeholder="아이디" required="required"> <i class="fa fa-user"></i> 
	        </div>
	        <div class="inputbox"> 
	        	<input type="password" class="form-control" name="userPw" id="userPw" placeholder="패스워드" required="required"> <i class="fa fa-lock"></i> 
	        	<span id="loginFail"></span>
	        </div>
	    </div>
	    <div class="d-flex justify-content-between">
	        <div class="form-check"><input type="checkbox" id="admin" name="admin" value="1"><label for="admin"> &nbsp;관리자</label></div>
	    </div>
	    <br>
	    <div class="mt-2"> 
	    	<button type="submit" class="btn btn-primary btn-block" id="login">로그인</button>
	    </div>
	    
	    <!-- 
	    <div class="mt-2"> 
	    	<button class="btn btn-primary btn-block" id="naverLogin">
	    		<img src="images/naverIcon.png" alt="Icon naver" id="naverImg">네이버로 로그인
	    	</button> 
	    </div>
	    -->
	    
	    <!-- 
	    <div class="mt-2"> 
	    	<button class="btn btn-primary btn-block" id="kakaoLogin">
	    		<img src="images/kakaoIcon.png" alt="Icon kakao" id="kakaoImg">카카오로 로그인
	    	</button> 
	    </div>
	    -->
	    <br>
	</form>
	<div class="findInfo">
		<a target="_blank" id="idinquiry" href="findid.action" style="color: black; text-align: center;">아이디 찾기</a> │
		<a target="_blank" id="pwinquiry" href="findpw.action"style="color: black; text-align: center;">비밀번호 찾기</a> │
		<a target="_blank" id="join" href="signupform.action"style="color: black; text-align: center;">회원가입</a>
	</div>
</div>

<div>
	<input type="hidden" id="id_error_msg" name="id_error_msg" value="아이디를 입력해주세요.">
	<input type="hidden" id="pw_error_msg" name="pw_error_msg" value="비밀번호를 입력해주세요.">	
</div>

</body>
</html>