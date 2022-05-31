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
				                                            <h1 class="card-text">0</h1>
				                                        </div>
				                                    </div>
				                                    <br>
				                                </div>
				                                <div class="card">
				                                    <div class="card-content">    
				                                        <div class="card-body1 mt-4">
				                                            <h4 class="card-title">출근사원</h4>
				                                             <br>
				                                            <h1 class="card-text">0</h1>
				                                        </div>
				                                    </div>
				                                </div>
				                                <div class="card">
				                                    <div class="card-content">
				                                        <div class="card-body1">
				                                            <h4 class="card-title mt-4">지각사원</h4>
				                                             <br>
				                                            <h1 class="card-text">0</h1>
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
														               <td style="width:20%"><h4>사원번호</h4></td>
														                <td><h4>사원명</h4></td>
														                <td><h4>직급명</h4></td>
														                <td><h4>부서명</h4></td>
														                <td><h4>출근상태</h4></td>
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
    		$("#attendanceList tbody tr").click(function(){
    			let check = $(this).children().eq(0).text();
    			console.log();
    		});
    	});
    </script>
    
</body>

</html>