<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String num = "1-"; %>
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
	.btn btn-primary{
		width: 70px;
		height: 30px;
	}
	.card-body {
		width: 140%;
		align: center;
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
				<h2>MeetingRoom Setting</h2>
				<h5>회의실 관리</h5>
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
													<div class="card-body">

														<!-- Table with outer spacing -->
														<div class="table-responsive">
															<table class="table table-lg" id="meetingRoom">
																<thead>
																	<tr>
																		<th>No</th>
																		<th>MettingRoom</th>
																		<th>Capacity</th>
																		<th>Note</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<td class="text-bold-500">1-01</td>
																		<td>Test1</td>
																		<td class="text-bold-500">20</td>
																		<td>테스트용</td>
																	</tr>
																	<tr>
																		<td class="text-bold-500">1-02</td>
																		<td>Test2</td>
																		<td class="text-bold-500">15</td>
																		<td>테스트회의실</td>
																	</tr>
																	
																</tbody>
															</table>
														</div>

														<div class="buttons">
															<a href="#" class="btn btn-primary">저장</a> <a href="#"
																class="btn btn-light">취소</a>
															<!-- <a href="#"	class="btn btn-light" onclick="add()">추가</a> -->
															<button type="button" class="btn btn-primary"
																data-toggle="modal" data-target="#myModal">
																모달테스트</button>

															<div class="modal" id="myModal">
																<div class="modal-dialog">
																	<div class="modal-content">

																		<div class="modal-header">
																			<h4 class="modal-title">회의실 추가</h4>
																			<button type="button" class="close"
																				data-dismiss="modal"></button>
																		</div>

																		<div class="modal-body">
																			<form name="insertRoom" method="post" action="#">

																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">회의실 번호</label>
																					<input type="text" class="form-control" id="room_no" name="room_no" value=<%= num %>>
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">회의실명</label>
																					<input type="text" class="form-control" id="room_name" name="room_name">
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">수용인원</label>
																					<input type="text" class="form-control" id="room_capa" name="room_capa">
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">비고</label>
																					<input type="text" class="form-control" id="room_note" name="room_note">
																				</div>
 
																			</form>													
																		</div>

																		<div class="modal-footer">
																			<button type="button" class="btn btn-danger"
																				data-dismiss="modal">추가</button>
																		</div>
																	</div>
																</div>
															</div>


														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</section>

							</div>
						</div>
						<!-- <div class="card"> -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		function add() { //
			const table = document.getElementById("meetingRoom");

			const newRow = table.insertRow();
			const newCell_1 = newRow.insertCell(0);
			const newCell_2 = newRow.insertCell(1);
			const newCell_3 = newRow.insertCell(2);
			const newCell_4 = newRow.insertCell(3);

		}
	</script>

	<script
		src="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="resources/assets/js/bootstrap.bundle.min.js"></script>
	<script src="resources/assets/vendors/apexcharts/apexcharts.js"></script>
	<script src="resources/assets/js/pages/dashboard.js"></script>
	<script src="resources/assets/js/main.js"></script>

</body>

</html>
							