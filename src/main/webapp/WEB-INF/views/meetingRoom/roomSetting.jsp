<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

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
	display: flex;
	justify-content: center;
}

#Pagenation {
	display: flex;
	justify-content: center;
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
							<div class="card-body">
								<section class="section">
									<div class="row" id="basic-table">
										<div class="col-12 col-md-6">
											<div class="card">
												<div class="card-content">
													<div class="card-body">
														<div class="table-responsive">
															<table class="table table-lg" id="meetingroom">
																<thead id="meetingroomRow">
																	<tr>
																		<th><input type="checkbox" id="checkbox-Top"
																			class="form-check-input"></th>
																		<th>No</th>
																		<th>회의실명</th>
																		<th>수용인원</th>
																		<th>비고</th>
																		<th></th>
																	</tr>
																</thead>
																<tbody>
																	<!-- 로그인한 회원이 소속된 회사의 회의실 리스트 뿌리기 -->
																	<c:forEach items="${ roomList }" var="r">
																		<tr>
																			<th><input type="checkbox" id="checkbox"
																				class="form-check-input" name="under-checkbox"
																				value="${ r.roomNo }"></th>
																			<th class="roomNo">${ r.roomNo }</th>
																			<th class="roomName">${ r.roomName }</th>
																			<th class="roomCapa">${ r.roomCapa }</th>
																			<th class="roomNote">${ r.roomNote }</th>
																			<th><button id="modifyRoom">수정</button></th>
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
																		<li class="page-item"><a class="page-link"
																			href="roomSetting.do?currentPage=${ pi.currentPage-1 }"><span
																				aria-hidden="true"><i
																					class="bi bi-chevron-left"></i></span></a></li>
																	</c:when>
																	<c:otherwise>
																		<li class="page-item disabled"><a
																			class="page-link" href=""><span
																				aria-hidden="true"><i
																					class="bi bi-chevron-left"></i></span></a></li>
																	</c:otherwise>
																</c:choose>

																<c:forEach begin="${ pi.startPage }"
																	end="${ pi.endPage }" var="p">
																	<c:choose>
																		<c:when test="${ pi.currentPage ne p }">
																			<li class="page-item" id="nowPage"><a
																				class="page-link"
																				href="roomSetting.do?currentPage=${ p }">${ p }</a></li>
																		</c:when>
																		<c:otherwise>
																			<li class="page-item disalbed" id="nowPage"><a
																				class="page-link" href="">${ p }</a></li>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>

																<c:choose>
																	<c:when test="${ pi.currentPage ne pi.maxPage }">
																		<li class="page-item"><a class="page-link"
																			href="roomSetting.do?currentPage=${ pi.currentPage + 1 }"><span
																				aria-hidden="true"><i
																					class="bi bi-chevron-right"></i></span></a></li>
																	</c:when>
																	<c:otherwise>
																		<li class="page-item disabled"><a
																			class="page-link"
																			href="roomSetting.do?currentPage=${ pi.currentPage + 1 }"><span
																				aria-hidden="true"><i
																					class="bi bi-chevron-right"></i></span></a></li>
																	</c:otherwise>
																</c:choose>
															</ul>
														</div>

														<br>

														<div class="buttons">
															<button type="button" class="btn btn-primary"
																data-toggle="modal" data-target="#myModal">추가</button>
															
															<div class="modifyBtns">
																<button type="button" class="btn btn-light"
																	id="modifyBtn" data-toggle="modal"
																	data-target="#modify-Modal">수정</button>
															</div>
															
															<button href="#" class="btn btn-danger" id="deleteRoom">삭제</button>

															<div class="modal" id="myModal">
																<div class="modal-dialog">
																	<div class="modal-content">

																		<div class="modal-header">
																			<h4 class="modal-title">회의실 추가</h4>
																			<button type="button" class="close"
																				data-dismiss="modal"></button>
																		</div>

																		<div class="modal-body" id="modal-body">
																			<form name="insertRoom" method="post" action="#">

																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">회의실번호</label>
																					<input type="text" class="form-control"
																						id="room_no" name="room_no"
																						placeholder="회사번호(0)-회의실번호(00)">
																					<!-- 자동으로 회사번호 받아오는 방법 추가하기 -->
																				</div>
																				<div>
																					<a id="room_no_check"></a>
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">회의실명</label>
																					<input type="text" class="form-control"
																						id="room_name" name="room_name">
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">수용인원</label>
																					<input type="text" class="form-control"
																						id="room_capa" name="room_capa">
																				</div>
																				<br>
																				<div class="form-insertRoom">
																					<label for="label-insertRoom" class="control-label">비고</label>
																					<input type="text" class="form-control"
																						id="room_note" name="room_note">
																				</div>

																			</form>
																		</div>

																		<div class="modal-footer">
																			<button type="button" class="btn btn-primary"
																				id="addRoom" data-dismiss="modal"
																				onclick="addRoom()">확인</button>
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

	<!-- 수정 Modal -->
	<div class="modal" id="modify-Modal">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<h4 class="modal-title">회의실 수정</h4>
					<button type="button" class="close" data-dismiss="modal"></button>
				</div>

				<div class="modal-body" id="modal-body">
					<form name="insertRoom" method="post" action="#">

						<div class="form-updateRoom">
							<label for="label-updateRoom" class="control-label">회의실번호</label>
							<input type="text" class="form-control" id="update_room_no"
								value="${ r.roomNo }">
							<!-- 자동으로 회사번호 받아오는 방법 추가하기 -->
						</div>
						<div>
							<a id="room_no_check"></a>
						</div>
						<br>
						<div class="form-updateRoom">
							<label for="label-updateRoom" class="control-label">회의실명</label>
							<input type="text" class="form-control" id="update_room_name"
								value="${ r.roomName }">
						</div>
						<br>
						<div class="form-updateRoom">
							<label for="label-updateRoom" class="control-label">수용인원</label>
							<input type="text" class="form-control" id="update_room_capa"
								value="${ r.roomCapa }">
						</div>
						<br>
						<div class="form-updateRoom">
							<label for="label-updateRoom" class="control-label">비고</label> <input
								type="text" class="form-control" id="update_room_note"
								value="${ r.roomNote }">
						</div>

					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="updateRoom"
						data-dismiss="modal" onclick="updateRoom()">확인</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		//회의실 수정 //체크
		$(function() {
			$("#modifyRoom").click(function() {							
				
				let modifyRow = 
				console.log(checkedRow);
						
				let roomNo = checkedRow.children().eq(1).text(); 
				console.log(roomNo);
		
				checkedRow.remove();
				console.log("행 삭제 완료");
				
				$.ajax({
					url : "deleteRoom.do",
					data : {
						roomNo : roomNo,
					},
					type : "post",
					success : function(obj) {
						alert("회의실을 삭제하였습니다.");
						console.log(obj)
					
						location.reload();		
					},
					error : function(error) {
						alert("회의실 삭제에 실패하였습니다.");
					}
				})					
			})
		}) 

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

	
		//회의실 추가 모달에서 Controller로 데이터 넘기기 -> 성공
		//Controller에서 데이터 받고 화면에 뿌리기 -> 페이지 새로고침 메소드 추가, 성공
		$(function() {
			$("#addRoom").click(function() {
				let addRoomNo = $("#room_no").val();
				let addRoomName = $("#room_name").val();
				let addRoomCapa = $("#room_capa").val();
				let addRoomNote = $("#room_note").val();

				$.ajax({
					url : "insertRoom.do",
					data : {
						roomNo : addRoomNo,
						roomName : addRoomName,
						roomCapa : addRoomCapa,
						roomNote : addRoomNote
					},
					type : "post",
					success : function(obj) {
						alert("회의실을 추가하였습니다.");
						console.log(obj)
					},
					error : function(error) {
						alert("회의실 추가에 실패하였습니다.");
					}
				})
			})
		})

		//회의실 삭제 -> 한개만 삭제할 떄 코드
		/* $(function() {
			$("#deleteRoom").click(function() {							
				let checkedBox = $("#checkbox:checked") //제목행은 아이디 다르게 줘서 삭제되지 않게
				let checkedRow = checkedBox.parent().parent(); //tr
				console.log(checkedRow);
						
				let roomNo = checkedRow.children().eq(1).text(); //val()은 안되고 text()는 되네... 차이점은?
				console.log(roomNo);
		
				checkedRow.remove();
				console.log("행 삭제 완료");
				
				$.ajax({
					url : "deleteRoom.do",
					data : {
						roomNo : roomNo,
					},
					type : "post",
					success : function(obj) {
						alert("회의실을 삭제하였습니다.");
						console.log(obj)
					
						location.reload();		
					},
					error : function(error) {
						alert("회의실 삭제에 실패하였습니다.");
					}
				})					
			})
		}) */

		//회의실 삭제
		$(function() {
			$("#deleteRoom").click(function() {

				let chk = $("input[name='under-checkbox']");
				let checkedArr = [];
				for (let i = 0; i < chk.length; i++) {
					if (chk[i].checked == true) {
						checkedArr.push(chk[i].value);
					}
				}

				console.log("넘길 배열 : " + checkedArr)

				$.ajax({
					url : "deleteRooms.do",
					type : "post",
					data : {
						checkedArr : checkedArr
					},
					success : function(data) {
						alert("회의실을 삭제하였습니다.")
						location.reload();
					},
					error : function() {
						console.log("회의실 삭제에 실패하였습니다.");
					}
				})
			})
		})

		/* $(function() {
			$("#deleteRoom").click(function() {			
				let checkedArr = [];
				$("#checkbox").each(function(i){   //each() : 모든 $("#checkbox") 요소를 검사함
					
					//배열에 체크된 행의 회의실번호 담기... i 
					//checkedArr.push($('#checkbox:checked:eq(' + i + ')').next().val());
					checkedArr.push($('#checkbox:checked:parent:parent:eq(' + i + ')').next().text());
					console.log("넘어갈 배열 : " + checkedArr);
				})
					
				$.ajax({
					url: "deleteRooms.do",
					type: "post",
					dataType: 'json',
					data: {
						checkedRoomNo: checkedArr
					},
					success: function(data){
						location.reload();
					},
					error: function(){
						alert("회의실 삭제에 실패하였습니다.");
					}
				})		
			})
		}) */

		//회의실번호 중복체크
		$(function() {
			let roomNoCheck = $("#room_no");

			roomNoCheck.keyup(function() {
				if (roomNoCheck.val().length >= 4) {

					$.ajax({
						url : "roomNoCheck.do",
						data : {
							roomNo : roomNoCheck.val()
						},
						type : "post",
						success : function(result) {
							if (result > 0) {
								roomNoCheckValidate(1)
							} else {
								roomNoCheckValidate(0)
							}
						},
						error : function() {
							console.log("ajax 통신 실패")
						}
					})
				} else {
					$("#room_no_check").css("color", "red").text(
							"네자리 이상 작성하세요.");
				}
			})
		})

		function roomNoCheckValidate(num) {
			if (num > 0) {
				$("#room_no_check").css("color", "red").text(
						"회의실번호는 중복될 수 없습니다.");
			} else if (num == 0) {
				$("#room_no_check").css("color", "green").text(
						"사용가능한 회의실번호입니다.");
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
