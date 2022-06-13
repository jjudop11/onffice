<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${chat.crTitle} 방</title>
    
    <!-- STOMP사용을 위한 cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- SockJS사용을 위한 cdn -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
	
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
	<style>
	*{
		padding:0;
    	margin:0;
	}
	
	.main{
		border: 1px black solid;
		width: 400px;
		min-height: 700px;
		display: inline-block;
		padding:0;
		position:static;
	}
	
	.header{
		width: 100%;
		height: 60px;
		display:flex;
		background-color:rgb(143, 248, 196);
		justify-content: center;
        align-items: center;
		
	}
	
	.header-title{
		width:70%;
		text-align:center;
	}
	
	.haeder-menu{
		display:flex;
		width:100%;  
		align-items: center;
	
	}
	
	.body{
		height:550px;
		position:relative;
		overflow:auto;
		background-color: rgb(149, 217, 248);
		width:400px;
	}
	
	.footer{
		height:80px;
		border-sizing: border-box;
		display: flex;
	}
	
	.profileImg{
		width:100%;
		height:100%;
		object-fit:cover;
	}
	
	.sidebar{
		display:none;
		left:330px;
		height:550px;
		width:200px;
		position:fixed;
		background:rgba(192, 214, 245, 0.897);
		z-index:1;
		border-right:1px solid black;
		border-left:1px solid rgb(203, 207, 209);
		
	}
	
	.sidebar.enter{
		display:block;
	}
	
	
	
<%-- 채팅박스 --%>
	html, body {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
    font-family: sans-serif;

	}
	body {

	  display: flex;
	  align-items: center;
	  justify-content: center;
	    flex-direction: column;
	}
	::-webkit-scrollbar {
	  width: 8px;
	}
	::-webkit-scrollbar-thumb {
	  background-color: #4c4c6a;
	  border-radius: 2px;
	}
	.chatbox {
	    width: 300px;
	    height: 400px;
	    max-height: 400px;
	    display: flex;
	    flex-direction: column;
	    overflow: hidden;
	    box-shadow: 0 0 4px rgba(0,0,0,.14),0 4px 8px rgba(0,0,0,.28);
	}
	.chat-window {
	    flex: auto;
	    max-height: calc(100% - 60px);
	    background: #2f323b;
	    overflow: auto;
	}
	.chat-input {
	    flex: 0 0 auto;
	    height: 100%;
	    width: 400px;
	    background: white;
	    border-top: 1px solid #2671ff;
	    box-shadow: 0 0 4px rgba(0,0,0,.14),0 4px 8px rgba(0,0,0,.28);
	}
	.chat-input input {
	    height: 100%;
	    line-height: 60px;
	    outline: 0 none;
	    border: none;
	    width: calc(100% - 60px);

	    text-indent: 10px;
	    font-size: 12pt;
	    padding: 0;

	}
	.chat-input button {
	    float: right;
	    outline: 0 none;
	    border: none;
	    background: rgba(255,255,255,.25);
	    height: 40px;
	    width: 40px;
	    border-radius: 50%;
	    padding: 2px 0 0 0;
	    margin: 10px;
	    transition: all 0.15s ease-in-out;
	}
	.chat-input input[good] + button {
	    box-shadow: 0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
	    background: #2671ff;
	}
	.chat-input input[good] + button:hover {
	    box-shadow: 0 8px 17px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
	}
	.chat-input input[good] + button path {
	    fill: white;
	}
	.msg-container {
	    position: relative;
	    display: inline-block;
	    width: 100%;
	    margin: 0 0 10px 0;
	    padding: 0;
	}
	.msg-box {
	    display: flex;
	    background: rgb(133, 150, 158);
	    padding: 10px 10px 0 10px;
	    border-radius: 0 6px 6px 0;
	    max-width: 80%;
	    width: auto;
	    float: left;
	    box-shadow: 0 0 2px rgba(0,0,0,.12),0 2px 4px rgba(0,0,0,.24);
	}
	.user-img {
	    display: inline-block;
	    border-radius: 50%;
	    height: 40px;
	    width: 40px;
	    background: #2671ff;
	    margin: 0 10px 10px 0;
	}
	.flr {
	    flex: 1 0 auto;
	    display: flex;
	    flex-direction: column;
	    width: calc(100% - 50px);
	}
	.messages {
	    flex: 1 0 auto;
	}
	.msg {
	    display: inline-block;
	    font-size: 11pt;
	    line-height: 13pt;
	    color: rgba(255,255,255,.7);
	    margin: 0 0 4px 0;
	}
	.msg:first-of-type {
	    margin-top: 8px;
	}
	.timestamp {
	    color: rgba(0,0,0,.38);
	    font-size: 10pt;
	    margin-bottom: 10px;
	}
	.username {
	    margin-right: 3px;
	}
	.posttime {
	    margin-left: 3px;
	}
	.msg-self .msg-box {
	    border-radius: 6px 0 0 6px;
	    background: #2671ff;
	    float: right;
	}
	.msg-self .user-img {
	    margin: 0 0 10px 10px;
	}
	.msg-self .msg {
	    text-align: right;
	}
	.msg-self .timestamp {
	    text-align: right;
	}
</style>
	
</head>
<body>
	<div class="main cast">
		<div class="header cast">
			<div class="header-title">
				<b>${chat.crTitle}</b>
			</div>

			<div class="header-menu"style="display:flex; width:30%; align-items: center;">
				<div class="menu-search" style="width:30px; margin:5px; display:inline-block;">
					<svg style="width:25px; height:25px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
				</div>
				<div class="menu-sideBar" style="width:30px;">
					<a class="menubar">
						<svg style="width:35px; height:35px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
						</svg>
					</a>
				</div>
				<div style="margin:0 0 0 10px;">
					<a type="button" onclick="exit()" class="btn btn-primary">
						<svg style="width:25px; height:25px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M13.854 2.146a.5.5 0 0 1 0 .708l-11 11a.5.5 0 0 1-.708-.708l11-11a.5.5 0 0 1 .708 0Z"/>
						  <path fill-rule="evenodd" d="M2.146 2.146a.5.5 0 0 0 0 .708l11 11a.5.5 0 0 0 .708-.708l-11-11a.5.5 0 0 0-.708 0Z"/>
						</svg>												
					</a>
				</div>
			</div>	
		</div><!-- header end -->
		<div class="body cast" id="space">
			<article>
				<aside class="sidebar">
				
					<div style="flot:bottom; position:absolute; bottom:0px; right:10px;">
						<a id="exitRoom" style="display:flex;">
							<div style="height:40px;"><div style="bottom:0;">나가기</div></div>
							<svg style="width:40px; height:40px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
							  <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
							</svg>
						</a>
					</div>
				</aside>
			<c:if test="${ !empty message }">
				<c:forEach items="${message}" var="m">
					<c:if test="${m.sender != mem.MName }">
						<article class="msg-container msg-remote">
					        <div class="msg-box">
					          <img class="user-img" src="${ pageContext.servletContext.contextPath }/resources/id_pictures/${m.PName}" />
					          <div class="flr">
					          	<span class="username" style="font-size:13px;"><b>${m.sender}</b></span>
					            <div class="messages">
					              <p class="msg">
					                ${m.chatContent}
					              </p>
					            </div>
					            <span class="timestamp">&bull;<span class="posttime">${m.chatCTime}</span></span>
					          </div>
					        </div>
					     </article>
					</c:if>
					
					<c:if test="${m.sender == mem.MName}">
					 <article class="msg-container msg-self">
				        <div class="msg-box">
				          <div class="flr">
				          
				            <div class="messages">
				              <p class="msg">
				                ${m.chatContent}
				              </p>
				            </div>
				            <span class="timestamp">&bull;<span class="posttime">${m.chatCTime}</span></span>
				          </div>
				          
				        </div>
				      	</article>
				      </c:if>
				</c:forEach>
			</c:if>
			
			</article>
		</div><!-- body end -->

		<div class="footer cast">
			<form class="chat-input" onsubmit="return false;">
      			<input type="text" autocomplete="on" autofocus id="message"/>
      				<button onclick="send()">
                    	<svg style="width:35px;height:35px" viewBox="0 0 24 24"><path fill="rgba(0,0,0,.38)" d="M17,12L12,17V14H8V10H12V7L17,12M21,16.5C21,16.88 20.79,17.21 20.47,17.38L12.57,21.82C12.41,21.94 12.21,22 12,22C11.79,22 11.59,21.94 11.43,21.82L3.53,17.38C3.21,17.21 3,16.88 3,16.5V7.5C3,7.12 3.21,6.79 3.53,6.62L11.43,2.18C11.59,2.06 11.79,2 12,2C12.21,2 12.41,2.06 12.57,2.18L20.47,6.62C20.79,6.79 21,7.12 21,7.5V16.5M12,4.15L5,8.09V15.91L12,19.85L19,15.91V8.09L12,4.15Z" /></svg>
                	</button>
    		</form>
			
		</div><!-- footer end -->
	</div><!-- main end -->
	
	
<script type="text/javascript">


	//채팅방 나가기
	function exit(){
		
			var crNo = ${chat.crNo};
			var mNo = '${m.MNo}';
			var cNo = ${chat.CNo};
			
			//location.href="exitRoom?crNo=" + crNo + "&mNo=" + mNo + "&cNo=" + cNo; 
			
			disconnect();
	};

	$("#exitRoom").click(function(){
		
		var crNo = ${chat.crNo};
		
		var mNo = ${mem.MNo};
		
		var cNo = ${chat.CNo};
		
		if(confirm("정말로 나가시겠습니까?")){
			
			location.href="exitRoom?crNo=" + crNo + "&mNo=" + mNo + "&cNo=" + cNo; 
			
		}
		
	});

		var stompClient = null;
		
		var crNo = ${chat.crNo};
		
		var MNo = ${ mem.MNo };
		
		var mName = "${mem.MName}";
		
		var cNo = ${chat.CNo};

		
		
		connect();
	
	    function connect(){
	    	// 유저가 웹서버에 접속할 시 소켓 연결을 해줄 url
	    	var socket = new SockJS('http://localhost:8010/spring/chat'); // WsConfig의 endPoint로 설정 
	    	stompClient = Stomp.over(socket); // SockJs를 stomp에 전해준다. SockJs위에서 돌아간다.
	        stompClient.connect({}, function () {
	        	console.log('connect')
	            stompClient.subscribe('/topic/' + crNo, function (e) { // 해당 페이지의 subscribe를 지정, 메세지를 보내면 이 주소로 받음을 명시
   			
	          // 	console.log(e.body)
	          //  console.log(JSON.parse(e.body))
	            var p =	JSON.parse(e.body);
	            
	            	console.log(p)
	            	//console.log(MNo)
	            	if(p.mno == MNo){
	            		
	            		showMessageRight(p);
	            		
	            	}else{
	            		
	            		showMessageLeft(p);
	            		
	            	}
	            
	            	
	            });
	        });
	    };
	    
	    function disconnect() {
	        if (stompClient !== null) {
	            stompClient.disconnect();
	            
	            location.href="disconnect?crNo=" + crNo +"&mNo=" + MNo;
	        };
	    };
	    

	    function send() {
	   
	    	if($("#message").val() == ''){
	    		
	    		return false;
	    		
	    	}else{
	    	
	        data = {'crNo': crNo, 'mno' : MNo , 'chatContent': $("#message").val(), 'sender' : mName , 'cno' : cNo};
	       
	        stompClient.send("/app/chat/send", {}, JSON.stringify(data)); // send("매핑주소" , {} , 메시지)
	        
	        $("#message").val('');
	        
	    	}
	    };
	    
	    
	    function showMessageLeft(e) {
	    	console.log("왼쪽")
	        var space = $("#space").html();
	        
	    	var value = space +
		 "<article class='msg-container msg-remote'>" +
	        "<div class='msg-box'>" +
	          "<img class='user-img' src='${ pageContext.servletContext.contextPath }/resources/id_pictures/"+ e.pname +"'/>" +
	          "<div class='flr'>" +
	          	"<span class='username' style='font-size:13px;'><b>"+e.sender +"</b></span>" +
	            "<div class='messages'>" +
	              "<p class='msg'>" + e.chatContent + "</p>" +
	            "</div>" +
	            "<span class='timestamp'>&bull;<span class='posttime'>"+e.chatCTime+"</span></span>" +
	          "</div>" +
	        "</div>" +
	     "</article>";
	     
	    	$('#space').html(value);
	    };
	    
	    
	    function showMessageRight(e) {
	    	console.log("오른쪽")
	       var space = $("#space").html();
	        
	    	var value = space +
	       "<article class='msg-container msg-self'>" +
		        "<div class='msg-box'>" +
		          "<div class='flr'>" +
		            "<div class='messages'>" +
		              "<p class='msg'>" + e.chatContent +  "</p>" +
		            "</div>" +
		            "<span class='timestamp'>&bull;<span class='posttime'>" + e.chatCTime + "</span></span>" +
		          "</div>" +
		        "</div>" +
	      	"</article>";
	      	
	      	$('#space').html(value);
	      	console.log(value)
	    };
	    
	    
	    $('.menubar').click(function(){
	    	
	    	$('.sidebar').removeClass("enter");
	    	$('.sidebar').addClass("enter");
	    	
	    });
	    
	    
	    <%--
	    function alertClosing(selector, delay){
	        console.log(selector);
	        document.getElementById(selector).style.display = "block";
	        window.setTimeout(function(){
	            document.getElementById(selector).style.display = "none";
	        },delay);
	    }
	    --%>
	   
	    

</script>
</body>

</html>