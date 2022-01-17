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
					                   		${roomInfo.roomTitle}
						                </h4>
	                                    <p class="mb-0 text-dark">
		                                    <form>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="inputEmail3" class="col-sm-2 col-form-label">大人数</label>
													<div class="col-sm-5">
														<input type="number" class="form-control detail__count-adult" min="1"　max="5" placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="1" style="width: 80px;">
													</div>
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="inputEmail3" class="col-sm-2 col-form-label">子供数</label>
													<div class="col-sm-5">
														<input type="number" class="form-control detail__count-child" value="0"　placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="width: 80px;">
													</div>
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="inputEmail3" class="col-sm-2 col-form-label">期&nbsp;&nbsp;&nbsp;&nbsp;間</label>
													<div class="col-sm-5">
														<input type="text" class="form-control" id="demo" name="demo" value=""/>
													</div>
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="inputEmail3" class="col-sm-2 col-form-label">総金額</label>
													<div class="col-sm-5">
														<input class="form-control detail__totalPrice" type="text" value="${roomInfo.adultCost }" placeholder="" readonly/>
													</div>
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													大人: ￥<fmt:formatNumber type="number" value="${roomInfo.adultCost }"/> |
													子供: ￥<fmt:formatNumber type="number" value="${roomInfo.childCost }"/>
													
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
			                                   		<div class="col-sm-3">
			                                    		<button type="button" class="btn btn-primary btn-lg registerReserve">Reserve</button>
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
           	<hr>
           	${roomInfo }
           	<fmt:parseDate value="${ roomInfo.createdAt }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
           	${parsedDateTime }<br>
			<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${ parsedDateTime }" />
       	</section>
	</div>
</div>
<div class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Modal title</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<select class="bankSelect form-control mx-sm-10">
					<option value="">---</option>
				</select>
				<p>Modal body text goes here.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Payment</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	$(document).ready(function(){
	let disabledArr = [];
		let amount = 0;
		
		let modal = $('.modal');
		$('.registerReserve').click(function(){
			modal.modal('show');
			$('.bankSelect').html('<option value="">---</option>');
			//은행정보
			$.getJSON('/api/payment/list' ,function(arr){
				console.log(arr);
				$.each(arr, function(i, bank){
					console.log(bank);
					let optionGroup = document.createElement('option');
					console.log(bank.bankName + bank.bankCd)
					optionGroup.innerText = bank.bankName;
					optionGroup.value=bank.bankCd;
					$('.bankSelect').append(optionGroup);
				})
			});
		});
		$('.modal-footer .btn-secondary').click(function(){
			modal.modal('hide');
		});
		$('.close span').click(function(){
			modal.modal('hide');
		});
		
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
		
		
		$(".detail__count-adult").change(function(){
			if($(".detail__count-adult").val() > ${roomInfo.max}){
				alert(${roomInfo.max}+"명 이하로 예약할 수 있습니다.");
				$(".detail__count-adult").val("5");
				$(".detail__count-child").val("0");
				$(".detail__count-adult").select();
			} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > ${roomInfo.max}){
				$(".detail__count-adult").val(Number($(".detail__count-adult").val()));
				$(".detail__count-child").val(Number($(".detail__count-child").val())-1);
				if($(".detail__count-adult").val() == ${roomInfo.max}){
					$(".detail__count-adult").val("5");
					$(".detail__count-child").val("0");
				}
			}
			$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
		});
		
		$(".detail__count-child").change(function(){
			if($(".detail__count-child").val() > ${roomInfo.max}-1){
				alert("성인이 1명 있어야 합니다.");
				$(".detail__count-child").val("4");
				$(".detail__count-adult").val("1");
				$(".detail__count-child").select();
			} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > ${roomInfo.max}){
				$(".detail__count-adult").val(Number($(".detail__count-adult").val())-1);
				$(".detail__count-child").val(Number($(".detail__count-child").val()));
				if($(".detail__count-child").val() == ${roomInfo.max}-1){
					$(".detail__count-child").val("4");
					$(".detail__count-adult").val("1");
				}
			}
			$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
		});
		
		function calculateTotal(a, c){
			let total = 0;
			let adultCost = ${roomInfo.adultCost};
			let childCost = ${roomInfo.childCost};
			total = adultCost*a + childCost*c
			return total;
		}
		
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
		       	/* var calendarEl = document.getElementById('calendar');
		        var calendar = new FullCalendar.Calendar(calendarEl, {
		          initialView: 'dayGridMonth',
		          initialDate: dateString,
		          height: 650,
		          dayMaxEvents: true, // allow "more" link when too many events
		          aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
		          events: jsonList,
		       }); */
				
		        //calendar.render();
		        
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
				"format": "YYYY-MM-DD", 
				"separator": " ~ ",
				"applyLabel": "확인", 
				"cancelLabel": "취소", 
				"fromLabel": "From", 
				"toLabel": "To", 
				"customRangeLabel": "Custom", 
				"weekLabel": "W", 
				"daysOfWeek": ["日", "月", "火", "水", "木", "金", "土"], 
				"monthNames": ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"], 
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
		        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
		    }
		});
		
		
	});
		
	
	
	
		
	
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</body>

