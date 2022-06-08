<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- <link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/assets/css/bootstrap.css">
<link rel="stylesheet" href="resources/assets/vendors/iconly/bold.css">
<link rel="stylesheet" href="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="resources/assets/css/app.css">
<link rel="shortcut icon" href="resources/assets/images/favicon.svg" type="image/x-icon">  -->

<!-- timepicker -->

<!-- fullcalendar -->

<!-- jQuery library -->

<!-- Popper JS -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->

<!-- Latest compiled JavaScript -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

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

#form-group-under {
	width: 100%;
	align: center;
}

#datePicker-div {
	width: 141px;
	float: left;
}

#datePicker {
	height: 38px;
}

#modal-datePicker {
	height: 38px;
}

#searchDateBtn {
	float: left;
	margin-left: 10px;
}

#reserve-btn-div {
	float: right;
	width: 58px;
}

#reserveRoomBtn {
	width: 58px;
}

.time {
	height: 38px;
}
</style>

</head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
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

				<div class="card-body">
					<!-- 콤보박스 -->

					<section class="section">
						<div class="row" id="basic-table">
							<div class="col-12 col-md-6">

								<div class="card">
									<div class="card-content">
										<!-- 회의실 예약 -->
										<div class="card-body">
											<div class="card-body-room">

												<!-- 데이트피커 -->
												<div id="datePicker-div">
													<input type="date" id="datePicker" class="datepicker-form">
												</div>

												<div>
													<button type="button" class="btn btn-primary"
														id="searchDateBtn">조회</button>
												</div>

												<div class="buttons" id="reserve-btn-div">
													<button type="button" class="btn btn-primary"
														id="reserveRoomBtn" data-toggle="modal"
														data-target="#myModal">예약</button>

													<div class="modal" id="myModal">
														<div class="modal-dialog">
															<div class="modal-content">

																<div class="modal-header">
																	<h4 class="modal-title">회의실 예약</h4>
																	<button type="button" class="close"
																		data-dismiss="modal"></button>
																</div>

																<div class="modal-body" id="modal-body">
																	<form name="insertRoom" method="post" action="#">

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">예약일</label><br>
																			<input type="date" id="modal-datePicker"
																				class="datepicker-form">
																		</div>
																		<br>

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">예약시간</label>
																			<br> <input type="time" class="timepicker" id="startTime">
																			~ <input type="time" class="timepicker" id="endTime">
																		</div>

																		<div>
																			<a id="timeCheck"></a>
																		</div>
																		<br>

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">회의실명</label>

																			<select class="form-select" id="selectRoom"
																				name="selectRoom">
																				<c:forEach items="${ roomList }" var="r">
																					<option value="${ r.roomName }">${ r.roomName }</option>
																				</c:forEach>
																			</select>
																		</div>
																		<br>

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">예약자</label>
																			<br> <input type="text" id="reserveUser"
																				value="${ userName } ${ userJob }" readonly>
																		</div>
																	</form>
																</div>

																<div class="modal-footer">
																	<button type="button" class="btn btn-primary"
																		id="reserveRoom" data-dismiss="modal"
																		onclick="reserveRoom()" disabled>확인</button>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!-- 예약 테이블 -->
												<div id="div-table">
													<table class="table table-bordered mb-0"
														id="roomReserveTable">
														<thead>
															<tr>
																<th colspan="2"></th>
																<th colspan="2">07</th>
																<th colspan="2">08</th>
																<th colspan="2">09</th>
																<th colspan="2">10</th>
																<th colspan="2">11</th>
																<th colspan="2">12</th>
																<th colspan="2">13</th>
																<th colspan="2">14</th>
																<th colspan="2">15</th>
																<th colspan="2">16</th>
																<th colspan="2">17</th>
																<th colspan="2">18</th>
																<th colspan="2">19</th>
																<th colspan="2">20</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${ roomList }" var="r">
																<tr>
																	<th colspan="2">${ r.roomName }</th>
																	<th id="07:00"></th>
																	<th id="07:30"></th>
																	<th id="08:00"></th>
																	<th id="08:30"></th>
																	<th id="09:00"></th>
																	<th id="09:30"></th>
																	<th id="10:00"></th>
																	<th id="10:30"></th>
																	<th id="11:00"></th>
																	<th id="11:30"></th>
																	<th id="12:00"></th>
																	<th id="12:30"></th>
																	<th id="13:00"></th>
																	<th id="13:30"></th>
																	<th id="14:00"></th>
																	<th id="14:30"></th>
																	<th id="15:00"></th>
																	<th id="15:30"></th>
																	<th id="16:00"></th>
																	<th id="16:30"></th>
																	<th id="17:00"></th>
																	<th id="17:30"></th>
																	<th id="18:00"></th>
																	<th id="18:30"></th>
																	<th id="19:00"></th>
																	<th id="19:30"></th>
																	<th id="20:00"></th>
																	<th id="20:30"></th>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>

											<div class="buttons" id="reserve-btn-div">
												<button type="button" class="btn btn-primary"
													id="reserveRoomBtn" data-toggle="modal"
													data-target="#myModal">예약확인</button>
												<div class="modal" id="myModal_reserveDetail">
													<div class="modal-dialog">
														<div class="modal-content">

															<div class="modal-header">
																<h4 class="modal-title">예약 상세</h4>
																<button type="button" class="close" data-dismiss="modal"></button>
															</div>

															<div class="modal-body" id="modal-body">
																<form name="insertRoom" method="post" action="#">

																	<div class="form-reserveRoom">
																		<label for="label-reserveRoom" class="control-label">예약일</label><br>
																		<input type="date" id="modal-datePicker"
																			class="datepicker-form">
																	</div>
																	<br>

																	<div class="form-reserveRoom">
																		<label for="label-reserveRoom" class="control-label">예약시간(내가
																			예약한 시간 띄우기)</label> <br> <input type="time" min="07:00"
																			max="21:00" step="1800" class="time" id="startTime"
																			required> ~ <input type="time" min="07:00"
																			max="21:00" step="1800" class="time" id="endTime">
																	</div>

																	<div>
																		<a id="timeCheck"></a>
																	</div>
																	<br>

																	<div class="form-reserveRoom">
																		<label for="label-reserveRoom" class="control-label">회의실명</label>
																		<input type="text" value="내가 예약한 회의실 띄우기">
																	</div>
																	<br>

																	<div class="form-reserveRoom">
																		<label for="label-reserveRoom" class="control-label">예약자</label>
																		<br> <input type="text" id="reserveUser"
																			value="${ userName } ${ userJob }" readonly>
																	</div>
																</form>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-primary"
																	id="reserveRoom" data-dismiss="modal"
																	onclick="reserveRoom()" disabled>확인</button>
															</div>
														</div>
													</div>
												</div>
											</div>

											<button id="trBtn">tr 확인용</button>
											<br>
											<br>

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
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		$(function(){
			$("#trBtn").click(function(){
				
				let th = $("#07:00").parent();
				let tr = th.children().eq(0);
				console.log(tr)
			})
		})
	
		//데이트피커
		$(function() {
			$("#testBtn").click(function() {
				let datepicker = $("#datePicker");

				console.log(datepicker.val(), typeof (datepicker.val()));
			})
		})

		//타임피커
		
		
		//회의실 예약 관련
		/* let time_0700 = $("tbody th").eq(1);
		let time_0730 = $("tbody th").eq(2);
		let time_0800 = $("tbody th").eq(3);
		let time_0830 = $("tbody th").eq(4);
		let time_0900 = $("tbody th").eq(5);
		let time_0930 = $("tbody th").eq(6);
		let time_1000 = $("tbody th").eq(7);
		let time_1030 = $("tbody th").eq(8);
		let time_1100 = $("tbody th").eq(9);
		let time_1130 = $("tbody th").eq(10);
		let time_1200 = $("tbody th").eq(11);
		let time_1230 = $("tbody th").eq(12);
		let time_1300 = $("tbody th").eq(13);
		let time_1330 = $("tbody th").eq(14);
		let time_1400 = $("tbody th").eq(15);
		let time_1430 = $("tbody th").eq(16);
		let time_1500 = $("tbody th").eq(17);
		let time_1530 = $("tbody th").eq(18);
		let time_1600 = $("tbody th").eq(19);
		let time_1630 = $("tbody th").eq(20);
		let time_1700 = $("tbody th").eq(21);
		let time_1730 = $("tbody th").eq(22);
		let time_1800 = $("tbody th").eq(23);
		let time_1830 = $("tbody th").eq(24);
		let time_1900 = $("tbody th").eq(25);
		let time_1930 = $("tbody th").eq(26);
		let time_2000 = $("tbody th").eq(27);
		let time_2030 = $("tbody th").eq(28);
		let time_2030_1 = $("tbody th").eq(30); */

		//예약된 일정 화면에 뿌리기
		$(function() {
			$("#searchDateBtn").click(function() {
	
				let date = $("#datePicker").val();

				$.ajax({
					url : "reservedRoomList.do",
					data : {
						date : date
					},
					type : "post",
					
					//한글 깨짐 해결하기
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					success : function(data, statusText, jqXHR) {
						const obj = JSON.parse(data);
						
						console.log(data)
						console.log(obj)
						
						let offset = 0;

						$("tbody th").css("background", "");
						
						for (const room of obj.rooms){					
							for (const time of room.times){
								for (let i = time[0]; i < time[1]; i++){
									$("tbody th").eq(i + offset + 1).css("background", "#2146b5"); //i + offset + 1 -> +1은 eq(0)이 회의실명 적힌 칸이라서
								}
							}
							
							offset += 29; //한 행에 29칸임, +29 해서 한칸씩 내려갈 것
						}

						//location.reload();
					},
					error : function(error) {
						alert("조회에 실패하였습니다.");
					}
				})
					
			})
		})

		//예약하기
		//날짜 등 데이터 null로 넘어갔으면 입력해달라고 alert 띄우기 
		$(function() {
			$("#reserveRoom").click(function() {
				let date = $("#modal-datePicker").val();
				let startTime = $("#startTime").val();
				let endTime = $("#endTime").val();
				let selectRoom = $("#selectRoom").val();
				
				$.ajax({
					url : "reserveRoom.do",
					data : {
						date : date,
						startTime : startTime,
						endTime : endTime,
						selectRoom : selectRoom
					},
					type : "post",
					
					//예약 완료시에 datepicker에 현재날짜 고정된채로 화면 reload 필요
					success: function(result){
						if(result > 0){
							alert("예약이 완료되었습니다.");
						}else if(result == -1){
							alert("이미 예약된 시간입니다.")
						}		
					},
					error: function(error){
						alert("예약에 실패하였습니다.")
					}
			 	 /* success : function(obj, statusText, jqXHR) {
						console.log("예약을 완료하였습니다.");
						//location.reload();
					},
					error : function(error) {
						console.log("예약에 실패하였습니다.");
					} */
				})
			})
		})
		
		//종료시간 체크용
		$(function(){
			$("#endTime").on("change", function(){
				console.log($("#endTime").val())
			})
		})
				
		//예약시작시간보다 종료시간이 작을 수 없음
		$(function(){
	
			let endTimeCheck = $("#endTime"); //종료시간이 선택 될 때 이벤트 발생시키기
			
			endTimeCheck.on("change", function(){			
				let startTime = $("#startTime").val();
				let endTime = $("#endTime").val();
				
				$.ajax({
					url: "timeCheck.do",
					data: {
						startTime: startTime,
						endTime: endTime						
					},
					type: "post",
					success:function(result){
						if(result > 0){
							console.log("OK")
							$("#reserveRoom").attr("disabled", false)
						}else if(result == 0){
							alert("시작시간과 종료시간은 같을 수 없습니다.")
							$("#reserveRoom").attr("disabled", false)
						}else{
							alert("종료시간은 시작시간보다 빠를 수 없습니다.")
							$("#reserveRoom").attr("disabled", true)
						}
					},
					error: function(){
						console.log("ajax 통신 실패")
					}
				})
			})
			
		}) 
		
		
		$(function(){
			$("#roomReserveTable tbody th").click(function(){
				location.href="reservationDetails.do";
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
