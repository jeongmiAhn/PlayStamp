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
<title>나의 프로필</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function ()
	{
		$("#userUpImg").on("change", handleImgFileSelect);
		
		
		//-- 비밀번호 일치 확인
		$("#userPw2").blur(function()
		{
			
			if($('#userPw').val() != $('#userPw2').val())
			{
				$("#checkPw").text("비밀번호가 일치하지 않습니다.").css("color", "red");
			    
				$('#userPw2').val('');
				$('#userPw2').css("border-color", "red");
				
				pwFlag = false;
			}
			else if($('#userPw').val() == $('#userPw2').val())
			{
				$("#checkPw").text("비밀번호가 일치합니다.").css("color", "green");
				$('#userPw2').css("border-color", "green");
				pwFlag = true;
			}
			
		 }); //-- 비밀번호 체크 끝

	});
	
	
	//-- 첨부 이미지 미리보기에 반영되기 전 확장자 체크
	function handleImgFileSelect(e) 
	{
	    var files = e.target.files;
	    var filesArr = Array.prototype.slice.call(files);

	    filesArr.forEach(function(f) {
	        if(!f.type.match("image.*")) {
	            alert("이미지 파일만 첨부해주세요.");
	            return;
	        }

	        sel_file = f;
	        var reader = new FileReader();
	        reader.onload = function(e) {
	            $("#imgWrap").attr("src", e.target.result);
	        }
	        reader.readAsDataURL(f);
	    });
	}
	
</script>
</head>
<body>
<!-- 메뉴 영역 -->
	<div>
		<c:import url="/WEB-INF/views/main/header.jsp"></c:import>
	</div>
	
	<div id="wrapper">
		
		<div class="container">
		
			 <div id="pageTitle" class="container">나의 프로필</div>
			
			<div id="pForm" >
			
				<!-- left -->
				<div id="profileImg profileImg-b" >
					
					<!-- 프로필사진 -->
					<form action="UserImgUpload" method="post" enctype="multipart/form-data">
						<div class="profileImg" id="userImg">
		                    <img id="imgWrap" onerror="this.src='<%=cp%>/images/default_profile.png'" 
							src="<%=cp%>/profile/${userInfo.user_Img }">
						</div>
					
						<div style="margin-bottom: 20px;">
							<input type="file" name="userImg" id="userUpImg" style="width:50%; float:left; margin-right: 20px;">
							<input class="btn btn-primary" type="submit" value="변경하기" style="width:50%;">
						</div>
						
						<input type="hidden" name="userId" value="${sessionScope.id }">
					</form>
					
					<div class="userInfo">${sessionScope.grade }</div>
					<div class="userInfo sTitle">현재 포인트</div>
					<div class="userInfo aTitle">${userPoint } p</div> 
					
				</div>
					
					
				<!-- right -->
				<div id="profileInput">
				
					<form class="form-horizontal"  action="update.action" method="post">
						  <div class="form-group">
						    <label for="userNick" class="col-sm-4 control-label">닉네임</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userNick" name="user_Nick" placeholder="${userInfo.user_Nick }" value="${userInfo.user_Nick }">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="userId" class="col-sm-4 control-label">아이디</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userId" name="user_Id" placeholder="${userInfo.user_Id }" value="${userInfo.user_Id }" readonly="readonly">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="userNm" class="col-sm-4 control-label">이름</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userNm" name="user_Nm" placeholder="${userInfo.user_Nm }" value="${userInfo.user_Nm }"readonly="readonly">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="userMail" class="col-sm-4 control-label">이메일</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userMail" name="user_Mail" placeholder="${userInfo.user_Mail }"  value="${userInfo.user_Mail }" readonly="readonly">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="userTel" class="col-sm-4 control-label">전화번호</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userTel" name="user_Tel" placeholder="${userInfo.user_Tel }" value="${userInfo.user_Tel }">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="userPw" class="col-sm-4 control-label">비밀번호</label>
						    <div class="col-sm-10">
						      <input type="password" class="form-control" id="userPw" name="user_Pw" placeholder="Password" required="required">
						    </div>
						    <div class="form-group">
							    <label for="userPw2" class="col-sm-4 control-label">비밀번호 확인</label>
							    <div class="col-sm-10">
							      <input type="password" class="form-control" id="userPw2" placeholder="Password" required="required">
							      <span id="checkPw"></span>
							    </div>
						  	</div>
						  </div>
						  
						  
						  <div class="form-group">
						    <div class="col-sm-offset-2 col-sm-10">
						      <input type="submit" id="updateBtn" class="btn btn-primary btn-lg btn-block" value="정보 수정하기"
							style="margin-top: 50px;">
						    </div>
						  </div>
						</form>
				
				</div>
				
			</div>
			<hr>
				<a href="dropform.action">탈퇴하기</a>
		</div>
	</div>
	
</body>
</html>