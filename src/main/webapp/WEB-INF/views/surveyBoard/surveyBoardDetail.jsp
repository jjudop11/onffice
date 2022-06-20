<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	*{
		color:black;
	}

	#main{
		padding:0;
	}
	
	
	.cast_surveyBoardList{

		height:1200px;
		padding:0 20px; 
		display:flex;
	}
	
	.main-cast_lists{
		width:80%;
		left:0px;
	}
	
	.side-cast_listOption{
		border-left:1px solid rgb(159, 160, 167);
		width:20%;
		height:1200px;
		right:0px;
		padding:20px 10px;

	}
	
	.list_table th, td{
		
		padding:10px 0  10px 10px;
		
	}
	
	.list_table td{
		
		border-bottom:1px solid rgb(159, 160, 167);
		
	}
	
	.go_detail:hover{
	
		background: rgb(250, 248, 115);
		
	}
	
	.td1{
		width:140px;
	}
	
	.participantBox{
		margin: 		30px 10px 50px 10px; 
		background: 	rgb(150, 253, 190);
		border:1px solid rgb(19, 241, 74);
		width: 			90px;
		height: 		80px;
		font-size: 		15px;
		text-align: 	center;
		border-radius: 	7px;
		color:white;
	}
	
	.sb_announcement{
		
		margin: 		0px 10px 50px 10px; 
		width:70%;
		height:70px;
		border-radius: 	7px;
		background: 	rgb(150, 253, 190);
		border:1px solid rgb(19, 241, 74);
		boarder:none;
		font-color:white;
	}
	
	.sb_inquiry{
	
		margin: 		0px 0px 50px 40px; 
		
	}
	
	.participation_box{
		width:700px;
		height:50px;
		border:1px solid rgb(19, 241, 74);
		background: 	rgb(150, 253, 190);
		border-radius: 	7px;
		font-size:13px;
		padding:15px 0 0 15px;
		display:none;
	}
	
	.header_button:hover{
		
		background:lightgray;
		width:73px;
		height:37px;
		padding:4px 0 0 0;
		
	}

</style>

</head>
<body>
<jsp:include page="../common/menubar.jsp"/>
	<div id="app">
		<div id="main" style="padding:0;">
			<div class="cast_surveyBoardList" >
				<div class="main-cast_lists">
					<div class="sb_header" style="border-bottom:1px solid rgb(159, 160, 167); height:70px; padding:30px 0 0 30px;">
						<h2>설문 상세</h2>
						<c:if test="${sbList[0].sbFounderNo == sessionScope.loginUser.MNo}">
							<div class="header_button" id="deleteBoard" style="position:absolute; border: 1 solid black; top:140px; left:66%; ">
								<svg style="width:30px; height:30px" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
								  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
								  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
								</svg> 삭제 
							</div>	
						</c:if>					
					</div>
					
					<div class="sb_body" style="width:100%">
						<div class="body_header" style="padding:40px 0 0 30px; ">
							<h5 class="sb_title">제목 : ${sbList[0].sbTitle}</h5>
						</div>
						<div class="body_main" style=" height:100%; padding:20px 0 0 30px;">
							<table class="body-writer">
								<tr>
									<td class="td1">작성자 : </td>
									<td>${sbList[0].sbFounderName } &nbsp; ${sbList[0].sbFounderdName }</td>
								</tr>
								<tr>
									<td class="td1">설문 기간 : </td>
									<td>${sbList[0].sbStartDate }&nbsp; ~ &nbsp;${sbList[0].sbEndDate }</td>
								</tr>
								<tr>
									<td class="td1">설문결과 : </td>
									<td class="sb_resultState"></td>
								</tr>
							</table>
							<div style="display:flex">	
								<div class="participantBox">
									<div style="margin:10px 0;">전체 참여자</div><div class="allCount" style="font-size:20px; font-weight:bold;"></div>
								</div>
								<div class="participantBox">
									<div style="margin:10px 0;">참여 완료</div><div class="comCount" style="font-size:20px; font-weight:bold;"></div>
								</div>
								<div class="participantBox">
									<div style="margin:10px 0;">미참여</div><div class="noCount" style="font-size:20px; font-weight:bold;"></div>
								</div>
							</div>
								<div style="margin:0 0 5px 10px"><b>게시물 안내 </b></div>
								<div class="sb_announcement" style="padding:10px;"></div>
							</div>
							
							
							<div class="sb_inquiry">
								<div id="sbAnswerCheck" style="display:none; font-size:0.8em; padding:0px 0 10px 0;"></div>
								<div class="sb_inquiryTitle" >
									<h4>${sbList[0].sbITitle }</h4>
								</div>
								<div class="sb_questionList" style="display:none; ">
									<form action="insertQuestionAnswer" class="form">
										<ul style="margin:0 0 0 20px">
											<c:forEach items="${sbList}" var="sb">
												<c:if test="${sb.sbIType == 'S' }">
													<li>
														<input type="radio" name="sbQuestion" id="${sb.sqNo}" value="${sb.sqNo}"> &nbsp;&nbsp;
									                    <label for="${sb.sqNo}">${sb.sqContent}</label>
								                    </li>
												</c:if>
												<c:if test="${sb.sbIType == 'M' }">
													<li>
														<input type="checkbox" name="sbQuestion" id="${sb.sqNo}" value="${sb.sqNo}"> &nbsp;&nbsp;
														<input type="text" value="${sb.sqContent}" style="border:none; background:none;" readonly/>
													</li>
												</c:if>
											</c:forEach>
											<li>
												<input type="hidden" class="sbNo" value="${sbList[0].sbNo}" name="sbNo"/>
												<input type="hidden" class="sbINo" value="${sbList[0].sbINo}" name="sbINo"/>
											</li>
										</ul>
									</form>
								</div>
								<div class="body_footer" id="form_div" style="margin:100px 0 0 30%; display:none;">
									<input type="submit" id="formSubmit" class="btn btn-primary" value="제출"/> 
								</div>
						
								<div class="participation_box" style="display:none;">	
									<span>전체 참여자 : <b>${memCount }</b> 명</span>&nbsp; &nbsp;&nbsp;
									<span>참여자 : <b>${comMemCount}</b> 명</span>
									<progress value="${comMemCount }" max="${memCount}" style="width:300px; height:40px; position:absolute; left:600px; top:750px;"></progress>
									<span style="margin:0 0 0 340px;" class="participation_bar"></span>
									<input type="hidden" id="sbNo" value="${sbList[0].sbNo}" />
								</div>
								<div class="chart_bar" style="width:700px; height: 350px; margin:50px 0 0 0; " >
									<!--차트가 그려질 부분-->
									<canvas id="myChart"></canvas>
								</div>
																
								<div class="body_footer" id="modify_answer" style="margin:10% 0 0 30%; display:none;" >
									<input type="button" id="modify_button" class="btn btn-primary" value="응답 수정"/> 
								</div>		
							</div>
						</div>
					</div>
				
				<div class="side-cast_listOption" >
					<button id="go_createBoard" class="btn btn-outline-secondary" value="설문 작성" style="width:200px; height:50px; font-size:15px;">설문 작성</button>
					<div class="optionList" style="margin:40px 0 0 10px; font-size:18px; font-weight:bold">
							<div class="option"><a href="#" class="endBoardList" onclick="selectSurveyBoard(1)"><i class="bi bi-stop-fill"></i> 홈으로</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
	$(function(){
	
		console.log(${sbList[0].sbFounderNo})
		console.log(${sessionScope.loginUser.MNo})
		var resultState = "";
		if('${sbList[0].sbResultState}' == 'Y'){
			
			resultState = "공개";
		}else{
			resultState = "비공개";
		}
		
		let noCount = ${memCount} - ${comMemCount};
		
		$('.sb_resultState').html(resultState);
		
		$('.allCount').html(${memCount});
		$('.comCount').html(${comMemCount});
		$('.noCount').html(noCount);
		

		$('.sb_announcement').html('${sbList[0].sbSurveyInfo}');

		
		var p = "";
		p =  ${comMemCount} / ${memCount} * 100;
		
		var q = String(p);
		
		var s = q.substring(0 , 5);
		
		$('.participation_bar').html("<b>" +s + " %<b>");
		
		
		if(${sbAState  != '미참여'}){

			chart();
		
		}
		
		if(${sbAState == '미참여'}){
			
			$('.sb_questionList').css("display" , "block");
			$('#form_div').css("display" , "block");
			
		}else if(${sbAState == '참여 완료' && sbList[0].sbResultState == 'Y'}){
			
			$('.chart_bar').css("display" , 'block');
			$('.participation_box').css("display" , 'block');
			$('#modify_answer').css("display" , 'block');
			
		}else if(${sbAState == '참여 완료' && sbList[0].sbResultState == 'N'}){
			
			$('.participation_box').css("display" , 'block');
			$('#modify_answer').css("display" , 'block');
			
			
		}else if(${sbAState == '종료됨' && sbList[0].sbResultState == 'Y'}){
			
			$('.chart_bar').css("display" , 'block');
			
		}
		
		
		
	})<%-- 시작함수 --%>
	
	
	$('#go_createBoard').click(function(){
	
		
			location.href="createSurveyBoardForm";
	
	})
	

	
	$(document).on('click' , '#formSubmit' , function(){
		

		if($('input[name="sbQuestion"]:checked').val() == null){
					
			$('#sbAnswerCheck').css("color" , "red").text("답변을 입력해 주세요.");
			$("#sbAnswerCheck").show();
		}else{
			
			$("#sbAnswerCheck").hide();
			
			$('.form').submit();
		}
		
		
		
		//console.log(${sbList});
		//console.log(${qList})
	})
	
	
	
	
</script>

<!-- chart.js -->
<script type="text/javascript">
	
function chart(){
	
	var sbNo = $('#sbNo').val();
	console.log(sbNo)
	$.ajax({
		
		url:"chartInfoList",
		data:{
			sbNo:sbNo
			
		},
		
		type:"post",
		success:function(result){
			
			var qList = [];
			var qCount = [];
			
		
			$.each(result.sbList , function(i , sb){
				
				qList.push(sb.sqContent);
				
				$.each(result.qList , function(j , q){
					
					if(q.sqNo == sb.sqNo){
					
						if(qCount[i] == null){
							qCount[i] = 1;
						}else{
							qCount[i] = qCount[i] + 1
						}
						console.log(qCount[i]);
					}
				})
				
			})
			console.log(qCount);
			console.log(qList);
			
			var context = document
		    .getElementById('myChart')
		    .getContext('2d');
		var myChart = new Chart(context, {
		    type: 'bar', // 차트의 형태
			    data: { // 차트에 들어갈 데이터
			        labels: 
			            //x 축
			            qList
			        ,
			        datasets: [
			            { //데이터
			                label: '${sbList[0].sbITitle }', //차트 제목
			                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			                data: 
			                	qCount //x축 label에 대응되는 데이터 값
			                ,
			                backgroundColor: [
			                    //색상
			                    'rgba(255, 99, 132, 0.2)',
			                    'rgba(54, 162, 235, 0.2)',
			                    'rgba(255, 206, 86, 0.2)',
			                    'rgba(75, 192, 192, 0.2)',
			                    'rgba(153, 102, 255, 0.2)',
			                    'rgba(255, 159, 64, 0.2)'
			                ],
			                borderColor: [
			                    //경계선 색상
			                    'rgba(255, 99, 132, 1)',
			                    'rgba(54, 162, 235, 1)',
			                    'rgba(255, 206, 86, 1)',
			                    'rgba(75, 192, 192, 1)',
			                    'rgba(153, 102, 255, 1)',
			                    'rgba(255, 159, 64, 1)'
			                ],
			                borderWidth: 1 //경계선 굵기
			            }
			        ]
			    },
			    options: {
			        scales: {
			            yAxes: [
			                {
			                    ticks: {
			                        beginAtZero: true
			                    }
			                }
			            ]
			        }
			    }
			});
			
		}<%-- success --%>
		
	})
	
	}

		
</script>

<script>
	
	// 게시물 삭제 함수
	$(document).on('click' , '#deleteBoard' , function(){
		
		if(confirm('정말로 삭제하시겠습니까?\n게시물 정보는 복구되지 않습니다.')){
			
			let sbNo = ${sbList[0].sbNo};
			
			location.href="deleteSurveyBoard?sbNo="+sbNo;
		}
		
	})
	
	// 게시글 홈으로 이동
	function selectSurveyBoard(){
		
		
		location.href="surveyBoardForm";
	}
	
	
	//게시글 수정
	$(document).on('click' , '#modifyBoard' , function(){
	
		if(confirm('게시글을 수정하시겠습니까?')){
				
				location.href="modifyBoard?sbNo="+${sbList[0].sbNo};
		}
		
		
	})
	
	// 응답 수정 버튼 클릭시
	$(document).on('click' , '#modify_button' , function(){
		
		$('.participation_box').css("display" , 'none');		
		$('#modify_answer').css("display" , 'none');
		$('.chart_bar').css("display" , 'none');
		
		
		$('.sb_questionList').css("display" , "block");
		
		$('#form_div').css("display" , "block");
		
	})
	
</script>

</body>
</html>