<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
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
	#final {
		float: right;
	}
	#pagingArea{width:fit-content;margin:auto;}
	
	td, .card-body1 {
	  text-align: center;
	}

  </style>
</head>

<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	
    <div id="app">        
        <div id="main">

            <div class="container light-style flex-grow-1 container-p-y">
		    <h2 class="font-weight-bold py-3 mb-4">
		      관리자페이지
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="managerpageForm">전체사원조회</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">비밀번호변경</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="jdForm">직급/부서관리</a>
		          	<a class="list-group-item list-group-item-action active" data-toggle="list" href="managerAttendance">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                 <section id="content-types">
				                    <div class="row">
				                        <div class="col-xl-12 col-md-12 col-sm-12 mb-3">
				                            <div class="card">
				                            	<h4 class="font-weight-bold mt-4">금일현황</h4>
				                                <div class="card-group mt-3">
				                                <div class="card">
				                                    <div class="card-content">
				                                        <div class="card-body1 mt-4">
				                                            <h4 class="card-title">전체사원</h4>
				                                             <br>
				                                            <h1 class="card-text" id="aCount">0</h1>
				                                        </div>
				                                    </div>
				                                    <br>
				                                </div>
				                                <div class="card">
				                                    <div class="card-content">    
				                                        <div class="card-body1 mt-4">
				                                            <h4 class="card-title">출근사원</h4>
				                                             <br>
				                                            <h1 class="card-text" id="wCount">0</h1>
				                                        </div>
				                                    </div>
				                                </div>
				                                <div class="card">
				                                    <div class="card-content">
				                                        <div class="card-body1">
				                                            <h4 class="card-title mt-4">지각사원</h4>
				                                             <br>
				                                            <h1 class="card-text" id="lCount">0</h1>
				                                        </div>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                        <div class="row match-height">
				                        <div class="col-12">
				                            <div class="card-group">
				                                <div class="card">
				                                    <div class="card-content">
				                                        <div class="card-body">
				                                        	<table id="attendanceList" class="table table-borderess mb-4">
				                                        		<thead>
												                    <tr>
														                <td><h5>사원번호</h5></td>
														                <td><h5>사원명</h5></td>
														                <td><h5>직급명</h5></td>
														                <td><h5>부서명</h5></td>
														                <td><h5>출근시간</h5></td>
														                <td><h5>퇴근시간</h5></td>
														                <td><h5>근무시간</h5></td>
														                <td><h5>출근상태</h5></td>
												                     </tr>
												                 </thead>
												                 <tbody id="here">
												                 	
												                 </tbody>
				                                        	</table>
				                                            <div id="pagingArea">
												                
												              
												            </div>
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
				                        <div class="col-12 mt-1 mb-1">
				                            <h4 class="section-title text-uppercase">주간근태현황</h4>
				                        </div>
				                    </div>
				                    <div class="row match-height">
				                        <div class="col-12">
				                            <div class="card-group">
				                                <div class="card">
				                                    <div class="card-content">
				                                        <div class="card-body" id="outer">
				                                        	<table id="attendanceList2" class="table table-borderess mb-4">
				                                        		<thead>
												                    <tr>
														               <td><h5>사원번호</h5></td>
														                <td><h5>사원명</h5></td>
														                <td><h5>직급명</h5></td>
														                <td><h5>부서명</h5></td>
														                <td><h5>총근무시간</h5></td>
												                     </tr>
												                 </thead>
												                 <tbody id="here2">
												                 </tbody>
				                                        	</table>
				                                        	<div id="pagingArea2" id="inner">

												            </div> 
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
				                </section>
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
   
    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
    
    <script>
    	$(function(){
    		
			selectAttendanceCount();
			selectAttendanceAllM();
			selectAttendanceCountList();
			selectAttendanceWList();

			$("#attendanceList tbody tr").click(function(){
    			let check = $(this).children().eq(0).text();
    			console.log();
    		});
				
					
		})
		
		function selectAttendanceCountList(pageNum){
    		
    		$.ajax({
				url:"selectAttendanceCountList",
				type:"post",
				data:{
					page: pageNum
				},
	
				success:function(result){
					
					let v= '';
					let b = '';
		            let page = result.page; // 현재페이지
		            let startpage = result.startpage; // 시작페이지
		            let endpage = result.endpage; // 끝페이지
		            let maxpage = result.maxpage; // 최대페이지
		        
		            for(var i in result.mList) {
		            	
		            	v += '<tr>'+
		                        '<td>'+result.mList[i].mno+'</td>'+
		                        '<td>'+result.mList[i].mname+'</td>'+
		                        '<td>'+result.mList[i].jname+'</td>'+
		                        '<td>'+result.mList[i].dname+'</td>';
		                        
		            	if(result.mList[i].aatime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].aatime+'</td>'
		            	}
		            	
		            	if(result.mList[i].altime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].altime+'</td>'
		            	}
		            	
		            	if(result.mList[i].awtime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].awtime+'</td>'
		            	}
		            	
		            	if(result.mList[i].astate == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].astate+'</td>'
		            	}
		            	v += '</tr>';
		            }
					$("#here").html(v);
					
					b += '<ul class="pagination">';
					if(page != 1) {
						b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceCountList('+ parseInt(page-1) + ');" class="page-btn">Previous</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
					}
                	
                	for(var num = startpage; num <= endpage; num++) {
                		if(num != page) {
                			b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceCountList('+ num + ');" class="page-btn">'+num+'</a></li>'
                		} else {
                			b += '<li class="page-item disabled"><a class="page-link" href="">'+num+'</a></li>'
                		}
                	}
                    
                	if(page != maxpage) {
						b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceCountList('+ parseInt(page+1) + ');" class="page-btn">Next</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Next</a></li>'
					}
                    
                	b += '</ul>';
                
					$("#pagingArea").html(b);

				},
				error:function(){
					console.log("금일 출퇴근 사원리스트 ajax 통신 실패");
				}
			});
    		
    	}
    	
		function selectAttendanceWList(pageNum){
    		
    		$.ajax({
				url:"selectAttendanceWList",
				type:"post",
				data:{
					page: pageNum
				},
	
				success:function(result){
					
					let v= '';
					let b = '';
		            let page = result.page; // 현재페이지
		            let startpage = result.startpage; // 시작페이지
		            let endpage = result.endpage; // 끝페이지
		            let maxpage = result.maxpage; // 최대페이지
		        
		            for(var i in result.mList) {
		            	
		            	v += '<tr>'+
		                        '<td>'+result.mList[i].mno+'</td>'+
		                        '<td>'+result.mList[i].mname+'</td>'+
		                        '<td>'+result.mList[i].jname+'</td>'+
		                        '<td>'+result.mList[i].dname+'</td>';
		                        
		            	if(result.mList[i].aatime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].aatime+'</td>'
		            	}
		            	
		            	if(result.mList[i].altime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].altime+'</td>'
		            	}
		            	
		            	if(result.mList[i].awtime == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].awtime+'</td>'
		            	}
		            	
		            	if(result.mList[i].astate == null) {
		            		v += '<td>'+'</td>';
		            	} else {
		            		v += '<td>'+result.mList[i].astate+'</td>'
		            	}
		            	v += '</tr>';
		            }
					$("#here2").html(v);
					
					b += '<ul class="pagination">';
					if(page != 1) {
						b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceWList('+ parseInt(page-1) + ');" class="page-btn">Previous</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
					}
                	
                	for(var num = startpage; num <= endpage; num++) {
                		if(num != page) {
                			b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceWList('+ num + ');" class="page-btn">'+num+'</a></li>'
                		} else {
                			b += '<li class="page-item disabled"><a class="page-link" href="">'+num+'</a></li>'
                		}
                	}
                    
                	if(page != maxpage) {
						b += '<li class="page-item"><a class="page-link" onclick="selectAttendanceWList('+ parseInt(page+1) + ');" class="page-btn">Next</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Next</a></li>'
					}
                    
                	b += '</ul>';
                	
					$("#pagingArea2").html(b);

				},
				error:function(){
					console.log("주간 출퇴근 사원리스트 ajax 통신 실패");
				}
			});
    		
    	}

		function selectAttendanceCount(){ // 출퇴근 사원 count
			$.ajax({
				url:"selectAttendanceCount",
				type:"post",
				success:function(result){
					
					$("#aCount").text(result.aCount)
					$("#wCount").text(result.wCount);
					$("#lCount").text(result.lCount);
					
				},
				error:function(){
					console.log("금일 출퇴근 사원수 ajax 통신 실패");
				}
			});
				
		}
    	
    	function selectAttendanceAllM(){ // 월별 모든사원 근무시간통계
    		
    		let mList = [];
			let vList = [];
			
			$.ajax({
				url:"selectAttendanceAllM",
				type:"post",
				success:function(list){

					for(let i in list) {
						mList.push(list[i].aEntDate);
						vList.push(list[i].aWtime.substr(0, 3));
					}
					console.log(mList)
					console.log(vList)
					
					
					new Chart(document.getElementById("line-chart"), {
						type: 'line',
						data: {
		    		    	labels: mList, 
		    		    	datasets: [{ 
		    		    	    data: vList, 
		    		    	    label: "전체 직원 월별 총 근무시간",
		    		    	    borderColor: "#3cba9f",
		    		    	    fill: false
		    		    	  }
		    		    	]
		    		    },
						
					}); // chart 끝
				},
				error:function(){
					console.log("금일 출퇴근 사원수 ajax 통신 실패");
				}
			});
				
		}
    	
		
		
    </script>
    
</body>

</html>