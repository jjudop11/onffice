<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티</title>
<style type="text/css">
.search {
  position: relative;
  width: 450px;
}

input {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}

img {
  position : absolute;
  width: 17px;
  top: 14px;
  right: 130px;
  margin: 0;
}
.selectBox{
	margin: 10px auto;
	margin-left: 20px;
}
</style>
</head>
<body>

    <jsp:include page="../common/menubar.jsp"/>
    <div id="app">
	<div id="main">
    <div class="content">
        <div class="innerOuter" style="padding:5% 10%;">
            <h2>커뮤니티</h2>
            <a class="btn btn-secondary" style="float:right" href="enrollFormCommunity.do">글쓰기</a>
            <div class="search" style="display: flex;">
            	<form method="post" name="search" action="searchNotice.do">
            		<table class="pull-right">
            			<tr>
            				<td>
            					<select name="condition" id="condition">
            						<option value="0">선택</option>
								  	<option value="title">제목</option>
								  	<option value="content">내용</option>
								  	<option value="titleAndContent">제목+내용</option>
								  </select>
            				</td>
            				<td><input type="text" name="keyword" placeholder="검색어 입력"></td>
	            			<td><button type="submit" class="btn btn-success">검색</button></td>			
					 		<!-- <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"> -->	
				  </tr>
				  </table>
			  </form>
			</div>
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
	                    	<td style="width:75%;" onclick="location.href='detailCommunity.do?Com_Num=${ n.comNum }'">${ n.comTitle }</td>
	                    	<td>익명</td>
	                        <td>${ n.comDate }</td>
	                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br>

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
    </div>
</body>
</html>