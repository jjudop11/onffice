<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
   	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <style>
	body{
	    background: #f5f5f5;
	    margin-top:20px;
	}
	
	.ui-w-80 {
	    width: 100px !important;
	    height: auto;
	}
	
	.btn-default {
	    border-color: rgba(24,28,33,0.1);
	    background: rgba(0,0,0,0);
	    color: #4E5155;
	}
	
	label.btn {
	    margin-bottom: 0;
	}
	
	.btn-outline-primary {
	    border-color: #26B4FF;
	    background: transparent;
	    color: #26B4FF;
	}
	
	.btn {
	    cursor: pointer;
	}
	
	.text-light {
	    color: #babbbc !important;
	}
	
	.btn-facebook {
	    border-color: rgba(0,0,0,0);
	    background: #3B5998;
	    color: #fff;
	}
	
	.btn-instagram {
	    border-color: rgba(0,0,0,0);
	    background: #000;
	    color: #fff;
	}
	
	.card {
	    background-clip: padding-box;
	    box-shadow: 0 1px 4px rgba(24,28,33,0.012);
	}
	
	.row-bordered {
	    overflow: hidden;
	}
	
	.account-settings-fileinput {
	    position: absolute;
	    visibility: hidden;
	    width: 1px;
	    height: 1px;
	    opacity: 0;
	}
	
	.account-settings-links .list-group-item.active {
	    font-weight: bold !important;
	}
	html:not(.dark-style) .account-settings-links .list-group-item.active {
	    background: transparent !important;
	}
	.account-settings-multiselect ~ .select2-container {
	    width: 100% !important;
	}
	.light-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24, 28, 33, 0.03) !important;
	}
	.light-style .account-settings-links .list-group-item.active {
	    color: #4e5155 !important;
	}
	.material-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24, 28, 33, 0.03) !important;
	}
	.material-style .account-settings-links .list-group-item.active {
	    color: #4e5155 !important;
	}
	.dark-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(255, 255, 255, 0.03) !important;
	}
	.dark-style .account-settings-links .list-group-item.active {
	    color: #fff !important;
	}
	.light-style .account-settings-links .list-group-item.active {
	    color: #4E5155 !important;
	}
	.light-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24,28,33,0.03) !important;
	}
	#final, #postcodify_search_button {
		float: right;
	}
	
	#pagingArea{width:fit-content;margin:auto;}
	
	#imgThum {postiion : relative;}
	#imgreset {
		position: absolute;
  		top: 80px;
  		left : 100px; 
  	}
	
	td, .card-body1 {
	  text-align: center;
	}
	
	.pagination {
	  width: 100px;
	  margin-left: auto;
	  margin-right: auto;
	}
  </style>
</head>

<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	<jsp:include page="../common/alarm.jsp"/>
	
    <div id="app">        
        <div id="main">
        	<header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <div class="page-title mb-3">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>근태현황</h3>
                        </div>
                    </div>
                </div>
                
                <section id="content-types">
                    <div class="row">
                        <div class="col-xl-3 col-md-3 col-sm-3">
                            <div class="card">
                                <div class="card-content ">
                                    <div class="card-body">
                                        <h6 class="card-text" id="ymd"></h6>
                                        <h1 class="card-text" id="clock"></h1>
                                        <br>
                                        <h6 class="card-text">주간근무시간</h6>
                                        <div class="progress progress-primary mt-4 mb-2">
		                                <div class="progress-bar progress-label" role="progressbar" style="width: 0%"
		                                    aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="bar"></div>
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
                        <div class="col-xl-9 col-md-9 col-sm-9 mb-3">
                            <div class="card">
                                <div class="card-group mt-3">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body1 mt-4">
                                            <h4 class="card-title">이번달 출근일</h4>
                                             <br>
                                            <h1 class="card-text" id="aCount">0</h1>
                                        </div>
                                    </div>
                                    <br>
                                </div>
                                <div class="card">
                                    <div class="card-content">    
                                        <div class="card-body1 mt-4">
                                            <h4 class="card-title">이번달 정상출근</h4>
                                             <br>
                                            <h1 class="card-text" id="nCount">0</h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body1">
                                            <h4 class="card-title mt-4">이번달 지각</h4>
                                             <br>
                                            <h1 class="card-text" id="lCount">0</h1>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mt-5">
                            <div class="card">
                                <div class="card-group mt-3">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body1 mt-4">
                                            <h4 class="card-title " >이번주 누적근무시간</h4>
                                             <br>
                                            <h1 class="card-text" id="attendanceW">0</h1>
                                        </div>
                                    </div>  <br>
                                </div>
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body1 mt-4">
                                            <h4 class="card-title">이번주 초과근무시간</h4>
                                             <br>
                                            <h1 class="card-text" id="overW">0</h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body1 mt-4">
                                            <h4 class="card-title">이번주 잔여근무시간</h4>
                                             <br>
                                            <h1 class="card-text" id="minusW">0</h1>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    </div>
                    
                    <div class="row">
                        
                    </div>
                            
                    <div class="row match-height">
                        <div class="col-12 mt-3 mb-1">
                            <h4 class="section-title text-uppercase">주간근태현황</h4>
                        </div>
                    </div>
                    <div class="row match-height">
                        <div class="col-12">
                            <div class="card-group">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body">
                                        	<table id="attendanceList" class="table table-borderess mb-0">
                                        		<thead>
								                    <tr>
										               <td style="width:20%"><h4>기준일</h4></td>
										                <td><h4>출근시간</h4></td>
										                <td><h4>퇴근시간</h4></td>
										                <td><h4>근무시간</h4></td>
										                <td><h4>상태</h4></td>
								                     </tr>
								                 </thead>
								                 <tbody id="here">
								                 </tbody>
                                        	</table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row match-height">
                        <div class="col-12 mt-5 mb-1">
                            <h4 class="section-title text-uppercase">월별근태현황</h4>
                        </div>
                    </div>
                    <div class="row match-height">
                        <div class="col-12">
                            <div class="card-group">
                                <div class="card">
                                    <div class="card-content">
                                        <canvas class="card-body" id="line-chart">
                                        
                                        </canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row match-height">
                        <div class="col-12 mt-5 mb-1">
                            <h4 class="section-title text-uppercase">나의근태현황검색</h4>
                        </div>
                    </div>
                    <div class="row match-height">
                        <div class="col-12">
                        	<div class="col-6" > 
								<div id="datePicker-div" class="mt-3 mb-3">
								<form id="searchAList" action="searchAList" method="get" >
										<label class="col-xs-4" for="start">시작일</label> &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; <label class="col-xs-4" for="edit-start">종료일</label><br>
										<input type="date" id="start" class="start">  &nbsp; ~ &nbsp;
										<input type="date" id="end" class="end"> &nbsp;
										<button type="button" class="btn btn-primary" id="search">조회</button>
								</form>
								</div>
                             </div>
                            <div class="card-group">
                                <div class="card">
                                    <div class="card-content">    
                                       <div class="card-body">
                                        	<table id="searchAttendanceList" class="table table-borderess mb-0">
                                        		<thead>
								                    <tr>
										               <td style="width:20%"><h4>기준일</h4></td>
										                <td><h4>출근시간</h4></td>
										                <td><h4>퇴근시간</h4></td>
										                <td><h4>근무시간</h4></td>
										                <td><h4>상태</h4></td>
								                     </tr>
								                 </thead>
								                 <tbody id="here2">
								                 </tbody>
                                        	</table>
                                        	<div id="pagingArea2" class="mt-3">
												                
												              
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
			monthCount();
			selectAttendance();
			selectAttendanceW();
			selectAttendanceM();
			searchAttendanceList();
			connectWs();
			
			
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
							selectAttendanceM();
							
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
							selectAttendanceM();
							
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
		
		function searchAttendanceList(pageNum){ 
				
			$("#search").on('click', function() {
				
				let start = $("#start").val();
				let end = $("#end").val();
				
				const d = new Date();
				let year = d.getFullYear();
			 	let month = d.getMonth()+1;
			    let date = d.getDate();
				let today =  moment(year +"-"+ month +"-"+ date).format('YYYY-MM-DD');
				
				if (start > end) {
		            alert('종료일이 시작일 보다 앞설 수 없습니다.');
		        }

				if (start > today) {
		            alert('검색기간이 오늘보다 뒤일 수 없습니다.');
		        }
				
				$.ajax({
					url:"searchAttendanceList",
					type:"post",
					data:{
						page: pageNum,
						start: start,
						end: end
					},
					success:function(result){
						
						let v= '';
						let b = '';
			            let page = result.page; // 현재페이지
			            let startpage = result.startpage; // 시작페이지
			            let endpage = result.endpage; // 끝페이지
			            let maxpage = result.maxpage; // 최대페이지
			            
						for(let i in result.list) {

							if(result.list[i].altime == null) {
								v += 
									'<tr>'+
										'<td><h6>'+result.list[i].aentDate+'</h6></td>'+
						                '<td><h6>'+result.list[i].aatime.substr(11,8)+'</h6></td>'+
						                '<td><h6></h6></td>'+
						                '<td><h6></h6></td>'+
						                '<td><h6></h6></td>'+
			                      	'</tr>';
							} else {
								v += 
									'<tr>'+
										'<td><h6>'+result.list[i].aentDate+'</h6></td>'+
						                '<td><h6>'+result.list[i].aatime.substr(11,8)+'</h6></td>'+
						                '<td><h6>'+result.list[i].altime.substr(11,8)+'</h6></td>'+
						                '<td><h6>'+result.list[i].awtime+'</h6></td>'+
						                '<td><h6>'+result.list[i].astate+'</h6></td>'+
			                      	'</tr>';
							}
							
						}
						$("#here2").html(v);
					
						
						b += '<ul class="pagination">';
						if(page != 1) {
							b += '<li class="page-item"><a class="page-link" onclick="searchAttendanceList('+ parseInt(page-1) + ');" class="page-btn">Previous</a></li>'
						} else {
							b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
						}
	                	
	                	for(var num = startpage; num <= endpage; num++) {
	                		if(num != page) {
	                			b += '<li class="page-item"><a class="page-link" onclick="searchAttendanceList('+ num + ');" class="page-btn">'+num+'</a></li>'
	                		} else {
	                			b += '<li class="page-item disabled"><a class="page-link" href="">'+num+'</a></li>'
	                		}
	                	}
	                    
	                	if(page != maxpage) {
							b += '<li class="page-item"><a class="page-link" onclick="searchAttendanceList('+ parseInt(page+1) + ');" class="page-btn">Next</a></li>'
						} else {
							b += '<li class="page-item disabled"><a class="page-link" href="">Next</a></li>'
						}
	                    
	                	b += '</ul>';
	                	
						$("#pagingArea2").html(b);
						// 페이징 클릭하면 조회버튼 자동 클릭
						$(".page-link").on('click', function() {
							$("#search").click();
						})

					},error:function(){
						console.log("검색한 근무기록 조회 ajax 통신 실패");
					}
					
				});
			})
		}

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
		
		function monthCount(){
			$.ajax({
				url:"monthCount",
				type:"post",
				success:function(result){
					console.log("==="+result)
					if(result != null) {
						$("#aCount").text(result.aCount) // 총출근횟수
						$("#nCount").text(result.wCount) // 정상출근횟수
						$("#lCount").text(result.lCount) // 지각횟수
					} 
				},
				error:function(){
					console.log("이번달 출근 횟수 ajax 통신 실패");
				}
			});
				
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
				},
				error:function(){
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
						
						$("#attendanceW").text(list[0].allWtime);
	
						let h = list[i].allWtime.substr(0,2);
						let m = list[i].allWtime.substr(3,2);
						let s = list[i].allWtime.substr(6,2);
						
						if(parseInt(40-h) < 0) {
							$("#overW").text(String(parseInt(h-40)).padStart(2,"0") +":"+ m +":" + s);
						} else {
							$("#overW").text("00:00:00");
						}
						
						if(parseInt(40-h) < 0) {
							$("#minusW").text("00:00:00");
						} else {
							$("#minusW").text(String(parseInt(40-h-1)).padStart(2,"0") +":"+ String(parseInt(60-m-1)).padStart(2,"0")+":" + String(parseInt(60-s)).padStart(2,"0"));
						}

						if(list[i].aLtime == null) {
							
							v += 
								'<tr>'+
									'<td><h6>'+list[i].aEntDate+'</h6></td>'+
					                '<td><h6>'+list[i].aAtime.substr(11,8)+'</h6></td>'+
					                '<td><h6></h6></td>'+
					                '<td><h6></h6></td>'+
					                '<td><h6></h6></td>'+
		                      	'</tr>';
						} else {
							
							v += 
								'<tr>'+
									'<td><h6>'+list[i].aEntDate+'</h6></td>'+
					                '<td><h6>'+list[i].aAtime.substr(11,8)+'</h6></td>'+
					                '<td><h6>'+list[i].aLtime.substr(11,8)+'</h6></td>'+
					                '<td><h6>'+list[i].aWtime+'</h6></td>'+
					                '<td><h6>'+list[i].aState+'</h6></td>'+
		                      	'</tr>';
						}
						
					}

					$("#here").html(v);

					let t = parseInt(list[0].allWtime.replace(":", "").substr(0, 2)) / 40 * 100
					
					if(Math.round(t) >= 100) {
						$("#bar").attr("aria-valuenow", "100");
						$("#bar").attr("style", "width:100%");
					} else {
						$("#bar").attr("aria-valuenow", Math.round(t));
						$("#bar").attr("style", "width: "+Math.round(t)+"%");
					}
					
				},
				error:function(){
					console.log("이번주 근무 시간 ajax 통신 실패");
				}
			});
				
		}
		
		function selectAttendanceM(){ // 올해 월별 근무시간 평균
				
			let mList = [];
			let vList = [];
			let mList2 = [];
			let vList2 = [];
			
				$.ajax({
					url:"selectAttendanceM",
					type:"post",
					success:function(list){
						
						for(let i in list) {
							mList.push(list[i].aEntDate);
							if(list[i].aWtime.length >= 9) {
								vList.push(list[i].aWtime.substr(0, 3));
							} else {
								vList.push(list[i].aWtime.substr(0, 2));
							}
							
						}

						$.ajax({
				
							url:"selectAttendanceAllM",
							type:"post",
							success:function(list){
			
								for(let i in list) {
									mList2.push(list[i].aEntDate);
									if(list[i].aWtime.length >= 9) { 
										vList2.push(list[i].aWtime.substr(0, 3));
									} else {
										vList2.push(list[i].aWtime.substr(0, 2));
									}
									
								}

								
								new Chart(document.getElementById("line-chart"), {
									type: 'bar',
									data: {
					    		    	labels: mList, 
					    		    	datasets: [{ 
					    		    	    data: vList, 
					    		    	    barThickness: 30,
					    		    	    label: "나의 월별 총 근무시간",
					    		    	    backgroundColor: "#3cba9f",
					    		    	    fill: false
					    		    	  }, {
					    		    		data: vList2, 
					    		    		barThickness: 30,
					    		    	    label: "전체 직원 월별 총 근무시간",
					    		    	    backgroundColor: "#3e95cd",
					    		    	    fill: false  
					    		    	  }
					    		    	]
					    		    }
					    		    
								}); // chart 끝
							},
							error:function(){
								console.log("이번달 전체사원 평균근무시간 ajax 통신 실패");
							}
						});
						
					},
					error:function(){
						console.log("이번달 평균근무시간 ajax 통신 실패");
					}
				});
					
			}
		


	</script>
	<script src="resources/full/js/moment.min.js"></script>
</body>

</html>