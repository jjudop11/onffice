<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/assets/css/bootstrap.css">
    <link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
    <link rel="stylesheet" href="resources/assets/css/pages/auth.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="bg-light">
  <div id="app">
    <section class="section">
      <div class="container mt-5">
        <div class="row">
          <div class="col-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4">
            <div class="auth-logo text-center mt-5 mb-5">
              <a href="index.jsp"><img src="resources/assets/images/logo/logo.png" alt="Logo"></a>
            </div>

            <div class="card card-primary mt-5">
              <div class="card-header">
              	<h4>비밀번호 찾기</h4>
              	<p class="text-muted">EMAIL에 전달받은 인증번호를 입력하세요</p>
              </div>

              <div class="card-body">
                <form id="passwordForm" action="findPwd" method="post" > 
                  
                  <div class="form-group">
                  	<input id="num" type="hidden" class="form-control" name="num" tabindex="1" value="${num}">
                    <label for="checknum">인증번호</label>
                    <input id="checkNum" type="text" class="form-control" name="checknum" tabindex="2" required autofocus>
                  </div>
				  <br><br>
                  <div class="form-group">
                    <button type="button" class="btn btn-primary btn-lg btn-block" tabindex="3" id="check">
                      인증하기
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  
  <script>
  	
  	$("#check").on('click', function() { 
		
		if($("#num").val() == $("#checkNum").val()) {
			location.href="resetPwd2";
		} else {
			alert("인증번호가 일치하지 않습니다");
		}
		
	})
  </script>
</body>
</html>