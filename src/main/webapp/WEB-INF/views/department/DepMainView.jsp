<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부서보관함</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
/*.side-bar {
	width: 25%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.5);
}

.content {
	margin-left: 25%;
	height: 100%;
}*/
</style>
<script>
	$(function() {
		$('#myDeptFile').click(function() {
			if ($(this).val() == '▶ 내 드라이브') {
				$(this).val('▼ 내 드라이브');
			} else {
				$(this).val('▶ 내 드라이브');
			}
		});
	});
	$(function() {
		$('#DeptFile').click(function() {
			if ($(this).val() == '▶ 부서 드라이브') {
				$(this).val('▼ 부서 드라이브');
			} else {
				$(this).val('▶ 부서 드라이브');
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div id="app">
			<div id="main" style="display: flex;">
				<div class="row">
					<div class="col-12 col-xl-4">
							<button>
								<span>+ 파일 업로드</span> <input type="file" id="uploadFile"
									multiple="multiple" style="visibility: hidden;">
							</button>
							<hr>
							<input type="button" id="myDeptFile" class="driveMenu"
								data-toggle="collapse" data-target="#myDept" value="▶ 내 드라이브">
							<div id="myDept" class="collapse">
								<a href="#" class="list-group-item list-group-item-action">Lorem</a>
							</div>
		
							<input type="button" id="DeptFile" class="driveMenu"
								data-toggle="collapse" data-target="#dept" value="▶ 부서 드라이브">
							<div id="dept" class="collapse">
								<a href="#" class="list-group-item list-group-item-action">TEST</a>
								<a href="#" class="list-group-item list-group-item-action">TEST2</a>
						</div>
					</div>
				</div>

				<div class="col-12 col-xl-8">
						<table id="commuList" class="table table-hover" align="center">
							<thead>
								<input type="checkbox" />
								<button>다운로드</button>
								<button>삭제</button>
								<button>이동</button>
								<button>폴더 추가</button>
							</thead>
							<tbody>
								<tr>
									<td>파일 이름</td>
									<td>업로드일</td>
								</tr>
								<tr>
									<td><input type="checkbox" />파일1</td>
									<td>06-04</td>
								</tr>
							</tbody>
						</table>
					<div id="pagingArea">
		                <ul class="pagination">
		                	<c:choose>
		                		<c:when test="${ pi.currentPage ne 1 }">
		                			<li class="page-item"><a class="page-link" href="listCommunity.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
		                		</c:when>
		                		<c:otherwise>
		                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
		                		</c:otherwise>
		                	</c:choose>
		                	
		                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
		                    	<c:choose>
			                		<c:when test="${ pi.currentPage ne p }">
		                    			<li class="page-item"><a class="page-link" href="listCommunity.do?currentPage=${ p }">${ p }</a></li>
			                		</c:when>
			                		<c:otherwise>
			                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
			                		</c:otherwise>
			                	</c:choose>
		                    </c:forEach>
		                    
		                    
		                    <c:choose>
		                		<c:when test="${ pi.currentPage ne pi.maxPage }">
		                			<li class="page-item"><a class="page-link" href="listCommunity.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
		                		</c:when>
		                		<c:otherwise>
		                			<li class="page-item disabled"><a class="page-link" href="listCommunity.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
		                		</c:otherwise>
		                	</c:choose>
		                </ul>
		            </div>
				</div>
				
			</div>
		</div>
</body>
</html>