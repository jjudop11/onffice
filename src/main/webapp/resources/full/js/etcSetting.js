//SELECT 색 변경
$('#edit-color').change(function () {
    $(this).css('color', $(this).val());
});

//필터
$("#type_filter").select2({
    placeholder: " 선택..",
    allowClear: true
});
$("#edit-start, #edit-end").datetimepicker({
    dateFormat:'yy-mm-dd',
    monthNamesShort:[ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
	dayNamesMin:[ '일', '월', '화', '수', '목', '금', '토' ],
	changeMonth:true,
	changeYear:true,
	showMonthAfterYear:true,
	autoclose: true,
	todayHighlight: true,
	// timepicker 설정
	timeFormat:'HH:mm',
	controlType:'select',
	oneLine:true
 });