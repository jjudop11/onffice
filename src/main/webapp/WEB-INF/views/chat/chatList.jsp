<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

 
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css?family=Amatic+SC');

	.cast {
		position:absolute; left:20%;
		width:70%;
		hight:auto;
		border: 3px solid #E2E2E2;
		padding: 20px; 

	}
	
	#boardList{
		width:80%;	
		margin:auto;
	
	}
	
	#boardList > tbody{

		padding:0 0 0 20px;
		
	}
	
	#boardList > thead > tr > th .bNo{
		width:7%;
	}
	
	.divLine{
		width:100%;
		align:center;
	}
	
	.divLine1{
		width:100%;
		align:center;
	}
	
	.CRdivLine{
		width:100%;
		align:center;
	}
	
	.title1 {
		flex:1; 
		width:20%;
	}
	
	.title2{
		flext:1; 
		width:10%;
		font-size:20px;
		color: inherit;
	}
	
	.modal-dialog.modal-fullsize {
	  width: 100%;
	  height: 70%;
	  margin: 0;
	  padding: 0;
	  top:100px;
	  left:800px;
	  
	}

	.modal-content.modal-fullsize {
	  height: auto;
	  min-height: 100%;
	  border-radius: 0; 
	}
	
	.imageSize{
		width:60px;
		height:60px;
	}
	
	#CR_mlist{
		width:450px;
		height:100%;
	
	}
	
	.td1{
		width:70px;
		
	}
	
	.countTd{
		vertical-align:bottom;
		padding:10px 0 0 10px; 
		width:50%; 
		display:flex; 
	}
	
	.InviteUser:hover{
		background:lightgray;
	}
	
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>

	<div class="cast">
		<div class="title" style="display:flex; margin:0 0 20px 0">
			<div class="title1"><h2>채팅방 </h2></div>
			<div class="title2"><a data-toggle="modal" data-target="#createCRModal" class="createCR">채팅방 생성</a></div>
		</div>
		<hr class="divLine">
  		<table id="boardList">
           		<!-- 채팅방 리스트 -->
                <tbody id="chatList">
                	
                </tbody>
            </table>
	

	 <!-- 채팅방 생성 클릭 시 뜨는 모달  -->
    <div class="modal fade" id="createCRModal">
        <div class="modal-dialog modal-fullsize" id="modalDialog">
            <div class="modal-content modal-fullsize">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">채팅방 생성</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button> 
            </div>

            <form action="createChatRoom" method="post" id="createChatRoom">
                <!-- Modal Body -->
                <div class="modal-body">
                    <label for="crTitle" class="mr-sm-2">그룹명 :</label>
                    <input type="text" class="form-control mb-2 mr-sm-2" placeholder="그룹명을 입력하세요." id="crTitle" name="crTitle"> 
                    <div id="crTitleCheck" style="display:none; font-size:0.8em"></div> <br>
                    <label for="userPwd" class="mr-sm-2">초대할 대상 :</label>
                    <a data-toggle="modal" href="#myModal2" class="btn btn-primary" id="inviteUser">추가하기</a>
                    
                    <!-- 선택된 사원 정보 -->
                    <div class="form-control mb-2 mr-sm-2" id="inviteUserList" style="min-height:40px;"></div>
                   
                    <div id="inviteUserCheck" style="display:none; font-size:0.8em"></div> <br>
                    <label for="userPwd" class="mr-sm-2">비밀번호 설정 <input class="" type="checkbox" id="pwCheck"></label>
                    <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter password" id="crPw" name="crPw" readOnly>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" id="encodeRoom" class="btn btn-primary">채팅방 생성</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                </div>
            </form>
            </div>
        </div>
    </div>
    
     <div class="modal fade" id="myModal2">
        <div class="modal-dialog modal-fullsize" >
            <div class="modal-content modal-fullsize" >
            	<!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">검색하기</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div><input type="text" class="form-control mb-2 mr-sm-2" placeholder="사원명 검색" id="searchUser" name="searchUser"></div>
                <div class="container"></div>
                <!-- Modal Body -->
                <div class="modal-body" style="overflow:auto; height:500px;">
                <!-- 사원 리스트 출력 테이블 -->
                    <table class="form-CR_mList" id="CR_mlist">
                    	
                    </table>
                    
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                	<a href="#" data-dismiss="modal" class="btn btn-primary" id="selectEnrollUser">추가하기</a>
                    <a href="#" data-dismiss="modal" class="btn btn-danger">닫기</a>
                    <input type="hidden" id="listCount" value=""></input> 
                </div>
            </div>
        </div>
    </div>
</div>
    <br clear="both">
    
    <script>
    	
    	$(function(){
    		
    		console.log("onload 함수 작동")
    		$.ajax({
    			
    			url:"selectChatRoomList",
    			
    			success(List){
    				
					var value="";
					
					$.each(List, function(i, c){
						
						if(c.crPw != null){
						value += 
    				
						"<tr>" +
                        	"<td class='countTd' style='width:100%;'><h4>" + c.crTitle+"</h4><h5>(" +  c.crCount  +" 명)</h5></td>" +
                        
	                        "<td style='width:20%;'><svg style='width:40px; height:40px;' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-heart' viewBox='0 0 16 16'>" +
								  "<path fill-rule='evenodd' d='M2.965 12.695a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2Zm-.8 3.108.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125ZM8 5.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z'/>" +
								"</svg></td>" +
						
	                        "<td id='lockIcon+"+i+"' style='width:20%;'>" +	                 
		                        "<svg style='width:40px; height:40px;' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-lock-fill' viewBox='0 0 16 16'>" +
							  	   "<path d='M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z'/>" +
								"</svg>" +
							"</td>" +
	                   		"<td >" +
		                   		"<form action='chatRoom/"+ c.crNo +"' id='EnrollChatForm"+i+"' method='post'>" +
			                   		"<input onClick='check("+i+")' class='btn btn-primary' name='createRoom' type='button' value='입장'/ style='width:60px; float:right;'>" +
									"<input type='hidden'  value='"+c.crNo +"' name='crNo' id='crNo"+i+"'>" +
									"<input type='hidden'  value='"+c.crTitle+"' name='crTitle'>" +
									"<input type='hidden'  value='"+c.crPw+"' name='crPw' id='pw"+i+"'>" +
								"</form>" +
							"</td>" +
						"</tr>" +
                    	"<tr><td colspan=5><hr class='divLine1' ></td></tr>"
							
    					}
				
    					else if(c.crPw == null){
    						value +=
    							
							"<tr>" +
	                        "<td class='countTd' style='width:100%;'><h4>" + c.crTitle+"</h4><h5>(" +  c.crCount  +" 명)</h5></td>" +
	                        
	                        "<td style='width:20%;'><svg style='width:40px; height:40px;' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-heart' viewBox='0 0 16 16'>" +
								  "<path fill-rule='evenodd' d='M2.965 12.695a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2Zm-.8 3.108.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125ZM8 5.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z'/>" +
								"</svg></td>" +
							
	                        "<td id='lockIcon+"+i+"' style='width:20%;'>" +	                 
								"</td>" +
	                   		"<td >" +
	                   		"<form action='chatRoom/"+ c.crNo +"' id='EnrollChatForm"+i+"' method='post'>" +
	                   		"<input onClick='check("+i+")' class='btn btn-primary' name='createRoom' type='button' value='입장'/ style='width:60px; float:right'>" +
							"<input type='hidden'  value='"+c.crNo +"' name='crNo' >" +
							"<input type='hidden'  value='"+c.crTitle+"' name='crTitle'>" +
							"</form>" +
							"</td>" +
							"</tr>" +
	                    	"<tr><td colspan=5><hr class='divLine1' ></td></tr>"
						
							
							
	    					}
	
						
					})
					
						
					
					$('#chatList').html(value);
					
					
					
				},error:function(request, error){
		   	   		
		
		   	   		alert("code:" + request.status + "\n" + "message:" + request.reponseText + "\n" + "error:" + error);
		   	   		
			   		console.log("ajax통신실패");
			   		//console.log(mList)
	   		
					 }
    				
    		})
    		
    	})
    		
    </script>

    <script>
    		// 채팅방 생성 버튼 클릭시
    		$("#encodeRoom").click(function(){

    			// 채팅방 제목의 val값을 가져옴
    			var crTitle = $("#createChatRoom input[name=crTitle]").val();
    			
    			// 채팅방 초대 리스트의 값을 가져옴
    			var inviteUser = $("#inviteUserList").html();
    			
    			// 채팅방 제목이 빈칸이면 밑에 경고 문구 출력
    			if(crTitle == ""){
    				
    				CheckCrTitle(1);
    			}else{
    				CheckCrTitle(0);
    			}
    			// 채팅방 초대 목록이 빈칸이면 밑에 경고 문구 출력
    			if(inviteUser == ""){
    				CheckInvUser(1);
    			}else{
    				CheckInvUser(0);
    			}
    			// 채팅방 제목과 초대목록이 모두 빈칸이 아니면
    			if(crTitle != "" && inviteUser != ""){
    				
    				// 채팅방 생성 함수 실행
    				CreateChatRoom();
        			
    			}
    		})
    			
    		// 채팅방 제목의 상태에 따라 경고문구 출력함수
    		function CheckCrTitle(num){
    			
    			if(num == 1){
    				
    				$('#crTitleCheck').css("color" , "red").text("그룹명을 지정해 주세요.");
    				$("#crTitleCheck").show();
    				$("#crTitle").focus();
    				
    			}else if(num == 0){
    				
    				$("#crTitleCheck").hide();
    			}
    			
    		}
    			
    		// 채팅방 초대목록의 상태에 따라 경고문구 출력함수
    		function CheckInvUser(num){
    		
    			
    			if(num == 1){
    				$('#inviteUserCheck').css("color" , "red").text("초대할 대상을 선택해 주세요.");
    				$("#inviteUserCheck").show();
    				
    			}
    			
    			else if(num == 0){
    				$("#inviteUserCheck").hide();
    			}
    			
    		}
    		
    		// 채팅방 생성 함수
    		 function CreateChatRoom(){
    			 $("#crTitleCheck").hide();
    			 
    			 // 채팅방 생성할 것인지 확인
    			if(confirm('채팅방을 생성하시겠습니까?')){
    				
    				var crTitle = $('#crTitle').val();
    				var crPw = $('#crPw').val();
    				
    				$.ajax({
    					
    					url:"createChatRoom",
    					type:"post",
    					data:{
    						crTitle:crTitle,
    						crPw:crPw
    					},
    					
    					success: function(result){
    		
    						// 채팅방 생성 성공 시 이벤트 강제 호출
    						$('#createCRModal').trigger('hidden.bs.modal');
    						// 모달창 닫기 위해 새로고침
    						location.reload();
    					
    						
    					},error:function(request, error){

    						alert("채팅방 생성에 실패하였습니다.");
    				   		console.log("채팅방 생성 실패");
    				   		//console.log(mList)
    		   		
    						 }
    				})
    				
    			}
    			
    		 }	 
    
			// 비밀번호 체크박스 선택 시 바뀌는 이벤트
			$("#pwCheck").change(checkedchange)
			function checkedchange(){
				if($(this).prop("checked")){
					$("#crPw").attr("readOnly", false);
				}else{
					$("#crPw").attr("readOnly", true);
				}			
	        }
			
			// 모달창 종료시 안에 입력된 값들 초기화 시키는 메소드
			$('.modal').on('hidden.bs.modal', function exitModal(e) {
				  $(this).find('form')[0].reset()
				  $('#pwCheck').attr("checked" , false);
				  $("#crPw").attr("readOnly", true);
				  deleteCheckedUser()
				  console.log("모달종료함수")
				});
			
			// 체크된 유저 삭제하는 함수
			function deleteCheckedUser(crNo){
				console.log('삭제 함수 실행')
				$.ajax({
				
				  url:"deleteCheckedUser",
				  type:"get",
				  
				  success : function(data) {
					  
					  if(data == 1){
					  checkedUserList();
					  }
					}
				  
			  })
			}
	</script>
	 
	<script>
	

		// 채팅방 생성시 초대할 유저 목록 이벤트
		$("#inviteUser").click(function(){

			$.ajax({
				url:"crSelectUserList",
				type:"post",
				success: function(mList){

					$('#listCount').val(mList.length);
					
					var value="";
					
					$.each(mList, function(i, m){
				
						value += 
							
							"<tr>" +
							"<td rowspan=2 class='td1'><label ><img class='imageSize' src='resources/assets/images/faces/" + m.pNo + ".jpg' alt= Face " + i + "></label></td>" +
							"<td class='td1'><b>" + m.mName + "</b></td>" +
							"<td class='td1'></td>" +
							"<td class='td1'></td>" +
							"<td class='td1'></td>" +
							"<td rowspan=2><input class='form-radio' id='CK_User"+i+"' value='" + m.mNo + "' type='checkbox'></td>" +
							"</tr>" +
							
							
							"<tr>" +
							"<td class='td1'>" + m.jName + "</td>" +
							"<td class='td1'>" + m.dName + "</td>" +
					
							"</tr>" +
							
							
							"<tr><td colspan=8><hr class='CRdivLine'></td></tr>" +
							"<input type='hidden' id='mName"+i+"' value='"+m.mName+"'>"
							
					})
					
					$('#CR_mlist').html(value);
					
					
					
				},error:function(request, error){
		   	   		
		
		   	   		alert("code:" + request.status + "\n" + "message:" + request.reponseText + "\n" + "error:" + error);
		   	   		
			   		console.log("ajax통신실패");
			   		//console.log(mList)
	   		
					 }
				
				})

		})

		// 초대할 유저를 목록에 담을 함수
		$('#selectEnrollUser').click(function(){
			
			var mList = $('#listCount').val();
			//console.log(mList)
			var eList = [];
			var arr = {};
			for(let i = 0; i < mList; i++){
				
				if($('#CK_User'+i).is(":checked")==true){
				
					var mName = $('#mName'+i).val();
					var mNo = $('#CK_User'+i).val();
					//console.log(mName)
					//console.log(mNo)
			 		arr = {
			 			mName: mName,
			 			mNo: mNo		
			 		}
					
			 		eList.push(mNo);
				} 
				
			}

			if(eList.length > 0){
			insertCKUserList(eList);
			}
			// 초대할 유저 목록을 controller단에 보내주는 함수
			function insertCKUserList(eList){
				
				$.ajax({
					
					url : "insertSelectUserList",
					type : "post",
					//contentType:'application/json; charset=UTF-8',
					//dataType:'json' ,
					//data:JSON.stringify(eList),
					data:{eList:eList},
					
					
					success : function (data) {
						
						if(data == 1){
						checkedUserList();
						
						console.log("json전달 성공")
						$("#inviteUserCheck").hide();
						}else{
							
							console.log(eList)
						}
					},error:function(request, error){
			   	   		
						console.log(JSON.stringify(eList))
			   	   		alert("code:" + request.status + "\n" + "message:" + request.reponseText + "\n" + "error:" + error);
			   	   		
				   		console.log("ajax통신실패");
				   		//console.log(mList)
		   		
						 }
				})
			}
			
		})
		
		// 선택된 유저를 뿌려주는 함수
		function checkedUserList(){ 

		$.ajax({
					
			url : "checkedUserList",
			type : "post",
				
			success : function (mList) {
	        	console.log(mList)
				var count = mList.length;
				
				var value= "";
				
				$.each(mList, function(i, m){
					
					value += 
						"<span><input id='userList"+i+"' onclick='IUserDelete("+i+")'  type='text' class='InviteUser' value='"+m.mName+"' readonly style='border-radius:10px; width:17%; margin:0 5px 10px 0; text-align:center;'></input></span>" +
						"<input type='hidden' value='"+m.mNo+"' id='inviteUserList"+i+"'>"
			
				})
				
				$('#inviteUserList').html(value);
				
			},error:function(request, error){
	   	   		
				
	   	   		alert("code:" + request.status + "\n" + "message:" + request.reponseText + "\n" + "error:" + error);
	   	   		
		   		console.log("ajax통신실패");

				 }
			})
		}
		
		// 채팅방 입장시 비밀번호 체크해서 들어가는 함수
		function check(i){

			crNo = $('#crNo'+i).val();
			var pw = $('#pw'+i).val();

			if(pw != ""){
				
				$.ajax({
					
					url:"checkCRUser",
					type:"post",
					data:{
						crNo:crNo
					},
					
					success:function(list){
				
					
						if(list != ""){
							
							$('#EnrollChatForm'+i).submit();
							
						}else{
							
							var pw = $('#pw'+i).val();

							console.log('pw ======= ' + pw)
							
							var checkPw = prompt("비밀번호를 입력하세요");
							
							
							
							if(checkPw == pw){
								

								$('#EnrollChatForm'+i).submit();
								
								
							}else{
								
								alert('비밀번호가 일치하지 않습니다.');
								

							}
							
						}

					}

				})
				
			}else{
				
				$('#EnrollChatForm'+i).submit();
			}
			

		}
		
		function IUserDelete(i){
			
			let mNo = $('#inviteUserList'+i).val(); 

			$.ajax({
			
				url:"IMemberDelete",
				type:"post",
				data:{
					mNo:mNo
				},
				
				success:function(e){
					
					if(e == 1){

						checkedUserList();	
					}
					
					
				}
				
				
			})
			
			
			
			
		}
		
		
		
	</script>
	
	

	 
</body>
</html>