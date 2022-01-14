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
	<div class="masthead">
		<div style="padding-top: 0px;">
	        	<section class="projects-section bg-light" style="margin-top: 20px; padding-bottom: 40px;">
		            <div class="container px-4 px-lg-5">
	                <div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
	                    <div class="col-lg-6"><img class="img-fluid" src="/resources/assets/img/room/room2.jpg" alt="..." /></div>
	                    <div class="col-lg-6">
	                        <div class="bg-light text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-left">
	                                    <h4 class="text-dark">Misty</h4>
	                                    <p class="mb-0 text-dark">
		                                    <form>
												<div class="form-group row">
													<label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
													<div class="col-sm-10">
														<input type="password" class="form-control" id="inputPassword" placeholder="Password">
													</div>
												</div>
											</form>
	                                    </p>
	                                    
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div style="padding-top: 20px;"></div>
	                <hr style="border: none; font-size: 0; line-height: 0; margin: 40px 0 40px 0; color: rgba(132, 129, 122,1.0); background:rgba(132, 129, 122,1.0); height: 3px;"/>
	            	<div style="padding-top: 20px;"></div>
	                <!-- <div class="row gx-0 justify-content-center">
	                    <div class="col-lg-6"><img class="img-fluid" src="/resources/assets/img/room/room3.jpg" alt="..." /></div>
	                    <div class="col-lg-6 order-lg-first">
	                        <div class="bg-black text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-right">
	                                    <h4 class="text-white">Mountains</h4>
	                                    <p class="mb-0 text-white-50">Another example of a project with its respective description. These sections work well responsively as well, try this theme on a small screen!</p>
	                                    <hr class="d-none d-lg-block mb-0 me-0" />
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div> -->
	                <div id='calendar'></div>
	            </div>
	        	</section>			
		</div>
	</div>
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
		var day = ('0' + today.getDate()).slice(-2);
	
		var dateString = year + '-' + ('0'+month).slice(-2)  + '-' + day;
	
		console.log(dateString);
		$.getJSON('/api/checkReserve/'+amount+"/${roomNum}" ,function(arr){
			let jsonList = new Array();
	       	  $.each(arr, function(i, data){
				let json = new Object();
	       		json.title = data[1].roomNo.roomTitle;
	       		json.start = moment(data[1].startDate).format('YYYY-MM-DD');
	       		json.end = moment(data[1].endDate).format('YYYY-MM-DD');
	       		json.color =data[0].colorCd;
	     		jsonList.push(json);
	       	  });
	       	var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
	          initialView: 'dayGridMonth',
	          initialDate: dateString,
	          dayMaxEvents: true, // allow "more" link when too many events
	          aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
	          events: jsonList,
	       });
			
	        calendar.render();
		});
	}
</script>
</body>

