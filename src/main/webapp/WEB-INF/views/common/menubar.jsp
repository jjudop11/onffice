<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ONFFICE</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="resources/assets/css/bootstrap.css">

    <link rel="stylesheet" href="resources/assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="resources/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="resources/assets/css/app.css">
    <link rel="shortcut icon" href="resources/assets/images/favicon.svg" type="image/x-icon">

</head>

<body>

	<div id="main" class='layout-navbar'>
      <header class='mb-3'>
          <nav class="navbar navbar-expand navbar-light ">
              <div class="container-fluid">
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">		 
                          <li class="nav-item dropdown me-1" ><!-- 채팅 아이콘 -->
                              <a class="nav-link active dropdown-toggle" href="#" data-bs-toggle="dropdown"
                                  aria-expanded="false">
                                  <i class='bi bi-chat bi-sub fs-4 text-gray-600'></i>
                              </a>
                              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                                  <li>
                                      <h6 class="dropdown-header">채팅</h6>
                                  </li>
                                  <li><a class="dropdown-item" href="selectCommunityList">community</a></li>
                                  <li><a class="dropdown-item" href="chatRoomListForm">chat</a></li>
                              </ul>
                          </li>
                          <li class="nav-item dropdown me-1">
                          	  <a class="nav-link active dropdown-toggle" href="#" data-bs-toggle="dropdown" id="drop"
                                  aria-expanded="false">
                                  <i class='bi bi-bell bi-sub fs-4 text-gray-600'></i>
                                  <span class="count" style="color:red" id="count"></span>
                              </a>
                         	  <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton" id="ul_list">
                         	  <li>
                                   <h6 class="dropdown-header">알람</h6>
                              </li>
                              </ul>
                          </li>
                      </ul>
                      <div class="dropdown">
                          <a href="#" data-bs-toggle="dropdown" aria-expanded="false">
                              <div class="user-menu d-flex">
                                  <div class="user-img d-flex align-items-center">
                                      <div class="avatar avatar-md">
                                          <img src="${ pageContext.servletContext.contextPath }/resources/id_pictures/${sessionScope.loginUser.PName}" />
                                      </div>
                                  </div>
                              </div>
                          </a>
                          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                              <li>
                                  <h6 class="dropdown-header">Hello?</h6>
                              </li>
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
	                         
	                         <li>
		                         <c:if test="${ sessionScope.loginUser.MManager eq 'N' }">
		                         	<a class="dropdown-item" href="mypageForm"><i class="icon-mid bi bi-file-diff me-2"></i> 개인정보관리</a>
		                         </c:if>
		                         <c:if test="${ sessionScope.loginUser.MManager eq 'Y' }">
		                         	<a class="dropdown-item" href="managerpageForm"><i class="icon-mid bi bi-file-diff me-2"></i> 관리자페이지</a>
		                         </c:if>
	                         </li>
                              <li><a class="dropdown-item" href="logout"><i class="icon-mid bi bi-box-arrow-left me-2"></i> Logout</a></li>
                          </ul>
                      </div>
                  </div>
              </div>
          </nav>
      </header>
	</div>
	
	<div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between">
                        <div class="logo">
                            <a href="main"><img src="resources/assets/images/logo/logo.png" alt="Logo" srcset=""></a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu</li>

                        <li class="sidebar-item">
                            <a href="timetableForm" class='sidebar-link'>
                                <i class="bi bi-calendar3"></i>
                                <span>일정관리</span>
                            </a>
                        </li>
						
						<li class="sidebar-item  ">
                            <a href="attendanceForm" class='sidebar-link'>
                                <i class="bi bi-person-check"></i>
                                <span>근태관리</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>전자결재</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="approvalEnrollForm.do">기안작성</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="approvalOngoingListView.do">결재진행</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="approvalCompleteListView.do">결재완료</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="approvalRequestListView.do">결재요청</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>회의실예약</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="roomReservation.do">회의실 예약</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="form-element-input.html">온라인 회의실</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="roomSetting.do">회의실 관리</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item">
                            <a href="deptView.do" class='sidebar-link'>
                                <i class="bi bi-pen-fill"></i>
                                <span>부서보관함</span>
                            </a>
                        </li>
                        
						 <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-pentagon-fill"></i>
                                <span>프로젝트보관함</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="ui-widgets-chatbox.html">전체 프로젝트</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="ui-widgets-pricing.html">내 프로젝트</a>
                                </li>
                            </ul>
                        </li>
                        
                        <li class="sidebar-item  ">
                            <a href="listNotice.do" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>공지사항</span>
                            </a>
                        </li>

                        <li class="sidebar-item  ">
                            <a href="listCommunity.do" class='sidebar-link'>
                                <i class="bi bi-file-earmark-spreadsheet-fill"></i>
                                <span>커뮤니티</span>
                            </a>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-egg-fill"></i>
                                <span>설문게시판</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="ui-icons-bootstrap-icons.html">Bootstrap Icons </a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="ui-icons-fontawesome.html">Fontawesome</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="ui-icons-dripicons.html">Dripicons</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-bar-chart-fill"></i>
                                <span>조직도</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="ui-chart-chartjs.html">ChartJS</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="ui-chart-apexcharts.html">Apexcharts</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
               
            </div>
        </div>
  	

  	    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="resources/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script src="resources/assets/js/bootstrap.bundle.min.js"></script>
    <script src="resources/assets/js/pages/dashboard.js"></script>
    <script src="resources/assets/vendors/choices.js/choices.min.js"></script>
    <script src="resources/assets/js/main.js"></script>
    
    <script>
    
    	$(function(){
    		
    		selectAlramList();

    	})
    	
    	function selectAlramList() {
    		let t = "";
    		$.ajax({
				url:"selectAlramList",
				type:"post",

				success:function(result){

					if(result.list.length == 0) {
						t +=  '<li><a class="dropdown-item" name="alram">새로운 알림이 없습니다</a></li>';
					}
					for(var i in result.list) {
		            	t +=  '<li><a class="dropdown-item" name="alram">'+result.list[i].alContent+'</a></li>';
		            }    
					var ul_list = $("#ul_list");
					ul_list.append(t);
					$("#count").html(result.count);

					$('#ul_list').children('li').off().on('click', function(e) {
						
						let text = $(this).text();
						let index = $(this).index()
						
						$.ajax({
							url:"deleteAlram",
							type:"post",
							data:{
								content: text
							},
							success:function(result){

								if(result == 1) {
									$('#ul_list').children('li').eq(index).text("")
								}
								location.reload();
							},
							error:function(){
								console.log("선택 알람 삭제 ajax 통신 실패");
							}
						});
						
		            })
				},
				error:function(){
					console.log("알람리스트 ajax 통신 실패");
				}
			});
    	}

    </script>
</body>
</html>
