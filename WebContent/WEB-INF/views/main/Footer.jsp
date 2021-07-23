 <%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
		Object user = session.getAttribute("id");
		String userId = (String)user;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="bootstrap/assets/favicon.ico" />

<!-- <link rel="stylesheet" href="css/bootstrap.min.css">-->
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">

<style type="text/css">

	#footer {
		margin: 80px 0 40px 0;
		width:100%;
		bottom:0;
	}
	
	.footerText {
		font-size: 14px;
		text-align: right;
		padding: 0 20px 0 0;
		color: #a8afb5;
	}
	ul {
        list-style: none;
	    margin-bottom: 0px;
	    margin-top: 15px !important;
	    color: #777 !important;
	}

#footer .list_corp .corp_item {
    float: left;
    color: #777 !important;
    margin-right: 8px;
}

#footer .list_corp .corp_item+.corp_item:before {
    content: "";
    display: inline-block;
    width: 1px;
    height: 11px;
    margin: 0 8px;
    background-color: #e4e8eb;
    vertical-align: -1px;
}

a {color: #a8afb5; font-size: 14px;}
</style>
</head>
<body>

<!-- header -->
<header class="header">
		<div id="footer">
			<div class="container footerText">
					<hr>
					<ul class="list_corp"> 
						<li class="corp_item"><a href="" >회사소개</a></li> 
						<li class="corp_item"><a href="" >이용약관</a></li> 
						<li class="corp_item"><a href="" ><strong>개인정보처리방침</strong></a></li> 
						<li class="corp_item"><a href="">고객센터</a></li> 
					</ul>
					<div class="footerText">copyrightⓒ 2021 All rights reserved by PlayStamp</div>
			</div>
		</div>
</header>

</body>
</html>

