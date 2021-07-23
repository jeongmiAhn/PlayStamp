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
<title>운영진 관리</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	function checkForm()
	{
		// 체크박스가 선택된 게 없다면
		if(!$("input[name='checkManager']").is(":checked"))
		{
			alert("삭제할 운영진을 선택해주세요.");
			return false;
		}
		// 체크박스가 선택됐다면
		else
		{
			if(confirm("정말 삭제하시겠어요?"))
			{
				return true;
			}
			else
			{
				return false;
			}
			/*var checkArr = [];
			
			// each() == 배열 관리 메소드
			$("input[name='checkManager']:checked").each(function(i) {
			    checkArr.push($(i).val());
			});
			
			$.ajax({
			    url: 'mangerdelete.action'
			    , type: 'post'
			    , dataType: 'text'
			    , data: { deleteArr: checkArr }
				, success : function()
				   {
						alert("성공");
				   }
			});*/
		}
	}
	
</script>
<style type="text/css">

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
	
	table {text-align: center; margin-top: 20px;}
	tr, th, td {line-height: 48px;}
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
				<div id="pageTitle">운영진 관리</div>
			</div>
			
			<form action="managerdelete.action" method="post" onsubmit="return checkForm()">
			
				<div style="float: left; width:60%; margin: 35px 0 5px 0;">운영진 정보 수정은 클릭 후 상세정보 페이지에서 진행해주세요.</div>
				<div class="btn-group btn-group-lg" style="float: right; margin: 12px 0 20px 0;">
					<button type="button" class="btn btn-default btn-lg" onclick="location.href='managerinsertform.action'">운영진 등록하기</button>
					<button type="submit" id="deleteBtn" class="btn btn-default">운영진 삭제</button>
				</div>
				<table id="cashTable" class="table table-hover" style="font-size: 16px;">
				<tr class="text-center">
					<th class="text-center">&emsp;</th>
					<th class="text-center">번호</th>
					<th class="text-center">닉네임/아이디</th>
					<th class="text-center">운영진 이름</th>
					<th class="text-center">핸드폰 번호</th>
				</tr>
				<c:forEach var="manager" items="${managerList}">
					<tr>
						<td><input type="checkbox" name="checkManager" class="checkManager" value="${manager.mng_id }"></td>
						<td>${manager.rownum }</td>
						<td><a href="managerupdateform.action?mng_id=${manager.mng_id }">${manager.mng_nick }(${manager.mng_id })</a></td>
						<td>${manager.mng_nm }</td>
						<td>${manager.mng_tel }</td>
					</tr>
				</c:forEach>
				</table>
				
			</form>
			
			
		</div>
	</div>
	
</body>
</html>