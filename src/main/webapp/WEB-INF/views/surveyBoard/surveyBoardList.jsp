<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	
	.cast_surveyBoardList{
		border-top:1px solid red;
		width:75%;
		height:700px;
		position:absolute;
		padding:30px 20px;
	}
	
	.side-cast_listOption{
		border-left:1px solid blue;
		width:20%;
		height:700px;
		position:absolute;
		right:0px;
		padding:20px 10px;
	
	}
	
	.option:hover{
		border:1 solid rgb(70, 98, 223);
		border-radius:70%;
	}

</style>


</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

	<div id="app">
		<div id="main" style="border:1 solid black; position:relative;">
			<div class="cast_surveyBoardList">
				<div class="sb_header" style="border-bottom:1px solid black">
					<h3>설문 게시판</h3>
				</div>
				<div class="sb_body">
					
				</div>
			</div>
			<div class="side-cast_listOption">
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
	
	
	
	<script>
		
	// 설문 작성 페이지 이동
	$('#go_createBoard').click(function(){
	
		location.href="createSurveyBoardForm";
		
	})
	
	
	
	
	
		$(function(){
		
			selectSurveyBoard(1)
			
	
			
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