<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//로그인유저 세션에서 받아와서 그 사람 회사번호 뿌리고, 그거 회사번호 텍스트 태그에 반영하기
%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="resources/assets/css/bootstrap.css">

<link rel="stylesheet" href="resources/assets/vendors/iconly/bold.css">

<link rel="stylesheet"
	href="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="resources/assets/css/app.css">
<link rel="shortcut icon" href="resources/assets/images/favicon.svg"
	type="image/x-icon">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
tr, th {
	text-align: center;
}

.btn btn-primary {
	width: 70px;
	height: 30px;
}

.card-body {
	width: 140%;
	align: center;
}

.card-header {
	width: 150px;
	height: 50px;
	margin: 0 0 0 90%;
}

.buttons {
	width: 150px;
	margin: auto;
}
</style>
</head>

<body style="background-color: #F0FFF0">

	<jsp:include page="../common/menubar.jsp" />

	<div id="app">

		<div id="main">
			<!-- 화면작아졌을때 메뉴바 토글버튼 -->
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading">
				<h2>MeetingRoom Reservation</h2>
				<h5>회의실 예약</h5>
			</div>
			<div class="page-content">

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header"></div>

							<div class="card-body">
								<section class="section">
									<div class="row" id="basic-table">
										<div class="col-12 col-md-6">
											<div class="card">
												<div class="card-content">
													<!-- 회의실 예약 -->
													<div class="card-body"></div>
														<h1>회의실 예약 표 영역</h1>
													<div class="card-body">
														
														<!-- 3행 46열 -->
														<div class="table-responsive">
															<table class="table table-bordered mb-0" id="meetingroom">
																<thead id="meetingroomRow">
																</thead>
																<!-- tr, th -->
																<tbody>
																	<% for(int i = 1; i < 24; i++){ %>
                                                      				<th colspan="2"></th>
                                                     				 <%} %>
																	
																	<c:forEach items="${ roomList }" var="r">
																		<tr>
																			<th>${ r.roomName }</th>
																			
																			<% for(int i = 1; i < 47; i++){ %>
																			<th><th>
																			<% } %>
																			
																		</tr>						
																	</c:forEach>
																</tbody>
																<tfoot>
																</tfoot>
															</table>
														
														<br><br>
														
														<!-- Table with outer spacing -->
														<h5>회의실 현황</h5>
														<br>
														<div class="table-responsive">
															<table class="table table-bordered mb-0" id="meetingroomView">
																<thead id="meetingroomView-head">
																	<tr>
																		<th>No</th>
																		<th>MettingRoom</th>
																		<th>Capacity</th>
																		<th>Note</th>
																	</tr>
																</thead>
																<tbody>
																	<!-- 로그인한 회원이 소속된 회사의 회의실 리스트 뿌리기 -->
																	<c:forEach items="${ roomList }" var="r">
																		<tr>
																			<th>${ r.roomNo }</th>
																			<th>${ r.roomName }</th>
																			<th>${ r.roomCapa }</th>
																			<th>${ r.roomNote }</th>
																		</tr>
																	</c:forEach>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</section>

							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		function addRow() {
			$("tbody")
					.append(
							"<tr>"
									+ "<th><input type='checkbox' id='checkbox' class='form-check-input'></th>"
									+ "<th><input type='text' class='addRoom' id='addRoomNo'></th>"
									+ "<th><input type='text' class='addRoom' id='addRoomName'></th>"
									+ "<th><input type='text' class='addRoom' id='addRoomCapa'></th>"
									+ "<th><input type='text' class='addRoom' id='addRoomNote'></th>"
									+ "</tr>")
		} //아이디.val() 가져와서 ajax로 넘기기

		function deleteRow() {
			//이건 제목행까지 삭제됨
			//$("input[type=checkbox]:checked").parent().parent().remove();

		}

		function saveRoom() {
			console.log("되고있냐?")
		}

		$(function() {
			$("#saveRoom").click(function() {
				let addRoomNo = $("#addRoomNo").val();
				let addRoomName = $("#addRoomName").val();
				let addRoomCapa = $("#addRoomCapa").val();
				let addRoomNote = $("#addRoomNote").val();

				/* let roomObject = {
					addRoomNo: addRoomNo,
					addRoomName: addRoomName,
					addRoomCapa: addRoomCapa,
					addRoomNote: addRoomNote
				}*/

				$.ajax({
					url : "saveRoom.do",
					data : {
						addRoomNo : addRoomNo,
						addRoomName : addRoomName,
						addRoomCapa : addRoomCapa,
						addRoomNote : addRoomNote
					},
					type : "post",
					success : function(success) {
						console.log("데이터 전달 성공" + success)
					},
					error : function(error) {
						console.log("ajax 통신 실패")
					}
				})
			})
		})
	</script>

	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
