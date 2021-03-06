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

#btns{
	text-align: center;
}

#btn{
	left-margin: 20px;
}
</style>
</head>

<body>

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
										
										//히든태그에 예약번호 받기
										<input type="hidden" id="reserveNo" value="">
										
										<h3>예약한 회의실 넘겨받기 ex)대회의실</h3>
										<br>
										
										//value에 예약한 날짜 받기
										<h5>예약일</h5>
										<div><input type="date" id="date" value="2022-06-07"> </div>
										<br>
									
										//value에 예약한 시간 받기
										<h5>예약시간</h5>
										<input type="time" id="startTime" value="08:00"> ~ <input type="time" id="endTime" value="08:00"> <input type="checkbox" class="form-check-input"> 종일
										<br><br>
										
										//value에 회의내용 받기
										<h5>회의명</h5>
										<input type="text" class="form-control" id="title" value="점심메뉴 고민">
										<br>
										
										//text에 예약자 받기
										<h5>예약자</h5>
										<h5>김말이 연구원</h5>
										<br>
										
										<div id="btns">
										<button class="btn btn-primary" id="updateReservation">수정</button>
										<button class="btn btn-danger" onclick="deleteReservation()">삭제</button>
										<button class="btn btn-light">돌아가기</button>
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

	<script>
		$(function(){
			$("#updateReservation").click(function(){
				
				//예약자와 현재 로그인유저가 동일인인지 확인
				
				let date = $("#date");
				let startTime = $("#startTime");
				let endTime = $("#endTime");
				
				
				
				$.ajax({
					url: "updateReservation.do",
					data: {
						
						
					}
				})
				
			})
		})
		
		//예약자==로그인유저 체크
		let userCheck;
		
		function userCheck(){
			
			$.ajax({
				url: "userCheck.do",
				data: {
					userName: userName
				},
				type: "post",
				success: function(result){
					//전역변수 user에 값 대입
				},
				error: function(e){
					console.log("ajax 통신오류")
				}
			})
			
			
		}
		
		
		function deleteReservation(){		
			//예약자와 현재 로그인유저가 동일인인지 확인
			if(userCheck == true){
				//삭제 진행~~
			}
			
		}
	</script>


	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
