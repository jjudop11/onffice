<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>기안작성</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	
	<!-- 데이트피커 cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	<style>
		#proposalForm, #paymentForm {
			display: none;
		}
	</style>

</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>
	
	<div id="app">
		<div id="main">
			<form id="enrollForm" method="post" action="insertApproval.do" enctype="multipart/form-data">
			
				<!-- hidden 으로 넘길 정보 -->
				<input type="hidden" id="cNo" name="cNo" value="${ loginUser.CNo }">
				<input type="hidden" id="dNo" name="dNo" value="${ loginUser.DNo }">
				<input type="hidden" id="mNo" name="mNo" value="${ loginUser.MNo }">
				
				<!-- 기본설정 -->
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">기본 설정</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="formSelect">문서종류</label>
									<fieldset class="form-group">
										<select class="form-select" id="form" name="foNo">
											<option value="10">휴가신청서</option>
											<option value="20">사업기획서</option>
											<option value="30">지출결의서</option>
										</select>
									</fieldset>
								</div>
							</div> 
							<div class="col-sm-6">
								<div class="form-group">
									<label for="writer">작성자</label>
									<input type="text" id="writer" class="form-control round" value="${ loginUser.MName }" name="writer" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 결재선 -->
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">결재선</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="apprLine">사원번호</label>
									
									<!-- 결재선 추가 버튼 -->
									<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#inlineForm">
									+
									</button>
									
								    <!-- 결재선 추가 모달 -->
									<div class="modal fade text-left" id="inlineForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title" id="myModalLabel33">결재선 검색</h4>
													<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
														<i data-feather="x"></i>
													</button>
												</div>
												
												<div class="modal-body">
													<label>사원명</label>
													<div class="form-group">
														<input type="text" id="searchName" name="searchName" placeholder="사원명을 검색해주세요" class="form-control">
														<button type="button" id="search" class="btn btn-primary">SEARCH</button>
													</div>
												</div>
												<div class="table-responsive">
                                    				<table class="table table-striped mb-0">
                                    					<thead>
			                                                <tr>
			                                                    <th>사번</th>
			                                                    <th>부서</th>
			                                                    <th>직급</th>
			                                                    <th>이름</th>
			                                                </tr>
			                                            </thead>
			                                            <tbody>
			                                            	<c:forEach items="${ list }" var="ap">
				                                                <tr>
				                                                    <td>${ ap.mNo }</td>
				                                                    <td>${ ap.dNo }</td>
				                                                    <td>${ ap.jNo }</td>
				                                                    <td>${ ap.mName }</td>
				                                                </tr>
			                                                </c:forEach>
		                                                </tbody>
                                    				</table>
                                    			</div>
                                    			
											</div>
										</div>
									</div>
									
									<input type="text" id="aplineNo" name="aplineNo" class="form-control round">
								</div>
							</div>
							<!-- <table border="1" class="table">
								<thead>
									<tr>
										<th style="width: 30px;" rowspan="3">
											신청
											<div class="modal-success me-1 mb-1 d-inline-block">
	                                            Button trigger for scrolling content modal
                                        <button type="button" class="btn btn-outline-success" data-bs-toggle="modal"
                                            data-bs-target="#exampleModalScrollable">
                                            +
                                        </button>

                                        scrolling content Modal
                                        <div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog"
                                            aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-scrollable" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalScrollableTitle">
                                                            Scrolling long
                                                            Content</h5>
                                                        <button type="button" class="close" data-bs-dismiss="modal"
                                                            aria-label="Close">
                                                            <i data-feather="x"></i>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>
                                                            Biscuit powder jelly beans. Lollipop candy canes croissant
                                                            icing
                                                            chocolate cake. Cake fruitcake
                                                            powder pudding pastry
                                                        </p>
                                                        <p>
                                                            Tootsie roll oat cake I love bear claw I love caramels
                                                            caramels halvah
                                                            chocolate bar. Cotton
                                                            candy
                                                            gummi bears pudding pie apple pie cookie. Cheesecake jujubes
                                                            lemon drops
                                                            danish dessert I love
                                                            caramels powder
                                                        </p>
                                                        <p>
                                                            Chocolate cake icing tiramisu liquorice toffee donut sweet
                                                            roll cake.
                                                            Cupcake dessert icing
                                                            dragée dessert. Liquorice jujubes cake tart pie donut.
                                                            Cotton candy
                                                            candy canes lollipop liquorice
                                                            chocolate marzipan muffin pie liquorice.
                                                        </p>
                                                        <p>
                                                            Powder cookie jelly beans sugar plum ice cream. Candy canes
                                                            I love
                                                            powder sugar plum tiramisu.
                                                            Liquorice pudding chocolate cake cupcake topping biscuit.
                                                            Lemon drops
                                                            apple pie sesame snaps
                                                            tootsie roll carrot cake soufflé halvah. Biscuit powder
                                                            jelly beans.
                                                            Lollipop candy canes
                                                            croissant icing chocolate cake. Cake fruitcake powder
                                                            pudding pastry.
                                                        </p>
                                                        <p>
                                                            Tootsie roll oat cake I love bear claw I love caramels
                                                            caramels halvah
                                                            chocolate bar. Cotton
                                                            candy gummi bears pudding pie apple pie cookie. Cheesecake
                                                            jujubes lemon
                                                            drops danish dessert I
                                                            love caramels powder.
                                                        </p>
                                                        <p>
                                                            dragée dessert. Liquorice jujubes cake tart pie donut.
                                                            Cotton candy
                                                            candy canes lollipop liquorice
                                                            chocolate marzipan muffin pie liquorice.
                                                        </p>
                                                        <p>
                                                            Powder cookie jelly beans sugar plum ice cream. Candy canes
                                                            I love
                                                            powder sugar plum tiramisu.
                                                            Liquorice pudding chocolate cake cupcake topping biscuit.
                                                            Lemon drops
                                                            apple pie sesame snaps
                                                            tootsie roll carrot cake soufflé halvah.Biscuit powder jelly
                                                            beans.
                                                            Lollipop candy canes croissant
                                                            icing chocolate cake. Cake fruitcake powder pudding pastry.
                                                        </p>
                                                        <p>
                                                            Tootsie roll oat cake I love bear claw I love caramels
                                                            caramels halvah
                                                            chocolate bar. Cotton
                                                            candy gummi bears pudding pie apple pie cookie. Cheesecake
                                                            jujubes lemon
                                                            drops danish dessert I
                                                            love caramels powder.
                                                        </p>
                                                        <p>
                                                            Chocolate cake icing tiramisu liquorice toffee donut sweet
                                                            roll cake.
                                                            Cupcake dessert icing
                                                            dragée dessert. Liquorice jujubes cake tart pie donut.
                                                            Cotton candy
                                                            candy canes lollipop liquorice
                                                            chocolate marzipan muffin pie liquorice.
                                                        </p>
                                                        <p>
                                                            Powder cookie jelly beans sugar plum ice cream. Candy canes
                                                            I love
                                                            powder sugar plum tiramisu.
                                                            Liquorice pudding chocolate cake cupcake topping biscuit.
                                                            Lemon drops
                                                            apple pie sesame snaps
                                                            tootsie roll carrot cake soufflé halvah. Biscuit powder
                                                            jelly beans.
                                                            Lollipop candy canes
                                                            croissant icing chocolate cake. Cake fruitcake powder
                                                            pudding pastry.
                                                        </p>
                                                        <p>
                                                            Tootsie roll oat cake I love bear claw I love caramels
                                                            caramels halvah
                                                            chocolate bar. Cotton
                                                            candy gummi bears pudding pie apple pie cookie. Cheesecake
                                                            jujubes lemon
                                                            drops danish dessert I
                                                            love caramels powder.
                                                        </p>
                                                        <p>
                                                            Chocolate cake icing tiramisu liquorice toffee donut sweet
                                                            roll cake.
                                                            Cupcake dessert icing
                                                            dragée dessert. Liquorice jujubes cake tart pie donut.
                                                            Cotton candy
                                                            candy canes lollipop liquorice
                                                            chocolate marzipan muffin pie liquorice.
                                                        </p>
                                                        <p>
                                                            Powder cookie jelly beans sugar plum ice cream. Candy canes
                                                            I love
                                                            powder sugar plum tiramisu.
                                                            Liquorice pudding chocolate cake cupcake topping biscuit.
                                                            Lemon drops
                                                            apple pie sesame snaps
                                                            tootsie roll carrot cake soufflé halvah.
                                                        </p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-light-secondary"
                                                            data-bs-dismiss="modal">
                                                            <i class="bx bx-x d-block d-sm-none"></i>
                                                            <span class="d-none d-sm-block">Close</span>
                                                        </button>
                                                        <button type="button" class="btn btn-primary ml-1"
                                                            data-bs-dismiss="modal">
                                                            <i class="bx bx-check d-block d-sm-none"></i>
                                                            <span class="d-none d-sm-block">Accept</span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                        
                                    
										</th>
										<th style="height: 30px;"></th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table> -->
						</div>
					</div>
				</div>
				
				<!-- 휴가신청서 서식입력폼 -->
				<div class="card" id="dayoffForm">
					<div class="card-header">
						<h4 class="card-title">휴가신청서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">제목</label>
									<input type="text" id="doTitle" name="doTitle" class="form-control round">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">기간</label>
									<div class="col-sm-3">
										<input type="date" id="datePicker" name="doStartDate" class="form-control">
										~
										<input type="date" id="datePicker" name="doEndDate" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="dayoffType">반차 여부</label>
									<div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="doType"
                                            id="flexRadioDefault1" value="10"> 
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            일차
                                        </label>
                                   </div>
                                   <div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="doType"
                                            id="flexRadioDefault1" value="20"> 
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            오전반차
                                        </label>
                                   </div>
                                   <div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="doType"
                                            id="flexRadioDefault1" value="30"> 
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            오후반차
                                        </label>
                                   </div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">사유</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="doContent"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
	                                        <label class="input-group-text" for="inputGroupFile01"><i
	                                                class="bi bi-upload"></i></label>
	                                        <input type="file" class="form-control" id="inputGroupFile01 upfile" name="upfile">
	                                    </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 사업기획서 서식입력폼 
				<div class="card" id="proposalForm">
					<div class="card-header">
						<h4 class="card-title">사업기획서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">프로젝트명</label>
									<input type="text" id="prTitle" name="prTitle" class="form-control round">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">시행목적</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prGoal"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">운영계획</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prPlan"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">기간</label>
									<div class="col-sm-3">
										<input type="date" id="datePicker" name="prStartDate" class="form-control">
										~
										<input type="date" id="datePicker" name="prEndDate" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">참여인원</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prPerson"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">소요예산</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prAmount"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
	                                        <label class="input-group-text" for="inputGroupFile01"><i
	                                                class="bi bi-upload"></i></label>
	                                        <input type="file" class="form-control" id="inputGroupFile01 upfile" name="upfile">
	                                    </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div> -->
				
				<!-- 지출결의서 서식입력폼 
				<div class="card" id="paymentForm">
					<div class="card-header">
						<h4 class="card-title">지출결의서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">제목</label>
									<input type="text" id="payTitle" name="payTitle" class="form-control round">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">결제일자</label>
									<div class="col-sm-3">
										<input type="date" name="payDay" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">결제내역</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="payList"
                                            rows="3"></textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">총지출금액</label>
									<input type="text" id="payAmount" name="payAmount" class="form-control round">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
	                                        <label class="input-group-text" for="inputGroupFile01"><i
	                                                class="bi bi-upload"></i></label>
	                                        <input type="file" class="form-control" id="inputGroupFile01 upfile" name="upfile">
	                                    </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div> -->
				
				<div class="buttons" align="center">
                	<button type="submit" class="btn btn-primary">결재요청</button>
                </div>
			</form>
		</div>
	</div> 
	
	<script type="text/javascript">
	
		<!-- 셀렉트박스 선택값에 따라 폼화면 변경 -->
		$(document).ready(function(){
	        $('#form').change(function(){ // 셀렉트박스 선택값에 따라 바로 변경 이벤트 발생 
	            var form = $('#form').val(); //id선택자로 email select box값 추출하여 저장
	            if(form == 10){ //selectbox value가 10일 때 폼화면 변경
	            	$('#dayoffForm').css({'display':'block'})
	            	$('#proposalForm').css({'display':'none'})
	            	$('#paymentForm').css({'display':'none'})
	            } else if (form == 20) { //selectbox value가 20일 때 폼화면 변경
	            	$('#dayoffForm').css({'display':'none'})
	            	$('#proposalForm').css({'display':'block'})
	            	$('#paymentForm').css({'display':'none'})
	            } else if (form == 30) { //selectbox value가 30일 때 폼화면 변경
	            	$('#dayoffForm').css({'display':'none'})
	            	$('#proposalForm').css({'display':'none'})
	            	$('#paymentForm').css({'display':'block'})
	            }
	        });
	    });
		
		<!-- 검색 버튼 클릭하면 컨트롤러에 검색값 전달 
		$(document).ready(function(){
			$(document).on('click', '#search', function(e){
				let searchName = $('#searchName').val();
				console.log(searchName)
				
				$.ajax({
					url : "searchApprovalLine.do",
					type : "post",
					data : {searchName:searchName},
					success : function(){
					},
					error : funcgion(){
						alert("error")
					}
				})
			});
		});-->
		
		$(function(){
			$('#search').click(function(){
				/* var searchName = $('#searchName').val(); */
				
				$.ajax({
					url : "searchApprovalLine.do",
					type : "post",
					date : searchName:$('#searchName').val(),
					success : function(){
						alert("성공")
					},
					error : function(){
						alert("실패")
					}
				});
			});
		});
		
	</script>
	
</body>
</html>