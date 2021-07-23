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
<title>탈퇴 안내</title>
<link href="<%=cp%>/css/myspace.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript">

	function checkDrop()
	{
		if(!$("#chk").prop("checked"))
		{
			alert("약관 동의 후 가입 가능합니다.");
			return false;
		}
		
		if($("#backup_y").val()=="")
		{
			alert("탈퇴 사유를 선택해주세요.");
			return false;
		}
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
			<div id="pageTitle" class="container">탈퇴 안내</div>
			
			<form action="userdrop.action" method="post" onsubmit="return checkDrop()">
				<div class="dropText">
					<h4>
						<mark><b>탈퇴 후에도 리뷰, 양도 게시판, 문의글 및 댓글은 자동 삭제되지 않고 그대로 남아 있습니다.</b></mark><br><br>
						삭제를 원하는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다.<br>
						탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 
						<mark>게시글을 임의로 삭제해드릴 수 없습니다. </mark>
						
						<mark>탈퇴 후에는 ${sessionScope.id } 아이디로 재가입이 불가능하며 아이디와 데이터는 복구할 수 없습니다.</mark><br>
						게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.
					</h4>
				</div>
				<br>
				
				<div class="checkbox">
				  <label>
				    <input type="checkbox" id="chk">
				    안내 사항을 모두 확인하였으며, 이에 동의합니다.
				  </label>
				</div>
				
				<br>
				<br>
				<br>
				<!-- Single button -->
					<label for="backup_y">탈퇴 사유</label>
					<select id="backup_y" name="backup_y" class="form-control">
						<option value="">탈퇴사유를 선택해주세요.</option>
						<option value="1">고객서비스 불만</option>
						<option value="2">방문빈도 낮음</option>
						<option value="3">개인정보 유출 우려</option>
						<option value="4">콘텐츠 부족</option>
						<option value="5">서비스 이용 불편</option>
						<option value="6">기타</option>
					</select>
				<div class="form-group">
				
				<br>
					<label for="user_Pw">비밀번호 확인</label>
					
					<input type="password" id="userPw" name="user_Pw" class="form-control" placeholder="비밀 번호를 입력하세요" required="required">
				</div>	
				<br>
				<input type="submit" class="btn btn-primary btn-lg btn-block" style="width: 50%; margin: 0 auto; " value="탈퇴하기">
			
			</form>
		</div>
	
	</div>
	
	
	
	
	
	
</body>
</html>