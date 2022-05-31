<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<style>
<style type="text/css">
.search {
  position: relative;
  width: 300px;
}

input {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}

img {
  position : absolute;
  width: 17px;
  top: 10px;
  right: 12px;
  margin: 0;
}
</style>
</head>
<body>
<script>
 	function selectReplyList(){
		var cn = ${c.comNum};
		$.ajax({
			url:"rListCommunity.do",
			data:{cn:cn},
			type:"get",
			success:function(list){
				$("#rcount").text(list.length);
				
				var value="";
				$.each(list, function(i, obj){
					
					if("${loginUser.MNo}" == obj.ComReWriter){
						value += "<tr style='background:#EAFAF1'>";
					}else{
						value += "<tr>";
					}
					
					value += "<th>" + obj.ComReWriter + "</th>" + 
								 "<td>" + obj.ComReContent + "</td>" + 
								 "<td>" + obj.ComReDate + "</td>" +
						 "</tr>";
				});
				$("#replyArea tbody").html(value);
			},error:function(){
				console.log("댓글 조회 실패");
			}
		});
	} 
</script>
<script type="text/javascript">
$(function(){
	selectReplyList();
	
	$("#addReply").click(function(){
		var cn = ${c.comNum};

		if($("#replyContent").val().trim().length != 0){
			
			$.ajax({
				url:"rinsertCommunity.do",
				type:"post",
				data:{ComReContent:$("#replyContent").val(),
					  ComPreNum:cn,
					  ComReWriter:"${loginUser.MNo}"},
				success:function(result){
					if(result > 0){
						$("#replyContent").val("");
						selectReplyList();
						
					}else{
						alert("댓글등록실패");
					}
				},error:function(){
					console.log("댓글 작성 실패");
				}
			});
			
		}
		
	});
});
</script>
    <jsp:include page="../common/menubar.jsp"/>
	<div id="app">
	<div id="main">
    <div class="content">
        <div class="innerOuter">
            <h2>커뮤니티</h2>
            <br>
            <div class="search">
			  <input type="text">
			  <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
			</div>
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
        </div>
        <br>
        <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
	                    <th colspan="2" style="width:75%">
	                    <textarea class="form-control" id="ComReContent" rows="2" style="resize:none; width:100%"></textarea>
	                    </th>
	                    <th style="vertical-align: middle"><button class="btn btn-secondary" id="addReply">등록하기</button></th>
                    </tr>
                    <tr>
                       <td colspan="3">댓글 (<span id="rcount">0</span>) </td> 
                    </tr>
                </thead>
                <tbody>
                
                </tbody>
		</table>
    </div>
    </div>
    </div>
</body>
</html>