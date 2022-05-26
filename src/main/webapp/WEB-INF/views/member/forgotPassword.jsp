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
              	<p class="text-muted">비밀번호를 찾을 ID와 EAMIL 주소를 입력하세요</p>
              </div>

              <div class="card-body">
                <form id="passwordForm" action="findPwd" method="post" > 
                  <div class="form-group">
                    <label for="Id">ID</label>
                    <input id="id" type="text" class="form-control" name="mId" tabindex="1" required autofocus>
                  </div>
                  <br>
                  <div class="form-group">
                    <label for="email">Email</label>
                    <input id="email" type="email" class="form-control" name="mEmail" tabindex="2" required>
                  </div>

                  <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-block" tabindex="3">
                      이메일 인증하기
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
</body>
</html>