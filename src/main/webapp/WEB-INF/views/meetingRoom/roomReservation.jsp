<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.uni.spring.meetingroom.model.dto.Meetingroom" %>
<%
	//로그인유저 세션에서 받아와서 그 사람 회사번호 뿌리고, 그거 회사번호 텍스트 태그에 반영하기 -> ?
			
	//
	ArrayList<Meetingroom> roomList = (ArrayList<Meetingroom>)request.getAttribute("roomList");

	int num = 0;
	
	for(int i = 0; i < roomList.size(); i++){
		
		num++;
	}
%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/assets/css/bootstrap.css">
<link rel="stylesheet" href="resources/assets/vendors/iconly/bold.css">
<link rel="stylesheet" href="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="resources/assets/css/app.css">
<link rel="shortcut icon" href="resources/assets/images/favicon.svg" type="image/x-icon">

<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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

.form-group{
	width: 10%;
}

#form-group-under{
	float: right;
	margin: 0 0 0 56.5%;
}
</style>
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
								<h1>회의실 예약 표 영역</h1>
								<div class="card-body-room">

													<!-- 회의실 갯수만큼 테이블 div 생성...? -->
														<!-- 3행 46열 --><!-- 기본 화면 테이블 -->
														<div class="table-responsive" id="table_1">
															<table class="table table-bordered mb-0" id="meetingroom">
																<thead id="meetingroomRow">
																</thead>
																<tbody>
																	<tr>
																		<th>어떻게</th>
																		<th>만들어야하나...</th>
																	</tr>
																</tbody>
																<tfoot>
																</tfoot>
															</table>
														</div>
										
														<br><br>
													</div>

													<!-- 하단 회의실 현황 -->
													<div id="meetingroomList">	
														<h3 id="roomSetting">회의실 현황</h3>
														<button class="btn btn-primary" id="roomSetting-button" onclick="location.href='reserve-roomSetting.do'">설정</button>
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
	

	<script>
		$("#roomSetting").click(function(){
			let roomList = "${ roomList }";
			console.log(roomList)
		})
		
	/*	$.datepicker.setDefaults({
        	dateFormat: 'yy-mm-dd',	//날짜포맷
        	prevText: '이전 달',		//마우스 올리면 이전달 텍스트
        	nextText: '다음 달',		//마우스 올리면 다음달 텍스트
        	closeText: '닫기', 		//닫기 버튼 텍스트 변경
        	currentText: '오늘', 	// 오늘 텍스트 변경
        	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
        	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
        	dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
        	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
        	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
        	showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
        	yearSuffix: '년',	//
        	showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
        	buttonImageOnly: true,	// input 옆에 조그만한 아이콘으로 캘린더 선택가능하게 하기
        	buttonImage: "images/calendar.gif",	// 조그만한 아이콘 이미지
        	buttonText: "Select date"	// 조그만한 아이콘 툴팁
    }); */
	
    /* $(function() {
        $("#datepicker").datepicker({ 
            onSelect: function() { 
                let date = $.datepicker.formatDate("yy-mm-dd",$("#datepicker").datepicker("getDate")); 
                console.log(date)
                alert(date);
            }
        });                    
    }); */
    
    $("#datepicker").datepicker({
    	language: 'ko'
    }); 
 

	</script>

	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
