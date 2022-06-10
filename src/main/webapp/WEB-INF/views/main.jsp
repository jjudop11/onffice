<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body style="background-color:#F0FFF0">

	<jsp:include page="common/menubar.jsp"/>
	<jsp:include page="common/alarm.jsp"/>
	
    <div id="app">
        
        <div id="main">
        	<!-- 화면작아졌을때 메뉴바 토글버튼 -->
            <div class="page-content">
                <section class="row">
                    <div class="col-12 col-lg-10">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>공지사항</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="chart-profile-visit">공지사항 리스트</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 col-xl-4">
                                <div class="card">
                             <div class="card-content ">
                                 <div class="card-body">
                                     <h6 class="card-text" id="ymd"></h6>
                                     <h1 class="card-text" id="clock"></h1>
                                     <br>
                                     <h6 class="card-text">주간근무시간</h6>
                                     <div class="progress progress-primary mt-4 mb-2">
	                                <div class="progress-bar progress-label" role="progressbar" style="width: 0%"
	                                   aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="bar"></div>
	                           		</div>
	                           		<br>
                                     <h6 class="card-text" id="aTime">출근시간:</h6>
                                     <h6 class="card-text" id="lTime">퇴근시간:</h6>
                                     <h6 class="card-text" id="wTime">근무시간</h6>
                                 </div>
                             </div>
                             <div class="card-footer d-flex justify-content-between">
                                 <button class="btn btn-primary btn" id="plus">출근하기</button>
                                 <button class="btn btn-danger btn" id="minus">퇴근하기</button>
                             </div>
                        </div>
                            </div>
                            <div class="col-12 col-xl-8">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>여기뭐넣지</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-lg">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Comment</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <div class="avatar avatar-md">
                                                                    <img src="resources/assets/images/faces/5.jpg">
                                                                </div>
                                                                <p class="font-bold ms-3 mb-0">Si Cantik</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">Congratulations on your graduation!</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="col-3">
                                                            <div class="d-flex align-items-center">
                                                                <div class="avatar avatar-md">
                                                                    <img src="resources/assets/images/faces/2.jpg">
                                                                </div>
                                                                <p class="font-bold ms-3 mb-0">Si Ganteng</p>
                                                            </div>
                                                        </td>
                                                        <td class="col-auto">
                                                            <p class=" mb-0">Wow amazing design! Can you make another
                                                                tutorial for
                                                                this design?</p>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-2"> 
                        <div class="card">
                            <div class="card-header">
                                <h4>접속자 정보</h4>
                            </div>
                              <div class="card">
                                <div class="card-body text-center">
                                    <div class="avatar">
                                        <img src="${ pageContext.servletContext.contextPath }/resources/id_pictures/${sessionScope.loginUser.PName}" style="width:100px; height:100px;"/>
                                    </div>
                                </div>
	                            <div class="name text-center">          	
	                            	<h4 class="font-bold">${ sessionScope.loginUser.MName } ${ sessionScope.loginUser.JName }</h4>
	                                <h5 class="text-muted mb-0">${ sessionScope.loginUser.DName }</h5>
                            	</div>
	                         </div>
	                         <c:if test="${ sessionScope.loginUser.MManager eq 'N' }">
	                         	<a class="dropdown-item" href="mypageForm"><i class="icon-mid bi bi-file-diff me-2"></i> 개인정보관리</a>
	                         </c:if>
	                         <c:if test="${ sessionScope.loginUser.MManager eq 'Y' }">
	                         	<a class="dropdown-item" href="managerpageForm"><i class="icon-mid bi bi-file-diff me-2"></i> 관리자페이지</a>
	                         </c:if>
                           	 <a class="dropdown-item" href="logout"><i class="icon-mid bi bi-box-arrow-left me-2"></i> Logout</a>
                        </div>
                    </div>
                </section>
            </div>
			
			<!-- 풋터 -->
            <footer>
                <div class="footer clearfix mb-0 text-muted">
                    <div class="float-start">
                        <p>2022 &copy; 같이좀해조</p>
                    </div>
                    <div class="float-end">
                        <p>Crafted with <span class="text-danger"><i class="bi bi-heart"></i></span> by 
                        <a href="">김영진</a> /
                        <a href="">김지은</a> / 
                        <a href="">박주연</a> /
                        <a href="">이상화</a> /
                        <a href="">현주아</a></p>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
	<script>
		
		$(function(){
			getClock();
			setInterval(getClock, 1000);
		})
		
		function getClock(){
			  const d = new Date();
			  let h = String(d.getHours()).padStart(2,"0");
			  let m = String(d.getMinutes()).padStart(2,"0");
			  let s = String(d.getSeconds()).padStart(2,"0");
			  
			  let year = d.getFullYear();
			  let month = d.getMonth()+1;
			  let date = d.getDate();
			  let week = ['일', '월', '화', '수', '목', '금', '토'];
			  $("#clock").text(h+":"+m+":"+s);
			  $("#ymd").text(year+"년 "+month+"월 "+date +"일 ("+week[d.getDay()]+")");
		}
	</script>

</body>

</html>