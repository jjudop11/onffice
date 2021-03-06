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
		      ??????????????????
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="managerpageForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="jdForm">??????/????????????</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">????????????</a>
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
		                  <label for="email-id-icon">??????</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="?????? (????????????) " id="mNo" name="mNo" readonly>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">?????????</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="?????????" id="mId" name="mId" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div id="idResult"></div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">??????</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="??????" id="mName" name="mName" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>

                        <div class="form-group">
                       	    <label for="email-id-icon">??????</label>
                       	    <select class="choices form-select" id="job" name="jNo">
                       	    <c:forEach items="${ jList }" var="j">
                               <option value="${ j.JNo }">${ j.JName }</option>
                           	</c:forEach>
                           	</select>
                         </div>
		               
		                <div class="form-group">
                       	    <label for="email-id-icon">??????</label>
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
		                  <label for="email-id-icon">????????????</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="????????????" id="mPhone" name="mPhone" required>
                              <div class="form-control-icon">
                                  <i class="bi bi-phone"></i>
                              </div>
                          </div>
		                </div>
		                <br>
		             	<div class="form-group has-icon-left"> 
                          <label>???????????? :</label>
                          <button type="button" class="btn btn-primary" id="postcodify_search_button">??????</button>
						  <input type="text" name="post" class="form-control mr-2 postcodify_postcode5" size="6" required>
                          <label>??????????????? : </label>
						  <input type="text" name="address1" class="form-control postcodify_address" size="30" required>
                       	  <label>???????????? : </label>
						  <input type="text" name="address2" class="form-control postcodify_extra_info"  size="30" required>
		               </div>
		                <div class="mt-3 mb-3 float-right" id="final">
						<button type="submit" class="btn btn-outline-primary" id="save" disabled>??????</button>
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
		// ?????? ????????? ????????? ?????? ???????????? ???????????? ????????????.
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
    		// ???????????? ????????????
			$('#imgreset').click(function(){			
				$("#imgThum").html(""); 
				$("#space").attr("src","resources/assets/images/faces/1.jpg"); 
				$("#space").show();
    		})
    		// ???????????? ???????????????
			$("#save").click(function(){
				if($("#file").val() == ""){
			        alert("?????? ????????? ????????? ?????????");
			    }
			})
		    // ID ?????? ??????
    		let idCheck = $("#insertForm input[name=mId]");
			
			idCheck.keyup(function(){
				
				if(idCheck.val().length >= 5){ // 5?????? ?????? ????????????
					
					$.ajax({
						url:"idCheck",
						data:{id:idCheck.val()},
						type:"post",
						success:function(result) {
							if(result > 0){ //   count > 0 ????????? ????????? ??????
								$("#idResult").text("????????? ???????????? ???????????????").css("color", "red");
								$("#save").attr("disabled", true);
							}else{
								$("#idResult").text("??????????????? ????????? ?????????").css("color", "green");
								$("#save").attr("disabled", false);
							}
						},
						error:function() {
							console.log("????????? ??????????????? ajax ?????? ??????");
						}
					});
					
				} else {
					$("#idResult").text("5?????? ?????? ???????????????").css("color", "red");
					$("#save").attr("disabled", true);
				}
			})
    		
    	})
    	
    	function setThum(event) { //????????? ????????????

            let reader = new FileReader(); // File API ???????????? ????????? ????????? ?????????

            reader.onload = function(event) {  // ?????? ?????? ?????????
                let img = document.createElement("img"); 
                img.setAttribute("src", event.target.result); // ??????????????? src ????????? ??????
                img.style.width = "155px";
                img.style.height = "155px";
                $("#imgThum").html(img); 
                $("#space").hide();
            }; 
            
            reader.readAsDataURL(event.target.files[0]); // ???????????? ????????? Base64 Encode ???????????? ??????
        }
    </script>
</body>

</html>