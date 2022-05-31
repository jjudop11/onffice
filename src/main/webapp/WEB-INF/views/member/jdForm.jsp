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
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="jdForm">직급/부서관리</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">

                                <div class="card-content mt-5">
                                    <!-- table hover -->
                                    <div class="table-responsive">
                                    	<div class="form-group mt-3">
				                       	    <select class="choices form-select" id="jd" name="jd" style="width:100px;">
				                       	       <c:if test ="${ set eq '1'}">
				                               <option value="1" selected>직급</option>
				                               <option value="2">부서</option>
				                               </c:if>
				                               <c:if test ="${ set eq '2'}">
				                               <option value="1">직급</option>
				                               <option value="2" selected>부서</option>
				                               </c:if>
				                           	</select>
				                         </div>
                                        <table id="jdList" class="table table-borderless mb-0" style="width:90%;"> <!--  -->
                                            <tbody id="here">	
                                            	<c:if test ="${ set eq '1'}">
	                                            	<c:forEach items="${ lists }" var="j" varStatus="index">
	                                                <tr>
		                                                <td style="width:15%;">${ index.count }</td>
		                                                <td style="width:65%;">${ j.JName }</td>
		                                                <td><button type="button" class="btn btn-danger" name="minus">삭제</button></td>
	                                            	</tr>
	                                            	</c:forEach>
	                                            	<tr>
	                                            	<td></td>
	                                            	<td><input type="text" class="form-control" placeholder="추가 직급명" id="job" name="job"></td>
	                                            	<td><button type="button" class="btn btn-primary" id="plus">추가</button></td>
	                                            	</tr>
                                            	</c:if>
                                            	
                                            	<c:if test ="${ set eq '2'}">
	                                            	<c:forEach items="${ lists }" var="d" varStatus="index">
	                                                <tr>
		                                                <td style="width:15%;">${ index.count }</td>
		                                                <td style="width:65%;">${ d.DName }</td>
		                                                <td><button type="button" class="btn btn-danger" name="minus">삭제</button></td>
	                                            	</tr>
	                                            	</c:forEach>
	                                            	<tr>
	                                            	<td></td>
	                                            	<td><input type="text" class="form-control" placeholder="추가 부서명" id="job" name="job"></td>
	                                            	<td><button type="button" class="btn btn-primary" id="plus">추가</button></td>
	                                            	</tr>
                                            	</c:if>
                                            	
                                            </tbody>
                                        </table>
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
    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
    
    <script>
    	let val = "";
    	$("#jd").change(function(){
    		val = $(this).val();
    		location.href="updatejdList?val="+val; 
    	})
    	
    	
	    $('[name="minus"]').on('click', function() { 
	    	
			let tr = $(this).closest('tr'); // 부모요소 중 tr 
			let del = tr.find('td:eq(1)').text(); // tr의 2번째 자식 text
			val = $("#jd").val();
		   	
			location.href="deletejd?val="+val+"&&del="+del;
		 	
		})
		
		 $("#plus").on('click', function() { 
			
			let tr = $(this).closest('tr'); // 부모요소 중 tr 
			let ins = tr.find('td:eq(1)').find('input').val(); // tr의 2번째 input val
			val = $("#jd").val();
			
			location.href="insertjd?val="+val+"&&ins="+ins;
		})
    </script>
    
</body>

</html>