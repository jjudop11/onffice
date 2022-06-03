<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>  
<meta charset='utf-8' />  
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">  
<!-- fullcalendar CDN -->  
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.js"></script>
<!-- fullcalendar 언어 CDN --> 
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales-all.js"></script>
 <style>  
 	html, body {    
 		overflow: hidden;    
 		font-family: Arial, Helvetica Neue, Helvetica, sans-serif;    
 		font-size: 14px;  
 	}  
 	.fc-header-toolbar {    
 		padding-top: 1em;    
 		padding-left: 1em;    
 		padding-right: 1em;  
 	}
 </style>
</head>
<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	
	 <div id="app">        
        <div id="main">
	
		<div id='calendar-container'>    
			<div id='calendar'>
			</div>  
		</div>  
		
		<!-- 일정 추가 MODAL -->
        <div class="modal fade" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    	<h4 class="modal-title"></h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작일</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">종료일</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                                <label class="col-xs-4" for="edit-allDay"><input class='allDayNewEvent' id="edit-allDay" type="checkbox">하루종일
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">구분</label>
                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
                                    <option value="카테고리1">개인</option>
                                    <option value="카테고리2">부서</option>
                                    <option value="카테고리3">프로젝트</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">설명</label>
                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                    	<button type="button" class="btn btn-primary" id="save-event">저장</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                    	<button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    	<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
	</div>
	</div>
	
	
	<script>  

		$(function(){    
			
			var calendar = new FullCalendar.Calendar($('#calendar')[0], {  // full-calendar 생성하기       
				
				height: '600px', // calendar 높이 설정        
				expandRows: true, // 화면에 맞게 높이 재설정        
				slotMinTime: '00:00', // Day 캘린더에서 시작 시간        
				slotMaxTime: '23:59', // Day 캘린더에서 종료 시간       
				// initialView				: 'dayGridMonth',  초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)        
				// initialDate				: '2022-06-01',  초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)       
				displayEventTime            : true, // 이벤트에 시간 텍스트가 항상 표시
				displayEventEnd             : true, // 이벤트 종료 시간 표시
				navLinks					: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크     
				firstDay                    : 0, //월요일이 먼저 오게 하려면 1
				weekNumbers                 : true, // 주 번호 표시
				editable					: true, // 수정 가능 기능      
				droppable					: true, // 드롭해서 일정추가 가능
				selectable					: true, // 달력 일자 드래그 설정가능        
				nowIndicator				: true, // 현재 시간 마크        
				dayMaxEvents				: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)        
				locale						: 'ko', // 한국어 설정
			  	navLinks                    : true,   // 요일, 주 클릭 가능여부
			  	nextDayThreshold            : "09:00:00", // 오전 9시 기준으로 다음날로 계산됨
			    nowIndicator                : true, // 현재 시간을 나타내는 마커를 표시
			 	// 해더에 표시할 툴바        
				headerToolbar: {          
					left: 'prevYear,prev,next,nextYear,today',  
					center:'title',  
					right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek' 
				},     
				views: { // 화면표시포맷
				    dayGridMonth: { // 월별
				      	titleFormat: { year: 'numeric', month: 'long' }
				    }
				},
				eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트          
					console.log(obj);        
				},        
				eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트          
					console.log(obj);        
				},        
				eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트          
					console.log(obj);        
				}, 
				eventClick: function(obj) { // 일정 클릭시 발생하는 이벤트          
					console.log(obj);        
				},  
				select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.          
					// 모달창관련
					$('.modal-title').html("새로운 일정");
					$('.modalBtnContainer-modifyEvent').hide();
					$('#eventModal').modal('show');
				
			        console.log(
			          'select',
			          arg.startStr,
			          arg.endStr,
			          arg.resource ? arg.resource.id : '(no resource)'
			        );
			        
			        calendar.addEvent({
			            //title: content,
			            //start: startDay,
			            //end: endDay,
			            //allDay: true
			         });
					calendar.unselect()

				},        // 이벤트       
				events:function(info, successCallback, failureCallback){
					
					$.ajax({
		                url: "selecttimetableList", // 조회하기
		                method: "post",
		                dataType: "json",
		                success: function (result) {
		                	console.log(result)
		                	var events = [];
		                	
		                	if(result != null) {
			                	for(var i in result) { // 나중에 팀, 개인 따라서 색깔 따로 표시
			                		events.push({
    			                        title: result[i].tname,
    			                        start: result[i].tstart,
    			                        end: result[i].tend,
    			                        color:"#6937a1"                                                   
    			                    }); //.push()
			                			
			                	}
			                	console.log(events);
		                	}
		                	successCallback(events);                      
		                }
		            });
					
				}
					
			});      // 캘린더 랜더링      
			calendar.render();    
		});  

	</script>
</body>
</html>
