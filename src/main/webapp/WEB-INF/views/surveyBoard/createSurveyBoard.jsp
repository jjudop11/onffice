<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.header{
		border-bottom:1px solid rgb(159, 160, 167);
		height:40px;
		width:1400px;
	}

	.surveyBoardInfo{
	
		margin:20px 0 0 0;
		
	}
	
	.surveyBoardInfo th, td{
		padding:20px;
		vertical-align: top;
	}
	
	.table_quetion th{
		width:160px;
		padding:20px 0 0 20px;
		vertical-align: top;
		
	}
	
	.example{
		width:480px;
		border: 1px solid rgb(228, 228, 230); 
		border-radius: 2px;
		font-size:12px;
		color:darkgray;
		min-height:30px;
	}
	
	.exampleWrite{
		width:480px;
		border: 1px solid rgb(159, 160, 167); 
		border-radius: 2px;
		font-size:14px;
		color:black;
		min-height:30px;
	}
	
	
	.exampleList li{
		padding:0 0 5px 0;
	}
	
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>
<div id="app">
	<div id="main">
		<div class="header">
			<h3>설문 작성</h3>
		</div>
	<form action="regSurveyBoard" method="post" id="regSurvey">
		<div class="main_section1" style="display:block; position:absolute;" >
			<table class="surveyBoardInfo">
				<tr>
					<th style="width:140px; ">설문 제목</th>
					<td><input name="sbTitle" class="boardtitle" style="width:600px;" type="text" placeholder="제목을 입력해주세요."/>
						<div id="sbTitleCheck" style="display:none; font-size:0.8em"></div>
					</td>
					
				</tr>
				
				<tr>
					<th>설문 기간</th>
					<td><input name="sbStartDate" class="startDate" type="date"> ~ <input name="sbEndDate" class="endDate" type="date">
						<div id="sbDateCheck" style="display:none; font-size:0.8em"></div>
					</td>
					
				</tr>
				
				<tr>
					<th>설문 대상자</th>
					
					<td>
						<ul>
							<li><input onclick="targetCheck()" name="target" class="public" type="checkbox" value="0"> 전체 공개</li>
							<c:forEach items="${ list }" var="b">
								<li><input onclick="targetCheck()" name="target" class="select" type="checkbox" value="${b.DNo}"> ${b.DName}</li>
							</c:forEach>							
						</ul>
					</td>
				</tr>
				
				<tr>
					<th>설문 결과</th>
					<td>
                    <input type="radio" name="sbResultState" id="open" value="Y">
                    <label for="open">공개</label> &nbsp;&nbsp;
                    <input type="radio" name="sbResultState" id="close" value="N">
                    <label for="close">비공개</label><br>
					</td>
				</tr>
			</table>
			<div class="footer_section1" style="margin:40px 0 0 0;">
	
			<span style="margin:0 40px 0 40%;"><input type="button" class="btn btn-primary" id="nextSection" value="다음"></span>
			<span><input type="button" class="btn btn-secondary" id="endSection" value="취소"></span>
		
			</div>
		</div>
	
		
		<div class="main_section2" style="display:none; position:absolute; padding:30px 0 0 0px; width:1400px;">
			<div class="notice" style="max-height:100px; min-height:100px; border-bottom:1px solid rgb(159, 160, 167); padding:0 0 0 20px; width:100%">
				<span style="font-weight:bold; vertical-align: top; margin:0 50px 0 0;">시작 안내 문구</span>
				<span>
					<textarea id="sbSurveyInfo" name="sbSurveyInfo" style="width:800px; border: 1px solid #ddd; border-radius: 2px; resize: none;"></textarea>		
				</span>
				<div id="surveyInfoCheck" style="display:none; font-size:0.8em; margin:0 0 0 160px;"></div>
			</div>
			<div class="inquiry" style="padding:20px 0 0 0; border-bottom:1px solid rgb(159, 160, 167);">
				<table class="table_quetion">
					<tr>
						<th>질문</th>
						<td>
						<input type="text" id="sbITitle" name="sbITitle" style="width:800px; min-height:20px; border: 1px solid #ddd; border-radius: 2px;" />
						<div id="sbITitleCheck" style="display:none; font-size:0.8em; padding:10px 0 0 0;"></div>
						</td>
					</tr>
					<tr>
						<th>설문 문항 타입</th>
						<td>
							<input type="radio" name="sbIType" id="single" value="S">
		                    <label for="single">단답형</label> &nbsp;&nbsp;
		                    <input type="radio" name="sbIType" id="multi" value="M">
		                    <label for="multi">복수형</label><br>
						</td>
					</tr>
					<tr>
						<th>보기</th>
						<td>
							<ul class="exampleList">
								<li>
									<input class="example" type='text' value="보기를 추가하려면 이곳을 클릭하세요." readonly/>
									<div id="exampleCheck" style="display:none; font-size:0.8em;"></div>		
								</li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<div class="footer_section2" style="margin:40px 0 0 0;">
	
			<span style="margin:0 20px 0 40%;"><input type="button" class="btn btn-primary" id="createComplite" value="작성 완료"></span>
			<span style="margin:0 20px 0 0;"><input type="button" class="btn btn-secondary" id="backSection" value="이전"></span>
			<span><input type="button" class="btn btn-danger" id="exitSection" value="작성 취소"></span>
			</div>
		</div>
	</form>

		
	</div>
</div>


<script>
// section1 


	$(function(){

		var date = new Date(+ new Date() + 3240 * 10000).toISOString().substring(0, 10);
		
		$('.startDate').val(date);
		$('.endDate').val(date);
		
		$('.public').attr('checked' , true);
		$('#open').attr('checked' , true);
		$('#single').attr('checked', true);
		
		targetCheck();
		
	})
	
	// 다음으로 넘거가기 전에 빈갑 체크
	$('#nextSection').click(function(){

		var bt = $('.boardtitle').val();

		if(bt == ""){
			
	
			$('#sbTitleCheck').css("color" , "red").text("제목을 입력해 주세요.");
			$("#sbTitleCheck").show();
			$('.boardtitle').focus();

		}else{
			
			$("#sbTitleCheck").hide();
			$('.main_section1').css('display' , 'none');
			$('.main_section2').css('display' , 'block');
		}
		
		

	})
	
	
	$('#endSection').click(function(){
		
		location.href="surveyBoardForm";
		
	})
	
	
	// 끝 날짜 기간 체크
	$('.endDate').change(function(){
	
		var ed = $('.endDate').val();
		var sd = $('.startDate').val();
		
		
		if(ed <sd){
			
			$('#sbDateCheck').css("color" , "red").text("끝 날짜는 시작날짜 보다 빠를수 없습니다.");
			$("#sbDateCheck").show();
			
			var date = new Date(+ new Date() + 3240 * 10000).toISOString().substring(0, 10);
			
			$('.endDate').val(date);
			
		}else{
			
			$("#sbDateCheck").hide();
		}
		
	})
	
	// 시작 날짜 기간 체크
	$('.startDate').change(function(){
	
		var ed = $('.endDate').val();
		var sd = $('.startDate').val();
		
		var date = new Date(+ new Date() + 3240 * 10000).toISOString().substring(0, 10);
		
		if(sd < date){
			
			$('#sbDateCheck').css("color" , "red").text("시작 날짜는 오늘 보다 느릴수 없습니다.");
			$("#sbDateCheck").show();

			$('.startDate').val(date);
			
		}	
		else if(ed < sd){
			
			$('#sbDateCheck').css("color" , "red").text("시작 날짜는 끝날짜 보다 느릴수 없습니다.");
			$("#sbDateCheck").show();

			$('.startDate').val(date);
			
		}else{
			
			$("#sbDateCheck").hide();
		}
		
	})
	
	
	
	// 설문 대상 공개 여부
	function targetCheck(){
		

		if($('.public').is(":checked")){
			
			$(".select").prop("checked" , false);
			$(".select").attr("disabled" , true);
			
		}else{
			
			$(".select").attr("disabled" , false);
			
		}
		
		
	}

</script>


<script type="text/javascript">
// section2

	$(document).on('click' , '#backSection' , function(){
		
		$('.main_section1').css('display' , 'block');
		$('.main_section2').css('display' , 'none');
		
		
		
	})
	
	// 작성 취소 버튼
	$(document).on('click' , '#exitSection' , function(){
		
		if(confirm('정말 취소하시겠습니까? \n작성중인 내용은 저장되지 않습니다.')){
			
			location.href="surveyBoardForm";
		}
		
		
		
	})

	// 작성 완료 버튼
	$(document).on('click' , '#createComplite' , function(){
		
		if($('#sbSurveyInfo').val() == ""){
			
			$('#surveyInfoCheck').css("color" , "red").text("안내 문구를 작성해 주세요.");
			$("#surveyInfoCheck").show();
		}else{
			
			$("#surveyInfoCheck").hide();
		}
		
		if($('#sbITitle').val() == ""){
			
			$('#sbITitleCheck').css("color" , "red").text("질문 제목을 작성해 주세요.");
			$("#sbITitleCheck").show();
			
		}else{
			
			$("#sbITitleCheck").hide();
		}
		
		
		if($('.exampleWrite').val() == null){
			
			$('#exampleCheck').css("color" , "red").text("최소 하나의 보기를 작성해 주세요.");
			$("#exampleCheck").show();
		}else{
			$("#exampleCheck").hide();
		}
		
		if($('#sbSurveyInfo').val() != "" && $('#sbITitle').val() != "" && $('.exampleWrite').val() != null){
			
			if(confirm('작성을 완료하시겠습니까?')){
				
				$('#regSurvey').submit();
			}
			
		}
		
	})
	
	
	
	// 질문 보기 추가
	$('.example').click(function(){
		
		
		var list = $('.exampleList').html();
				
				list = 
					
					"<li>" +
						"<input name='questionContent' class='exampleWrite' type='text'/> &nbsp;" +
						"<a href='#' class='delExample'>" +
							"<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x-lg' viewBox='0 0 16 16'>" +
							  "<path d='M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z'/>" +
							"</svg>" +
						"</a>" +
					"</li>" 
			
					
		$('.exampleList').prepend(list);

		
	})
	
	
	// 질문 보기 삭제
	$(document).on("click" , '.delExample' ,function(){
			
	
			$(this).parent().remove();
		
	})

</script>
</body>
</html>