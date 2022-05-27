<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
  </style>
</head>

<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	
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
                                <div class="card-content">
                                    <div class="card-body">
                                        <h6 class="card-text" id="ymd"></h6>
                                        <h1 class="card-text" id="clock"></h1>
                                        <h6 class="card-text" id="aTime">출근시간:</h6>
                                        <h6 class="card-text" id="lTime">퇴근시간:</h6>
                                        <h6 class="card-text" id="wTime"></h6>
                                    </div>
                                </div>
                                <div class="card-footer d-flex justify-content-between">
                                    <button class="btn btn-primary btn" id="plus">출근하기</button>
                                    <button class="btn btn-danger btn" id="minus">퇴근하기</button>
                                </div>
                            </div>
                            
                        </div>
                        <div class="col-xl-9 col-md-9 col-sm-9">
                            <div class="card">
                                <div class="card-group">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <h4 class="card-title">총연차</h4>
                                            <h1 class="card-text">0</h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-content">
                                       
                                        <div class="card-body">
                                            <h4 class="card-title">사용연차</h4>
                                            <h1 class="card-text">0</h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <h4 class="card-title">잔여연차</h4>
                                            <h1 class="card-text">0</h1>
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
                            <h4 class="section-title text-uppercase">월간현황</h4>
                        </div>
                    </div>
                    <div class="row match-height">
                        <div class="col-12">
                            <div class="card-group">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="card-body">
                                            <p class="card-text">
                                                This card has supporting text below as a natural lead-in to additional
                                                content.</p>
                                            <small class="text-muted">Last updated 3 mins ago</small>
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
		$(function(){
			
			getClock();
			setInterval(getClock, 1000);
			selectReplyList();
					
			$("#plus").on('click', function() { 
				
				let val = $("#clock").text();
				$.ajax({
					url:"insertAtime",
					type:"post",
					success:function(result){
						
						if(result == "1") {
							$("#aTime").text("출근시간 : "+val);
							getClock();
							setInterval(getClock, 1000);
							selectReplyList();
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
						
						if(result == "1") {
							$("#LTime").text("퇴근시간: "+val);
							getClock();
							setInterval(getClock, 1000);
							selectReplyList();
						}

					},error:function(){
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
		
		function selectReplyList(){
			$.ajax({
				url:"selectAttendance",
				type:"post",
				success:function(result){
					
					if(result == null) {

					} else {
						$("#aTime").text("출근시간 : "+result.aAtime.substr(10,9))
						$("#plus").attr("disabled", true);
						$("#lTime").text("퇴근시간 : "+result.aLtime.substr(10,9))
					}
				},
				error:function(){
					console.log("출퇴근 시간 ajax 통신 실패");
				}
			});
				
		}

	</script>

</body>

</html>