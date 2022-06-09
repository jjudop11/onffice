<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티</title>
<style type="text/css">
#board {
	background-color: white;
	border-radius: 10px;
	padding: 2%;
	box-shadow: 0 10px 20px -10px DarkSeaGreen; 
}

form[name="search"] {
  position: relative;
  width: 450px;
}
input, button {
  border: none;
  
}
input[type="text"] {
  outline:0;
  width: 350px;
  height:40px;
  background-color: white;
  border-radius: 10px;
  appearance: none; 
  transition: all var(--dur) var(--bez);
  transition-property: width, border-radius;
  position: relative;
  padding-left:15px; 
  padding-right:35px; 
  box-shadow: 0 10px 20px -10px DarkSeaGreen; 
}
#condition {
	width:120px;
	outline-style:none;
	border: none;
	background:none;
	color: DodgerBlue;
	cursor: pointer;
}

#condition option {
	outline-style:none;
	border: none;
	background:none;
	color: black;
	cursor: pointer;
}

button {
  display: none;
  width: 80px; 
  height:40px;
  background:none;
  position: absolute;
  top: 0;
  right: 0;
  z-index: 1;
  padding-left: 70px;
}
input:not(:placeholder-shown) + button {
  display: block;
}
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
    <div id="app">
	<div id="main">
    <div class="content">
        <div class="innerOuter" style="padding:0% 10%;">
            <h2>커뮤니티</h2>
            <br>
            <a class="btn btn-secondary" style="float:right" href="enrollFormCommunity.do">글쓰기</a>
            <div class="search" style="display: flex; padding-left: 20px;" >
            	<form method="GET" name="search" action="searchCommunity.do">
            		<table class="pull-right">
            			<tr>
            				<td >
            					<select name="condition" id="condition" >
								  	<option value="title">제목</option>
								  	<option value="content">내용</option>
								  	<option value="titleAndContent">제목+내용</option>
								  </select>
            				</td>
            				<td style="padding-left:5%;"><input type="text" name="keyword" id="search" placeholder="검색어 입력">
            				<button type="submit" name="btnSearch" id="btnSearch"><i class="fa fa-search"/></button></td>
				  		</tr>
				  	</table>
				  <input type="hidden" name="pageNum" value="1">
				  <input type="hidden" name="amount" value="10">
			  </form>
			</div>
			<br>
			<div id="board">
	            <table id="commuList" class="table table-hover" align="center">
	                <thead>
	                  <tr>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>작성일</th>
	                  </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${ list }" var="n">
		                    <tr>
		                    	<td style="display: none;">${ n.comNum }</td>
		                    	<td style="width:65%;" onclick="location.href='detailCommunity.do?Com_Num=${ n.comNum }'">${ n.comTitle }</td>
		                    	<td style="width:20%;">익명</td>
		                        <td><fmt:formatDate value="${ n.comDate }" pattern = "MM-dd" /></td>
		                    </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
            </div>
            <br><br>

            <div id="pagingArea" style="display: flex; justify-content: center;">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage ne 1 }">
                			<li class="page-item"><a class="page-link" href="searchCommunity.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                		<c:when test="${ pi.currentPage ne p }">
                    			<li class="page-item"><a class="page-link" href="searchCommunity.do?currentPage=${ p }">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
	                		</c:otherwise>
	                	</c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                		<c:when test="${ pi.currentPage ne pi.maxPage }">
                			<li class="page-item"><a class="page-link" href="searchCommunity.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="searchCommunity.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            </div>
        </div>
    </div>
    </div>
    </div>
</body>
</html>