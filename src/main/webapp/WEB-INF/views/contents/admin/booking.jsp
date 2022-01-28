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
					    	<select class="buildCdList form-control mx-sm-3">
								<option value="">---</option>
								<c:forEach items="${buildCdList}" var="buildCd">
									<option value="${buildCd}">${buildCd}</option>
								</c:forEach>
							</select>
					    	<label>階</label>
						</div>
						<div class="form-group">
					    	<select class="roomNoList form-control mx-sm-3">
								<option value="">---</option>
							</select>
					    	<label>号室</label>
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
	
<div class="modal" tabindex="-1">
	<div class="modal-dialog" style="margin: 10.75rem auto;max-width: 900px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"></h5>
				<label for="" class="col-sm-1 col-form-label"></label>
				<div class="col-sm-2">
					<input class="form-control customer" type="text" placeholder=""/>
					<input class="reserveNo" type="hidden">
					<input class="startDate" type="hidden">
					<input class="endDate" type="hidden">
				</div>
				<label for="" class="col-sm-2 col-form-label">顧客様</label>
				<label for="" class="col-sm-1 col-form-label">regDate</label>
				<div class="col-sm-4">
					<input class="form-control regDate" type="text" placeholder="" readonly="readonly" style="background-color: #fff; border:none;"/>
				</div>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-1 col-form-label">総金額</label>
					<div class="col-sm-2">
						<input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					<label for="" class="col-sm-1 col-form-label">Bank</label>
					<div class="col-sm-2">
						<select class="bankSelect form-control mx-sm-10">
							<option value="">---</option>
						</select>
					</div>
					<label for="" class="col-sm-1 col-form-label">Adult</label>
					<div class="col-sm-2">
						<input class="form-control detail__count-adult" type="number" placeholder=""/>
					</div>
					<label for="" class="col-sm-1 col-form-label">Child</label>
					<div class="col-sm-2">
						<input class="form-control detail__count-child" type="number" placeholder=""/>
					</div>
				</div>
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-1 col-form-label">입실일</label>
					<div class="col-sm-3">
						<input class="form-control start" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					<label for="" class="col-sm-1 col-form-label">퇴실일</label>
					<div class="col-sm-3">
						<input class="form-control end" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					<label for="" class="col-sm-1 col-form-label">phone</label>
					<div class="col-sm-3">
						<input class="form-control phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>
						<input class="form-control phone__clone" type="hidden" placeholder="" style="display: none;"/>
					</div>
				</div>
				<div class="form-group row" style="justify-content: flex-end;">
					
				</div>
				<p class="response__data"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-success permitPwBtn" style="display: none;">Permit</button>
				<button type="button" class="btn btn-danger cancelPwBtn" style="display: none;">Cancel</button>
				<button type="button" class="btn btn-primary modifyPwBtn">Modify</button>
				<button type="button" class="btn btn-primary checkPwBtn" style="display: none;">Confirm</button>
			</div>
		</div>
	</div>
</div>
<div aria-live="polite" aria-atomic="true" style="position: fixed; bottom: 3%;width: 100%;height: 10%; z-index: 1070;">
  <div class="toast" style="position: absolute; top: 0; right: 0; z-index: 1;">
    <div class="toast-header">
      <div class="rounded mr-2 colorMark" style="width: 20px; height: 20px; border-radius: 3px;"></div>
      <strong class="mr-auto">Success</strong>
      <small></small>
      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <div class="toast-body">
    	
    </div>
  </div>
</div>
<script type="text/javascript">
let modal = $('.modal');
$('.modal-footer .btn-secondary, .close').click(function(){
	$('.permitPwBtn').hide();
	$('.cancelPwBtn').hide();
	$('.checkPwBtn').hide();
	$('.modifyPwBtn').show();
	modal.modal('hide');
});
let disabledArr = [];
let eventObj = "";
let amount = 0;
let today = new Date();
const WEEKDAY = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"];
$(document).ready(function(){
	
	
	$('.phone').keyup(function(){
		//console.log($(this).val().length);
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
	});
	$(".phone").change(function(){
		let str = $(this).val();
		let tmp = str.replace(/\-/g,'');
		$(".phone__clone").val(tmp);
	});
	$('.modifyPwBtn').on('click', function(){
		$('.permitPwBtn').show();
		$('.cancelPwBtn').show();
		$('.checkPwBtn').show();
		$('.modifyPwBtn').hide();
		modal.find('input').attr('disabled', false);
		modal.find('select').attr('disabled', false);
		modal.find('input').css('background-color','#fff');
		modal.find('input').css('border','1px solid #ced4da');
		modal.find('select').css('border-radius','0.25rem');
		modal.find('select').css('border','1px solid #ced4da');
		modal.find('select').css('border-radius','0.25rem');
		modal.find('.regDate').css('border','none');
	});
	
	checkReserve(amount)
	$('#calendar').click(function(e){
		if(e.target == document.querySelector('button[title="Previous month"]') || e.target == document.querySelector('span[class="fc-icon fc-icon-chevron-left"]')){
			amount = amount - 1;
			moment().subtract(amount, 'months').format('YYYY-MM-DD');
			checkReserve(amount, moment().add(amount, 'months').format('YYYY-MM-DD'));
		} else if(e.target == document.querySelector('button[title="Next month"]') || e.target == document.querySelector('span[class="fc-icon fc-icon-chevron-right"]')){
			amount = amount + 1;
			checkReserve(amount, moment().add(amount, 'months').format('YYYY-MM-DD'))
		} else if(e.target == document.querySelector('button[title="This month"]')){
			amount = 0;
			checkReserve(amount)
		}
		console.log(amount)
		
  	});
	
	$('.buildCdList').change(function(){
		$('.roomNoList').empty();
		let optionGroup = document.createElement('option');
		optionGroup.innerText = "---";
		optionGroup.value = '';
		$('.roomNoList').append(optionGroup);
		$.getJSON('/api/checkReserveRooms/'+$('.buildCdList option:selected').val() ,function(arr){
			$.each(arr, function(i, room){
				let optionGroup = document.createElement('option');
				console.log(i)
				console.log(room.roomNum + room.roomTitle)
				optionGroup.innerText = room.roomNum;
				optionGroup.value = room.no;
				$('.roomNoList').append(optionGroup);
				checkReserve(amount);
			});
		});
	});
	
	$('.roomNoList').change(function(){
		checkReserve(amount);
	})
	
	$('.start').daterangepicker({
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
	         //console.log(thisCompare);
	         //console.log(uniteUnique(disabledArr));
			
	         if($.inArray(thisCompare,uniteUnique(disabledArr))!=-1){
	            //console.log("      ^--------- DATE FOUND HERE");
	             return true;
	         }
	         if(disabledArr.length == 0){
	        	 console.log(disabledArr.length);
	        	 return true;
	         }
	     },
	     opens: 'left',
	     minDate: today,
	     maxSpan: {
	    	    "days": '10'
   		},　
		"locale": { 
			"format": "YYYY年　MM月　DD日", 
			"separator": "	~	",
			"applyLabel": "확인", 
			"cancelLabel": "취소", 
			"fromLabel": "From", 
			"toLabel": "To", 
			"customRangeLabel": "Custom", 
			"weekLabel": "W", 
			"daysOfWeek": ["日", "月", "火", "水", "木", "金", "土"], 
			"monthNames": ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"], 
		},
		"opens": "right",
		"autoUpdateInput": false,
		"autoApply": false,
		"drops": "down",
	}, function (start, end, label) { 
		let dayStart = new Date(start._d);
		let dayEnd = new Date(end._d);
		let weekStart = WEEKDAY[dayStart.getDay()];
		let weekEnd = WEEKDAY[dayEnd.getDay()];
		//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		$('.startDate').val(start.format('YYYYMMDD'));
		$('.endDate').val(end.format('YYYYMMDD'));
		
		$('.start').val(start.format('YY年MM月DD日'));
		$('.end').val(end.format('YYYY年MM月DD日'));
	});
   $('.end').daterangepicker({
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
	         //console.log(thisCompare);
	         //console.log(uniteUnique(disabledArr));
			
	         if($.inArray(thisCompare,uniteUnique(disabledArr))!=-1){
	            //console.log("      ^--------- DATE FOUND HERE");
	             return true;
	         }
	         if(disabledArr.length == 0){
	        	 console.log(disabledArr.length);
	        	 return false;
	         }
	     },
	     opens: 'left',
	     minDate: today,
	     maxSpan: {
	    	    "days": '10'
   		},
		"locale": { 
			"format": "YYYY年　MM月　DD日", 
			"separator": "	~	",
			"applyLabel": "확인", 
			"cancelLabel": "취소", 
			"fromLabel": "From", 
			"toLabel": "To", 
			"customRangeLabel": "Custom", 
			"weekLabel": "W", 
			"daysOfWeek": ["日", "月", "火", "水", "木", "金", "土"], 
			"monthNames": ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"], 
		},
		"opens": "left",
		"autoUpdateInput": false,
		"autoApply": false,
		"drops": "down",
	}, function (start, end, label) { 
		let dayStart = new Date(start._d);
		let dayEnd = new Date(end._d);
		let weekStart = WEEKDAY[dayStart.getDay()];
		let weekEnd = WEEKDAY[dayEnd.getDay()];
		//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		$('.startDate').val(start.format('YYYYMMDD'));
		$('.endDate').val(end.format('YYYYMMDD'));
		
		$('.start').val(start.format('YYYY年MM月DD日'));
		$('.end').val(end.format('YYYY年MM月DD日'));
	});
   
   $(".start, .end").on("apply.daterangepicker",function(e,picker){

	    // Get the selected bound dates.
	    var startDate = picker.startDate.format('YYYY-MM-DD')
	    var endDate = picker.endDate.format('YYYY-MM-DD')
	    //console.log(startDate+" to "+endDate);
	    
	    // Compare the dates again.
	    var clearInput = false;
	    let disableD = uniteUnique(disabledArr);
	   // console.log(disableD)
	    for(i=0;i<disableD.length+1;i++){
	        if(startDate<disableD[i] && endDate>disableD[i]){
	            //console.log("중복");
	            clearInput = true;
	        }
	    }

	    // If a disabled date is in between the bounds, clear the range.
	    if(clearInput){

	        // To clear selected range (on the calendar).
	        // To clear input field and keep calendar opened.
	        var today = new Date();
	        $(this).data('daterangepicker').setStartDate(today);
	        $(this).data('daterangepicker').setEndDate(today);

	        $(this).val("").focus();
	        //console.log("Cleared the input field...");

	        // Alert user!
	        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
	    }
	});
   
   
   $('.people').on('click', function(e){
   	if($('.startDate').val() === ''){
			$('.start').click();
  			$('.btn-Search').hide();
			return false;
		}
   	$('.peoplePopup').fadeIn('300');
   });//
   
   $(".detail__count-adult").change(function(){
		if($(".detail__count-adult").val() > parseInt(eventObj.extendedProps.max)){
			alert(eventObj.extendedProps.max+"명 이하로 예약할 수 있습니다.");
			$(".detail__count-adult").val(parseInt(eventObj.extendedProps.max));
			$(".detail__count-child").val("0");
			$(".detail__count-adult").select();
		} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(eventObj.extendedProps.max)){
			$(".detail__count-adult").val(Number($(".detail__count-adult").val()));
			$(".detail__count-child").val(Number(eventObj.extendedProps.max-$(".detail__count-adult").val()));
			if($(".detail__count-adult").val() == eventObj.extendedProps.max){
				$(".detail__count-adult").val(parseInt(eventObj.extendedProps.max));
				$(".detail__count-child").val("0");
			}
		}
		$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
	});
	
	$(".detail__count-child").change(function(){
		if($(".detail__count-child").val() > parseInt(eventObj.extendedProps.max)-1){
			alert("성인이 1명 있어야 합니다.");
			$(".detail__count-child").val(parseInt(eventObj.extendedProps.max));
			$(".detail__count-adult").val("1");
			$(".detail__count-child").select();
		} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(eventObj.extendedProps.max)){
			$(".detail__count-adult").val(Number(eventObj.extendedProps.max - $(".detail__count-child").val()));
			$(".detail__count-child").val(Number($(".detail__count-child").val()));
			if($(".detail__count-child").val() == parseInt(eventObj.extendedProps.max)-1){
				$(".detail__count-child").val(parseInt(eventObj.extendedProps.max)-1);
				$(".detail__count-adult").val("1");
			}
		}
		$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
	});
	
	function calculateTotal(a, c){
		let total = 0;
		let adultCost = parseInt(eventObj.extendedProps.adultCost);
		let childCost = parseInt(eventObj.extendedProps.childCost);
		total = adultCost*a + childCost*c
		return total;
	}
	
	
	
	
	
});//

	function checkReserve(amount, calcDate) {
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
		var dateString = calcDate
		console.log(dateString)
		buildCd = $('.buildCdList option:selected').val();
		roomNo = $('.roomNoList option:selected').val();
		let url = "";
		if(roomNo !== ''){
			url = '/'+buildCd+'/'+roomNo;
		}else if(buildCd !== ''){
			url = '/'+buildCd;
		}
		console.log(dateString);
		console.log(url)
		//console.log(dateString);
		$.getJSON('/api/checkReserve/'+amount+url ,function(arr){
			let jsonList = new Array();
	       	  $.each(arr, function(i, data){
	       		//console.log(data[1])
				let json = new Object();
	       		json.roomNo = data[1].roomNo.no;
	       		json.reserveNo = data[1].no;
	       		json.title = (data[1].paymentFlg==0?"❌ ":"✔ ") + data[1].roomNo.roomNum + "号室 / " +data[1].name +"📞"+data[1].phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") ;
	       		json.roomNum = data[1].roomNo.roomNum;
	       		json.bankNo = data[1].bankNo;
	       		json.adultCost = data[1].roomNo.adultCost;
	       		json.childCost = data[1].roomNo.childCost;
	       		json.buildCd = data[1].roomNo.buildCd;
	       		json.max = data[1].roomNo.max;
	       		json.colorCd = data[1].roomNo.colorCd;
	       		json.images = data[1].roomNo.images;
	       		json.start = moment(data[1].startDate).format('YYYY-MM-DD');
	       		json.end = moment(moment(data[1].endDate).add(1, 'days')).format('YYYY-MM-DD');
	       		json.color =data[0].colorCd;
	     		jsonList.push(json);
	       	  });
	     		//console.log(jsonList)
	       	var calendarEl = document.getElementById('calendar');
	        var calendar = new FullCalendar.Calendar(calendarEl, {
				eventChange: function(info) {
					
				},
				eventClick: function(info) {
					disabledArr.length=0;
					eventObj = info.event;
					let reserve = {
						no: eventObj.extendedProps.reserveNo,
						roomNo: eventObj.extendedProps.roomNo,
					}
					$.ajax({
						url: '/api/getReserve',
						method: 'post',
						data: JSON.stringify(reserve),
						contentType: 'application/json; charset=utf-8',
						dataType: 'json',
						success: function(data){
							console.log(data);
							
							$('.colorMark').css('background-color', eventObj.extendedProps.colorCd)
							$('.startDate').val(data.startDate);
							$('.endDate').val(data.endDate);
							$('.modal-title').text(eventObj.extendedProps.roomNum +" 号室");
							$('.detail__totalPrice').val(eventObj.extendedProps.adultCost*data.adult+eventObj.extendedProps.childCost*data.child)
							$('.detail__count-adult').val(data.adult );
							$('.detail__count-child').val(data.child);
							$('.start').val(moment(data.startDate).format('YYYY年MM月DD日'))
							$('.end').val(moment(data.endDate).format('YYYY年MM月DD日'))
							$('.customer').val(data.name)
							$('.phone').val(data.phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"))
							$('.phone__clone').val(data.phone)
							$('.reserveNo').val(data.no)
							$('.regDate').val(moment(data.createdAt).format('YY年MM月DD日 HH:mm:ss'));
							if(today>moment(data.startDate,'YYYYMMDD')){
								$('.modifyPwBtn').hide();
							}
							modal.find('input').attr('disabled', true);
							modal.find('select').attr('disabled', true);
							modal.find('input').css('background-color','#fff');
							modal.find('input').css('border','none');
							modal.find('select').css('background-color','#fff');
							modal.find('select').css('border','none');
							
							modal.modal('show');
							
							$.getJSON('/api/checkReserveSpecify/'+amount+'/'+eventObj.extendedProps.roomNo+'/'+eventObj.extendedProps.reserveNo ,function(arr){
								let jsonList = new Array();
						       	  $.each(arr, function(i, data){
						       		disabledArr.push(getRange(data[1].startDate, data[1].endDate, 'days').flat(Infinity));
						       	  });
							});
							//bankInfo
							$.getJSON('/api/payment/list' ,function(arr){
								$('.bankSelect').html('<option value="">---</option>');
								//console.log(arr);
								$.each(arr, function(i, bank){
									//console.log(bank);
									let optionGroup = document.createElement('option');
									//console.log(bank.bankName + bank.bankCd)
									optionGroup.innerText = bank.bankName;
									optionGroup.value=bank.bankCd;
									if(bank.bankCd == eventObj.extendedProps.bankNo){
										optionGroup.setAttribute ("selected", true);
									}
									
									$('.bankSelect').append(optionGroup);
								})
							});//
						}
					});//
					console.log(eventObj);
					/*alert(
						'Clicked ' + eventObj.extendedProps.no + '.\n'
						+'Srart ' +eventObj._instance.range.start + '.\n'
						+'End' + eventObj._instance.range.end
					);*/
				},
				//selectable: true,
				initialView: 'dayGridMonth',
				initialDate: dateString,
				dayMaxEvents: true, // allow "more" link when too many events
				height: 1100,
				contentHeight: 500,
				aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
				events: jsonList,
			    dayMaxEvents: true,
			    /* select: function(info) {
					console.log("selected:")
					console.log(info)
				    console.log('selected ' + info.startStr + ' to ' + info.endStr);
				}, */
	       });
	        
	        calendar.render();
		});
	}
	
	//modify
	$('.checkPwBtn').click(function(){
		if($('.bankSelect').val() == ''){
			alert('Select Bank');
			let selectMenu = document.querySelector('.bankSelect');
			$('.bankSelect').focus();
			return true;
		}
		if($('.customer').val() == ''){
			$('.name').focus();
			return true;
		}
		if($('.phone__clone').val() == ''){
			$('.phone').focus();
			return true;
		}
		if($('.detail__count-adult').val() == ''){
			$('.detail__count-adult').focus();
			return true;
		}
		let reserve = {
			no : $('.reserveNo').val(),
			name : $('.customer').val(),
			adult : $('.detail__count-adult').val(),
			child : $('.detail__count-child').val(),
			bankName : $('.bankSelect option:selected').text(),
			bankNo : $('.bankSelect option:selected').val(),
			buildCd : eventObj.extendedProps.buildCd,
			bankbranchcde : $('.bankSelect option:selected').val(),
			startDate : $('.startDate').val(),
			endDate : $('.endDate').val(),
			totalCost : $('.detail__totalPrice').val(),
			phone : $('.phone__clone').val(),
			roomNo : eventObj.extendedProps.roomNo,
		}
		console.log(reserve);
		$.ajax({
			url: '/api/reserve/modify',
			method: 'post',
			data: JSON.stringify(reserve),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success:function(data){
				modal.find('input').attr('disabled', true);
				modal.find('select').attr('disabled', true);
				modal.find('input').css('background-color','#fff');
				modal.find('input').css('border','none');
				modal.find('select').css('background-color','#fff');
				modal.find('select').css('border','none');
				console.log(data);
				let newNo = parseInt(data);
				
				$('.permitPwBtn').hide();
				$('.cancelPwBtn').hide();
				$('.checkPwBtn').hide();
				$('.modifyPwBtn').show();
				
				modal.modal('hide');
				$('.toast').toast('show')
				$('.toast-body').text(eventObj.extendedProps.roomNo+"号室 "+eventObj.extendedProps.reserveNo+"번 예약이 수정되었습니다.");
				checkReserve(amount);
			}
		});
	});
	
	$('.permitPwBtn').click(function(){
		let reserve = {
			no : $('.reserveNo').val(),
			paymentFlg : '1',
		}
		console.log(reserve);
		$.ajax({
			url: '/api/reserve/modify/payment',
			method: 'post',
			data: JSON.stringify(reserve),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success:function(data){
				console.log(data);
				modal.find('input').attr('disabled', true);
				modal.find('select').attr('disabled', true);
				modal.find('input').css('background-color','#fff');
				modal.find('input').css('border','none');
				modal.find('select').css('background-color','#fff');
				modal.find('select').css('border','none');
				modal.modal('hide');
				
				$('.permitPwBtn').hide();
				$('.cancelPwBtn').hide();
				$('.checkPwBtn').hide();
				$('.modifyPwBtn').show();
				
				$('.toast').toast('show');
				$('.toast-body').text(eventObj.extendedProps.roomNo+"号室 "+eventObj.extendedProps.reserveNo+"번 예약이 확정되었습니다.");
				checkReserve(amount);
			}
		});
	});
	$('.cancelPwBtn').click(function(){
		let reserve = {
			no : $('.reserveNo').val(),
			cancelFlg : '1',
		}
		$.ajax({
			url: '/api/reserve/modify/cancel',
			method: 'post',
			data: JSON.stringify(reserve),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success:function(data){
				console.log(data);
				modal.find('input').attr('disabled', true);
				modal.find('select').attr('disabled', true);
				modal.find('input').css('background-color','#fff');
				modal.find('input').css('border','none');
				modal.find('select').css('background-color','#fff');
				modal.find('select').css('border','none');
				modal.modal('hide');
				
				$('.permitPwBtn').hide();
				$('.cancelPwBtn').hide();
				$('.checkPwBtn').hide();
				$('.modifyPwBtn').show();
				
				$('.toast').toast('show')
				$('.toast-body').text(eventObj.extendedProps.roomNo+"号室 "+eventObj.extendedProps.reserveNo+"번 예약이 취소되었습니다.");
				checkReserve(amount);
			}
		});
	});
	
	
	
	//기간
	function getRange(startDate, endDate, type) {
		let fromDate = moment(startDate)
		let toDate = moment(endDate)
		let diff = toDate.diff(fromDate, type)
		let range = []
		for (let i = 0; i <= diff; i++) {
		  range.push(moment(moment(startDate).add(i, type)).format('YYYY-MM-DD'));
		}
		return range
	}
	
	function uniteUnique(arr) {
		  return Array.from(new Set(arr.flat()));
	}
	
	//공백제거
	function blankCheck(str){
		if(str == null || str == "null"
			   || str == undefined || str == "undefined"
			   || str == '' || str == "" || str.length == 0
		   ){
			return null;
		}else{
			return str;
		}
	}
	
</script>

</body>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />