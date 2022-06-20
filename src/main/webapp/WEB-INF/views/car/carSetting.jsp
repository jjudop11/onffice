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
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/assets/css/bootstrap.css">
<link rel="stylesheet" href="resources/assets/vendors/iconly/bold.css">
<link rel="stylesheet" href="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="resources/assets/css/app.css">
<link rel="shortcut icon" href="resources/assets/images/favicon.svg" type="image/x-icon">

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
	display: flex;
	justify-content: center;
}

#Pagenation {
	display: flex;
	justify-content: center;
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
				<h3>차량관리</h3>
			</div>
			<div class="page-content">

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<section class="section">
									<div class="row" id="basic-table">
										<div class="col-12 col-md-6">
											<div class="card">
												<div class="card-content">
													<div class="card-body" id="in-card-body">
														<div class="table-responsive">
															<table class="table table-lg" id="car">
																<thead id="carRow">
																	<tr>
																		<th><input type="checkbox" id="checkbox-Top"
																			class="form-check-input"></th>
																		<!-- <th>No</th>  -->
																		<th>차량명</th>
																		<th>차량번호</th>
																	</tr>
																</thead>
																<tbody>
																	<!-- 로그인한 회원이 소속된 회사의 차량 리스트 -->
																	<c:forEach items="${ carList }" var="c">
																		<tr>
																			<th><input type="checkbox" id="checkbox"
																				class="form-check-input" name="under-checkbox"
																				value="${ c.carNo }"></th>
																			<!-- <th class="roomNo">${ c.no }</th>  -->
																			<th class="roomName">${ c.carName }</th>
																			<th class="roomCapa">${ c.carNo }</th> <!-- 대여 버튼으로 바꾸기 -->
																		</tr>
																	</c:forEach>														
																</tbody>
															</table>
														</div>

														<br>

														<!-- 페이징 -->
														<div id="Pagenation">
															<ul class="pagination pagination-primary">
																<c:choose>
																	<c:when test="${ pi.currentPage ne 1 }">
																		<li class="page-item"><a class="page-link" href="carSetting.do?currentPage=${ pi.currentPage-1 }"><span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a>
																		</li>
																	</c:when>
																	<c:otherwise>
																		<li class="page-item disabled"><a class="page-link" href=""><span aria-hidden="true"><i class="bi bi-chevron-left"></i></span></a>
																		</li>
																	</c:otherwise>
																</c:choose>
																	
																<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
																	<c:choose>
																		<c:when test="${ pi.currentPage ne p }">
																			<li class="page-item" id="nowPage"><a class="page-link" href="carSetting.do?currentPage=${ p }">${ p }</a></li>
																		</c:when>
																		<c:otherwise>
																			<li class="page-item disalbed" id="nowPage" ><a class="page-link" href="">${ p }</a></li>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
																
																<c:choose>
																	<c:when test="${ pi.currentPage ne pi.maxPage }">
																		<li class="page-item"><a class="page-link" href="carSetting.do?currentPage=${ pi.currentPage + 1 }"><span aria-hidden="true"><i class="bi bi-chevron-right"></i></span></a></li>
																	</c:when>
																	<c:otherwise>
																		<li class="page-item disabled"><a class="page-link" href="carSetting.do?currentPage=${ pi.currentPage + 1 }"><span aria-hidden="true"><i class="bi bi-chevron-right"></i></span></a></li>
																	</c:otherwise>
																</c:choose>												
															</ul>
														</div>

														<br>

														<div class="buttons">
															<button type="button" class="btn btn-primary"
																data-toggle="modal" data-target="#myModal">추가</button>
															<button href="#" class="btn btn-danger" id="deleteCar">삭제</button>

															<div class="modal" id="myModal">
																<div class="modal-dialog">
																	<div class="modal-content">

																		<div class="modal-header">
																			<h4 class="modal-title">차량 추가</h4>
																			<button type="button" class="close"
																				data-dismiss="modal"></button>
																		</div>

																		<div class="modal-body" id="modal-body">
																			<form name="insertCar" method="post" action="#">

																				<div class="form-insertCar">
																					<label for="label-insertCar" class="control-label">차량명</label>
																					<input type="text" class="form-control" id="car_name" name="car_name">
																				</div>
																				<br>
																				<div class="form-insertCar">
																					<label for="label-insertCar" class="control-label">차량번호</label>
																					<input type="text" class="form-control" id="car_no" name="car_no">
																				</div>
																				<div>
																					 <a id="car_no_check"></a>
																				</div>
																				<br><br>
																			</form>
																		</div>

																		<div class="modal-footer">
																			<button type="button" class="btn btn-primary" id="addCar" data-dismiss="modal">등록</button>
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
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		
		//체크박스 전체체크, 해제
		$(function() {
			$("#checkbox-Top").click(function() {
				if ($("#checkbox-Top").is(":checked")) {
					$(".form-check-input").prop("checked", true);
				} else {
					$(".form-check-input").prop("checked", false);
				}
			})

			$("input[name=under-checkbox]").click(function(){
				const total = $("input[name=under-checkbox]").length;
				const checked = $("input[name=under-checkbox]:checked").length;
				
				if (total != checked)
					$("#checkbox-Top").prop("checked", false);
				else
					$("#checkbox-Top").prop("checked", true);
			})
		})
		
		
		//차량 추가
		$(function() {
			$("#addCar").click(function() {
				let addCarName = $("#car_name").val();
				let addCarNo = $("#car_no").val();
				console.log(addCarName, addCarNo);

				$.ajax({
					url : "insertCar.do",
					data : {
						addCarName : addCarName,
						addCarNo : addCarNo
					},
					type : "post",
					success : function(obj) {
						alert("차량을 추가하였습니다.");
						console.log(obj)
						location.reload();	
						
					},
					error : function(error) {
						alert("차량 추가에 실패하였습니다.");
					}
				})
			})
		})
		
		//차량 삭제
		$(function() {
			$("#deleteCar").click(function() {

				let chk = $("input[name='under-checkbox']");
				let checkedArr = [];
				for (let i = 0; i < chk.length; i++) {
					if (chk[i].checked == true) {
						checkedArr.push(chk[i].value);
					}
				}

				console.log("넘길 배열 : " + checkedArr)

				$.ajax({
					url: "deleteCars.do",
					type: "post",
					data: {
						checkedArr : checkedArr
					},
					success : function(data) {
						alert("차량을 삭제하였습니다.");			
						location.reload();
					},
					error : function() {
						console.log("차량 삭제에 실패하였습니다.");
					}
				})
			})
		})
			
		//차량번호 중복체크
		$(function(){
			let carNoCheck = $('#car_no');
			
			carNoCheck.keyup(function(){		
					
				if(carNoCheck.val().length >= 1){
					$.ajax({
						url: "carNoCheck.do",
						data: {
							carNo: carNoCheck.val()	
						},
						type: "post",
						success: function(result){
							if(result > 0){
								carNoCheckValidate(1)
							}else{
								carNoCheckValidate(0)
							}			
						},
						error: function(){
							console.log("ajax 통신 실패")
						}	
					})			
				
				}else{
					$("#car_no_check").css("color", "red").text("차량번호를 입력해주세요.");
				}
					
			})
		})
		
		//차량번호 정규식
		/* $(function(){
			$('#car_no').blur(function(){
				
				let carNo = /^\d{2,3}[가-힣]{1}\s{1}\d{4}$/;
				
				if((carNo).test($('#car_no').val())){
					console.log("true");
					$('#car_no_check').css('color', 'green').text("올바른 형식입니다.");
					$('#addCar').attr("disabled", false);
				}else{
					$('#car_no_check').css('color', 'red').text("올바른 형식이 아닙니다.");
					$('#addCar').attr("disabled", true);
					//return false;
				}
			})
		}) */
		
		
		//차량번호 중복검사 & 형식 검사
		function carNoCheckValidate(num){
			if(num > 0){
				$("#car_no_check").css("color", "red").text("차량번호는 중복될 수 없습니다.");
				$('#addCar').attr("disabled", true);
			
			}else if(num == 0){
				$("#car_no_check").css("color", "green").text("사용가능한 차량번호입니다.");
				
				$('#car_no').blur(function(){
					
					let carNo = /^\d{2,3}[가-힣]{1}\s{1}\d{4}$/;
					
					if((carNo).test($('#car_no').val())){
						console.log("true");
						$('#car_no_check').css('color', 'green').text("올바른 형식입니다.");
						$('#addCar').attr("disabled", false);
					}else{
						$('#car_no_check').css('color', 'red').text("올바른 형식이 아닙니다.");
						$('#addCar').attr("disabled", true);
						//return false;
					}
				})
			}
		}
		
		
		
		//모달 닫을 시 내용 초기화
		$(".modal").on("hidden.bs.modal", function(e) {
			$(this).find("form")[0].reset();
			$("#room_no_check").empty();
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
