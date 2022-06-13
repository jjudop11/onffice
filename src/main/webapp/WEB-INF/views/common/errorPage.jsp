<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에러페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/assets/css/bootstrap.css">
    <link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
    <link rel="stylesheet" href="resources/assets/css/pages/auth.css">
</head>
</head>
<body>

   	<div class="login-form-bg h-100">
	     <div class="container h-100">
	         <div class="row justify-content-center h-100 mt-5">
	             <div class="mt-5">
	                 <div class="error-content mt-5">
	                     <div class="card mb-0 mt-5">
	                         <div class="card-body text-center mt-5">
	                             <h1 class="error-text text-primary">${ requestScope['javax.servlet.error.message'] }</h1>
	                             <h4 class="mt-5"><i class="fa fa-thumbs-down text-danger"></i> Bad Request </h4>
	                             <c:if test="${ requestScope['javax.servlet.error.status_code'] eq '404' }">
	                             <p class="mt-5">404 / 요청하신 페이지를 찾을 수 없습니다.</p>
	                             </c:if>
	                              <c:if test="${ requestScope['javax.servlet.error.status_code'] eq '500' }">
	                             <p class="mt-5">500 / 서버에 오류가 발생하여 요청을 수행할 수 없습니다.</p>
	                             </c:if>
	                             
	                             <c:if test="${ requestScope['javax.servlet.error.message'] eq '해당 ID로 가입한 계정이 없거나 잠긴계정입니다'}">
	                             <form class="mt-5 mb-5">                                  
	                                 <div class="text-center mb-4 mt-5"><a href="${ pageContext.servletContext.contextPath }">로그인하러가기</a>
	                                 </div>
	                             </form>
	                             </c:if>
	                             <c:if test="${ requestScope['javax.servlet.error.message'] ne '해당 ID로 가입한 계정이 없거나 잠긴계정입니다'}">
	                             <form class="mt-5 mb-5">                                  
	                                 <div class="text-center mb-4 mt-5"><a href="javascript:history.back(-1)">뒤로가기</a> / <a href="main">메인화면으로가기</a>
	                                 </div>
	                             </form>
	                             </c:if>
	                         </div>
	                     </div>
	                 </div>
	             </div>
	         </div>
	     </div>
	 </div>

</body>
</html>