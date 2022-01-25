<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/calendar.css">
<script type="text/javascript" src="/resources/js/calendar.js"></script>

<style>
a{text-decoration: none;}
</style>
<body>
	<!-- <div id="calendarForm"></div> -->
	<div class="bg-dark " style="height: 94px"></div>
	<section class="masthead">
		<div style="padding-top: 20px;">
			<div class="container">
				<div di>
					<form class="form-inline">
						<div class="form-group">
					    	<label>部屋番号</label>
					    	<select class="roomSelect form-control mx-sm-3">
								<option value="">---</option>
							</select>
						</div>
					</form>
				</div>
				<br/>
					<div id='calendar'></div>
				<br/>
				<form class="form-inline d-flex justify-content-end">
					<div class="form-group">
				    	<label>Search</label>
				    	<input type="text" class="form-control" name="keyword">
					</div>
				</form>
				<br/>
			</div>
		</div>
	</section>
<script type="text/javascript">
	$(document).ready(function(){
		let amount = 0;
		
		checkReserve(amount)
		$('#calendar').click(function(e){
			if(e.target == document.querySelector('button[title="Previous month"]') || e.target == document.querySelector('span[class="fc-icon fc-icon-chevron-left"]')){
				amount = amount - 1;
				checkReserve(amount);
			} else if(e.target == document.querySelector('button[title="Next month"]') || e.target == document.querySelector('span[class="fc-icon fc-icon-chevron-right"]')){
				amount = amount + 1;
				checkReserve(amount)
			} else if(e.target == document.querySelector('button[title="This month"]')){
				amount = 0;
				checkReserve(amount)
			}
			console.log(amount)
			
	  	});
		
		$.getJSON('/api/checkReserve' ,function(arr){
			console.log(arr);
			$.each(arr, function(i, room){
				let optionGroup = document.createElement('option');
				console.log(room.roomNum + room.roomTitle)
				optionGroup.innerText = room.roomNum;
				$('.roomSelect').append(optionGroup);
			})
		});
		
	});
	function checkReserve(amount) {
		var today = new Date();
	
		var year = today.getFullYear();
		var month = Number(('0' + (today.getMonth() + 1 + amount)).slice(-2));
		if(month == 0 || month > 13|| amount<0) {
		console.log(month)
			let i = 0;
			if(month % 13){
				i--;
			}
			year = year-1-i;
			month = 13+amount;
		}
		var day = ('0' + today.getDate()).slice(-2);
	
		var dateString = year + '-' + ('0'+month).slice(-2)  + '-' + day;
	
		console.log(dateString);
		$.getJSON('/api/checkReserve/'+amount ,function(arr){
			let jsonList = new Array();
	       	  $.each(arr, function(i, data){
	       		//console.log(data[1])
				let json = new Object();
	       		json.no = data[1].roomNo.no;
	       		json.title = data[1].roomNo.roomTitle;
	       		json.start = moment(data[1].startDate).format('YYYY-MM-DD');
	       		json.end = moment(moment(data[1].endDate).add(1, 'days')).format('YYYY-MM-DD');
	       		json.color =data[0].colorCd;
	     		jsonList.push(json);
	     		//console.log(jsonList)
	       	  });
	       	var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
				eventChange: function(info) {
					
				},
				eventClick: function(info) {
					var eventObj = info.event;
					
					if (eventObj.url) {
						alert(
						'Clicked ' + eventObj.no + '.\n'
						);
					
						window.open(eventObj.url);
						
						info.jsEvent.preventDefault(); // prevents browser from following link in current tab.
					} else {
						console.log(eventObj)
						alert(
							'Clicked ' + eventObj.extendedProps.no + '.\n'
							+'Srart ' +eventObj._instance.range.start + '.\n'
							+'End' + eventObj._instance.range.end
						);
					}
				},
				initialView: 'dayGridMonth',
				initialDate: dateString,
				dayMaxEvents: true, // allow "more" link when too many events
				height: 1100,
				contentHeight: 500,
				aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
				events: jsonList,
			    dayMaxEvents: true,
	       });
			
	        calendar.render();
		});
	}
</script>
</body>

