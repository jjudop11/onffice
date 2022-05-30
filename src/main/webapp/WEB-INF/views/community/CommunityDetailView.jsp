<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
	<div id="app">
	<div id="main">
    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>커뮤니티</h2>
            <br>
            
            <br><br>
            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ c.comTitle }</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${ c.comDate }</td> 
                </tr>
                <!--  <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:if test="${ !empty b.originName }">
                        	<a href="${ pageContext.servletContext.contextPath }/resources/upload_files/${b.changeName}" download="${ b.originName }">${ b.originName }</a>
                        </c:if>
                        <c:if test="${ empty b.originName }">
                        	첨부파일이 없습니다.
                        </c:if>
                    </td>
                </tr>-->
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4"><p style="height:150px">${ c.comContent }</p></td>
                </tr>
            </table>
            <br>
	
			<c:if test="${ sessionScope.loginUser.MNo eq c.comWrite }">
	            <div align="center">
	                <button class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</button>
	                <button class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</button>
	            </div>
	            
	           <form id="postForm" action="" method="post">
					<input type="hidden" name="ComNum" value="${ c.comNum }">
					 <!-- <input type="hidden" name="fileName" value="${ b.changeName }">  -->
				</form>
				<script>
					function postFormSubmit(num){
						var postForm = $("#postForm");
						
						if(num == 1){
							postForm.attr("action", "updateFormCommu.do");
						}else{
							postForm.attr("action", "deleteCommu.do");
						}
						postForm.submit();
					}
				</script>
            </c:if>
            <br><br>
        </div>
        <br><br>
    </div>
    </div>
    </div>
	<script>
 	$(function(){
		selectReplyList();
		
		$("#addReply").click(function(){
    		var cn = ${c.comNum};

			if($("#replyContent").val().trim().length != 0){
				
				$.ajax({
					url:"rinsertCommunity.do",
					type:"post",
					data:{replyContent:$("#replyContent").val(),
						  refBoardNo:cn,
						  replyWriter:"${loginUser.MNo}"},
					success:function(result){
						if(result > 0){
							$("#replyContent").val("");
							selectReplyList();
							
						}else{
							alert("댓글등록실패");
						}
					},error:function(){
						console.log("댓글 작성 ajax 통신 실패");
					}
				});
				
			}
			
		});
	});
 	
 	function selectReplyList(){
		var cn = ${c.comNum};
		$.ajax({
			url:"rinsertCommunity.do",
			data:{cn:cn},
			type:"get",
			success:function(list){
				$("#rcount").text(list.length);
				
				var value="";
				$.each(list, function(i, obj){
					
					if("${loginUser.MNo}" == obj.replyWriter){
						value += "<tr style='background:#EAFAF1'>";
					}else{
						value += "<tr>";
					}
					
					value += "<th>" + obj.replyWriter + "</th>" + 
								 "<td>" + obj.replyContent + "</td>" + 
								 "<td>" + obj.createDate + "</td>" +
						 "</tr>";
				});
				$("#replyArea tbody").html(value);
			},error:function(){
				console.log("댓글 리스트조회용 ajax 통신 실패");
			}
		});
	}
     
    </script>
</body>
</html>