<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="resources/full/css/timepicker.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
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

<body style="background-color:#F0FFF0">

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
                          
                      <form id="updateForm" action="updateMember" method="post" enctype="multipart/form-data">
		              <div class="d-flex align-items-center">
		                <div class="avatar avatar-xl mt-5"> &nbsp;  &nbsp; &nbsp;  &nbsp;
		                	<div id="imgThum"></div>
                            <label><img src="${ pageContext.servletContext.contextPath }/resources/id_pictures/${m.PName}" style="width:150px; height:150px;" alt="" id="space"><input type="file" class="account-settings-fileinput" id="file" name="file" onchange="setThum(event)"></label>
                        	<button type="button" class="btn btn-dark mt-5" id="imgreset">delete</button> 
                        </div>      
		                <div class="ms-3 name mt-5">
                            <h5 class="font-bold" id="mname">${ m.MName } / ${ m.JName }</h5>
                            <h5 class="text-muted mb-0" id="dname">${ m.DName }</h5>
                            <input type="hidden" class="form-control" id="cNo" name="cNo" value="${ m.CNo }" readonly>
                            <input type="hidden" class="form-control" id="pNo" name="pNo" value="${ m.PNo }" readonly>
                        </div>
		              </div>
		              <div class="card-body">
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">사번</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="사번 (자동생성) " id="mNo" name="mNo" value="${ m.MNo }" readonly>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">아이디</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="아이디" id="mId" name="mId" value="${ m.MId }" readonly>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>

                        <div class="form-group">
                       	    <label for="email-id-icon">직급</label>
                       	    <select class="choices form-select" id="job" name="jNo">
                       	    <c:forEach items="${ jList }" var="j">
                               <option value="${ j.JNo }" <c:if test ="${m.JNo eq j.JNo}">selected</c:if>>${ j.JName }</option>
                           	</c:forEach>
                           	</select>
                         </div>
		               
		                <div class="form-group">
                       	    <label for="email-id-icon">부서</label>
                            <select class="choices form-select" id="dNo" name="dNo">
                       	    <c:forEach items="${ dList }" var="d">
                               <option value="${ d.DNo }"<c:if test ="${m.DNo eq d.DNo}">selected</c:if>>${ d.DName }</option>
                           	</c:forEach>
                           	</select>
                         </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">Email</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="Email" id="mEmail" name="mEmail" value="${ m.MEmail }" required autofocus>
                              <div class="form-control-icon">
                                  <i class="bi bi-envelope"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">전화번호</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="전화번호" id="mPhone" name="mPhone" value="${ m.MPhone }" required autofocus>
                              <div class="form-control-icon">
                                  <i class="bi bi-phone"></i>
                              </div>
                          </div>
		                </div>
		                <br>
		                <c:forTokens var="addr" items="${ m.MAddress }" delims="/" varStatus="status">
							<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
							<c:set var="post" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
							<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 1 }">
							<c:set var="address1" value="${ addr }"/>
							</c:if>
							<c:if test="${ status.index eq 2 }">
							<c:set var="address2" value="${ addr }"/>
							</c:if>
						</c:forTokens>
		             	<div class="form-group has-icon-left"> 
                          <label>우편번호 :</label>
                          <button type="button" class="btn btn-primary" id="postcodify_search_button" >검색</button>
						  <input type="text" name="post" class="form-control mr-2 postcodify_postcode5" value="${ post }" required autofocus>
                          <label>도로명주소 : </label>
						  <input type="text" name="address1" class="form-control postcodify_address" value="${ address1 }" required autofocus>
                       	  <label>상세주소 : </label>
						  <input type="text" name="address2" class="form-control postcodify_extra_info"  value="${ address2 }">
		               </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">입사일</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="입사일" id="mEntDate" name="mEntDate" value="${ m.MEntDate}" required autofocus>
                              <div class="form-control-icon">
                                  <i class="bi bi-house"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <c:if test ="${m.MWork eq 'Y'}">
                          <div class="position-relative">
                          	<input type="hidden" class="form-control" placeholder="퇴사일" id="mHireDate" name="mHireDate" value="2022-05-24">
                          </div>	  
                          		
                          </c:if>	
                          <c:if test ="${m.MWork eq 'N'}">
                          	<label for="email-id-icon">퇴사일</label>
                          	<div class="position-relative">
	                      		<input type="text" class="form-control" placeholder="퇴사일" id="mHireDate" name="mHireDate" value="${ m.MHireDate }">
	                          	<div class="form-control-icon">
	                              <i class="bi bi-house"></i>
	                          	</div>
                          	</div>
                          </c:if>
                          
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">관리자유무</label>
                          <div class="position-relative">
                              <select class="choices form-select" id="mManager" name="mManager">
                       	       <option value="Y"<c:if test ="${m.MManager eq 'Y'}">selected</c:if>>Y</option>
                               <option value="N"<c:if test ="${m.MManager eq 'N'}">selected</c:if>>N</option>
                           	</select>
                          </div>
		                </div>
		                <div class="mt-3 mb-3 float-right" id="final">
						<button type="submit" class="btn btn-primary">수정</button>
						<c:if test ="${m.MWork eq 'Y'}">
						<button type="button" class="btn btn-secondary" id="reset">비밀번호 초기화</button>
						<button type="button" class="btn btn-danger" id="delete">퇴사 등록</button>
						</c:if>
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
    
    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
	
	<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	<script>
		// 검색 단추를 누르면 팝업 레이어가 열리도록 설정한다.
		$(function(){
			$("#postcodify_search_button").postcodifyPopUp();
		});
	</script>
	
    <script>
    	$(function(){
        	
        	$("#mEntDate, #mHireDate").datepicker({
    		    dateFormat:'yy-mm-dd',
    		    monthNamesShort:[ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
    			dayNamesMin:[ '일', '월', '화', '수', '목', '금', '토' ],
    			changeMonth:true,
    			changeYear:true,
    			showMonthAfterYear:true,
    			autoclose: true,
    			todayHighlight: true
    		 });
    		
    		$('#delete').click(function(){
    			
    			if(confirm("퇴사 처리 하시겠습니까?")) {
    				$("#updateForm").attr("action", "deleteMember");
    				$("#updateForm").submit();
    			}
    			
    		})
    		
    		$('#reset').click(function(){
    			
    			if(confirm("비밀번호를 초기화 하시겠습니까?")) {
    				$("#updateForm").attr("action", "resetPwd");
    				$("#updateForm").submit();
    			}
    			
    		})
    		
    		$('#imgreset').click(function(){			
    			$("#imgThum").html(""); 
				$("#space").attr("src","resources/assets/images/faces/1.jpg"); 
				$("#space").show();
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
   	<script src="resources/full/js/moment.min.js"></script>
 	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="resources/full/js/timepicker.js"></script>
</body>

</html>