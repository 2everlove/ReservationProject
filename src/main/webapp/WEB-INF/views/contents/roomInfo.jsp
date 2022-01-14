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
            		<h4 class="text-dark">${roomInfo.roomNum } 号</h4>
	                <div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
	                    <div class="col-lg-6"><img class="img-fluid" src="/resources/assets/img/room/room2.jpg" alt="..." /></div>
	                    <div class="col-lg-6">
	                        <div class="bg-light text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-left">
	                                    <h4 class="text-dark">
						                   		${roomInfo.roomTitle }
						                   
						                </h4>
	                                    <p class="mb-0 text-dark">
		                                    <form>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="inputEmail3" class="col-sm-2 col-form-label">人数</label>
													<div class="col-sm-5">
														<input type="number" class="form-control detail__count-adult" min="1"　max="5" placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="1">
														<input type="number" class="form-control detail__count-child"　placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
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
                <input type="text" id="demo" name="demo" value="" />
                <div id='calendar'></div>
            	</div>
           	<hr>
           	<fmt:parseDate value="${ roomInfo.createdAt }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
           	${parsedDateTime }<br>
			<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${ parsedDateTime }" />
       	</section>			
	</div>
</div>
<script type="text/javascript">

	$(document).ready(function(){
	let disabledArr = [];
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
			
		
		//방정보
		$.getJSON('/api/checkReserve' ,function(arr){
			//console.log(arr);
			$.each(arr, function(i, room){
				let optionGroup = document.createElement('option');
				console.log(room.roomNum + room.roomTitle)
				optionGroup.innerText = room.roomNum;
				$('.roomSelect').append(optionGroup);
			})
		});
		
		$(".detail__count-adult").change(function(){
			if($(".detail__count-adult").val() > 5){
				alert(${pBoard.pboard_unit_stocks}+"개 이하로 구매할 수 있습니다.");
				$(".detail__count-adult").val(${pBoard.pboard_unit_stocks});
				$(".pboard_unit_stocks").val(0);
				$("input[name=pboard_unit_stocks]").val(0);
				$(".detail__count-input").select();
			}
		});
		//기간
		function getRange(startDate, endDate, type) {
			let fromDate = moment(startDate)
			let toDate = moment(endDate)
			let diff = toDate.diff(fromDate, type)
			let range = []
			for (let i = 0; i < diff; i++) {
			  range.push(moment(moment(startDate).add(i, type)).format('YYYY-MM-DD'))
			}
			return range
		}
		
		function uniteUnique(arr) {
			  return Array.from(new Set(arr.flat()));
		}
		function checkReserve(amount) {
			var today = new Date();
			
			var year = today.getFullYear();
			var month = Number(('0' + (today.getMonth() + 1 + amount)).slice(-2));
			var day = ('0' + today.getDate()).slice(-2);
			
			var dateString = year + '-' + ('0'+month).slice(-2)  + '-' + day;
			console.log(dateString);
			$.getJSON('/api/checkReserve/'+amount+"/${roomNum}" ,function(arr){
				console.log(arr);
				let jsonList = new Array();
		       	  $.each(arr, function(i, data){
		       		disabledArr.push(getRange(data[1].startDate, data[1].endDate, 'days').flat(Infinity));
		       		//console.log(data[1]);
		       		//console.log(data[1].startDate+ " " + data[1].endDate);
		       		//console.log(uniteUnique(disabledArr));
					//console.log(data);
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
		          height: 650,
		          dayMaxEvents: true, // allow "more" link when too many events
		          aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
		          events: jsonList,
		       });
				
		        calendar.render();
		        
			});
		}
		console.log(uniteUnique(disabledArr));
		$('#demo').daterangepicker({
			isInvalidDate: function(arg){

		         // Prepare the date comparision
		         var thisMonth = arg._d.getMonth()+1;   // Months are 0 based
		         if (thisMonth<10){
		             thisMonth = "0"+thisMonth; // Leading 0
		         }
		         var thisDate = arg._d.getDate();
		         if (thisDate<10){
		             thisDate = "0"+thisDate; // Leading 0
		         }
		         var thisYear = arg._d.getYear()+1900;   // Years are 1900 based

		         var thisCompare = thisYear +"-"+ thisMonth +"-"+ thisDate ;
		         console.log(thisCompare);
				
		         if($.inArray(thisCompare,uniteUnique(disabledArr))!=-1){
		             console.log("      ^--------- DATE FOUND HERE");
		             return true;
		         }
		     },
		     opens: 'left',
			"locale": { 
				"format": "YYYY/MM/DD", 
				"separator": " ~ ",
				"applyLabel": "확인", 
				"cancelLabel": "취소", 
				"fromLabel": "From", 
				"toLabel": "To", 
				"customRangeLabel": "Custom", 
				"weekLabel": "W", 
				"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"], 
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], 
			}, 
			"startDate": new Date(), 
			"endDate": new Date(), 
			"drops": "auto" 
		}, function (start, end, label) { 
			
			console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		});
		
		$("#demo").on("apply.daterangepicker",function(e,picker){

		    // Get the selected bound dates.
		    var startDate = picker.startDate.format('YYYY-MM-DD')
		    var endDate = picker.endDate.format('YYYY-MM-DD')
		    //console.log(startDate+" to "+endDate);
		    
		    // Compare the dates again.
		    var clearInput = false;
		    let disableD = uniteUnique(disabledArr);
		    //console.log(disableD)
		    for(i=0;i<disableD.length;i++){
		        if(startDate<disableD[i] && endDate>disableD[i]){
		            console.log("중복");
		            clearInput = true;
		        }
		    }

		    // If a disabled date is in between the bounds, clear the range.
		    if(clearInput){

		        // To clear selected range (on the calendar).
		        var today = new Date();
		        $(this).data('daterangepicker').setStartDate(today);
		        $(this).data('daterangepicker').setEndDate(today);

		        // To clear input field and keep calendar opened.
		        $(this).val("").focus();
		        //console.log("Cleared the input field...");

		        // Alert user!
		        alert("중복된 날짜가 있습니다. 다시 입력해주세요.");
		    }
		});
	});
		
	
	
	
		
	
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</body>

