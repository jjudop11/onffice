<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		.tooltip {
	  position: relative;
	  display: block;
	}
	
	.tooltip .tooltiptext {
	  visibility: hidden;       /* 이벤트가 없으면 툴팁 영역을 숨김 */
	  width: 120px;             /* 툴팁 영역의 넓이를 설정 */
	  background-color: black;
	  color: #fff;
	  text-align: center;
	  border-radius: 6px;
	  padding: 5px 0;
	
	  position: absolute;       /* 절대 위치를 사용 */
	  z-index: 1;
	}
	
	.tooltip:hover .tooltiptext {
	  visibility: visible;      /* hover 이벤트 발생시 영역을 보여줌 */
	}
	</style>
</head>

<body>

	<jsp:include page="common/menubar.jsp"/>
	<jsp:include page="common/alarm.jsp"/>
	
    <div id="app">
        <div id="main">
        	<div class="page-content">
                <section class="row">
                    <div class="col-12 col-lg-9">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h2>공지사항</h2>
                                    </div>
                                    <div class="card-body">
                                        <div id="board">
								            <table id="boardList" class="table table-hover" align="center">
								                <thead>
								                  <tr>
								                    <th>제목</th>
								                    <th>작성일</th>
								                  </tr>
								                </thead>
								                <tbody id="here">
								                	<c:forEach items="${ list }" var="n">
									                    <tr>
									                    	<td style="display: none;">${ n.c_No }</td>
									                    	<td style="display: none;">${ n.no_Num }</td>
									                    	<td style="width:80%;" onclick="location.href='detailNotice.do?no_Num=${ n.no_Num }'">
									                    	<c:if test="${ n.no_Important == 'Y' }">
												            	<a class="badge bg-danger">중요</a>
												            </c:if>${ n.no_Title }</td>
									                        <td> <fmt:formatDate value="${ n.no_Date }" pattern = "MM-dd" /></td>
									                    </tr>
								                    </c:forEach>
								                </tbody>
								            </table>
							        	</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 col-xl-4 col-md-3">
                                <div class="card">
		                       	 <div class="card-content ">
		                           <div class="card-body">
		                              <h6 class="card-text" id="ymd"></h6>
		                              <h2 class="card-text" id="clock"></h2>
		                              <h6 class="card-text">주간근무시간</h6>
		                              <div class="progress progress-primary mt-4">
		                         	  <div class="progress-bar progress-label" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="bar"></div>
		                      		  </div>
		                      		  <br>
		                              <h6 class="card-text" id="aTime">출근시간:</h6>
		                              <h6 class="card-text" id="lTime">퇴근시간:</h6>
		                              <h6 class="card-text" id="wTime">근무시간</h6>
		                          </div>
		                        </div>
		                         <div class="card-footer d-flex justify-content-between">
		                           <button class="btn btn-primary btn" id="plus">출근하기</button>
		                           <button class="btn btn-danger btn" id="minus">퇴근하기</button>
		                         </div>
		                	 </div>
                            </div>
                            <div class="col-12 col-xl-8 col-md-9">
                                <div class="card">
                                    <div class="card-header">
                                        <h3>금일회의현황</h3>
                                    </div>
                                    <div class="card-body">
                                        <div id="div-table">
											<table class="table table-bordered" id="roomReserveTable">
												<thead>
													<tr>
														<th colspan="2"></th>
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
														<tr id="roomReservetr">
															<th colspan="2">${ r.roomName }</th>
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
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-3">
                      <div class="card">
                         <div class="card-body text-center">
                            <div class="avatar mt-3">
                                <img src="${ pageContext.servletContext.contextPath }/resources/id_pictures/${sessionScope.loginUser.PName}" style="width:100px; height:100px;"/>
                             </div>
                         </div>

                         <div class="name text-center">   
                         	<table align="center" class="mt-4 mb-5">
                         		<tr>
                         			<th><h5 class="font-bold"><i class="bi bi-person-circle"></i></h5></th>
                         			<th><h5 class="font-bold">&nbsp; ${ sessionScope.loginUser.MName } ${ sessionScope.loginUser.JName }</h5>
                         			</th>
                         		</tr>
                         		<tr>
                         			<th><h5 class="font-bold"><i class="bi bi-wallet"></i></h5></th>
                         			<th><h5 class="font-bold">&nbsp; ${ sessionScope.loginUser.DName }</h5>
                         			</th>
                         		</tr>
                         		<tr>
                         			<th><h5 class="font-bold"><i class="bi bi-envelope"></i></h5></th>
                         			<th><h5 class="font-bold">&nbsp; ${ sessionScope.loginUser.MEmail }</h5>
                         			</th>
                         		</tr>
                         		<tr>
                         			<th><h5 class="font-bold"><i class="bi bi-telephone"></i></h5></th>
                         			<th><h5 class="font-bold">&nbsp; ${ sessionScope.loginUser.MPhone }</h5>
                         			</th>
                         		</tr>
                         	</table>       	 	
                      	 </div>               
                	 </div>
                	 
                       <div class="card mt-4">
                       	 <div class="card-header">
                             <h3>설문게시판</h3>
                         </div>
                       	 <div class="card-content">
                           <div class="card-body ">
                             <table class="list_table" style=" border-bottom:1px solid rgb(159, 160, 167); height:100%;">
								<thead>
									<tr style="font-size:12px; padding:0 0 10px 10px; border-bottom:1px solid rgb(159, 160, 167);">
										<th style="width:450px">설문 제목</th>
										<th style="width:300px">설문 기간</th>
									</tr>
								</thead>
								<tbody class="tbody_list" >
								
								</tbody>
							</table>
                          </div>
                        </div>
                	 </div>
                     </div>
                </section>
            </div>
            
			
			<!-- 풋터 -->
            <footer>
                <div class="footer clearfix mb-0 text-muted">
                    <div class="float-start">
                        <p>2022 &copy; 같이좀해조</p>
                    </div>
                    <div class="float-end">
                        <p>Crafted with <span class="text-danger"><i class="bi bi-heart"></i></span> by 
                        <a href="">김영진</a> /
                        <a href="">박주연</a> /
                        <a href="">이상화</a> /
                        <a href="">현주아</a></p>
                    </div>
                </div>
            </footer>
            <!-- app main -->
        </div>
    </div>

    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
	<script>
		
		var socket = null;

		$(function(){
			getClock();
			setInterval(getClock, 1000);
			selectAttendance();
			selectAttendanceW();
			reservedRoomList();
			selectSurveyBoard(1);

			$("#plus").on('click', function() { 
				
				let val = $("#clock").text();
				$.ajax({
					url:"insertAtime",
					type:"post",
					success:function(result){
				
						if(result != null) {
							getClock();
							setInterval(getClock, 1000);
							selectAttendance();
							selectAttendanceW();
							reservedRoomList();
							
							let socketMsg = "출근," + result.mName + "," + result.jName + "," + result.dName;
		        			console.log(socketMsg);
		        			socket.send(socketMsg);
						}
						

					},error:function(){
						console.log("출근 등록 ajax 통신 실패");
					}
					
				});
			})
					
			$("#minus").on('click', function() { 
			
				let val = $("#clock").text();
		
				$.ajax({
					url:"insertLtime",
					type:"post",
					success:function(result){
						
						if(result != null) {
							getClock();
							setInterval(getClock, 1000);
							selectAttendance();
							selectAttendanceW();
							reservedRoomList();
							
							let socketMsg = "퇴근," + result.mName + "," + result.jName + "," + result.dName;
		        			console.log(socketMsg);
		        			socket.send(socketMsg);
						}
						
	        			
		           		
					},error:function(){
						alert("출근 먼저 등록해주세요")
						console.log("퇴근 등록 ajax 통신 실패");
					}
					
				});
			
			})
		})
		
		function getClock(){
			  const d = new Date();
			  let h = String(d.getHours()).padStart(2,"0");
			  let m = String(d.getMinutes()).padStart(2,"0");
			  let s = String(d.getSeconds()).padStart(2,"0");
			  
			  let year = d.getFullYear();
			  let month = d.getMonth()+1;
			  let date = d.getDate();
			  let week = ['일', '월', '화', '수', '목', '금', '토'];
			  $("#clock").text(h+":"+m+":"+s);
			  $("#ymd").text(year+"년 "+month+"월 "+date +"일 ("+week[d.getDay()]+")");
		}
		
		function selectAttendance(){
			
			$.ajax({
				url:"selectAttendance",
				type:"post",
				success:function(result){
				
					if(result != null && result.aAtime != null) {
						$("#aTime").text("출근시간 : "+result.aAtime.substr(10,9)+" / "+result.aState)
						$("#plus").attr("disabled", true);
						
						if(result.aLtime != null) {
							$("#lTime").text("퇴근시간 : "+result.aLtime.substr(10,9))
							$("#wTime").text("오늘근무시간 : "+result.aWtime);
						}
					} 

				}, error:function(){
					console.log("출퇴근 시간 ajax 통신 실패");
				}
			});
				
		}
		
		function selectAttendanceW(){ // 이번주 근무시간 
			
			$.ajax({
				url:"selectAttendanceW",
				type:"post",
				success:function(list){
					
					let v = "";
					for(let i in list) {

						let t = parseInt(list[0].allWtime.replace(":", "").substr(0, 2)) / 40 * 100
						
						if(Math.round(t) >= 100) {
							$("#bar").attr("aria-valuenow", "100");
							$("#bar").attr("style", "width:100%");
						} else {
							$("#bar").attr("aria-valuenow", Math.round(t));
							$("#bar").attr("style", "width: "+Math.round(t)+"%");
						}
					}
					
				},
				error:function(){
					console.log("이번주 근무 시간 ajax 통신 실패");
				}
			});
				
		}
		
		function reservedRoomList() {
			
			const today = new Date();
			let year = today.getFullYear();
		  	let month = String(today.getMonth()+1).padStart(2,"0");
		  	let date = today.getDate();

			let day =year+"-"+month+"-"+date;

			$.ajax({
				url : "reservedRoomList.do",
				data : {
					date : day
				},
				type : "post",
				
				//한글 깨짐 해결하기
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data, statusText, jqXHR) {
					
					const obj = JSON.parse(data);
					
					console.log(data)
					console.log(obj)
					
					let offset = 0;

					$("#roomReserveTable #roomReservetr th").css("background", "");
					
					for (const room of obj.rooms){					
						for (const time of room.times){
							for (let i = time[0]; i < time[1]; i++){
								$("#roomReserveTable #roomReservetr th").eq(i + offset -1).css("background", "#2146b5");
							}
						}
						
						offset += 27;
					}
					
					$("#roomReserveTable #roomReservetr th").on('click', function() { 
							
						let title = $(this).siblings().eq(0).text() // 회의실명
						let time = $(this)[0].id // 클릭한 시간값
						
						$.ajax({
							url:"selectreservedRoom",
							type:"post",
							data:{
								title:title,
								time:time
							},
							success:function(result){
								console.log(result)
								var tag = document.getElementById(time); 
								tag.title = '회의내용 : '+ result.reserveTitle + '  주최자 : ' + result.mNo + ' '+result.reserveNo; 
								
							},
							error:function(data){
								console.log("회의실 정보 ajax 통신 실패");
							}
						});
						
					})
				},
				error : function(error) {
					alert("조회에 실패하였습니다.");
				}
			})
		}
		
	function selectSurveyBoard(num, pNum){
			
			$.ajax({
				
				url:"selectSBList",
				type:"post",
				data:{
					
					num:num,
					page:pNum
					
				},
				
				success:function(sbList){
					
					let val = "";
					
					$.each(sbList.list, function(i, sb){
	
						val += 
							'<tr class="go_detail" style="padding:10px 0 0 10px" onclick="goSurveyBoardDetail('+sb.sbNo+' , \''+ sb.sbAState +'\')">' +	
							"<td>"+ sb.sbTitle +"</td>" +
							"<td>"+ sb.sbStartDate +" ~ "+ sb.sbEndDate +"</td>" +				
							"</tr>"
					})
					
					$('.tbody_list').html(val);

				}
		
			})
			
	}
	
	function goSurveyBoardDetail(sbNo, sbAState){
		
		location.href="surveyBoardDetail?sbNo="+sbNo+"&sbAState=" + sbAState;
		
	}
		
	</script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</body>

</html>