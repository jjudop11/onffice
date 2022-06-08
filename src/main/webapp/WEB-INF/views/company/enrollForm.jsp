<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - ONFFICE</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/assets/css/bootstrap.css">
    <link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
    <link rel="stylesheet" href="resources/assets/css/pages/auth.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="bg-light">
    <div id="auth">
        <div class="row h-100">
            <div class="col-lg-4 col-12 offset-lg-4">
                <div id="auth">
                    
                    <div class="mt-5">
                    	<h1 class="auth-title">안녕하세요</h1>
                    	<h1 class="auth-subtitle mb-2">회사계정을 생성하세요.</h1>
                    	<br>
                   	</div>
                    
                    <form id="enrollForm" method="post" action="insertCompany.do">
                    	<div class="form-group position-relative has-icon-left mb-1">
                            <input type="text" class="form-control form-control-xl" name="cId" id="cId" placeholder="아이디" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div id="idResult"></div>
                        
                        <div class="form-group position-relative has-icon-left mb-1">
                            <input type="password" class="form-control form-control-xl" name="cPwd" id="cPwd" maxlength="15" placeholder="비밀번호" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div id="pwdResult"></div>
                      
                        <div class="form-group position-relative has-icon-left mb-1">
                            <input type="email" class="form-control form-control-xl" name="cEmail" id="cEmail" placeholder="이메일" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                        </div>
                        <div id="emailResult"></div>
                        
                        <div class="form-group position-relative has-icon-left mb-1">
                            <input type="text" class="form-control form-control-xl" name="cName" id="cName" placeholder="회사명" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-building"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-1">
                            <input type="text" class="form-control form-control-xl" name="cRNumber" id="cRNumber" maxlength="12" placeholder="사업자등록번호" onchange="cknum(this.value)" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-clipboard-check"></i>
                            </div>
                        </div>
                        <div id="rNumResult"></div>
                        <button class="btn btn-primary btn-block btn-lg shadow-lg mt-2" id="save" type="submit">생성</button>
                        
                    </form>
                    <div class="text-center mt-5 text-lg fs-4">
                        <p class='text-gray-600'>이미 회사계정이 있으신가요? <a href="index.jsp"
                                class="font-bold">Log in</a>.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 d-none d-lg-block">
                <div id="auth-right">

                </div>
            </div>
        </div>

    </div>
    
    <script>

		$(function(){
			
			let idCheck = $("#enrollForm input[name=cId]");
			
			idCheck.keyup(function(){
				
				if(idCheck.val().length >= 5){ // 5글자 이상 중복체크
					
					$.ajax({
						url:"idCheck",
						data:{id:idCheck.val()},
						type:"post",
						success:function(result) {
							if(result > 0){ //   count > 0 중복된 아이디 존재
								$("#idResult").text("중복된 아이디가 존재합니다").css("color", "red");
								$("#save").attr("disabled", true);
							}else{
								$("#idResult").text("사용가능한 아이디 입니다").css("color", "green");
								$("#save").attr("disabled", false);
							}
						},
						error:function() {
							console.log("아이디 중복체크용 ajax 통신 실패");
						}
					});
					
				} else {
					$("#idResult").text("5글자 이상 작성하세요").css("color", "red");
					$("#save").attr("disabled", true);
				}
			})
			
			
			let pwdCheck = $("#enrollForm input[name=cPwd]"); 
			
			pwdCheck.keyup(function(){
				
				if(pwdCheck.val().length >= 8){
					// 영문자포함 8~15 비번 정규식
					if(!(/^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,15}$/i.test(pwdCheck.val()))){
						$("#enrollForm input[name=cPwd]").focus();
						$("#pwdResult").text("영문자를 포함한 8자리이상 15자리이하로 작성하세요").css("color", "red");
						$("#save").attr("disabled", true);
					} else {
						$("#pwdResult").text("옳바른 비밀번호 양식입니다").css("color", "green");
						$("#save").attr("disabled", false);
					}
						
					let emailCheck = $("#enrollForm input[name=cEmail]");
					
					emailCheck.keyup(function(){
						// 이메일 정규식
						if(!(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test(emailCheck.val()))){
							$("#enrollForm input[name=emailcheck]").focus();
							$("#emailResult").text("옳바른 이메일 양식이 아닙니다").css("color", "red");
							$("#save").attr("disabled", true);
						} else {
							$("#emailResult").text("")
							$("#emailResult").text("옳바른 이메일 양식입니다").css("color", "green");
							$("#save").attr("disabled", false);
						}
						
					})
					
				} else {
					$("#pwdResult").text("");
				}
				
			})
			
		
		});
		
		function cknum(val) {
			let num;
			let rNum;
			if(val.length >= 10) {
	
				var data = {
				    "b_no": [val] // 사업자번호 조회
				   }; 

				$.ajax({
					
					  url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=Lfr0PEL3zTN/Kpf9FORMkPyFg6o0eGOegU0L/36MunhajPVxE34blq0mNYlv1mE4sHiszx86H20fiiEaqziZSw==",  // serviceKey 값입력
					  type: "POST",
					  data: JSON.stringify(data), // json 을 string으로 변환하여 전송
					  dataType: "JSON",
					  contentType: "application/json",
					  accept: "application/json",
					  success: function(result) {
						  $("#rNumResult").text("");
						  
					      if(result.data[0].tax_type == "국세청에 등록되지 않은 사업자등록번호입니다.") {
					    	  $("#save").attr("disabled", true);
					    	  alert(result.data[0].tax_type)
					    	  
					      } else {
					    	  
					    	  num = val.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3'); // 사업자등록번호 정규식
							  $("#cRNumber").val(num);
							  rNum = $("#cRNumber").val();
					    	  
							  $.ajax({
									url:"rNumCheck",
									data:{rNum:rNum},
									type:"post",
									success:function(result) {
										if(result > 0){ 
											$("#rNumResult").text("해당 사업자등록번호로 가입한 계정이 있습니다").css("color", "red");
											$("#save").attr("disabled", true);
										} else {
											$("#rNumResult").text("가입 가능한 사업자등록번호 입니다").css("color", "green");
											$("#save").attr("disabled", false);
										}
									},
									error:function() {
										console.log("사업자번호 중복체크용 ajax 통신 실패");
									}
							});
					    }

					  },
					  error: function(result) {
					      console.log(result.responseText); //responseText의 에러메세지 확인
					      $("#save").attr("disabled", true);
					  }
					  
				});
				
			} else {
				$("#rNumResult").text("사업자등로번호 10자리를 입력하세요").css("color", "red");
				$("#save").attr("disabled", true);
			}
				
		}	
				

		

		
    </script>
</body>
</html>