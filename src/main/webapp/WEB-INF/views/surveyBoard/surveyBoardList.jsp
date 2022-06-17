<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	
	.cast_surveyBoardList{

		height:700px;
		padding:30px 20px; 
		display:flex;
	}
	
	.main-cast_lists{
		width:80%;
		left:0px;
	}
	
	.side-cast_listOption{
		border-left:1px solid rgb(159, 160, 167);
		width:20%;
		height:700px;
		right:0px;
		padding:20px 10px;

	}
	
	
</style>


</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

	<div id="app">
		<div id="main">
			<div class="cast_surveyBoardList" >
				<div class="main-cast_lists">
					<div class="sb_header" style="border-bottom:1px solid rgb(159, 160, 167); height:70px; padding:30px 0 0 10px;">
						<h3>설문 게시판</h3>
					</div>
					<div class="sb_body">
						<h5 class="kind_list"></h5>
					</div>
				</div>
				<div class="side-cast_listOption" >
				<button id="go_createBoard" class="btn btn-outline-secondary" value="설문 작성" style="width:200px; height:50px; font-size:15px;">설문 작성</button>
				<div class="optionList" style="margin:40px 0 0 10px; font-size:18px; font-weight:bold">
						<div class="option"><a href="#" class="endBoardList"><i class="bi bi-stop-fill"></i> 종료된 설문</a></div>
						<div class="option"><a href="#" class="endBoardList"><i class="bi bi-stop-fill"></i> 모든 설문</a></div>
						<div class="option"><a href="#" class="endBoardList"><i class="bi bi-stop-fill"></i> 작성한 설문</a></div>
						<div class="option"><a href="#" class="endBoardList"><i class="bi bi-stop-fill"></i> 홈으로</a></div>
				</div>
			</div>
			</div>
		</div>
	</div>
	
	
	
	<script>
		
	
	$(function(){
		
		selectSurveyBoard(1)
		

		
	})
	
	// 설문 작성 페이지 이동
	$('#go_createBoard').click(function(){
	
		location.href="createSurveyBoardForm";
		
	})

		function selectSurveyBoard(num){
				
				$.ajax({
					
					url:"selectSBList",
					type:"post",
					data:{
						
						num:num
						
					},
					
					success:function(sbList){
						
						console.log(sbList);
						
					}
				

				})
				
		}
	
	</script>
</body>
</html>