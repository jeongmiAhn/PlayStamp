<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String user_id = request.getParameter("user_id");
	String user_point = request.getParameter("point");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ModifyPointPopup.jsp</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<style>

.underline
{
    border-style:none;
    border-bottom:solid 1px #cacaca;
    border-collapse:collapse;
}

.underline:focus {outline:none;}

#user_id, #user_id:focus
{  
	border-style:none; 
	font-size: 15px;
	width: 100px;
	outline: none;
}

* { text-align: center; }

</style>
<script type="text/javascript">

	$(function()
	{
		$("#submitBtn").click(function()
		{	
			if( $("#point").val()=="" || isNaN($("#point").val())==true )
			{
				$("#err").html("포인트를 입력해주세요.");
				$("#err").css("display", "inline");
				return;		
			}
			
			$("#submitBtn").submit();
			
			$(location).attr("href", "modifypoint.action?user_id=" + "<%=user_id%>" + "&point=" +$(".underline").val());
		});
		
	});
	
</script>
</head>
<body>

<div>
	<h4><input type="text" name="user_id" id="user_id" value="<%=user_id %>" readonly="readonly">님의 포인트 변경</h4><hr><br>
	<input type="text" class="underline" name="point" id="point" required="required" placeholder="<%=user_point%>">&ensp;점<br><br>
	<button type="button" id="submitBtn">변경</button>
	<button type="reset" id="resetBtn">취소</button><br>
	<span id="err" style="color: red; font-size: 8pt; margin-top: 10px; font-weight: bold; display: none;"></span>
</div>

</body>
</html>