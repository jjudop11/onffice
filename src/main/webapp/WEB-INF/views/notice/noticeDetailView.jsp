<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>

#contentArea {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 10px 20px -10px DarkSeaGreen; 
}
td {
	padding: 15px 30px !important;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div id="app">
		<div id="main">
			<div class="content">
				<div class="innerOuter" style="padding:0% 10%;">
					<h2>공지사항</h2>
					<br>
					<table id="contentArea" align="center" class="table">
						<tr>
							<td style="font-size: x-large; font-weight: bold; width: 75%;">${ n.no_Title }</td>
							<td>
							<c:if test="${ sessionScope.loginUser.MNo eq n.no_Write }">
								<div align="center">
									<button class="btn" onclick="postFormSubmit(1);">수정</button> |
									<button class="btn" onclick="postFormSubmit(2);">삭제</button>
								</div>
		
								<form id="postForm" action="" method="post">
									<input type="hidden" name="No_Num" value="${ n.no_Num }">
								</form>
							</c:if>
							</td>
						</tr>
						<tr>
							<td><a style="font-size: small;">작성자</a> ${ n.no_WriteName } <a style="font-size: small;">(${ n.no_Date })</a></td>
						</tr>
						<tr>
							<td><p style="height: 150px">${ n.no_Content }</p></td>
						</tr>
					</table>
					<br>
						<script>
							function postFormSubmit(num) {
								var postForm = $("#postForm");

								if (num == 1) {
									postForm.attr("action",
											"updateFormNotice.do");
								} else {
									postForm.attr("action", "deleteNotice.do");
								}
								postForm.submit();
							}
						</script>
				</div>
			</div>
		</div>
	</div>

</body>
</html>