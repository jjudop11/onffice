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
	
	.list_table th, td{
		
		padding:10px 0  10px 10px;
		
	}
	
	.list_table td{
		
		border-bottom:1px solid rgb(159, 160, 167);
		
	}
	
	.go_detail:hover{
	
		background: rgb(250, 248, 115);
		
	}
	
</style>


</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

	<div id="app">
		<div id="main" style="padding:0;">
			<div class="cast_surveyBoardList" >
				<div class="main-cast_lists">
					<div class="sb_header" style="border-bottom:1px solid rgb(159, 160, 167); height:70px; padding:30px 0 0 10px;">
						<h3>설문 게시판</h3>
					</div>
					<div class="sb_body" style="width:100%">
						<div class="body_header" style="padding:50px 0 0 10px; border-bottom:1px solid rgb(159, 160, 167)">
							<h5 class="kind_list"></h5>
						</div>
						<div class="body_main" style=" height:100%;">
							<table class="list_table" style=" border-bottom:1px solid rgb(159, 160, 167); height:100%;">
								<thead>
									<tr style="font-size:12px; padding:0 0 10px 10px; border-bottom:1px solid rgb(159, 160, 167);">
										<th style="width:150px">상태</th>
										<th style="width:450px">설문 제목</th>
										<th style="width:300px">설문 기간</th>
										<th style="width:150px">작성자</th>
									</tr>
								</thead>
								<tbody class="tbody_list" >
								
								</tbody>
							</table>
						</div>
						<div class="body_footer" style="margin:30px 0 0 0px">
							<div id="pagingArea"></div>
						</div>
					</div>
				</div>
				<div class="side-cast_listOption" >
				<button id="go_createBoard" class="btn btn-outline-secondary" value="설문 작성" style="width:200px; height:50px; font-size:15px;">설문 작성</button>
				<div class="optionList" style="margin:40px 0 0 10px; font-size:18px; font-weight:bold">
						<div class="option"><a href="#" class="endBoardList" onclick="selectSurveyBoard(2)"><i class="bi bi-stop-fill"></i> 모든 설문</a></div>
						<div class="option"><a href="#" class="endBoardList" onclick="selectSurveyBoard(3)"><i class="bi bi-stop-fill"></i> 작성한 설문</a></div>
						<div class="option"><a href="#" class="endBoardList" onclick="selectSurveyBoard(4)"><i class="bi bi-stop-fill"></i> 종료된 설문</a></div>
						<div class="option"><a href="#" class="endBoardList" onclick="selectSurveyBoard(1)"><i class="bi bi-stop-fill"></i> 홈으로</a></div>
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

	function selectSurveyBoard(num, pNum){
			
			$.ajax({
				
				url:"selectSBList",
				type:"post",
				data:{
					
					num:num,
					page:pNum
					
				},
				
				success:function(sbList){
					
					if(num == 1){
						$('.kind_list').html('게시글 홈')
					}else if(num == 2){
						$('.kind_list').html('모든 게시글')
					}else if(num == 3){
						$('.kind_list').html('내가 작성한 게시글')
					}else{
						$('.kind_list').html('종료된 게시글')
					}
					
					let val = "";
					let b = '';
		            let page = sbList.page; // 현재페이지
		            let startpage = sbList.startpage; // 시작페이지
		            let endpage = sbList.endpage; // 끝페이지
		            let maxpage = sbList.maxpage; // 최대페이지
					
					
					$.each(sbList.list, function(i, sb){
	
						val += 
							'<tr class="go_detail" style="padding:10px 0 0 10px" onclick="goSurveyBoardDetail('+sb.sbNo+' , \''+ sb.sbAState +'\')">' +	
							"<td>"+ sb.sbAState +"</td>" +
							"<td>"+ sb.sbTitle +"</td>" +
							"<td>"+ sb.sbStartDate +" ~ "+ sb.sbEndDate +"</td>" +
							"<td>"+ sb.sbFounderName +" &nbsp; "+ sb.sbFounderdName +"</td>" +					
							"</tr>"
					})
					
					$('.tbody_list').html(val);

					
					
					b += '<ul class="pagination">';
					if(page != 1) {
						b += '<li class="page-item"><a class="page-link" onclick="selectSurveyBoard('+num+','+ parseInt(page-1) + ');" class="page-btn">Previous</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
					}
                	
                	for(var i = startpage; i <= endpage; i++) {
                		if(i != page) {
                			b += '<li class="page-item"><a class="page-link" onclick="selectSurveyBoard('+num+','+ i + ');" class="page-btn">'+i+'</a></li>'
                		} else {
                			b += '<li class="page-item disabled"><a class="page-link" href="">'+i+'</a></li>'
                		}
                	}
                    
                	if(page != maxpage) {
						b += '<li class="page-item"><a class="page-link" onclick="selectSurveyBoard('+num+','+ parseInt(page+1) + ');" class="page-btn">Next</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Next</a></li>'
					}
                    
                	b += '</ul>';
                	
					$("#pagingArea").html(b);
					console.log(sbList);
					
				}
			

			})
			
	}
	
	
	function goSurveyBoardDetail(sbNo, sbAState){
		
		
		location.href="surveyBoardDetail?sbNo="+sbNo+"&sbAState=" + sbAState;
		
		
	}
	
	</script>
</body>
</html>