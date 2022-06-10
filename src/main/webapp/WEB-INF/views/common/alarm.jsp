<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head>
<body>

</body>
<script>
	var socket = null;
	
	toastr.options = {
			  "closeButton": true, // 닫힘 버튼 보이게
			  "debug": false, // 콘솔창 관련 메시지 띄울것인가
			  "newestOnTop": false, // 새로운 팝업창 띄울때 위로 true, 아래 false
			  "progressBar": true, // 닫힐때까지 시간 bar 표시
			  "positionClass": "toast-top-right", // 팝업창 표시
			  "preventDuplicates": false, // 중복 방지
			  "onclick": null, 
			  "showDuration": "200", // 등장 시간
			  "hideDuration": "5000", // 사라지는 시간
			  "timeOut": "5500", // 자동 사라지는 시간
			  "extendedTimeOut": "1000", // 마우스 올렸다가 땟을때 사라지는 시간
			  "showEasing": "swing", // 보일때 애니메이션
			  "hideEasing": "linear", // 사라질때 애니메이션
			  "showMethod": "fadeIn", // 보일때 효과
			  "hideMethod": "fadeOut" // 사람질때 효과
	}
	
	$(function(){
		connectWs();
	})
	
	function connectWs(){
		
		var ws = new SockJS("http://localhost:8097/spring/alarm");
		socket = ws;
	
		ws.onopen = function() {
			 console.log('open');
	 
	 	};
	
		ws.onmessage = function(event) {
			console.log(event)
			console.log("onmessage"+event.data);
			toastr.info(event.data);
			
			setTimeout(function () {
			    location.reload();
			}, 10 * 1000);

	
		};
	
		ws.onclose = function() {
			console.log('close');
		 };
		 
	};//소켓끝

</script>
</html>