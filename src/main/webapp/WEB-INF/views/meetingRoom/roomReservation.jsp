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

#startTime, #endTime {
	width: 220px;
	float: left;
}

#wiggle {
	float: left;
	margin-left: 9.1px;
	margin-right: 9px;
}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />

	<div id="app">
		<div id="main">

			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i class="bi bi-justify fs-3"></i></a>
			</header>

			<div class="page-heading">
				<h3>????????? ??????</h3>
			</div>

			<div class="card">
				<div class="card-body">
					<section class="section">
						<div class="row" id="basic-table">
							<div class="col-12 col-md-6">

								<div class="card">
									<div class="card-content">
										<!-- ????????? ?????? -->
										<div class="card-body">
											<div class="card-body-room">

												<div id="datePicker-div">
													<input type="date" id="datePicker" class="datepicker-form"
														value="${ today }">
												</div>

												<div>
													<button type="button" class="btn btn-primary"
														id="searchDateBtn">??????</button>
												</div>

												<div class="buttons" id="reserve-btn-div">
													<button type="button" class="btn btn-primary"
														id="reserveRoomBtn">??????</button>

													<div class="modal" id="myModal">
														<form name="insertRoom">
															<div class="modal-dialog">
																<div class="modal-content">

																	<div class="modal-header">
																		<h4 class="modal-title">????????? ??????</h4>
																		<button type="button" class="close"
																			data-dismiss="modal"></button>
																	</div>

																	<div class="modal-body" id="modal-body">


																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">?????????</label><br>
																			<input type="date" id="modal-datePicker"
																				class="datepicker-form" required>
																		</div>
																		<br>

																		<div class="form-reserveRoom" id="timeSelect">
																			<label for="label-reserveRoom" class="control-label">????????????</label>
																			<br> <select id="startTime" class="form-control">
																				<script>
																		          let hour = '';
																		          let min = '00';
	
																		          for (var i = 14; i < 42; i++) {
																		              hour = (Math.floor(i / 2));
	
																		              if (hour < 10) {
																		                  hour = '0' + hour;
																		              }
																		              if (i % 2 != 0) {
																		                  min = '30';
																		              } else {
																		            	  min = '00';
																		              }
																		            
																		              document.write('<option value=' + hour + ':' + min + '>'
																		                      + hour
																		                      + ':'
																		                      + min
																		                      + '</option>');
																		          }
																	          </script>
																			</select>

																			<div id="wiggle">~</div>

																			<select id="endTime" class="form-control">
																				<script>
																		          for (var i = 15; i < 43; i++) {
																		              hour = (Math.floor(i / 2));
	
																		              if (hour < 10) {
																		                  hour = '0' + hour;
																		              }
																		              if (i % 2 != 0) {
																		                  min = '30';
																		              } else {
																		            	  min = '00';
																		              }
																		                       
																		              document.write('<option value=' + hour + ':' + min + '>'
																		                      + hour
																		                      + ':'
																		                      + min
																		                      + '</option>');
																		          }
																	          </script>
																			</select>
																		</div>

																		<br> <br> <br>

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">????????????</label>

																			<select class="form-select" id="selectRoom"
																				name="selectRoom">
																				<c:forEach items="${ roomList }" var="r">
																					<option value="${ r.roomName }">${ r.roomName }</option>
																				</c:forEach>
																			</select>
																		</div>
																		<br>

																		<div class="form-reserveRoom">
																			<label for="basicInput">?????????</label> <input
																				type="text" class="form-control" id="reservetitle"
																				placeholder="?????? ????????? ??????????????????" required>
																		</div>

																		<br>

																		<div class="form-reserveRoom">
																			<label for="label-reserveRoom" class="control-label">?????????</label>
																			<br> <input type="text" class="form-control"
																				id="reserveUser" value="${ userName } ${ userJob }"
																				readonly>
																		</div>

																	</div>

																	<div class="modal-footer">
																		<input type="submit" class="btn btn-primary"
																			id="reserveRoom" onclick="reserveRoom()" value="??????">
																		<!-- data-dismiss="modal" -->
																		<button type="button" id="btnCloseModal"
																			class="btn btn-danger">??????</button>
																	</div>
																</div>
															</div>
														</form>
													</div>
												</div>

												<!-- ?????? ????????? -->
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
																<tr data-roomno="${r.roomNo}">
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

											<br> <br>

											<form id="hiddenForm" action="reservationDetails.do"
												method="post">
												<div id="hiddenDiv">
													<input type="hidden" name="dateD" id="dateD" value="">
													<input type="hidden" name="roomNoD" id="roomNoD" value="">
													<input type="hidden" name="startTimeD" id="startTimeD"
														value="">
												</div>
											</form>

											<!-- ?????? ????????? ?????? -->
											<div id="meetingroomList">
												<h3 id="roomSetting">????????? ??????</h3>
												<button class="btn btn-primary" id="roomSetting-button"
													onclick="location.href='reserve-roomSetting.do'">??????</button>
												<br> <br>
												<div class="table-responsive">
													<table class="table table-bordered mb-0"
														id="meetingroomView">
														<thead id="meetingroomView-head">
															<tr>
																<th>No</th>
																<th>?????????</th>
																<th>????????????</th>
																<th>??????</th>
															</tr>
														</thead>
														<tbody>
															<!-- ???????????? ????????? ????????? ????????? ????????? ????????? ????????? -->
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
	
		//?????? ????????? value??? ????????? ?????? ?????? ??????
		window.onload = function(){
			$('#searchDateBtn').trigger('click');
		}
		
		//????????? ?????? ????????? ?????????
		$(function() {
			$('#searchDateBtn').click(function() {
				let date = $('#datePicker').val();
				
				$.ajax({
					url : 'reservedRoomList.do',
					data : {
						date : date
					},
					type : 'post',
					success : function(data) {		
						const obj = JSON.parse(data);
						const cells = $('#roomReserveTable tbody th');

						let offset = 0;

						//?????? ????????? ????????? ?????? ???????????? ???????????? ?????????, ??????????????? ??????????????? ????????? ???????????? ????????? ?????????
						cells.css('background', '');
						cells.removeData('st-time');
						cells.removeData('ed-time');

						for (const room of obj.rooms){ 				//obj.rooms??? ????????? ???????????? ????????? ?????? ???				
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
									const item = cells.eq(i + offset + 1);

									item.css('background', '#2146b5'); 
									item.data('st-time', stTime);
									item.data('ed-time', edTime);
									item.prop('title', stTime + ' ~ ' + edTime)
								}
							}							
							offset += 29;
						}
					},
					error : function(error) {
						alert('????????? ?????????????????????.');
					}
				})				
			})
		})

		//????????????
		$(function() {
			$('#reserveRoom').click(function(e) {
				let date = $('#modal-datePicker').val();
				let startTime = $('#startTime').val();
				let endTime = $('#endTime').val();
				let selectRoom = $('#selectRoom').val();
				let title = $('#reservetitle').val();
					
				if(date.length == 0){
					alert('????????? ??????????????????.');
					$('#modal-datePicker').focus();
					return false;
					
				}else if(title.length == 0){
					alert('???????????? ??????????????????.');
					$('#reservetitle').focus();
					return false;
					
				}else{
					$.ajax({
						url: 'reserveRoom.do',
						data: {
							date : date,
							startTime : startTime,
							endTime : endTime,
							selectRoom : selectRoom,
							title: title
						},
						type: 'post',	
						success: function(result){
							if(result > 0){
								alert('????????? ?????????????????????.');
								$('#searchDateBtn').trigger('click');
								
							}else if(result == -1){
								alert('?????? ????????? ???????????????.');
							}		
						},
						error: function(error){
							alert('????????? ?????????????????????. ??????????????? ??????????????????.');
						}
					})
				}					
				$('#myModal').modal('hide');
				e.preventDefault(); 
			})
		})
		
		$('#reserveRoomBtn').click(function(e) {
			//?????? ??????
			$('#myModal').modal('toggle');
		})
		
		$('#btnCloseModal').click(function(e) {
			//???????????? ?????? ??????. ?????? ???????????? ????????? ??????.
			$('#myModal').modal('hide');
		})

		//???????????????????????? ??????????????? ?????? ??? ??????
		$(function(){
			const fn = function(){			
				let startTime = $('#startTime').val();
				let endTime = $('#endTime').val();
				
				$.ajax({
					url: 'timeCheck.do',
					data: {
						startTime: startTime,
						endTime: endTime						
					},
					type: 'post',
					success:function(result){
						if(result > 0){
							console.log('OK');
							$('#reserveRoom').attr('disabled', false);
							
						}else if(result == 0){
							alert('??????????????? ??????????????? ?????? ??? ????????????.');
							//return false;
							$('#reserveRoom').attr('disabled', true);
							
						}else{
							alert('??????????????? ?????????????????? ?????? ??? ????????????.');
							//return false;
							$('#reserveRoom').attr('disabled', true);
						}
					},
					error: function(){
						console.log('?????? ??????');
					}
				})
			};

			$('#startTime').on('change', fn); // ???????????? ????????? ????????? ??????
			$('#endTime').on('change', fn); // ???????????? ?????????
			//$('#reserveRoom').on('click', fn); //???????????? ????????? 
		}) 
				
		//?????? ????????? ??????
		$(function(){
			$('#roomReserveTable tbody th').click(function(){
				const item = $(this);
				const id = item.attr('id');
				const roomno = item.parent().data('roomno');
				const stTime = item.data('st-time');
				const edTime = item.data('ed-time');
		
				const date = $('#datePicker').val();
				
				if (typeof id == 'undefined' || id == "" || id == null ||
				    typeof stTime == 'undefined' || stTime == "" || stTime == null ||
				    typeof edTime == 'undefined' || edTime == "" || edTime == null){
					
					return;
				}else{
					
					console.log(id, typeof(id))
					console.log(roomno, typeof(roomno))
					console.log(stTime, typeof(stTime))
					console.log(edTime, typeof(edTime))
					console.log(date, typeof(date))
									
					$('input[name=dateD]').attr('value', date);
					$('input[name=roomNoD]').attr('value', roomno);
					$('input[name=startTimeD]').attr('value', stTime);
					//console.log($("#dateD").val())
					//console.log($("#roomNoD").val())
					//console.log($("#startTimeD").val())		
					$('#hiddenForm').submit();
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
		<c:remove var="msg" scope="session" />
	</c:if>

</body>

</html>
