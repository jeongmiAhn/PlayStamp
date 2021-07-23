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
<title>ReportAlert.jsp</title>

<script type="text/javascript">
		var message = "${msg}";
		var url = "${url}";

		if (message!=null)
		{
			alert(message);
			document.location.href = url;
		}
</script>
</head>
<body>

</body>
</html>