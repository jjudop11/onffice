<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
 	#enrollForm>table{width:100%;}
    #enrollForm>table *{ margin:5px;}
    
    th {
		width: 150px;
	}
    
</style>
</head>
<body>
    <jsp:include page="../common/menubar.jsp"/>
	<div id="app">
	<div id="main">
    <div class="content">
        <div class="innerOuter">
            <form id="enrollForm" method="post" action="insertNotice.do" enctype="multipart/form-data">
                <table align="center">
               		<tr style="display: none;">
                        <th><label for="company">회사 번호 번호</label></th>
                        <td><input type="text" id="company" class="form-control" value="${ sessionScope.loginUser.CNo }" name="C_No"></td>
                    </tr>
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td>
		                	<input type="checkbox" id="important_notice" name="No_Important" value="Y"> 중요<a style="color: red;">!</a>
		                	<input type="text" id="title" class="form-control" name="No_Title" required>
                        </td>
                    </tr>
                    <tr>
                        <th><label for="writerNaem">작성자</label></th>
                        <td><input type="text" id="writeName" class="form-control" value="${ sessionScope.loginUser.MName }" name="No_WriteName" readonly></td>
                    </tr>
                    <tr style="display: none;">
                        <th><label for="writer">작성자 번호</label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ sessionScope.loginUser.MNo }" name="No_Write"></td>
                    </tr>
                    <tr>
                        <th colspan="2"><label for="content">내용</label></th>
                    </tr>
                    <tr>
                        <td colspan="2"><textarea class="form-control" required name="No_Content" id="content" rows="10" style="resize:none;"></textarea></th>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
    </div>
	</div>
	</div>
</body>
</html>