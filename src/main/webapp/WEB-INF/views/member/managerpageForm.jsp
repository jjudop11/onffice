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
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">개인정보수정</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">비밀번호변경</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                
                                <h4 class="card-title mt-5">전사원조회</h4>    
                               
                                <div class="card-content mt-5">
                                    <!-- table hover -->
                                    <div class="table-responsive">
                                        <table id="memberList" class="table table-hover mb-0"> <!--  -->
                                            <thead>
                                                <tr>
                                                    <th>사번</th>
                                                    <th>이름</th>
                                                    <th>직급</th>
                                                    <th>부서</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach items="${ list }" var="m">
                                                <tr>
                                                    <td>${ m.MNo }</td>
                                                    <td>${ m.MName }</td>
                                                    <td>${ m.JName }</td>
                                                    <td>${ m.DName }</td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table><!--  -->
                                        <br>
                                        <div id="pagingArea">
							                <ul class="pagination">
							                	<c:choose>
							                		<c:when test="${ pi.currentPage ne 1 }">
							                			<li class="page-item"><a class="page-link" href="listBoard.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
							                		</c:when>
							                		<c:otherwise>
							                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
							                		</c:otherwise>
							                	</c:choose>
							                	
							                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							                    	<c:choose>
								                		<c:when test="${ pi.currentPage ne p }">
							                    			<li class="page-item"><a class="page-link" href="listBoard.do?currentPage=${ p }">${ p }</a></li>
								                		</c:when>
								                		<c:otherwise>
								                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
								                		</c:otherwise>
								                	</c:choose>
							                    </c:forEach>
							                    
							                    
							                    <c:choose>
							                		<c:when test="${ pi.currentPage ne pi.maxPage }">
							                			<li class="page-item"><a class="page-link" href="listBoard.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
							                		</c:when>
							                		<c:otherwise>
							                			<li class="page-item disabled"><a class="page-link" href="listBoard.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
							                		</c:otherwise>
							                	</c:choose>
							                </ul>
							            </div>
                                        <div class="mt-3 mb-3 float-right" id="final">
                                        
										<button type="button" class="btn btn-outline-primary" onclick="location.href='insertMemberForm'">사원추가</button>
										&nbsp;  &nbsp; &nbsp;  &nbsp;

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
</body>

</html>