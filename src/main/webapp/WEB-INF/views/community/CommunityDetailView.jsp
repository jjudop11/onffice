<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<style>
#contentArea {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 10px 20px -10px DarkSeaGreen; 
}
td {
	padding: 15px 30px !important;
}

.comment_box {
	padding: 10px 0 !important;
	margin:auto;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div id="app">
		<div id="main">
			<div class="content">
				<div class="innerOuter" style="padding:0% 10%;">
					<h2>커뮤니티</h2>
					<br>
					<table id="contentArea" align="center" class="table">
						<tr>
							<td style="font-size: x-large; font-weight: bold; width: 75%;">${ c.comTitle }</td>
							<td>
								<c:if test="${ sessionScope.loginUser.MNo eq c.comWrite }">
								<div align="center">
									<button class="btn" onclick="postFormSubmit(1);">수정</button> |
									<button class="btn" onclick="postFormSubmit(2);">삭제</button>
								</div>
		
								<form id="postForm" action="" method="post">
									<input type="hidden" name="ComNum" value="${ c.comNum }">
								</form>
								<script>
									function postFormSubmit(num) {
										var postForm = $("#postForm");
		
										if (num == 1) {
											postForm.attr("action",
													"updateFormCommu.do");
										} else {
											postForm.attr("action", "deleteCommu.do");
										}
										postForm.submit();
									}
								</script>
								</c:if>
							</td>
						</tr>
						<tr>
							<td>익명 <a style="font-size: small;">(${ c.comDate })</a></td>
						</tr>
						<tr>
							<td><p style="height: 150px">${ c.comContent }</p></td>
						</tr>
					</table>
					<br>
				<table id="replyArea" class="table" align="center">
					<thead>
						<tr>
							<th colspan="3" width="100%">
							<textarea
									class="form-control" id="ComReContent" rows="2"
									style="resize: none; width: 100%" placeholder="댓글을 입력하는 공간입니다."></textarea>
							<button class="btn btn-secondary" id="addReply" style="float: right; margin: 10px;">댓글 등록</button></th>
						</tr>
					</thead>
					<tbody>
						<script>
						$(function() {
							$("#deleteReply").click(function(){
								var cn = ${obj.ComReNum};		
								
								$.ajax({			
									url: "deleteReply.do", 
									type : "post", 
									data : {cn : cn}, 
									success: function(result){				
										selectReplyList();		
										}			
									, error: function(error){				
										console.log("에러 : " + error);			
										}		
									});	
								location.reload();
								});
						});
						</script>
					</tbody>
				</table>
				</div>

			</div>
		</div>
	</div>
	<script>
		function selectReplyList() {
			var cn = ${c.comNum};
			$.ajax({
				url : "rListCommunity.do",
				data : {cn : cn},
				type : "get",
				success : function(list) {
					$("#rcount").text(list.length);

					var value = "";
					$.each(list, function(i, obj) {

						if ("${loginUser.MNo}" == obj.ComReWriter) {
							value += "<div class='comment_box'><tr style='background:#EAFAF1'>";
						} else {
							value += "<div class='comment_box'><tr>";
						}

						value += "<td style='display: none;'>" + obj.ComReNum + "</td>"
						+ "<td style='width: 75%;'>" + obj.ComReWriterName + "<a style='font-size: small;'> ( "
								+  obj.ComReDate + " )</a>" + "</td>" 
						
						if ("${loginUser.MNo}" == obj.ComReWriter) {
							value += "<td><div align='center'>" +
							"<button class='btn' onclick='postFormSubmit(1);'>수정</button>" + "|" +
							"<button class='btn' id='deleteReply'>삭제</button>" +
							"</div></td>";
						} else {		
							value += "</tr>";
						}
								
						if ("${loginUser.MNo}" == obj.ComReWriter) {
							value += "<tr style='background:#EAFAF1; border:hidden;'>";
						} else {
							value += "<tr style='border:hidden;'>";
						}
						
						value += "<td colspan='2'>"
								+ obj.ComReContent + "</td>"
								"</tr></div>";
					});
					$("#replyArea tbody").html(value);
				},
				error : function() {
					console.log("댓글 조회 실패");
				}
			});
		}
		
		$(function() {
			selectReplyList();

			$("#addReply").click(function() {
				var cn = ${c.comNum};

				if ($("#ComReContent").val().trim().length != 0) {

					$.ajax({
						url : "rinsertCommunity.do",
						type : "post",
						data : {
							ComReContent : $("#ComReContent").val(),
							ComPreNum : cn,
							ComReWriter : "${loginUser.MNo}"
						},
						success : function(result) {
							if (result > 0) {
								$("#ComReContent").val("");
								selectReplyList();

							} else {
								alert("댓글 등록 실패");
							}
						},
						error : function() {
							console.log("댓글 작성 실패");
						}
					});

				}

			});
		});
		

	</script>
</body>
</html>