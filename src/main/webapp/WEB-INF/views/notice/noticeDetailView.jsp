<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 상세보기</h2>
            <br>
            
            <br><br>
            <table id="contentArea" align="center" class="table">
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">${ n.No_Title }</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>${ n.No_Write }</td>
                    <th>작성일</th>
                    <td>${ n.No_Date }</td>
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
                    <td colspan="4"><p style="height:150px">${ n.No_Content }</p></td>
                </tr>
            </table>
            <br>
	
			<c:if test="${ sessionScope.loginUser.MNo eq n.No_Write }">
	            <div align="center">
	                <button class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</button>
	                <button class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</button>
	            </div>
	            
	           <!--  <form id="postForm" action="" method="post">
					<input type="hidden" name="bno" value="${ n.No_Num }">
					 <input type="hidden" name="fileName" value="${ b.changeName }"> 
				</form> -->
				<script>
					function postFormSubmit(num){
						var postForm = $("#postForm");
						
						if(num == 1){
							postForm.attr("action", "updateFormNotice.do");
						}else{
							postForm.attr("action", "deleteNotice.do");
						}
						postForm.submit();
					}
				</script>
            </c:if>
            <br><br>
        </div>
        <br><br>
    </div>
    

</body>
</html>