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
	#final, #postcodify_search_button {
		float: right;
	}
  </style>
</head>

<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	
    <div id="app">        
        <div id="main">

            <div class="container light-style flex-grow-1 container-p-y">
		    <h2 class="font-weight-bold py-3 mb-4">
		      개인정보관리
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action data-toggle="list" href="mypageForm">개인정보수정</a>
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="updatePassword">비밀번호변경</a>
		          </div>
		        </div>
		        <div class="col-md-9">
		          <div class="tab-content">
		            <div class="tab-pane fade active show" id="account-general">
		            <form id="updateForm" action="updatePassword" method="post">
		              
		              <div class="card-body">
		                <div class="form-group">
		                  <label class="form-label">현재 비밀번호</label>
		                  <input type="password" class="form-control mb-1" name="pwd">
		                </div>
		                <div class="form-group">
		                  <label class="form-label">새 비밀번호</label>
		                  <input type="password" class="form-control" name="newPwd" id="newPwd">
		                </div>
		                <div id="newPwdResult"></div>
		                <div class="form-group">
		                  <label class="form-label">새 비밀번호 확인</label>
		                  <input type="password" class="form-control mb-1" name="newPwd2" id="newPwd2">
		                </div>
		                <div id="newPwd2Result"></div>
		                
		                <div class="mt-3 mb-3 float-right" id="final">
						<button type="submit" class="btn btn-primary" disabled id="save">수정</button>
						</div>
		              </div>
		            </form>
		            </div>
		      	</div>
		   	 </div>
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
    
    <script>
	    $(function(){
	    	
	    	$("#newPwd").keyup(function(){
	    	
		    	if(!(/^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,15}$/i.test($("#newPwd").val()))){
					$("#newPwd").focus();
					$("#newPwdResult").text("영문자를 포함한 8자리이상 15자리이하로 작성하세요").css("color", "red");
				} else {
					$("#newPwdResult").text("");
					
					$("#newPwd2").keyup(function(){
			    		
			    		if($("#newPwd2").val() == $("#newPwd").val()) {
							$("#newPwd2Result").text("비밀번호가 일치합니다").css("color", "green");
							$("#save").attr("disabled", false);
						} else {
							$("#newPwd2").focus();
							$("#newPwd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");
							$("#save").attr("disabled", true);
						}
			    		
			    	})
				}
	    	})
	    	
	    })
    </script>
    
    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	<script>
		// 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
		$(function(){
			$("#postcodify_search_button").postcodifyPopUp();
		});
	</script>
</body>

</html>