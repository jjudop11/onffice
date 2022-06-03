<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div id="app">
		<div id="main">
			<div class="content">

				<div class="innerOuter">
					<h2>공지사항</h2>
					<br>
					<table id="contentArea" align="center" class="table">
						<tr>
							<td colspan="3">${ n.no_Title }</td>
						</tr>
						<tr>
							<td>작성자 ${ n.no_WirterName } (${ n.no_Date })</td>
						</tr>
						<!--  <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:if test="${ !empty b.originName }">
                        	<a href="${ pageContext.servletContext.contextPath }/resources/upload_files/${b.changeName}" download="${ b.originName }">${ b.originName }</a>
                        </c:if>
                        <c:if test="${ empty b.originName }">
                        	첨부파일이 없습니다.
                        </c:if>
                    </td>
                </tr>-->
						<tr>
							<td colspan="4"><p style="height: 150px">${ n.no_Content }</p></td>
						</tr>
					</table>
					<c:if test="${ sessionScope.loginUser.MNo eq n.no_Write }">
						<div align="center">
							<button class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</button>
							<button class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</button>
						</div>

						<form id="postForm" action="" method="post">
							<input type="hidden" name="No_Num" value="${ n.no_Num }">
							<!-- <input type="hidden" name="fileName" value="${ b.changeName }">  -->
						</form>
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
					</c:if>
				</div>
			</div>
		</div>
	</div>

</body>
</html>