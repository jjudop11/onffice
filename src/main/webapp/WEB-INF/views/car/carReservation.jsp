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

#roomSetting-button {
	float: right;
}

#useNote {
	height: 90px;
	resize: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />

	<div id="app">
		<div id="main">

			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i></a>
			</header>

			<div class="page-heading">
				<h3>차량 예약</h3>
			</div>

			<div class="card">
				<div class="card-body">
					<section class="section">
						<div class="row" id="basic-table">
							<div class="col-12 col-md-6">

								<div class="card">
									<div class="card-content">
										<div class="card-body">

											<!-- 하단 회의실 현황 -->
											<div id="meetingroomList">
												<button class="btn btn-primary" id="roomSetting-button"
													onclick="location.href='reserve-roomSetting.do'">설정</button>
												<br> <br> <input type="hidden" id="today"
													value="${ today }">
												<div class="table-responsive">
													<table class="table table-bordered mb-0" id="ReservingCar">
														<thead id="ReservingCar-head">
															<tr>
																<th>차량명</th>
																<th>차량번호</th>
																<th>대여현황</th>
															</tr>
														</thead>
														<tbody>
															<!-- 로그인한 회원이 소속된 회사의 회의실 리스트 뿌리기 -->
															<c:forEach items="${ carList }" var="c">
																<tr>
																	<th id="carName">${ c.carName }</th>
																	<th id="carNo">${ c.carNo }</th>
																	<c:choose>
																		<c:when test="${c.carStatus eq 'N' }">
																			<th><button class="btn btn-primary" id="able" name="ableBtn"
																					data-toggle="modal" data-target="#myModal">대여가능</button></th>
																		</c:when>
																		<c:when test="${c.carStatus eq 'Y' }">
																			<th><button class="btn btn-light" id="unable" name="unableBtn"
																					data-toggle="modal" data-target="#returnModal">대여불가</button></th>
																		</c:when>
																	</c:choose>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
		
												<!-- 차량 예약 모달 -->
												<div class="modal" id="myModal">
													<div class="modal-dialog">
														<div class="modal-content">

															<div class="modal-header">
																<h4 class="modal-title">차량 예약</h4>
																<button type="button" class="close" data-dismiss="modal"></button>
															</div>

															<div class="modal-body" id="modal-body">
																<form name="insertCar" method="post" action="#">

																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">대여일자</label>
																		<input type="text" class="form-control"
																			id="reserveDate" value="${ today }" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">차량번호</label>
																		<input type="text" class="form-control"
																			id="reserveCarNo" value="" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">대여자</label>
																		<input type="text" class="form-control"
																			id="reserveMember" value="${ userName } ${ userJob }"
																			disabled> <input type="hidden"
																			id="reserveMemberNo" value="${ userNo }">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">사용날짜</label>
																		<input type="text" class="form-control" id="useDate">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">내용</label>
																		<textarea class="form-control" id="useNote"></textarea>
																	</div>
																</form>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-primary"
																	id="addCar" data-dismiss="modal">확인</button>
															</div>
														</div>
													</div>
												</div>
												
												<!-- 차량 반납 모달 -->
												<div class="modal" id="returnModal">
													<div class="modal-dialog">
														<div class="modal-content">

															<div class="modal-header">
																<h4 class="modal-title">예약 내역</h4>
																<button type="button" class="close" data-dismiss="modal"></button>
															</div>

															<div class="modal-body" id="modal-body">
																<form name="insertCar" method="post" action="#">

																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">대여일자</label>
																		<input type="text" class="form-control"
																			id="reserveDate" value="${ today }" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">차량번호</label>
																		<input type="text" class="form-control"
																			id="reserveCarNo" value="" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">대여자</label>
																		<input type="text" class="form-control"
																			id="reserveMember" value="${ userName } ${ userJob }"
																			disabled> <input type="hidden"
																			id="reserveMemberNo" value="${ userNo }">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">사용날짜</label>
																		<input type="text" class="form-control" id="useDate">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">내용</label>
																		<textarea class="form-control" id="useNote"></textarea>
																	</div>
																</form>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-primary"
																	id="addCar" data-dismiss="modal">확인</button>
															</div>
														</div>
													</div>
												</div>


												<!-- 차량 반납시 차량번호 저장용 //필요 없을듯. 체크 -->
												<input type="hidden" id="returnCar">
												
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
			$('#able').click(function(){
				
				let ableBtn = $('#able');
					
				//현재 행
				let row = $(this).closest('tr');
				let carNo = row.find('th:eq(1)').text();
				console.log("차량번호 : ", carNo);
				
				$('#reserveCarNo').attr('value', carNo);

			})
		})
		
		//차량 사용일자 빈칸
		/* $(function(){
			var required = $('#useDate').filter('[required]:empty');
			if(required.size() > 0) {
				$('#useDate').focus();
				$('#useDate').innerHTML = "사용일자를 입력하세요";
			}
		}) */
		
		//차량 대여 //
		$(function(){
			$('#addCar').click(function(){
		
				//예약할 차량번호
				/* let ableBtn = $('#able');
				let row = $(this).closest('tr');
				let carNo = row.find('th:eq(1)').text();
				console.log("차량번호 : ", carNo); */
				
				let reserveDate = $('#reserveDate').val();
				let reserveCarNo = $('#reserveCarNo').val();
				let memberNo = $('#reserveMemberNo').val(); //controller에서 사번
				let useDate = $('#useDate').val();
				let note = $('#useNote').val();
					
				console.log(reserveDate, memberNo, useDate, note);
				
				$.ajax({
					url: "reservingCar",
					data: {
						reserveDate: reserveDate,
						reserveCarNo: reserveCarNo,
						useDate: useDate,
						note: note
					},
					type: "post",
					success: function(userNo){
						console.log("성공");
						alert("차량을 예약하였습니다.");
						console.log(userNo);
						console.log(${userNo})
						location.reload();
					},
					error: function(){
						console.log("통신 실패");
					}
				})
				
				/* if(userNo === ${userNo}){
					$('#unable').text("반납");
				}*/
			})
		})
		
		//차량 반납
		$(function(){
			$('#unable').click(function(){	
				console.log("대여불가 클릭");
				
				//let unableBtn = $('#unable');
				let row = $(this).closest('tr');
				let reserveCarNo = row.find('th:eq(1)').text();
				console.log("차량번호 : ", reserveCarNo);	
				//$('#returnCar').attr('value', reserveCarNo);
				
				$.ajax({
					url:"reserveDetails.do",
					data:{
						reserveCarNo: reserveCarNo
					},
					type:"post",
					success: function(){
						console.log("성공");
					},
					error: function(){
						console.log("실패");
					}
				})
			
			})
		})
	
	
		//화면 진입시 value에 지정된 날짜 자동 조회
		window.onload = function(){
			$("#searchDateBtn").trigger('click');
		}
		
		//예약된 일정 화면에 뿌리기
		$(function() {
			$("#searchDateBtn").click(function() {
	
				let date = $("#datePicker").val();
				console.log(date);
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
						const cells = $("#roomReserveTable tbody th");

						let offset = 0;

						cells.css("background", "");
						cells.removeData("st-time");
						cells.removeData("ed-time");

						for (const room of obj.rooms){					
							for (const time of room.times){
								
								const stTime = cells.eq(time[0] + offset + 1).attr('id');
								let edTime = cells.eq(time[1] + offset).attr('id');

								let splitedTime = edTime.split(':');
								let edTimeHour = parseInt(splitedTime[0]);
								let edTimeMinute = parseInt(splitedTime[1]);
								
								if (edTimeMinute == 30){
									edTimeHour++;
									edTimeMinute = '00';
								} else {
									edTimeMinute = '30';
								}
								
								if (edTimeHour < 10){
									edTimeHour = '0' + edTimeHour;
								}
								
								edTime = edTimeHour + ':' + edTimeMinute;
								
								for (let i = time[0]; i < time[1]; i++){
									
									const item = cells.eq(i + offset + 1); //i + offset + 1 -> +1은 eq(0)이 회의실명 적힌 칸이라서

									item.css('background', '#2146b5'); 
									item.data('st-time', stTime);
									item.data('ed-time', edTime);
									item.prop('title', stTime + ' ~ ' + edTime)
								}
							}
							
							offset += 29; //한 행에 29칸임, +29 해서 한칸씩 내려갈 것
						}
					},
					error : function(error) {
						alert("조회에 실패하였습니다.");
					}
				})
					
			})
		})

		//예약하기
		$(function() {
			$("#reserveRoom").click(function(e) {
				let date = $("#modal-datePicker").val();
				let startTime = $("#startTime").val();
				let endTime = $("#endTime").val();
				let selectRoom = $("#selectRoom").val();
				let title = $("#reservetitle").val();
							
				$.ajax({
					url : "reserveRoom.do",
					data : {
						date : date,
						startTime : startTime,
						endTime : endTime,
						selectRoom : selectRoom,
						title: title
					},
					type : "post",
					
					//예약 완료시에 datepicker에 현재날짜 고정된채로 화면 reload 필요
					success: function(result){
						if(result > 0){
							alert("예약이 완료되었습니다.");
							$("#searchDateBtn").trigger('click');
						}else if(result == -1){
							alert("이미 예약된 시간입니다.")
						}		
					},
					error: function(error){
						alert("예약에 실패하였습니다. 예약정보를 입력해주세요.")
					}
				})
				
				$('#myModal').modal('hide');
				e.preventDefault(); //페이지 새로고침되지 않게 //새로고침되면 datepicker 초기화됨
			})
		})
		
		$('#reserveRoomBtn').click(function(e) {
			//모달 열기
			$('#myModal').modal('toggle');
		})
		
		$('#btnCloseModal').click(function(e) {
			//수동으로 모달 닫기. 여백 클릭해도 닫히지 않음.
			$('#myModal').modal('hide');
		})

		//예약시작시간보다 종료시간이 작을 수 없음
		$(function(){
			const fn = function(){			
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
							$("#reserveRoom").attr("disabled", false);
						}else if(result == 0){
							alert("시작시간과 종료시간은 같을 수 없습니다.");
							//$("#reserveRoom").attr("disabled", true)
						}else{
							alert("종료시간은 시작시간보다 빠를 수 없습니다.");
							//$("#reserveRoom").attr("disabled", true)
						}
					},
					error: function(){
						console.log("ajax 통신 실패")
					}
				})
			};

			$("#startTime").on("change", fn); // 시작시간이 선택 될 때 이벤트 발생
			$("#endTime").on("change", fn); // 종료시간이 선택 될 때 이벤트 발생
		}) 
				
		//에약 상세로 진입
		$(function(){
			$("#roomReserveTable tbody th").click(function(){
				const item = $(this);
				const id = item.attr('id');
				const roomno = item.parent().data("roomno");
				const stTime = item.data('st-time');
				const edTime = item.data('ed-time');
		
				const date = $("#datePicker").val();
				
				if (typeof id == "undefined" || id == "" || id == null ||
				    typeof stTime == "undefined" || stTime == "" || stTime == null ||
				    typeof edTime == "undefined" || edTime == "" || edTime == null){
					
					return;
				}else{
					
					console.log(id, typeof(id))
					console.log(roomno, typeof(roomno))
					console.log(stTime, typeof(stTime))
					console.log(edTime, typeof(edTime))
					console.log(date, typeof(date))
									
					$("input[name=dateD]").attr("value", date);
					$("input[name=roomNoD]").attr("value", roomno);
					$("input[name=startTimeD]").attr("value", stTime);
					//console.log($("#dateD").val())
					//console.log($("#roomNoD").val())
					//console.log($("#startTimeD").val())		
					$("#hiddenForm").submit();
				}
				
			})
		}) 
		
		//모달 닫을 시 내용 초기화
		$(".modal").on("hidden.bs.modal", function(e){
			$(this).find("form")[0].reset();
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
