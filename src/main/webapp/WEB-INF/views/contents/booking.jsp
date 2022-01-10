<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/calendar.css">
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	calendarMaker($("#calendarForm"),new Date());
	
	$(".btn-calender-display").click(function(){
		$("#calendarForm").toggle("fast");
		$(".btn-calender-display").toggle();
	});
});

	
</script>
<body>
	<div id="calendarForm"></div>
	<button class="btn-calender-display">Hide</button>
	<button class="btn-calender-display" style="display: none">Show</button>
</body>
