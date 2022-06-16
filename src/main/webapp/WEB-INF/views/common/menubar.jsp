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

	<style>
		.orgChart{
			border: 1px solid black;
			bottom:20px;
			left:320px;
			position:fixed;
			box-shadow: 0 0 16px 0 rgb(0 0 0 / 40%);
		    background: #fff;
		    border-radius: 4px;
		    display:none;
		}
		
		.orgChart.open{
			display:block;
		}
		
		.oc_header{
			height:40px; 
			width:100%; 
			border-bottom:1px solid rgba(189, 191, 194, 0.897);
			padding: 5px 5px; 
		}
		
		.oc_main{
			height:410px;
			width: 100%;
		    min-height: 110px;
		    border-radius: 0 0 5px 5px;
		    overflow-y: auto;
		    margin: 0;
		    background: #fff;
		}
		
		
		ul{
			list-style:none;
			margin:0;
			padding:0;
			
		}
		
		a {
		  color:#607080;
		}
		
		.orgChartList > ul> li > a, i{
			margin:0px 5px;
			
		}
		
		.toggle_down {
			margin:0px 5px;
			left:10px;
		}
	
		.toggle_down > a{
			margin:0px 0 0 20px;
			left:20px;
			
		}
		
		.toggle_down > ul{
			margin:0px 0 0 40px;
			left:40px;
		}
		
		.profile_popup{
			
			display:none;
			width:250px;
			height:350px;
			border: 2px solid #c1c9d2;
		    background: #fff;
		    padding: 14px 12px;
		    min-height: 258px;
		    border-radius: 10px;
		    box-shadow: 0 20px 40px #d7dade;
			top:40%;
			left:520px;
			position:fixed;
		}
		
		.mem_photo{
			border-radius: 60px;
		    width: 100px;
		    height: 100px;
		    border: 2px solid #fff;
		}
		
		.oc_search_list{
			 width:100%; 
			 height:100%; 
			 background:white; 
			 display:none;
			 padding:10px 5px;
		
		}
		
		
	</style>
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
                                <span>결재상신</span>
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
                            </ul>
                        </li>
                        
                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-grid-1x2-fill"></i>
                                <span>결재수신</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item ">
                                    <a href="approvalRequestListView.do">결재요청</a>
                                </li>
                                <li class="submenu-item ">
                                    <a href="approvalAllowListView.do">결재내역</a>
                                </li>
                            </ul>
                        </li>

                        <li class="sidebar-item  has-sub">
                            <a href="#" class='sidebar-link'>
                                <i class="bi bi-hexagon-fill"></i>
                                <span>예약 관리</span>
                            </a>
                            <ul class="submenu ">
                                <li class="submenu-item">
                                    <a href="roomReservingForm.do">회의실 예약</a>
                                </li>
                                <li class="submenu-item">
                                    <a href="carReservingForm.do">차량 예약</a>
                                </li>
                                <li class="submenu-item">
                                    <a href="roomSetting.do">회의실 관리</a>
                                </li>
                                <li class="submenu-item">
                                    <a href="carSetting.do">차량 관리</a>
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

                  		<li class="sidebar-item">
                            <a href="surveyBoardForm" class='sidebar-link'>
                                <i class="bi bi-egg-fill"></i>
                                <span>설문게시판</span>
                            </a>
                        </li>

						<li class="sidebar-item" onclick="asideDisplay()">
                            <a href="#" class='sidebar-link' id="orgChart-link">
                                <i class="bi bi-bar-chart-fill"></i>
                                
                                <span>조직도</span>
                            </a>
                        </li>
                    </ul>
                </div>
               <aside class="orgChart" id="orgChart" style="height:450px; width:350px;">
               		<div class="oc_header" style="height:40px; width:100%; border-bottom:1px solid rgba(189, 191, 194, 0.897); ">
               			<input id="search_key" type="text" placeholder="검색어를 입력하세요." style="width:300px; height:30px;">
               			<a href="#" onclick="asideDisplay()">
               			<svg style="width:25px; height:25px; margin:0 0 0 5px" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M13.854 2.146a.5.5 0 0 1 0 .708l-11 11a.5.5 0 0 1-.708-.708l11-11a.5.5 0 0 1 .708 0Z"/>
						  <path fill-rule="evenodd" d="M2.146 2.146a.5.5 0 0 0 0 .708l11 11a.5.5 0 0 0 .708-.708l-11-11a.5.5 0 0 0-.708 0Z"/>
						</svg>
						</a> 
               		</div>
               		<div class="oc_search_list">
               			<ul class="searchMemList">
               				
               			</ul>
               		</div>
               		<div class="oc_main">
               			<div class="oc_main_list" style="min-height:410px; max-height:410px; padding:10px 5px; ">
               				<ul class="orgChartList">

               				</ul>
               			</div>
               		</div>
               </aside>
               <div class="profile_popup">
               		<a href="#" onclick="popupdisplay()">
               			<svg style="width:20px; height:20px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M13.854 2.146a.5.5 0 0 1 0 .708l-11 11a.5.5 0 0 1-.708-.708l11-11a.5.5 0 0 1 .708 0Z"/>
						  <path fill-rule="evenodd" d="M2.146 2.146a.5.5 0 0 0 0 .708l11 11a.5.5 0 0 0 .708-.708l-11-11a.5.5 0 0 0-.708 0Z"/>
						</svg>
					</a> 
					<div class="profile_content" style="width:100%; box-sizing:border-box; position:relative;">
						<div class="profile_photo" style="height:100px; display:inline-block; margin:0 0 0 60px;">
							<img class="mem_photo" />
						</div>
						<div class="profile_name" style="text-align:center; margin:20px 0 0 0; font-size:18px; font-weight:bold; color:black;">
							<span id="name"></span>
							<span id="jName"></span>
						</div>
						<div class="profile_email" style="color:#607080; text-align:center; font-size:16px; margin:0 0 10px 0;">
							<div class="p_email"></div>
							<div class="p_cName"></div>
						</div>
						<ul style="text-align:center;">
							<li>
								<span>Cell.</span>
								<span class="profile_num"></span>
							</li>
						</ul>
						<div class="profile_astate" style="text-align:center; margin:20px 0 0 0;">
							<span class="p_astate"></span>
						</div>
					</div>
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
    
      <script>

		$('#orgChart-link').click(function(){

    		$.ajax({

    			url:"orgChartList",
    			type:"get",
    			
    			success:function(org){
    				
    				console.log(org);
    				
    				
    				
    				var val = "";
    				
    				val = 
    					"<li>" +
    					"<i class='bi bi-building'></i>" +
    					"<a href='#' class='oc_list_cName'>"+org.cMList[0].cname+"</a>" +
    					"<ul>"
    						$.each(org.cMList, function(i , cm){
								
    								if(i == 0){
    									
    									val +=
    										"<li><img class='user-img' src='${ pageContext.servletContext.contextPath }/resources/icon/right-arrow.png' />" +
    										"<a href='#' class='profile_info' onclick='selectInfo("+cm.cno+","+cm.mno+")'><i class='bi bi-person-check-fill'></i>"+cm.mname+"&nbsp;"+cm.jname+"</a>	</li>"
    										
    								
    								}else{
    									val +="<li><a href='#' onclick='selectInfo("+cm.cno+","+cm.mno+")'><i class='bi bi-person-fill'></i>"+cm.mname+"&nbsp;"+cm.jname+"</a></li>"
    								}
    								
    								
    						})
    						
							
		    						
    					
    						$.each(org.dList, function(i, d){
    						
    							val +=
    								"<li class='toggle_down'>" +
    									"<a class='oc_list_iconClick' href='#'>" +
               								"<img class='oc_list_icon' src='${ pageContext.servletContext.contextPath }/resources/icon/dash-circle-fill.svg'/>" +
               							"</a>" +
    									"<a class='oc_list_profile' style='margin:0 0 0 5px;'>"+ d +"</a>" +
    									"<ul>"
    									
    									
    									$.each(org.cList, function(j , c){
    									
    										if(c.dname == d){
    								
    										val +=
    											"<li>" +
    												"<img class='user-img' src='${ pageContext.servletContext.contextPath }/resources/icon/right-arrow.png' />" +
    												"<a href='#' class='profile_info' onclick='selectInfo("+c.cno+","+c.mno+")'><i class='bi bi-person-fill'></i>"+c.mname+"&nbsp;"+c.jname+"</a>" +
    											"</li>"

    										}
	
    									})
    									
    									
    									val += "</ul>" +

    								 "</li>"		
    									
    						})
    					
    					+ "</ul>"

    				+ "</li>"
    				
    				$('.orgChartList').html(val);

    			}<%-- success --%>

    		})
		
    }) <%--조직도 실행 함수 --%>
    	
    	
			let count = 0;
    	
    	$('.oc_list_iconClick').click(function(){
    		
    		count++;
    		
    		if($(this).children().attr("src" , "${ pageContext.servletContext.contextPath }/resources/icon/dash-circle-fill.svg")) {
    	
        		$(this).children().attr("src" , "${ pageContext.servletContext.contextPath }/resources/icon/plus-circle-fill.svg")
    		
    		} else {
    		
    	   		$(this).children().attr("src" , "${ pageContext.servletContext.contextPath }/resources/icon/dash-circle-fill.svg")
    		}

    	})
    	

 		// 조직도 껐다 켰다
    	function asideDisplay(){

			if($('#orgChart').css("display") == 'none'){
				console.log("디스플레이 논")
				$('#orgChart').css("display" , "block")
				
			}else{
				console.log("디스플레이 블락")
				$('#orgChart').css("display" , "none")
				
			};	
    	};
    	
    	
    	function popupdisplay(){

			if($('.profile_popup').css("display") == 'none'){
				console.log("디스플레이 논")
				$('.profile_popup').css("display" , "block")
				
			}else{
				console.log("디스플레이 블락")
				$('.profile_popup').css("display" , "none")
				
			};	
    	};
    
    	
    	function selectInfo(cno, mno){
    		
    		$.ajax({
    			
    			url:"selectMemProfile",
    			tyle:"post",
    			data:{
    				mNo:mno,
    				cNo:cno
    			},
    			
    			success:function(e){
    				
    				var pName = "${ pageContext.servletContext.contextPath }/resources/id_pictures/" + e.pName;
    				
    				$('.mem_photo').attr("src" , pName);
    				$('#name').text(e.mName);
    				$('#jName').text(e.jName);
    				$('.p_email').text(e.mEmail);
    				$('.p_cName').text(e.cName);
    				$('.profile_num').text(e.mPhone);
    				$('.p_astate').text(e.aState);
    				
    				if(e.aState === '근무중'){
    					
    					$('.profile_astate').css("color" , "rgba(57, 118, 211, 0.897)")
    				}else{
    					$('.profile_astate').css("color" , "rgba(147, 147, 148, 0.897)")
    				}
    				
    				popupdisplay();
    			}
    			
    			
    			
    		})
    		
    	}
    	
   
    	$('#search_key').keyup(function(){
    	
    		var input = $('#search_key').val();

    		$.ajax({
    			
    			url:"searchMemList",
    			type:"post",
    			data:{
    				key:input
    			},
    			
    			success:function(resultList){
  
    				var val = "";
    				
    				$.each(resultList, function(i, s){
    				
    				val +=	
    					
	    				"<li style='height:30px'>" +
							"<a href='#' class='profile_info' onclick='selectInfo("+s.cNo+","+s.mNo+")' style='width:100%; height:100%;'><i style='margin:5px 5px -3px 0; ' class='bi bi-person-fill'></i>"+s.mName+"&nbsp;"+s.jName+"</a>" +
						"</li>"
    					
    					
    					
    				})
    				
    				$('.searchMemList').html(val);
    			}
    			
    			
    		})
    		
    		
    		
    	})
    	
    	$(function(){
    		
    		
    		
    		$("#search_key").on("propertychange change keyup paste input" , function(){
    			 
    			if($("#search_key").val() != ""){
    				
    				$('.oc_search_list').css('display' ,'block');
    			
    			}else{
    				
    				console.log('else 타라');
    				
    				$('.oc_search_list').css('display' , 'none');
    		
    				
    			}
    		})
    		
    		
    	})
    	
    	function searchListClean(){
    		
    		$('.orgChartList').html(null);
    	}
    
    </script>
</body>
</html>
