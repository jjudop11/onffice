<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.uni.spring.meetingroom.model.dto.Meetingroom"%>
<%
//로그인유저 세션에서 받아와서 그 사람 회사번호 뿌리고, 그거 회사번호 텍스트 태그에 반영하기 -> ?

//
ArrayList<Meetingroom> roomList = (ArrayList<Meetingroom>) request.getAttribute("roomList");

int num = 0;

for (int i = 0; i < roomList.size(); i++) {

	num++;
}
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

<!-- datepicker -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"
	integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- fullcalendar -->
<link href='resources/fullcalendar-scheduler/lib/locales/main.css'
	rel='stylesheet' />
<script src='resources/fullcalendar-scheduler/lib/locales/main.js'></script>

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

.card-body-room {
	margin: auto;
}

#roomSetting {
	display: inline;
}

#roomSetting-button {
	float: right;
}

.form-group {
	width: 10%;
}

#form-group-under {
	float: right;
	margin: 0 0 0 56.5%;
}
</style>

<script>
	//프리미엄 체험판 라이센스
	var calendar = new Calendar(calendarEl, {
		schedulerLicenseKey : 'CC-Attribution-NonCommercial-NoDerivatives'
	});

	//풀캘린더 초기화
	
</script>
</head>

<body style="background-color: #F0FFF0">

	<jsp:include page="../common/menubar.jsp" />

	<div id="app">
		<div id="main">

			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading">
				<h2>MeetingRoom Reservation</h2>
				<h5>회의실 예약</h5>
			</div>

			<div class="card">

				<!-- <div class="card-header">
				 </div> -->

				<div id="datepicker-div">
					<input type="date" id="datePicker" class="datepicker-form">
				</div>


				<div class="card-body">
					<!-- 콤보박스 -->
					<div class="row" id="form-group-top">
						<div class="form-group" id="form-group-under">
							<fieldset class="form-group">
								<select class="form-select" id="form" name="foNo">
									<c:forEach items="${ roomList }" var="r">
										<option value="1">${ r.roomName }</option>
									</c:forEach>
								</select>
							</fieldset>
						</div>
					</div>

					<!-- 데이트피커 -->


					<section class="section">
						<div class="row" id="basic-table">
							<div class="col-12 col-md-6">

								<div class="card">
									<div class="card-content">
										<!-- 회의실 예약 -->
										<div class="card-body">
											<h3>풀캘린더 영역</h3>
											<div class="card-body-room">

												<div id='calendar'></div>

												<br> <br>
											</div>

											<!-- 하단 회의실 현황 -->
											<div id="meetingroomList">
												<h3 id="roomSetting">회의실 현황</h3>
												<button class="btn btn-primary" id="roomSetting-button"
													onclick="location.href='reserve-roomSetting.do'">설정</button>
												<br> <br>
												<div class="table-responsive">
													<table class="table table-bordered mb-0"
														id="meetingroomView">
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
													<!-- 페이징 -->
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



	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
