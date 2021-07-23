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
<title>CommentReport.jsp</title>
<!-- 모달 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<style type="text/css">

.container { width: 1000px; margin: auto; }

</style>
</head>
<body>
<div class="modal-header">
 	<h3 class="smaller lighter blue no-margin modal-title">신고 내역 확인</h3>
</div>
<br><br>
<div class="container">
	<div class="modal-body">
		<!-- 신고 처리 테이블 insert를 위해 요청하는 주소 -->
		<form action="checkcommreport.action" method="post">
			<table class="table table-striped table-sm" >
				<tr>
					<th>좌석 리뷰</th>
					<td>${commentReport.rep_contents }</td>
				</tr>
				<tr>
					<th>신고 사유</th>
					<td>${commentReport.rep_y }</td>
				</tr>
				<tr>
					<th>글 작성자</th>
					<td>${commentReport.writer }</td>
				</tr>
				<tr>
					<th>작성 일자</th>
					<td>${commentReport.wr_dt }</td>
				</tr>
			</table><br>        
			<table class="table">
				<tr>
					<th>최종 카테고리</th>
					<th>승인/반려</th>
				</tr>
				<tr>
					<td>
						<!-- 신고 처리 테이블 insert 시 보낼 정보 1. 최종 신고 사유 -->
						<select class="form-control" id="rep_y_cd" name="rep_y_cd">
							<option value="1" ${commentReport.rep_y eq '사기 및 가격 정책 위반' ? "selected=\"selected\"" : "" }>사기 및 가격 정책 위반</option>
							<option value="2" ${commentReport.rep_y eq '욕설, 비방, 차별, 혐오' ? "selected=\"selected\"" : "" }>욕설, 비방, 차별, 혐오</option>
							<option value="3" ${commentReport.rep_y eq '홍보, 영리 목적' ? "selected=\"selected\"" : "" }>홍보, 영리 목적</option>
							<option value="4" ${commentReport.rep_y eq '개인정보 노출, 유포, 거래' ? "selected=\"selected\"" : "" }>개인정보 노출, 유포, 거래</option>
							<option value="5" ${commentReport.rep_y eq '음란, 청소년 유해' ? "selected=\"selected\"" : "" }>음란, 청소년 유해</option>
							<option value="6" ${commentReport.rep_y eq '도배, 스팸' ? "selected=\"selected\"" : "" }>도배, 스팸</option>
						</select>
					</td>
					<td>
						<!-- 신고 처리 테이블 insert 시 보낼 정보 2. 승인/반려 여부 -->
						<select class="form-control" id="rep_st_cd" name="rep_st_cd">
							<option value="1" selected="selected">승인</option>
							<option value="2">반려</option>
						</select>
					</td>
				</tr>
			</table>
			<div class="modal-footer">
			    <button type="submit" class="btn btn-sm btn-success" id="testSave">
			        저장<i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
			    </button>
			    <button type="reset" class="btn btn-sm btn-danger pull-right" data-dismiss="modal" id="btnClose">
			        <i class="ace-icon fa fa-times"></i>취소
			    </button>
			</div>
			<!-- 신고 처리 테이블 insert 시 보낼 정보 3. 신고코드 -->
			<input type="hidden" id="rep_cd" name="rep_cd" value="${commentReport.rep_cd}">
			<!-- 신고 처리 테이블 insert 시 보낼 정보 4. 글 작성자(피신고자) 사용자코드 5. 신고자 사용자 코드 -->
			<input type="hidden" id="writer_cd" name="writer_cd" value="${commentReport.writer_cd}">
			<input type="hidden" id="reporter_cd" name="reporter_cd" value="${commentReport.reporter_cd}">
		</form>
	</div>
</div>

</body>
</html>
