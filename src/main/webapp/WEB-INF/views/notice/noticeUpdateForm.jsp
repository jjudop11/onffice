<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
	#updateForm>table{width:100%;}
    #updateForm>table *{ margin:5px;}
</style>
</head>
<body>

    <jsp:include page="../common/menubar.jsp"/>
	<div id="app">
	<div id="main">
    <div class="content">
        <br><br>
        <div class="innerOuter">
            <br>
            <form id="updateForm" method="post" action="updateNotice.do" enctype="multipart/form-data">
            	<input type="hidden" name="No_Num" value="${ n.no_Num }">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="checkbox" id="important_notice" name="No_Important" value="${ n.no_Important }">중요 !<input type="text" id="title" class="form-control" name="No_Title" value="${ n.no_Title }" required></td>
                    </tr>
                    <!-- <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                            <input type="file" id="upfile" class="form-control-file border" name="reUploadFile">
                            <c:if test="${ !empty b.originName }">
	                                                               현재 업로드된 파일 : ${ b.originName } <br>
	                            <input type="hidden" name="changeName" value="${ b.changeName }">
	                            <input type="hidden" name="originName" value="${ b.originName }">
                            </c:if>
                        </td>
                    </tr> -->
                    <tr>
                        <th colspan="2"><label for="No_content">내용</label></th>
                    </tr>
                    <tr>
                        <th colspan="2"><textarea class="form-control" required name="No_Content" id="content" rows="10" style="resize:none;">${ n.no_Content }</textarea></th>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                    <button type="button" class="btn btn-danger" onclick="javascript:history.go(-1);">이전으로</button>
                </div>
            </form>
        </div>
        <br><br>
    </div>
    </div>
    </div>
</body>
</html>