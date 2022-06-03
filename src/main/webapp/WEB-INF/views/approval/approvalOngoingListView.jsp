<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>기안작성</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>
	
	<div id="app">
		<div id="main">
			<section class="section">
	            <div class="row" id="basic-table">
	                <div class="col-12 col-md-12">
	                    <div class="card">
	                        <div class="card-header">
	                            <h4 class="card-title">결재진행</h4>
	                        </div>
	                        <div class="card-content">
	                            <div class="card-body">
	                                <!-- Table with outer spacing -->
	                                <div class="table-responsive">
	                                    <table class="table table-lg">
	                                        <thead>
	                                            <tr>
	                                                <th>결재양식</th>
	                                                <th>제목</th>
	                                                <th>작성일</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	<c:forEach items="${ list }" var="ap">
		                                            <%-- <tr>
		                                                <td>${ ap.foNo }</td>
		                                                <td>${ ap.title }</td>
		                                                <td>${ ap.date }</td>
		                                            </tr>  --%>
	                                            </c:forEach>
	                                            
	                                        </tbody>
	                                    </table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </div>
        	</section>
		</div>
	</div> 
	
</body>
</html>