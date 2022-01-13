<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/calendar.css">
<script type="text/javascript" src="/resources/js/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//calendarMaker($("#calendarForm"),new Date());
	
	$(".btn-calender-display").click(function(){
		$("#calendar").toggle("fast");
		$(".btn-calender-display").toggle();
	});
	$('.roomList').on('click', '')
});

	
</script>
<script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
      });
      


      /* document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
          selectable: true,
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          dateClick: function(info) {
            alert('clicked ' + info.dateStr);
          },
          select: function(info) {
            alert('selected ' + info.startStr + ' to ' + info.endStr);
          }
        });

        calendar.render();
      }); */



    </script>
<body>
	<!-- <div id="calendarForm"></div> -->
	<div class="container">
	<div class="d-flex justify-content-around mb-4">
		<label>部屋番号<select>
			<option value="">---</option>
			<c:forEach var="roomList" items="${roomInfoList}">
				<option class="roomList">
					${roomList.roomNum}
				</<option>
					
			</c:forEach>
		</select></label>
		<label></label><input type="text" name="keyword" ></label>
	</div>
		<div class="d-flex justify-content-center mb-3" style="flex-direction: row; align-items: center">
			<div class="col-lg-7"> 
					<div id='calendar'></div>
		<!-- 			<button class="btn-calender-display">Hide</button>
					<button class="btn-calender-display" style="display: none">Show</button>  -->		
			</div>
		</div>
		<br/>
	
		
	</div>
	
</body>
