<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link rel='icon' type='images/png' href='resources/assets/images/logo/ONLOGO1.png'>
<link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<title>ONFFICE </title>
<style>
	*{
		padding:0;
    	margin:0;
	}
	
	.main{
		border: 1px black solid;
		width: 100%;
		height: 500px;
		
	}
	
	.header{
		border: 1px black solid;
		width: 100%;
		height: 60px;
		display:flex;
		background-color:rgb(143, 248, 196);
		justify-content: center;
        align-items: center;
		
	}
	
	.header-title{
		width:80%;
		text-align:center;
	}
	
	#haeder-menu{
		display:flex;
		width:20%;  
		align-items: center;
	
	}
</style>

<script>
	function submitChatMessageForm(form){
		form.writer.value= form.writer.value.trim();
		
		if(form.writer.value.length== 0){
			alert('작성자를 입력해주세요');
			form.writer.focus();
			
			retrun false
		}
		
		if(form.body.value.length== 0){
			alert('내용을 입력해주세요');
			form.body.focus();
			
			retrun false
		}
		
		var writer = form.writer.value;
		var body form.body.value;
		
		form.body.value='';
		form.body.focus();
	
		
		$.post(
			'/'		
		)
		
	}
</script>
</head>
<body>
<form id="chatRoom">
	
	<div class="main cast">
		<div class="header cast">
			<div class="header-title">
				<b>채팅방 제목</b>
			</div>
			<form onsubmit="submitChatMessageForm(this); return false;">
			<div>
				<input  type="text" name="writer" placeholder="작성자" autocomplete="off"/>
			</div>
			
			<div>
				<input type="text" name="body" placeholder="내용" autocomplete="off"/>
			</div>
			
			<div>
				<input type="submit" value="작성"/>
			</div>
			</form>
			<div class="header-menu"style="display:flex; width:20%; align-items: center;">
				<div class="menu-search" style="width:40%;">
					<svg style="width:30px; height:30px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
				</div>
				<div class="menu-sideBar" style="width:40%;">
					<svg style="width:35px; height:35px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
					</svg>
				</div>
			</div>	
		</div><!-- header end -->
	</div><!-- main end -->
	
</form>
	
	<script>
	const Hyphen = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '') //전체에서  0~9사이에 아무 숫자 '하나'  찾음 
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		}
	
	$('#submit').click(function(){
		
		let phone = $('[name="phone"]').val();
		console.log(phone)
		
		if(phone == ""){
			
			alert("전화번호를 입력해주세요.");
			$('[name="phone"]').focus();
			return false;
			
		}else{
			
			opener.document.getElementById("buyerPhone").value = document.getElementById("newPhone").value
			// url 변경
			location.href="<%=request.getContextPath()%>/updatePhone.do?phone="+phone;
			// 부모창 새로고침
			opener.parent.location.reload();
			// 팝업 닫기
			window.close();
			
		}
		
		
		
		
	})
	
	
	</script>
</body>
</html>