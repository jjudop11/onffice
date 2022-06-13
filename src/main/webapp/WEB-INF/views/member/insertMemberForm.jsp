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
	
	#pagingArea{width:fit-content;margin:auto;}
	
	#imgThum {postiion : relative;}
	#imgreset {
		position: absolute;
  		top: 80px;
  		left : 100px; 
  	}
  </style>
</head>

<body>

	<jsp:include page="../common/menubar.jsp"/>
	
    <div id="app">        
        <div id="main">

            <div class="container light-style flex-grow-1 container-p-y">
		    <h2 class="font-weight-bold py-3 mb-4">
		      관리자페이지
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="managerpageForm">전체사원조회</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">비밀번호변경</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="jdForm">직급/부서관리</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                          
                      <form id="insertForm" action="insertMember" method="post" enctype="multipart/form-data">
		              <div class="d-flex align-items-center">
		                <div class="avatar avatar-xl mt-5"> &nbsp;  &nbsp; &nbsp;  &nbsp;
		                	<div id="imgThum"></div>
                            <label><img src="resources/assets/images/faces/1.jpg" style="width:150px; height:150px;" alt="Face 1" id="space"><input type="file" class="account-settings-fileinput" id="file" name="file" onchange="setThum(event)" required></label>
                        	<button type="button" class="btn btn-dark mt-5" id="imgreset">delete</button> 
                        </div>    
		                <div class="ms-3 name mt-5">
                            <h5 class="font-bold" id="mname"></h5>
                            <h6 class="text-muted mb-0" id="dname"></h6>
                            <input type="hidden" class="form-control" id="cNo" name="cNo" value="${ sessionScope.loginUser.CNo }" readonly>
                        </div>
		              </div>
		              <div class="card-body">
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">사번</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="사번 (자동생성) " id="mNo" name="mNo" readonly>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">아이디</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="아이디" id="mId" name="mId" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div id="idResult"></div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">이름</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="이름" id="mName" name="mName" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>

                        <div class="form-group">
                       	    <label for="email-id-icon">직급</label>
                       	    <select class="choices form-select" id="job" name="jNo">
                       	    <c:forEach items="${ jList }" var="j">
                               <option value="${ j.JNo }">${ j.JName }</option>
                           	</c:forEach>
                           	</select>
                         </div>
		               
		                <div class="form-group">
                       	    <label for="email-id-icon">부서</label>
                            <select class="choices form-select" id="dNo" name="dNo">
                       	    <c:forEach items="${ dList }" var="d">
                               <option value="${ d.DNo }">${ d.DName }</option>
                           	</c:forEach>
                           	</select>
                         </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">Email</label>
                          <div class="position-relative">
                              <input type="email" class="form-control" placeholder="Email" id="mEmail" name="mEmail" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-envelope"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">전화번호</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="전화번호" id="mPhone" name="mPhone" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-phone"></i>
                              </div>
                          </div>
		                </div>
		                <br>
		             	<div class="form-group has-icon-left"> 
                          <label>우편번호 :</label>
                          <button type="button" class="btn btn-primary" id="postcodify_search_button">검색</button>
						  <input type="text" name="post" class="form-control mr-2 postcodify_postcode5" size="6" required>
                          <label>도로명주소 : </label>
						  <input type="text" name="address1" class="form-control postcodify_address" size="30" required>
                       	  <label>상세주소 : </label>
						  <input type="text" name="address2" class="form-control postcodify_extra_info"  size="30" required>
		               </div>
		                <div class="mt-3 mb-3 float-right" id="final">
						<button type="submit" class="btn btn-outline-primary" id="save" disabled>등록</button>
						</div>
		              </div>
		            </form>   
                	</section>
		      		</div>
		   	 	</div>
		 	</div>
    		</div>
    		</div>
    		
        </div>
    </div>
    
    <script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	<script>
		// 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
		$(function(){
			$("#postcodify_search_button").postcodifyPopUp();
		});
	</script>
	
    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
    <script>
    	$(function(){
    		// 사진첨부 화면출력
			$('#imgreset').click(function(){			
				$("#imgThum").html(""); 
				$("#space").attr("src","resources/assets/images/faces/1.jpg"); 
				$("#space").show();
    		})
    		// 사진첨부 유효성체크
			$("#save").click(function(){
				if($("#file").val() == ""){
			        alert("사진 파일을 첨부해 주세요");
			    }
			})
		    // ID 중복 체크
    		let idCheck = $("#insertForm input[name=mId]");
			
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
    		
    	})
    	
    	function setThum(event) { //파일이 첨부되면

            let reader = new FileReader(); // File API 비동기적 파일의 내용을 읽어옴

            reader.onload = function(event) {  // 파일 읽기 완료시
                let img = document.createElement("img"); 
                img.setAttribute("src", event.target.result); // 파일경로를 src 속성에 추가
                img.style.width = "155px";
                img.style.height = "155px";
                $("#imgThum").html(img); 
                $("#space").hide();
            }; 
            
            reader.readAsDataURL(event.target.files[0]); // 바이너리 파일을 Base64 Encode 문자열로 반환
        }
    </script>
</body>

</html>