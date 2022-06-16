<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>결재진행</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<style>
		
		/* 결재선 라인 테이블 */
		table {
			width: 100%;
		}
		
		.apprTable {
			text-align: center;
		}
	</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>
	
	<div id="app">
		<div id="main">
			<!-- <form id="enrollForm" method="post" action="updateApproval.do" enctype="multipart/form-data"> -->
			<div>
				<!-- hidden 으로 넘길 정보 
				<input type="hidden" id="cNo" name="cNo" value="${ loginUser.CNo }">
				<input type="hidden" id="dNo" name="dNo" value="${ loginUser.DNo }">
				<input type="hidden" id="mNo" name="mNo" value="${ loginUser.MNo }"> -->
				
				<!-- 기본설정 -->
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">기본 설정</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-6">
								<div class="form-group">
									<label for="dept">부서</label>
									<input type="text" id="dept" class="form-control round" value="${ loginUser.DName }" name="writer" readonly>
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
							<div class="col-sm-12">
								<div class="form-group"><div class="table-responsive apprTable">
									<table id="apprTable" class="table table-bordered mb-0">
										<tbody><tr>
												<td rowspan="3" style="width: 150px">결재선</td>
												<td id="jName1" style="width: 170px; height: 40px">${jName}</td>
												<td id="jName2" style="width: 170px"></td>
												<td id="jName3" style="width: 170px"></td>
												<td id="jName4" style="width: 170px"></td>
												<td id="jName5" style="width: 170px"></td>
											</tr>
											<tr id="appr">
												<td style="height: 100px"></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr id="apprName">
												<td id="mName1" style="height: 40px">${mName}</td>
												<td id="mName2"></td>
												<td id="mName3"></td>
												<td id="mName4"></td>
												<td id="mName5"></td>
											</tr>
										</tbody>
									</table>
									</div>
								</div>
							</div>
							<table border="1">
								<thead></thead>
								<tbody></tbody>
							</table>
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
									<label for="title"></label>
									<input type="text" id="doTitle" name="doTitle" class="form-control round" value="${ dayoffForm.doTitle }" readonly/>
								</div>
							</div> 
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">기간</label>
									<div class="col-sm-3">
										<input type="date" id="datePicker" name="doStartDate" class="form-control" value="${ dayoffForm.doStartDate }" readonly/>
										~
										<input type="date" id="datePicker" name="doEndDate" class="form-control" value="${ dayoffForm.doEndDate }" readonly/>
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
                                            rows="3" readonly>${ dayoffForm.doContent}</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
                                            <c:if test="${ !empty formAtt.originName }">
                                            	<a href="${ pageContext.servletContext.contextPath }/resources/upload_files/${formAtt.changeName}" download="${ formAtt.originName }">${ formAtt.originName }</a>
	                                        </c:if>
	                                        <c:if test="${ empty formAtt.originName }">
	                                        	첨부파일이 없습니다.
	                                        </c:if>
                                        </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div> 
				
				<!-- 사업기획서 서식입력폼 -->
				<div class="card" id="proposalForm">
					<div class="card-header">
						<h4 class="card-title">사업기획서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">프로젝트명</label>
									<input type="text" id="prTitle" name="prTitle" class="form-control round" value="${ prForm.prTitle }" readonly/>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">시행목적</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prGoal"
                                            rows="3" readonly>${ prForm.prGoal }</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">운영계획</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prPlan"
                                            rows="3" readonly>${ prForm.prPlan }</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">기간</label>
									<div class="col-sm-3">
										<input type="date" id="datePicker" name="prStartDate" class="form-control" value="${ prForm.prStartDate }" readonly/>
										~
										<input type="date" id="datePicker" name="prEndDate" class="form-control" value="${ prForm.prEndDate }" readonly/>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">참여인원</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prPerson"
                                            rows="3" readonly>${ prForm.prPerson }</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">소요예산</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="prAmount"
                                            rows="3" readonly>${ prForm.prAmount }</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
	                                        <c:if test="${ !empty formAtt.originName }">
                                            	<a href="${ pageContext.servletContext.contextPath }/resources/upload_files/${formAtt.changeName}" download="${ formAtt.originName }">${ formAtt.originName }</a>
	                                        </c:if>
	                                        <c:if test="${ empty formAtt.originName }">
	                                        	첨부파일이 없습니다.
	                                        </c:if>
	                                    </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div> 
				
				<!-- 지출결의서 서식입력폼 -->
				<div class="card" id="paymentForm">
					<div class="card-header">
						<h4 class="card-title">지출결의서</h4>
					</div>
					
					<div class="card-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">제목</label>
									<input type="text" id="payTitle" name="payTitle" class="form-control round" value="${ payForm.payTitle }" readonly/>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="date">결제일자</label>
									<div class="col-sm-3">
										<input type="date" name="payDay" class="form-control" value="${ payForm.payDay }" readonly/>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="content">결제내역</label>
									<textarea class="form-control" id="exampleFormControlTextarea1" name="payList"
                                            rows="3" readonly>${ payForm.payList }</textarea>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="title">총지출금액</label>
									<input type="text" id="payAmount" name="payAmount" class="form-control round" value="${ payForm.payAmount }" readonly>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="upfile">첨부파일</label>
									<div class="input-group mb-3">
	                                    <div class="input-group mb-3">
	                                        <c:if test="${ !empty formAtt.originName }">
                                            	<a href="${ pageContext.servletContext.contextPath }/resources/upload_files/${formAtt.changeName}" download="${ formAtt.originName }">${ formAtt.originName }</a>
	                                        </c:if>
	                                        <c:if test="${ empty formAtt.originName }">
	                                        	첨부파일이 없습니다.
	                                        </c:if>
	                                    </div>
	                                </div>
								</div>
							</div>
						</div>
					</div>
				</div> 
				
				<div class="buttons" align="center">
	                <button id="updateBtn" class="btn btn-primary" onclick="postFormSubmit(1);">결재수정</button>
	                <button class="btn btn-danger" onclick="postFormSubmit(2);">결재취소</button>
	            </div>
	            
	            <form id="postForm" action="" method="post">
					<input type="hidden" name="apNo" value="${ apNo }">
					<input type="hidden" name="foNo" value="${ foNo }">
					<input type="hidden" name="fileName" value="${ formAtt.changeName }">
				</form>
				
				<script>
					function postFormSubmit(num){
						
						var postForm = $("#postForm");
						
						if(num == 1){
							postForm.attr("action", "updateApprovalForm.do");
						} else {
							postForm.attr("action", "deleteApproval.do");
						}
						postForm.submit();
					}
				</script>
			</div>
		</div>
	</div> 
	
	<script type="text/javascript">
	
		// 한명이라도 결재했으면 결재수정 버튼 비활성화
		$(document).ready(function(){
			console.log(${apStatus})
			
			if(${apStatus} !== 0){
				$('#updateBtn').css({'display':'none'})
			}
		});
	
		// 폼 서식에 따라 폼화면 변경 
		$(document).ready(function(){
			console.log("foNo : " + ${ foNo })
			
			if(${ foNo } == 10) {
				$('#dayoffForm').css({'display':'block'})
            	$('#proposalForm').css({'display':'none'})
            	$('#paymentForm').css({'display':'none'})
			} else if(${ foNo } == 20){
				$('#dayoffForm').css({'display':'none'})
            	$('#proposalForm').css({'display':'block'})
            	$('#paymentForm').css({'display':'none'})
			} else if(${ foNo } == 30){
				$('#dayoffForm').css({'display':'none'})
            	$('#proposalForm').css({'display':'none'})
            	$('#paymentForm').css({'display':'block'})
			} 
	    });
		
		// 휴가타입 라디오버튼 체크
		$(document).ready(function(){
			$(":radio[name='doType'][value='" + ${ dayoffForm.doType } + "']").attr('checked', true);
		});
		
		// 결재선
		$(document).ready(function(){
			
			let loginName = "${loginUser.MName}";
			
			let apprTd = $('#appr td');
			let apprNameTd = $('#apprName td'); // 승인자 이름 
			let value="";
			
			let tr = $('#apprTable tbody tr');
			let td = tr.children();
			
			$.ajax({
				url : "selectApLineStatus.do",
				type : "post",
				data : {
					apNo : ${ apNo },
					mName : "${ mName }"
				},
				dataType : "text",
				success : function(apLineStatus){
					for(let i = 0; i < 5; i++){
						if(apprNameTd.eq(i).text() == "${ mName }"){
							if(apLineStatus == '"Y"'){
								apprTd.eq(i).html("승인");
							} else if(apLineStatus == '"N"'){
								apprTd.eq(i).html("반려");
							}
						}
					}
				},
				error : function(){
					alert("조회 실패");
				}
			}) 
		});
		
	</script>
	
</body>
</html>