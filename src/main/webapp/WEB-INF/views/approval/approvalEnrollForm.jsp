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
										<select class="form-select" id="foNo" name="foNo">
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
									<input type="text" id="aplineNo" name="aplineNo" class="form-control round" placeholder="사원번호를 입력해주세요">
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
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">휴가신청서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">제목</label>
									<input type="text" id="doTitle" name="doTitle" class="form-control round" placeholder="제목을 입력해주세요">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">기간</label>
									<div class="col-sm-3">
										<input type="date" id="datePicker" name="doStartDate" class="form-control" placeholder="시작일"/>
										~
										<input type="date" id="datePicker" name="doEndDate" class="form-control" placeholder="종료일"/>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="dayoffType">반차 여부</label>
									<div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="flexRadioDefault doType"
                                            id="flexRadioDefault1 dayoffType" value="10"> 
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            일차
                                        </label>
                                   </div>
                                   <div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="flexRadioDefault doType"
                                            id="flexRadioDefault1 dayoffType" value="20"> 
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            오전반차
                                        </label>
                                   </div>
                                   <div class="form-check"> 
                                        <input class="form-check-input" type="radio" name="flexRadioDefault doType"
                                            id="flexRadioDefault1 dayoffType" value="30"> 
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
				
				<div class="buttons" align="center">
                	<button type="submit" class="btn btn-secondary">결재요청</button>
                </div>
			</form>
		</div>
	</div>
	
	<!-- 휴가타입 선택값 전달 --> 
	<%-- <script type="text/javascript">
		$(function(){
			let doType = Number($('input[name=doType]:checked').val());
			console.log(doType)
			location.href = "<%=request.getContextPath()%>/insertApproval.do?doType="+doType;
		})
	</script> --%>
	
</body>
</html>