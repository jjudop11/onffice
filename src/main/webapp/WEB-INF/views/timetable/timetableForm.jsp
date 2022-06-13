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
<!-- css -->
<link rel="stylesheet" href="resources/full/css/fullcalendar.min.css">
<link rel="stylesheet" href="resources/full/css/select2.min.css">
<link rel="stylesheet" href="resources/full/css/fullcalendar.min.css">
<link rel="stylesheet" href="resources/full/css/material-icon.css">
<link rel="stylesheet" href="resources/full/css/timepicker.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
 <style>  
	body {
	  font-family: 'Open Sans', Arial, Helvetica, sans-serif;
	  padding: 30px;
	}
	
	.dropNewEvent {
	  font-size: 13px;
	}
	
	.popoverTitleCalendar {
	  width: 100%;
	  height: 100%;
	  padding: 15px 15px;
	  font-size: 13px;
	  border-radius: 5px 5px 0 0;
	}
	
	.popoverInfoCalendar i {
	  font-size: 14px;
	  margin-right: 10px;
	  line-height: inherit;
	  color: #d3d4da;
	}
	
	.popoverInfoCalendar p {
	  margin-bottom: 1px;
	}
	
	.popoverDescCalendar {
	  margin-top: 12px;
	  padding-top: 12px;
	  border-top: 1px solid #E3E3E3;
	  overflow: hidden;
	  display: -webkit-box;
	  -webkit-line-clamp: 3;
	  -webkit-box-orient: vertical;
	}
	
	.popover-title {
	  background: transparent;
	  font-weight: 600;
	  padding: 0 !important;
	  border: none;
	}
	
	.popover-content {
	  padding: 15px 15px;
	  font-size: 13px;
	}
	
	.inputModal {
	  width: 65%;
	  margin-bottom: 10px;
	}
	
	.modal{
	  position: fixed;
	  transform: translate(5%);
	}
	
	#contextMenu {
	  position: absolute;
	  display: none;
	  z-index: 2;
	}
	
	#contextMenu .dropdown-menu {
	  border: none;
	}
	
	.opacityWeekend {
	  background-color: #f4f4fb !important;
	}
	
	.fc-avatar-image {
	  top: 4px;
	  left: 20px;
	  height: 28px;
	  width: 28px;
	  border-radius: 50%;
	  position: absolute;
	  z-index: 2;
	}
	
	.fc-avatar-image img {
	  height: 28px;
	  width: 28px;
	  border-radius: 50%;
	}
	
	.fc-avatar-image:before {
	  content: none !important;
	}
	
	.fc-day-header {
	  text-transform: uppercase;
	  font-size: 13px;
	  font-weight: 500;
	  color: #505363;
	  background-color: #FAFAFA;
	  padding: 11px 0px !important;
	  text-decoration: none;
	}
	
	.fc-day-header a {
	  text-decoration: none !important;
	  color: #505363;
	}
	
	.fc-center h2 {
	  text-transform: uppercase;
	  font-size: 18px;
	  font-weight: 600;
	  color: #505363;
	  line-height: 32px;
	}
	
	.fc-toolbar.fc-header-toolbar {
	  margin-bottom: 22px;
	  padding-top: 22px;
	}
	
	.fc-agenda-view .fc-day-grid .fc-row .fc-content-skeleton {
	  padding-bottom: 1em;
	  padding-top: 1em;
	}
	
	.fc-day {
	  -webkit-transition: all 0.2s linear;
	  -o-transition: all 0.2s linear;
	  transition: all 0.2s linear;
	}
	
	.fc-day:hover {
	  background: #EEF7FF;
	  cursor: pointer;
	  -webkit-transition: all 0.2s linear;
	  -o-transition: all 0.2s linear;
	  transition: all 0.2s linear;
	}
	
	.fc-highlight {
	  background: #EEF7FF;
	  opacity: 0.7;
	}
	
	.fc-time-grid-event.fc-short .fc-time:before {
	  content: attr(data-start);
	  display: none;
	}
	
	.fc-time-grid-event.fc-short .fc-time span {
	  display: inline-block;
	}
	
	.fc-time-grid-event.fc-short .fc-avatar-image {
	  display: none;
	  -webkit-transition: all 0.3s linear;
	  -o-transition: all 0.3s linear;
	  transition: all 0.3s linear;
	}
	
	.fc-time-grid .fc-bgevent,
	.fc-time-grid .fc-event {
	  border: 1px solid #fff !important;
	}
	
	.fc-time-grid-event.fc-short .fc-content {
	  padding: 4px 20px 10px 22px !important;
	}
	
	.fc-time-grid-event .fc-avatar-image {
	  top: 9px;
	}
	
	.fc-event-vert {
	  min-height: 22px;
	}
	
	.fc .fc-axis {
	  vertical-align: middle;
	  padding: 0 4px;
	  white-space: nowrap;
	  font-size: 10px;
	  color: #505362;
	  text-transform: uppercase;
	  text-align: center !important;
	  background-color: #fafafa;
	}
	
	.fc-unthemed .fc-event .fc-content,
	.fc-unthemed .fc-event-dot .fc-content {
	  padding: 5px 10px 5px 10px;
	  font-family: 'Roboto', sans-serif;
	  margin-left: -1px;
	  height: 100%;
	}
	
	.fc-event {
	  border: none !important;
	}
	
	.fc-day-grid-event .fc-time {
	  font-weight: 700;
	  text-transform: uppercase;
	}
	
	.fc-unthemed .fc-day-grid td:not(.fc-axis).fc-event-container {
	  /* padding: 0.2rem 0.5rem; */
	}
	
	.fc-unthemed .fc-content,
	.fc-unthemed .fc-divider,
	.fc-unthemed .fc-list-heading td,
	.fc-unthemed .fc-list-view,
	.fc-unthemed .fc-popover,
	.fc-unthemed .fc-row,
	.fc-unthemed tbody,
	.fc-unthemed td,
	.fc-unthemed th,
	.fc-unthemed thead {
	  border-color: #DADFEA;
	}
	
	.fc-ltr .fc-h-event .fc-end-resizer,
	.fc-ltr .fc-h-event .fc-end-resizer:before,
	.fc-ltr .fc-h-event .fc-end-resizer:after,
	.fc-rtl .fc-h-event .fc-start-resizer,
	.fc-rtl .fc-h-event .fc-start-resizer:before,
	.fc-rtl .fc-h-event .fc-start-resizer:after {
	  left: auto;
	  cursor: e-resize;
	  background: none;
	}
	
	select.calfilter {
	  width: 270px !important;
	}
	
	.material-icons {
	  font-family: 'Material Icons';
	  font-weight: normal;
	  font-style: normal;
	  font-size: 24px;
	  /* Preferred icon size */
	  display: inline-block;
	  line-height: 1;
	  text-transform: none;
	  letter-spacing: normal;
	  word-wrap: normal;
	  white-space: nowrap;
	  direction: ltr;
	
	  /* Support for all WebKit browsers. */
	  -webkit-font-smoothing: antialiased;
	  /* Support for Safari and Chrome. */
	  text-rendering: optimizeLegibility;
	
	  /* Support for Firefox. */
	  -moz-osx-font-smoothing: grayscale;
	
	  /* Support for IE. */
	  -webkit-font-feature-settings: 'liga';
	          font-feature-settings: 'liga';
	}
	
	#add-color,
	#edit-color {
	  color: #d25565;
	}
	
	.tippy-box[data-theme~='custom'] {
       background-color: yellow;
       color: black;
    }

 </style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>
	<jsp:include page="../common/alarm.jsp"/>

	 <div id="app">        
        <div id="main">
		 <div class="col-lg-12">
             <label for="calendar_view">구분 필터</label>
             <div class="input-group">
                 <select class="calfilter" id="type_filter" multiple="multiple">
                     <option value="개인">개인</option>
                     <option value="부서">부서</option>
                     <option value="프로젝트">프로젝트</option>
                 </select>
             </div>
        </div>
         
		<div id='calendar-container'>    
			<div id='calendar' style="background-color:white">
			</div>  
		</div>  
		
		<!-- 일정 추가 MODAL -->
        <div class="modal fade" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    	<h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">
					<form>
						<div class="form-body">
                           <div class="row">
                               <div class="col-12">
                                   <div class="form-group has-icon-left">
                                   	   <input class="inputModal" type="hidden" name="tno" id="tno"/>
                                       <label class="col-xs-4" for="edit-title">일정명</label>
                                       <div class="position-relative">
                                           <input type="text" class="form-control"
                                                type="text" name="edit-title" id="edit-title" required="required">
                                           <div class="form-control-icon">
                                               <i class="bi bi-calendar-check"></i>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <div class="col-12">
									<div class="form-group has-icon-left">
                                       <label class="col-xs-4" for="edit-start">시작일</label>
                                       <div class="position-relative">
                                           <input type="text" class="form-control" type="text" name="edit-start" id="edit-start">
                                           <div class="form-control-icon">
                                               <i class="bi bi-calendar-event"></i>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <div class="col-12">
                                   <div class="form-group has-icon-left">
                                       <label class="col-xs-4" for="edit-end">종료일</label>
                                       <div class="position-relative">
                                           <input type="text" class="form-control" type="text" name="edit-end" id="edit-end">
                                           <div class="form-control-icon">
                                               <i class="bi bi-calendar-event-fill"></i>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               <label class="col-xs-4" for="edit-allDay"><input class='allDayNewEvent' id="edit-allDay" type="checkbox"> 하루종일</label>
                               <div class="col-12 mt-1">
                                   <div class="form-group has-icon-left">
                                       <label class="col-xs-4" for="edit-type">구분</label>
                                       <fieldset class="form-group">
                                           <select class="form-select" type="text" name="edit-type" id="edit-type">
                                                <option value="개인">개인</option>
			                                    <option value="부서">부서</option>
			                                    <option value="프로젝트">프로젝트</option>
                                           </select>
                                       </fieldset>
                                   </div>
                               </div>
                               <div class="col-12 mt-1">
                                   <div class="form-group has-icon-left">
                                       <label class="col-xs-4" for="edit-color">색상</label>
                                       <fieldset class="form-group">
                                           <select class="form-select" name="color" id="edit-color">
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
                                       </fieldset>
                                   </div>
                               </div>
                               <div class="col-12">
                                    <div class="form-group mb-3">
                                        <label class="col-xs-4" for="edit-desc">내용</label>
                                        <textarea class="form-control" name="edit-desc" id="edit-desc"></textarea>
                               	  </div>
                               </div>
                           </div>
                       </div>
                    </form>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                    	<button type="button" class="btn btn-primary" id="save-event">저장</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" id="close">취소</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                    	<button type="button" class="btn btn-primary" id="updateEvent">변경</button>
                    	<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close1">닫기</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal --> 
	</div>
	</div>
	
	<script>  

		$(function(){    
			
			cal(); // 첫 입장시는 필터값 없이 캘릭더 작동
			
			let fil = "";
			$('.calfilter').on('change', function () { // 필터값 변경될때 마다
				fil = $(this).val()
			    cal(fil); // 필터값 추가해서 캘린더 작동
			});
			
			function cal(fil) {
				
				var calendar = new FullCalendar.Calendar($('#calendar')[0], {  // full-calendar 생성하기       
					
					height: '800px', // calendar 높이 설정        
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
				  	nextDayThreshold            : "00:00:00", // 0시 기준으로 다음날로 계산됨
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
					eventDidMount: function(info) { 
						let val = "";
						if(info.event._def.extendedProps.content == null) {
							val = "없음";
						} else {
							val = info.event._def.extendedProps.content;
						}
			            tippy(info.el, { // 툴팁으로
			                content:  val,
			                theme: 'custom',
			                arrow: false
			            });
			        },
  
					eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트          

						var eventData = {
							tTitle: obj.oldEvent.title,
							tStart: obj.event.start,
							tEnd: obj.event.end,
							tContent: obj.oldEvent._def.extendedProps.content, // 내용
							tCategory: obj.oldEvent._def.extendedProps.category, // 구분
							tColor: obj.oldEvent.backgroundColor,
							tNo: obj.oldEvent._def.extendedProps.tno,
							tAllday: false
					    };
						
						if(obj.event.allDay) { 
							eventData.tStart = moment(eventData.tStart).format('YYYY-MM-DD');
				            eventData.tEnd = moment(eventData.tEnd).format('YYYY-MM-DD');
				            eventData.tAllday = true;
						} else { 
							eventData.tStart  = moment(eventData.tStart).format('YYYY-MM-DD HH:mm');
							eventData.tEnd = moment(eventData.tEnd).format('YYYY-MM-DD HH:mm');
							eventData.tAllday = false;
						}

						$.ajax({
				            type: "post",
				            url: "updateTimetable",
				            data: JSON.stringify(eventData),
				            contentType: 'application/json',
				            success: function (response) {		
				            	cal();
				            },
				            error:function(){
								console.log("일정 변경 ajax 통신 실패");
							}
				        });	
					},        

					eventClick: function(obj) { // 일정 클릭시 발생하는 이벤트  
						
						$('.modal-title').html("등록된 일정");
						$('.modalBtnContainer-addEvent').hide();
						$('.modalBtnContainer-modifyEvent').show();
						$('#eventModal').modal('show');

						$("#tno").val(obj.event._def.extendedProps.tno); // 일정번호
						$("#edit-title").val(obj.event.title); // 제목
						$("#edit-desc").val(obj.event._def.extendedProps.content); // 내용
						
						if(obj.event.allDay) { //true
							$("#edit-start").val(moment(obj.event._instance.range.start).format('YYYY-MM-DD 00:00'));
							$("#edit-end").val(moment(obj.event._instance.range.end).subtract(1, 'days').format('YYYY-MM-DD 00:00'));
							$("#edit-allDay").attr('checked', true);
						} else { // false
							$("#edit-start").val(moment(obj.event.start).format('YYYY-MM-DD HH:mm'));
							$("#edit-end").val(moment(obj.event.end).format('YYYY-MM-DD HH:mm'));
							$("#edit-allDay").attr('checked', false);
						}
						
						if($("#edit-start").val() > $("#edit-end").val()) {
							$("#edit-end").val(moment(obj.event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'));
						}
					
						$("#edit-type").val(obj.event._def.extendedProps.category).prop("selected", true); // 구분
						$("#edit-color").val(obj.event.backgroundColor).prop("selected", true); // 배경색
						$('#edit-color').css('color', obj.event.backgroundColor); 
						
						// 닫기, 취소시 값 초기화
						$("#close1").on('click', function () {
							$('#eventModal').modal('hide');
						})
						$('#eventModal').on('hidden.bs.modal', function () {
							$(this).find('form')[0].reset();
							$('#edit-color').css('color', "#D25565"); 
							$("#edit-allDay").attr('checked', false);
				   		});
						
						// 삭제시 
						$("#deleteEvent").on('click', function () {
							
							let tNo = $("#tno").val();
							$.ajax({
					            type: "post",
					            url: "deleteTimetable",
					            data: {
					            	tNo:tNo
					            },
					            success: function (response) {		
					            	cal();
					            },
					            error:function(){
									console.log("일정 삭제 ajax 통신 실패");
								}
					        });
							
							$('#eventModal').modal('hide');
							$("#edit-allDay").attr('checked', false);
						})
						// 변경시 
						$("#updateEvent").on('click', function () {
							
							var eventData = {
								tTitle: $("#edit-title").val(),
								tStart: $("#edit-start").val(),
								tEnd: $("#edit-end").val(),
								tContent: $("#edit-desc").val(), // 내용
								tCategory: $("#edit-type").val(), // 구분
								tColor: $("#edit-color").val(),
								tNo: $("#tno").val(),
								tAllday: false
						    };
							
					        if ($('#edit-allDay').is(':checked')) {
					            eventData.tStart = moment(eventData.tStart).format('YYYY-MM-DD');
					            eventData.tEnd = moment(eventData.tEnd).add(1, 'days').format('YYYY-MM-DD');
					            eventData.tAllday = true;
					        }
							
							if (eventData.tStart > eventData.tEnd) {
					            alert('끝나는 날짜가 앞설 수 없습니다.');
					            return false;
					        }

					        if (eventData.tTitle === '') {
					            alert('일정명은 필수입니다.');
					            return false;
					        }

					        
					        $.ajax({
					            type: "post",
					            url: "updateTimetable",
					            data: JSON.stringify(eventData),
					            contentType: 'application/json',
					            success: function (response) {		
					            	cal();
					            },
					            error:function(){
									console.log("일정 변경 ajax 통신 실패");
								}
					        });
					        
					        $("#edit-allDay").attr('checked', false);
					        $('#eventModal').modal('hide');
						})
					},  
					
					select: function(arg) { // 캘린더 칸 클릭시
						// 모달창띄움
						$('.modal-title').html("새로운 일정");
						$('.modalBtnContainer-addEvent').show();
						$('.modalBtnContainer-modifyEvent').hide();
						$('#eventModal').modal('show');
						$("#edit-start").val(moment(arg.start).format('YYYY-MM-DD HH:mm'));
						$('#save-event').unbind();
						
						$("#close").on('click', function () {
							$('#eventModal').modal('hide');
						})
						$('#eventModal').on('hidden.bs.modal', function () {
							$(this).find('form')[0].reset();
							$('#edit-color').css('color', "#D25565"); 
							$("#edit-allDay").attr('checked', false);
				   		});
						
						// 저장버튼 클릭
						$('#save-event').on('click', function () {
							
							var eventData = {
								tTitle: $("#edit-title").val(),
								tStart: $("#edit-start").val(),
								tEnd: $("#edit-end").val(),
								tContent: $("#edit-desc").val(), // 내용
								tCategory: $("#edit-type").val(), // 구분
								tColor: $("#edit-color").val(),
								tAllday: false
						    };
							
					        if ($('#edit-allDay').is(':checked')) {
					            eventData.tStart = moment(eventData.tStart).format('YYYY-MM-DD');
					            eventData.tEnd = moment(eventData.tEnd).add(1, 'days').format('YYYY-MM-DD');
					            eventData.tAllday = true;
					        } 
							
							if (eventData.tStart > eventData.tEnd) {
					            alert('끝나는 날짜가 앞설 수 없습니다.');
					            return false;
					        }
	
					        if (eventData.tTitle === '') {
					            alert('일정명은 필수입니다.');
					            return false;
					        }

					        $("#edit-allDay").attr('checked', false);
					        $('#eventModal').modal('hide');
	
					        $.ajax({
					            type: "post",
					            url: "insertTimetable",
					            data: JSON.stringify(eventData),
					            contentType: 'application/json',
					            success: function (response) {		
					            	cal();					              
					            },
					            error:function(){
									console.log("일정 추가 ajax 통신 실패");
								}
					        });
						});
				        
						calendar.unselect()
	
					}, // select 이벤트 끝
					
					events:function(info, successCallback, failureCallback) {
						let start = moment(info.start).format('YYYY-MM-DD'); // 조회할 DB 시작일
						let end = moment(info.end).format('YYYY-MM-DD');
						$.ajax({
			                url: "selecttimetableList", // 조회하기
			                method: "post",
			                data: {
			                	fil: fil, // 전역변수로 받음
			                	start: start,
			                	end: end
							},
			                success: function (result) {

			                	var events = [];
			                	
			                	if(result != null) {
				                	for(var i in result) {
				                		if(result[i].tAllday == "true") {
				                			events.push({
        	    			                    title: result[i].tTitle,
        	    			                    start: moment(result[i].tStart).format('YYYY-MM-DD HH:mm'),
        	    			                    end: moment(result[i].tEnd).format('YYYY-MM-DD HH:mm'),
        	    			                    color:result[i].tColor,
        	    								category:result[i].tCategory,
        	    								content:result[i].tContent,
        	    								tno:result[i].tNo,
         	    								allDay: true
        	    			                }); //events.push()
    									} else {
    										events.push({
    							    			title: result[i].tTitle,
    							    			start: moment(result[i].tStart).format('YYYY-MM-DD HH:mm'),
    							    			end: moment(result[i].tEnd).format('YYYY-MM-DD HH:mm'),
    							    			color:result[i].tColor,
    							    			category:result[i].tCategory,
    							    			content:result[i].tContent,
    							    			tno:result[i].tNo,
    							    			allDay: false	        
    							    		}); //events.push()
    									}    

				                	}
				                	console.log(events); // 받아온 DB 전체다 확인
			                	}
			                	successCallback(events); // 성공해서 받은 DB 화면 출력                     
			                }
			            });
					}
				});      // 캘린더 랜더링      
				calendar.render();    
			}
		});  
		
	</script>
	<script src="resources/full/js/moment.min.js"></script>
	<script src="resources/full/js/select2.min.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="resources/full/js/timepicker.js"></script>
	<script src="resources/full/js/etcSetting.js"></script>
	<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
	<script src="https://unpkg.com/tippy.js@6"></script>

</body>
</html>
