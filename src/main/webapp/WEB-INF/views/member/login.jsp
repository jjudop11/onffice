<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ONFFICE</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/assets/css/bootstrap.css">
    <link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
    <link rel="stylesheet" href="resources/assets/css/pages/auth.css">
</head>
<body class="bg-light">
<div id="auth">
        <div class="row h-100">
            <div class="col-lg-4 col-12 offset-lg-4" >
                <div id="auth">
                    <div class="auth-logo text-center mt-5 mb-5">
                        <a href="index.jsp"><img src="resources/assets/images/logo/logo.png" alt="Logo"></a>
                    </div>
                    <h1 class="auth-title text-center">OFFICE IN ONLINE</h1>
                    <p class="auth-subtitle mb-5 text-center">그룹웨어 서비스 ONFFICE 입니다</p>

                    <form action="login" method="post">
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="text" class="form-control form-control-xl" name="mId" placeholder="ID">
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="password" class="form-control form-control-xl" name="mPwd" placeholder="Password">
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div class="form-check form-check-lg d-flex align-items-end">
                            <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault">
                            <label class="form-check-label text-gray-600" for="flexCheckDefault">
                                Keep me logged in
                            </label>
                        </div>
                        <button class="btn btn-outline-success btn-block btn-lg mt-5">로그인</button>
                    </form>
                    <div class="text-center mt-2 mb-2 text-lg">
                    	<a href="auth-register.html" class="font-bold">비밀번호찾기</a>    
                    </div>
                    <div class="text-center mt-5 text-lg">
                        <a href="enrollForm" class="font-bold">회사등록하기</a>    
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
</body>
</html>