<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
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
	
</style>
</head>
<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	<div class="cast">
		<div class="title" style="display:flex; margin:0 0 20px 0">
			<div class="title1"><h2>채팅방 </h2></div>
			<div class="title2"><a data-toggle="modal" data-target="#loginModal" class="createCR">채팅방 생성</a></div>
		</div>
		<hr class="divLine">
  		<table id="boardList">
           
                <tbody>
                	<c:forEach items="${ list }" var="b">
	                    <tr>
	                        <td style="padding:10px 0 0 0;"><h5>${ b.crTitle }(${ b.crCount })</h5></td>
	                        <td>
								<svg style="width:40px; height:40px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-heart" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M2.965 12.695a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2Zm-.8 3.108.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125ZM8 5.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z"/>
								</svg>
							</td>
	                        <td >
	                        <c:if test="${ !empty b.crPw }">	                 
	                        	<svg style="width:40px; height:40px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
								  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
								</svg>
	                        </c:if>
	                   		<td>
							
	                    </tr>
	                    <tr><td colspan=3><hr class="divLine1" ></td></tr>
                    </c:forEach>
                </tbody>
            </table>
	

	 <!-- 로그인 클릭 시 뜨는 모달  -->
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-fullsize">
            <div class="modal-content modal-fullsize">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">채팅방 생성</h4>
                <button type="button" class="close" data-dismiss="modal" onclick="exitModal()">&times;</button> 
            </div>

            <form action="login.do" method="post">
                <!-- Modal Body -->
                <div class="modal-body">
                    <label for="crTitle" class="mr-sm-2">그룹명 :</label>
                    <input type="text" class="form-control mb-2 mr-sm-2" placeholder="그룹명을 입력하세요." id="crTitle" name="crTitle"> <br>
                    <label for="userPwd" class="mr-sm-2">초대할 대상 :</label>
                    <a data-toggle="modal" href="#myModal2" class="btn btn-primary" id="btn btn-primary" onclick="ajaxStart()">추가하기</a>
                    <input type="text" class="form-control mb-2 mr-sm-2" id="inviteList" name="inviteList"><br>
                    <label for="userPwd" class="mr-sm-2">비밀번호 설정 <input class="" type="checkbox" id="pwCheck"></label>
                    <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter password" id="crPw" name="crPw" readOnly>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="exitModal()">취소</button>
                </div>
            </form>
            </div>
        </div>
    </div>
    
     <div class="modal" id="myModal2">
        <div class="modal-dialog">
            <div class="modal-content">
            	<!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">검색하기</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div><input type="text" class="form-control mb-2 mr-sm-2" placeholder="사원명 검색" id="searchUser" name="searchUser"> <br></div>
                <div class="container"></div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <table class="CR_mList" id="CR_mlist">
                    	
                    </table>
                    
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                    <a href="#" class="btn btn-primary">Save changes</a>
                </div>
            </div>
        </div>
    </div>

    <br clear="both">
    
    	<script>
		window.onload = function(){
		// 전화번호 업데이트하는 이벤트
		$("#createRoom").click(function() {
			window.name = "parent";
			// 팝업 url
			let url = "createChatRoom.do";
			// 팝업 이름
			let name = "createChatRoomPopup";
			// 팝업 속성
			let option = "width = 500, height = 600, top = 50%, left = 50%, location = no";
			
			open(url, name, option);
						
		})
		}
		
			$("#pwCheck").change(checkedchange)
			function checkedchange(){
				if($(this).prop("checked")){
					$("#crPw").attr("readOnly", false);
				}else{
					$("#crPw").attr("readOnly", true);
				}			
	        }
			
			function exitModal(){
			$('.modal').on('hidden.bs.modal', function (e) {
				  $(this).find('form')[0].reset()
				  $('#pwCheck').attr("checked" , false);
				  $("#crPw").attr("readOnly", true);
				  
				});
			}
	</script>
	
	<script type="text/javascript">
	
	window.onload = function ajaxStart(){
		$('#btn btn-primary').onclick(function(){
			console.log("함수동작확인");
			$.ajax({
				
				url:"CR_selectUserList.do",
				type:"get",
				success: function(mList){
					
					var value="";
					
					$.each(mList, function(i, m){
						
						value += 
							
							"<tr>" +
							"<th rowspan=2><label><img src='resources/assets/images/faces/" + ${m.pNo} + ".jpg' alt= Face " + i + "></label></th>" +
							"<td>" + m.mName + "<td>" +
							"<td><input type='radio'></td>" +
							"</tr>" +
							"<tr><td colspan=4><hr class='CRdivLine'><td></tr>
						
							
					})
					
					$('#searchUser').html(value);
					
					
				},error:function(request, error){
		   	   		
		   	   		//alert("fail");
		   	   		alert("code:" + request.status + "\n" + "message:" + request.reponseText + "\n" + "error:" + error);
		   	   		
			   		//console.log("ajax통신실패");
			   		//console.log(list)
	   		
				  }
			
		})
	}
	</script>
</body>
</html>