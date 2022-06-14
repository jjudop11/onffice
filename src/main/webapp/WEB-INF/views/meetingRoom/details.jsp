<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
#inner-card-body {
	border: 2px solid rgb(217, 222, 226);
	border-radius: 10px 10px 10px 10px;
}

#btns {
	text-align: center;
}

#btn {
	left-margin: 20px;
}

#startTime, #endTime{
	width: 45%;
	box-sizing: border-box;
	float: left;
}

#wiggle {
	width: 10%;
	box-sizing: border-box;
	float: left;
	text-align: center;
}

#selectTimeDiv{
	display: inline;
	margin: auto;
}

#date{
	height: 38px;
}
</style>
</head>

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
				<h2>Reservation Details</h2>
				<h5>예약 상세</h5>
			</div>

			<div class="page-content">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<div class="card-content">
									<div class="card-body" id="inner-card-body">

										<!-- //히든태그 value에 예약번호 받기 //수정, 삭제에 사용할 것
										<input type="hidden" id="reserveNo" value="">
										
										<h3>예약한 회의실명 받기 ex)대회의실</h3>
										<br>
										
										//value에 예약한 날짜 받기
										<h5>예약일</h5>
										<div><input type="date" value="2022-06-07"> </div>
										<br>
									
										//value에 예약한 시간 받기
										<h5>예약시간</h5>
										<input type="time" id="startTime" value="08:00"> ~ <input type="time" id="endTime" value="08:00"> <input type="checkbox" class="form-check-input" id="allTime"> 종일
										<br><br>
										
										<h5>회의명</h5>
										<input type="text" class="form-control" id="reserveTitle" value="오늘 점심 뭐먹을까?">
										<br>
										
										//value에 예약자 받기
										<h5>예약자</h5>
										<input type="text" class="form-control" id="reserveUser" value="김말이 사원"
										readonly>
										<br>
										
										<div id="btns">
										<button class="btn btn-primary" id="modifyReservation()">수정</button>
										<button class="btn btn-danger" id="deleteReservation()">삭제</button>
										<button class="btn btn-light" onclick="history.back(-1)">돌아가기</button>
										</div> -->


										<form id="detailView" action="deleteReservation.do"
											method="post">

											<!-- hidden태그 value에 예약번호 받음. 수정, 삭제에 사용 -->
											<input type="hidden" name="reserveNo" id="reserveNo" value="${ room.reserveNo }">

											<!-- 예약한 회의실명 -->
											<!-- <h3>${ roomName }</h3> -->
											<h5>회의실</h5>
											<select class="form-select" id="selectRoom" name="selectRoom" required>
												<c:forEach items="${ roomList }" var="r">
													<option value="${ r.roomName }">${ r.roomName }</option>
												</c:forEach>
											</select>
											<br>

											<!-- 예약한 날짜 -->
											<h5>예약일</h5>
											<div>
												<input type="date" id="date" value="${ room.reserveDate }" required>
											</div>
											<br>

											<!-- 예약한 시간 -->
											<h5>예약시간</h5>
											<!-- <input type="time" id="startTime" value="${ room.startTime }"> ~ <input type="time" id="endTime" value="${ room.endTime }"> <input type="checkbox" class="form-check-input"> 종일  -->
											<!-- <h5>${ room.startTime }~${ room.endTime }</h5>  -->
											<div id="selectTimeDiv">
											<div id="selectStartTime">
											<select id="startTime" class="form-control" required>
												<option class="stTime" value="07:00">07:00</option>
												<option class="stTime" value="07:30">07:30</option>
												<option class="stTime" value="08:00">08:00</option>
												<option class="stTime" value="08:30">08:30</option>
												<option class="stTime" value="09:00">09:00</option>
												<option class="stTime" value="09:30">09:30</option>
												<option class="stTime" value="10:00">10:00</option>
												<option class="stTime" value="10:30">10:30</option>
												<option class="stTime" value="11:00">11:00</option>
												<option class="stTime" value="11:30">11:30</option>
												<option class="stTime" value="12:00">12:00</option>
												<option class="stTime" value="12:30">12:30</option>
												<option class="stTime" value="13:00">13:00</option>
												<option class="stTime" value="13:30">13:30</option>
												<option class="stTime" value="14:00">14:00</option>
												<option class="stTime" value="14:30">14:30</option>
												<option class="stTime" value="15:00">15:00</option>
												<option class="stTime" value="15:30">15:30</option>
												<option class="stTime" value="16:00">16:00</option>
												<option class="stTime" value="16:30">16:30</option>
												<option class="stTime" value="17:00">17:00</option>
												<option class="stTime" value="17:30">17:30</option>
												<option class="stTime" value="18:00">18:00</option>
												<option class="stTime" value="18:30">18:30</option>
												<option class="stTime" value="19:00">19:00</option>
												<option class="stTime" value="19:30">19:30</option>
												<option class="stTime" value="20:00">20:00</option>
												<option class="stTime" value="20:30">20:30</option>
											</select>
											</div>
											<div id="wiggle"><h3>~</h3></div>
											<div id="selectEndTime">
											<select id="endTime" class="form-control" required>
												<option class="edTime" value="07:30">07:30</option>
												<option class="edTime" value="08:00">08:00</option>
												<option class="edTime" value="08:30">08:30</option>
												<option class="edTime" value="09:00">09:00</option>
												<option class="edTime" value="09:30">09:30</option>
												<option class="edTime" value="10:00">10:00</option>
												<option class="edTime" value="10:30">10:30</option>
												<option class="edTime" value="11:00">11:00</option>
												<option class="edTime" value="11:30">11:30</option>
												<option class="edTime" value="12:00">12:00</option>
												<option class="edTime" value="12:30">12:30</option>
												<option class="edTime" value="13:00">13:00</option>
												<option class="edTime" value="13:30">13:30</option>
												<option class="edTime" value="14:00">14:00</option>
												<option class="edTime" value="14:30">14:30</option>
												<option class="edTime" value="15:00">15:00</option>
												<option class="edTime" value="15:30">15:30</option>
												<option class="edTime" value="16:00">16:00</option>
												<option class="edTime" value="16:30">16:30</option>
												<option class="edTime" value="17:00">17:00</option>
												<option class="edTime" value="17:30">17:30</option>
												<option class="edTime" value="18:00">18:00</option>
												<option class="edTime" value="18:30">18:30</option>
												<option class="edTime" value="19:00">19:00</option>
												<option class="edTime" value="19:30">19:30</option>
												<option class="edTime" value="20:00">20:00</option>
												<option class="edTime" value="20:30">20:30</option>
												<option class="edTime" value="21:00">21:00</option>
											</select> 
											</div>
											</div>
											
											
											<br><br>
											
											<h5>회의명</h5>
											<input type="text" class="form-control" id="reserveTitle" value="${ room.reserveTitle }" required> 
											<br>
												
											<h5>예약자</h5>
											<input type="hidden" name="reserveUserNo" id="reserveUserNo" value="${ room.mNo }">
											<h5 id="reserveUser">${ mName }${ mJob }</h5>
											<br>

											<div id="btns"> 
												<button class="btn btn-primary" type="button" id="updateReservation">수정</button>
												<button class="btn btn-danger" type="submit">삭제</button>
												<button class="btn btn-light" type="button">돌아가기</button>
											</div>
										</form>
										
										<!-- 수정버튼 누르면 여기 인풋태그에 값 들어가게  -->
										<form id="updateForm" action="updateReservation.do" method="post">
											<input type="hidden" name="reserveNoUpdate">
											<input type="hidden" name="selectRoomUpdate">
											<input type="hidden" name="dateUpdate">
											<input type="hidden" name="startTimeUpdate">
											<input type="hidden" name="endTimeUpdate">
											<input type="hidden" name="reserveTitleUpdate">
											<input type="hidden" name="reserveUserNoUpdate">
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<script>
		//종일 체크박스 만들어보자
		/* $(function() {
			$("#allTime").click(function() {
				if ($("#allTime").is(":checked")) {
					$("#startTime").value = "07:00";
					$("#endTime").value = "21:00";
				}
			})

		}) */

		//페이지 진입시 selectbox에 예약된 값 지정 
		window.onload = function() {

			//예약된 시작시간 잘 넘어옴
			let startTime = "${ room.startTime }";
			let endTime = "${ room.endTime }";
			let roomName = "${ roomName }"
			
			console.log(startTime, endTime);

			$('#startTime').val(startTime).prop('selected', true);
			$('#endTime').val(endTime).prop('selected', true);
			$('#selectRoom').val(roomName).prop('selected', true);
			
			/* //class="stTime"인 태그 
			   let startList = $('.stTime');
			
			   for(let i = 0; i < startList.length; i++){		
			   	
				if(startList[i].value === startTime){
					    startList[i].prop('selected', true);
					}		
				} */

		}
		
		/* $(function(){
			$('#reserveNo').click(function() {
				let reserveNo = $('#reserveNo').val();
				let roomName = $('#selectRoom').val();
				let startTime = $('#startTime').val();
				let endTime = $('#endTime').val();
				let reserveTitle = $('#reserveTitle').val();
				
				console.log(reserveNo, roomName, startTime, endTime, reserveTitle);	
			})
		}) */
		
		//예약 수정
		$(function(){
			$('#updateReservation').click(function(){
				let reserveNo = $('#reserveNo').val();
				let roomName = $('#selectRoom').val();
				let date = $('#date').val();
				let startTime = $('#startTime').val();
				let endTime = $('#endTime').val();
				let reserveTitle = $('#reserveTitle').val();
				let reserveUserNo = $('#reserveUserNo').val();
														
				console.log(reserveNo, roomName, startTime, endTime, reserveTitle, reserveUserNo);	
				
				
				$("input[name='reserveNoUpdate']").attr('value', reserveNo);
				$("input[name='selectRoomUpdate']").attr('value', roomName);
				$("input[name='dateUpdate']").attr('value', date);
				$("input[name='startTimeUpdate']").attr('value', startTime);
				$("input[name='endTimeUpdate']").attr('value', endTime);
				$("input[name='reserveTitleUpdate']").attr('value', reserveTitle);
				$("input[name='reserveUserNoUpdate']").attr('value', reserveUserNo);
				
				console.log($("input[name='startTimeUpdate']").val())
				
				$('#updateForm').submit();		
			})
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
							$("#updateReservation").attr("disabled", false);
						}else if(result == 0){
							alert("시작시간과 종료시간은 같을 수 없습니다.");
							$("#updateReservation").attr("disabled", true)
						}else{
							alert("종료시간은 시작시간보다 빠를 수 없습니다.");
							$("#updateReservation").attr("disabled", true)
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
		
	</script>


	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
