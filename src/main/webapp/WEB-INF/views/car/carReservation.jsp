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

.close{
	border: 0.1px solid gray;
}

#carNotice{
	width: 100%;
	height: 262px;
	background-color: rgb(247, 247, 247);
	border: 0.3px solid rgb(161, 177, 200);
	border-radius: 5px 5px 5px 5px;
	padding: 20px;
	
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
				<h3>?????? ??????</h3>
			</div>

			<div class="card">
				<div class="card-body">
					<section class="section">
						<div class="row" id="basic-table">
							<div class="col-12 col-md-6">
								<div class="card">
									<div class="card-content">
										<div class="card-body">
										
											<div id="carNotice">
												${ notice }
											</div>

											<!-- ?????? ?????? -->
											<div id="carList">
												<br> <br> <input type="hidden" id="today"
													value="${ today }">
												<div class="table-responsive">
													<table class="table mb-0" id="ReservingCar">
														<thead id="ReservingCar-head">
															<tr>
																<th>?????????</th>
																<th>????????????</th>
																<th>????????????</th>
															</tr>
														</thead>
														<tbody>
															<!-- ???????????? ????????? ????????? ????????? ?????? ????????? ????????? -->
															<c:forEach items="${ carList }" var="c">
																<tr>
																	<th id="carName">${ c.carName }</th>
																	<th id="carNo">${ c.carNo }</th>
																	<c:choose>
																		<c:when test="${c.carStatus eq 'N' }">
																			<th><button class="btn btn-primary" id="able" name="ableBtn"
																					data-toggle="modal" data-target="#myModal">????????????</button></th>
																		</c:when>
																		<c:when test="${c.carStatus eq 'Y' }">
																			<th><button class="btn btn-light" id="unable" name="unableBtn"
																					data-toggle="modal" data-target="#returnModal">????????????</button></th>
																		</c:when>
																	</c:choose>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
		
												<!-- ?????? ?????? ?????? -->
												<div class="modal" id="myModal">
													<div class="modal-dialog">
														<div class="modal-content">

															<div class="modal-header">
																<h4 class="modal-title">?????? ??????</h4>
																<button type="button" class="close" data-dismiss="modal"></button>
															</div>

															<div class="modal-body" id="modal-body">
																<form name="insertCar" method="post" action="#">

																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control"
																			id="reserveDate" value="${ today }" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control"
																			id="reserveCarNo" value="" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">?????????</label>
																		<input type="text" class="form-control"
																			id="reserveMember" value="${ userName } ${ userJob }"
																			disabled> <input type="hidden"
																			id="reserveMemberNo" value="${ userNo }">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control" id="useDate">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">??????</label>
																		<textarea class="form-control" id="useNote"></textarea>
																	</div>
																</form>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-primary"
																	id="addCar" data-dismiss="modal">??????</button>
																<button type="button" class="btn btn-danger"
																	id="closeModal" data-dismiss="modal">??????</button>	
															</div>
														</div>
													</div>
												</div>
												
												<!-- ?????? ?????? ??????, ?????? ?????? ?????? -->
												<div class="modal" id="returnModal">
													<div class="modal-dialog">
														<div class="modal-content">

															<div class="modal-header">
																<h4 class="modal-title">?????? ??????</h4>
																<button type="button" class="close" data-dismiss="modal"></button>
															</div>

															<div class="modal-body" id="modal-body">
																<form name="insertCar" method="post" action="#">

																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control"
																			id="reserveDate-return" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control"
																			id="reserveCarNo-return" disabled>
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">?????????</label>
																		<input type="text" class="form-control"
																			id="reserveMember-return" value="" disabled> 													
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">????????????</label>
																		<input type="text" class="form-control" id="useDate-return">
																	</div>
																	<br>
																	<div class="form-reservingCar">
																		<label for="label-reservingCar" class="control-label">??????</label>
																		<textarea class="form-control" id="useNote-return"></textarea>
																	</div>
																</form>
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-light"
																	id="updateCar">??????</button>
																<button type="button" class="btn btn-primary"
																	id="returnCar">??????</button>
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

	<script>
		
	/* $(function(){
		$('#able').click(function(){			
			let ableBtn = $('#able');				
			//?????? ???
			let row = $(this).closest('tr');
			let carNo = row.find('th:eq(1)').text();
			console.log("???????????? : ", carNo);
			
			$('#reserveCarNo').attr('value', carNo);
		})
	}) */
	
	//?????? ????????? ???????????? ????????????. id??? ?????????????????? name ??? ??????????????? ????????? ???
	$(function(){
		$("[name='ableBtn']").click(function(){
			
			let row = $(this).closest('tr');
			let carNo = row.find('th:eq(1)').text();
			console.log('???????????? : ', carNo);
			
			$('#reserveCarNo').attr('value', carNo);
		})
	})
		
	//?????? ???????????? ??????
	/* $(function(){
		var required = $('#useDate').filter('[required]:empty');
		if(required.size() > 0) {
			$('#useDate').focus();
			$('#useDate').innerHTML = "??????????????? ???????????????";
		}
	}) */
		
	//?????? ??????
	$(function(){
		$('#addCar').click(function(){
	
			//????????? ????????????
			/* let ableBtn = $('#able');
			let row = $(this).closest('tr');
			let carNo = row.find('th:eq(1)').text();
			console.log("???????????? : ", carNo); */
			
			let reserveDate = $('#reserveDate').val();
			let reserveCarNo = $('#reserveCarNo').val();
			let memberNo = $('#reserveMemberNo').val(); //controller?????? ??????
			let useDate = $('#useDate').val();
			let note = $('#useNote').val();
				
			console.log(reserveDate, memberNo, useDate, note);
			
			if(useDate.length == 0){
				alert('??????????????? ??????????????????.');
				$('#useDate').focus();
				return false;
				
			}else{		
				$.ajax({
					url: 'reservingCar',
					data: {
						reserveDate: reserveDate,
						reserveCarNo: reserveCarNo,
						useDate: useDate,
						note: note
					},
					type: 'post',
					success: function(userNo){
						console.log('??????');
						alert('????????? ?????????????????????.');
						//console.log(userNo);
						//console.log(${userNo})
						
						location.reload();			
					},
					error: function(){
						console.log('?????? ??????');
					}
				})			
			}			
			 
		})
	})
		
	//?????? ???????????? ??????
	 $(function(){
		 $("[name='unableBtn']").click(function(){	
			console.log("???????????? ??????");
			
			let row = $(this).closest('tr');
			let reserveCarNo = row.find('th:eq(1)').text();
			console.log("???????????? : ", reserveCarNo);	
			
			$.ajax({
				url: 'reserveDetails.do',
				data: {
					reserveCarNo: reserveCarNo
				},
				type: 'post',
				success: function(data){		
					console.log('??????');
					const carObj = JSON.parse(data);	
					//console.log(data);
					
					let reserveDate = carObj.reserveDate;
					let reserveCarNo = carObj.reserveCarNo;
					let reserveMName = carObj.reserveMName;
					let reserveJName = carObj.reserveJName;
					let userNo = carObj.userNo;
					let useDate = carObj.useDate;
					let useNote = carObj.useNote;
					//console.log(reserveDate, reserveCarNo, reserveMName, reserveJName, userDate, userNote);
					
					$('#reserveDate-return').attr('value', reserveDate);
					$('#reserveCarNo-return').attr('value', reserveCarNo);
					$('#reserveMember-return').attr('value', reserveMName + " " + reserveJName);
					$('#reserveCarNo-return').attr('value', reserveCarNo);
					$('#useDate-return').attr('value', useDate);
					//$('#useNote-return').attr('text', useNote);
					//$('#useNote-return').innerHTML = useNote;
					document.getElementById('useNote-return').value = useNote;
					
					//?????????????????? ????????? ???????????? ?????? ??? ???????????? ????????????
					if(userNo != ${userNo}){
						$('#returnCar').prop("disabled", true);
						$('#updateCar').prop("disabled", true);
						$('#useDate-return').prop("disabled", true);
						$('#useNote-return').prop("disabled", true);
						
					}else{
						$('#returnCar').prop("disabled", false);
						$('#updateCar').prop("disabled", false);
						$('#useDate-return').prop("disabled", false);
						$('#useNote-return').prop("disabled", false);
					}	
				},
				error: function(){
					console.log('??????');
				}
			})
		
		})
	}) 

	//?????? ??????
	$(function(){
		$('#returnCar').click(function(){
			let reserveCarNo = $('#reserveCarNo-return').val();
			console.log(reserveCarNo);
			
			$.ajax({
				url: 'returnCar.do',
				data: {
					reserveCarNo: reserveCarNo
				},
				type: 'post',
				success: function(){
					alert('????????? ?????????????????????.');
					location.reload();
				},
				error: function(){
					console.log('?????? ??????');
				}
			})
		})
	})
	
	//???????????? ??????
	$(function(){
		$('#updateCar').click(function(){
			
			let reserveCarNo = $('#reserveCarNo-return').val();
			let updateUseDate = $('#useDate-return').val();
			let updateUseNote = $('#useNote-return').val();
			console.log(updateUseDate, updateUseNote);
			
			if(updateUseDate.length == 0){
				alert("??????????????? ??????????????????.");
				$('#useDate-return').focus();
				return false;
			}else{
				$.ajax({
					url: 'updateReserveCar.do',
					data: {
						reserveCarNo: reserveCarNo,
						updateUseDate: updateUseDate,
						updateUseNote: updateUseNote
					},
					type: 'post',
					success: function(){
						alert('????????? ?????????????????????.');
						location.reload();
					},
					error: function(){
						console.log('??????');
					}
				}) 
			}		
		})
	})
	
	//?????? ?????? ??? ?????? ?????????
	$('.modal').on('hidden.bs.modal', function(e){
		$(this).find('form')[0].reset();
	})
		
	</script>

	<c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>

</body>

</html>
