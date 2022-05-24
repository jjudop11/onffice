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
	#final {
		float: right;
	}
	#pagingArea{width:fit-content;margin:auto;}
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
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">개인정보수정</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">비밀번호변경</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                          
                      <form id="updateForm" action="update" method="post">
		              <div class="d-flex align-items-center">
		                <div class="avatar avatar-xl mt-5"> &nbsp;  &nbsp; &nbsp;  &nbsp;
                            <label><img src="resources/assets/images/faces/1.jpg" alt="Face 1"><input type="file" class="account-settings-fileinput"></label> 
                        </div>    
		                <div class="ms-3 name mt-5">
                            <h5 class="font-bold" id="mname"></h5>
                            <h6 class="text-muted mb-0" id="dname"></h6>
                        </div>
		              </div>
		              <div class="card-body">
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">사번</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="사번 (자동생성) " id="email-id-icon" readonly>
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">아이디</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="아이디" id="email-id-icon">
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">이름</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="이름" id="email-id-icon">
                              <div class="form-control-icon">
                                  <i class="bi bi-person"></i>
                              </div>
                          </div>
		                </div>

                        <div class="form-group">
                       	    <label for="email-id-icon">직급</label>
                            <select class="choices form-select">
                                <option value="square">Square</option>
                                <option value="rectangle">Rectangle</option>
                                <option value="rombo">Rombo</option>
                                <option value="romboid">Romboid</option>
                                <option value="trapeze">Trapeze</option>
                                <option value="traible">Triangle</option>
                                <option value="polygon">Polygon</option>
                            </select>
                         </div>
		               
		                <div class="form-group">
                       	    <label for="email-id-icon">부서</label>
                            <select class="choices form-select">
                                <option value="square">Square</option>
                                <option value="rectangle">Rectangle</option>
                                <option value="rombo">Rombo</option>
                                <option value="romboid">Romboid</option>
                                <option value="trapeze">Trapeze</option>
                                <option value="traible">Triangle</option>
                                <option value="polygon">Polygon</option>
                            </select>
                         </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">Email</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="Email" id="email-id-icon">
                              <div class="form-control-icon">
                                  <i class="bi bi-envelope"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">전화번호</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="전화번호" id="email-id-icon">
                              <div class="form-control-icon">
                                  <i class="bi bi-phone"></i>
                              </div>
                          </div>
		                </div>
		                <div class="form-group has-icon-left">
		                  <label for="email-id-icon">주소</label>
                          <div class="position-relative">
                              <input type="text" class="form-control" placeholder="주소" id="email-id-icon">
                              <div class="form-control-icon">
                                  <i class="bi bi-house"></i>
                              </div>
                          </div>
		                </div>
		                <div class="mt-3 mb-3 float-right" id="final">
						<button type="button" class="btn btn-outline-primary">등록</button>
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
</body>

</html>