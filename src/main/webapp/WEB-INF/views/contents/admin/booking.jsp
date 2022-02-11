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
				<div class="selectRoomMenu">
					<form class="form-inline" style="justify-content: space-between;">
						<div class="form-group">
					    	<select class="buildCdList form-control mx-sm-3">
								<option value="">---</option>
								<c:forEach items="${buildCdList}" var="buildCd">
									<option value="${buildCd}">${buildCd}</option>
								</c:forEach>
							</select>
					    	<label>階</label>
					    	<select class="roomNoList form-control mx-sm-3">
								<option value="">---</option>
							</select>
					    	<label>号室</label>
						</div>
						<div class="form-group">
					    	<span class="calendarMenu" style="font-size: 2.5rem; margin-right: 1rem; cursor: pointer;"><i class="far fa-calendar-alt"></i></span>
							<span class="tableMenu" style="font-size: 2.5rem; cursor: pointer;"><i class="fas fa-table"></i></span>
						</div>
					</form>
					
				</div>
				<br/>
			</div>
		</div>
	</section>
	
<div class="modal" tabindex="-1">
	<div class="modal-dialog" style="margin: 10.75rem auto;max-width: 1200px;">
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
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">phone</label>
					<div class="col-sm-2">
						<input class="form-control phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>
						<input class="form-control phone__clone" type="hidden" placeholder="" style="display: none;"/>
					</div>
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Bank</label>
					<div class="col-sm-2">
						<select class="bankSelect form-control mx-sm-10">
							<option value="">---</option>
						</select>
					</div>
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px; font-size: 14px; padding-left: 1px;padding-right: 1px;display: flex;align-items: center;justify-content: center;">チェックイン</label>
					<div class="col-sm-2">
						<input class="form-control start" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;font-size: 13px; padding-left: 1px;padding-right: 1px;display: flex;align-items: center;justify-content: center;">チェックアウト</label>
					<div class="col-sm-2">
						<input class="form-control end" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					
				</div>
				<div class="form-group row headModal-secondTr" style="justify-content: flex-end;">
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Adult</label>
					<div class="col-sm-1">
						<input class="form-control detail__count-adult" type="number" placeholder=""/>
					</div>
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>
					<div class="col-sm-1">
						<input class="form-control detail__count-child" type="number" placeholder=""/>
					</div>
					<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>
					<div class="col-sm-2">
						<input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/>
					</div>
					
					
				</div>
				<div class="form-group row" style="justify-content: flex-end;">
					
				</div>
				<p class="response__data"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary modifyPwBtn">Modify</button>
				<button type="button" class="btn btn-success checkPwBtn" style="display: none;">Confirm</button>
			</div>
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
$('.selectRoomMenu').after(
		'<br/><div class="wrapperCalendar"><div id="calendar"></div></div><br/>'
)
$('.calendarMenu').css('color','#ff7f50')
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
		modal.find('input[type=text]').css('background-color','#fff');
		modal.find('input[type=text]').css('border','1px solid #ced4da');
		modal.find('input[type=number]').css('background-color','#fff');
		modal.find('input[type=number]').css('border','1px solid #ced4da');
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
	
	//상단 buildCD select
	$('.buildCdList').change(function(){
		$('.roomNoList').empty();
		let optionGroup = document.createElement('option');
		optionGroup.innerText = "---";
		optionGroup.value = '';
		$('.roomNoList').append(optionGroup);
		if($('.buildCdList option:selected').val() !== ''){
			$.getJSON('/api/checkReserveRooms/'+$('.buildCdList option:selected').val() ,function(arr){
				$.each(arr, function(i, room){
					let optionGroup = document.createElement('option');
					console.log(i)
					console.log(room.roomNum + room.roomTitle)
					optionGroup.innerText = room.roomNum;
					optionGroup.value = room.no;
					$('.roomNoList').append(optionGroup);
					if($('.wrapperCalendar').find('#calendar').length > 0){
						checkReserve(amount);
					} else {
						
					}
				});
			});
		} else {
			if($('.wrapperCalendar').find('#calendar').length > 0){
				checkReserve(amount);
			} else {
				const sysdate = moment();
				$('.wrapperCalendar').empty();
				let reserveAndPage = {
					buildCd: '7',
					startDate: sysdate.format('YYYYMMDD'),
					page: '1',
				}
				console.log(reserveAndPage)
				$.ajax({
					url: '/api/getReserve/monthly',
					method: 'POST',
					data: JSON.stringify(reserveAndPage),
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					success: function(datas){
						drawTable(datas, reserveAndPage);
						
					}
				});
			}
		}
	});
	
	$('.roomNoList').change(function(){
		if($('.wrapperCalendar').find('#calendar').length > 0){
			checkReserve(amount);
		} else {
			const sysdate = moment();
			//$('.wrapperCalendar').empty();
			let reserveAndPage = {
				buildCd: '7',
				startDate: sysdate.format('YYYYMMDD'),
				page: '1',
			}
			console.log(reserveAndPage)
			/* $.ajax({
				url: '/api/getReserve/monthly',
				method: 'POST',
				data: JSON.stringify(reserveAndPage),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				success: function(datas){
					drawTable(datas, reserveAndPage);
					
				}
			}); */
		}
		
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
	}, 
	$(".start").on("apply.daterangepicker",function(e,picker){

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
	        $('.start').val(moment($('.startDate').val()).format('YYYY/MM/DD'));
	        $('.end').val(moment($('.endDate').val()).format('YYYY/MM/DD'));
	        //console.log("Cleared the input field...");

	        // Alert user!
	        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
	        return;
	    } 
		if(!clearInput) {
	    	let dayStart = new Date(picker.startDate._d);
			let dayEnd = new Date(picker.endDate._d);
			let weekStart = WEEKDAY[dayStart.getDay()];
			let weekEnd = WEEKDAY[dayEnd.getDay()];
			//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
			$('.startDate').val(picker.startDate.format('YYYYMMDD'));
			$('.endDate').val(picker.endDate.format('YYYYMMDD'));
			
			$('.start').val(picker.startDate.format('YYYY/MM/DD'));
			$('.end').val(picker.endDate.format('YYYY/MM/DD'));
			return;
	    }
	}),
	function (start, end, label) { 
		/* let dayStart = new Date(start._d);
		let dayEnd = new Date(end._d);
		let weekStart = WEEKDAY[dayStart.getDay()];
		let weekEnd = WEEKDAY[dayEnd.getDay()];
		//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		$('.wrapperCalendar').find('.startDate').val(start.format('YYYYMMDD'));
		$('.wrapperCalendar').find('.endDate').val(end.format('YYYYMMDD'));
		
		$('.wrapperCalendar').find('.start').val(start.format('YYYY/MM/DD'));
		$('.wrapperCalendar').find('.end').val(end.format('YYYY/MM/DD')); */
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
	}, 
	$(".end").on("apply.daterangepicker",function(e,picker){

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
	        $('.start').val(moment($('.startDate').val()).format('YYYY/MM/DD'));
	        $('.end').val(moment($('.endDate').val()).format('YYYY/MM/DD'));
	        //console.log("Cleared the input field...");

	        // Alert user!
	        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
	        return;
	    } 
		if(!clearInput) {
	    	let dayStart = new Date(picker.startDate._d);
			let dayEnd = new Date(picker.endDate._d);
			let weekStart = WEEKDAY[dayStart.getDay()];
			let weekEnd = WEEKDAY[dayEnd.getDay()];
			//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
			$('.startDate').val(picker.startDate.format('YYYYMMDD'));
			$('.endDate').val(picker.endDate.format('YYYYMMDD'));
			
			$('.start').val(picker.startDate.format('YYYY/MM/DD'));
			$('.end').val(picker.endDate.format('YYYY/MM/DD'));
			return;
	    }
	}),
	function (start, end, label) { 
		/* let dayStart = new Date(start._d);
		let dayEnd = new Date(end._d);
		let weekStart = WEEKDAY[dayStart.getDay()];
		let weekEnd = WEEKDAY[dayEnd.getDay()];
		//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		$('.wrapperCalendar').find('.startDate').val(start.format('YYYYMMDD'));
		$('.wrapperCalendar').find('.endDate').val(end.format('YYYYMMDD'));
		
		$('.wrapperCalendar').find('.start').val(start.format('YYYY/MM/DD'));
		$('.wrapperCalendar').find('.end').val(end.format('YYYY/MM/DD')); */
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

function changDataStatusOnBtn(data){
	modal.find('.modal-body').find('.btn').attr('data-deleteFlg', data.deleteFlg)
	modal.find('.modal-body').find('.btn').attr('data-cancelFlg', data.cancelFlg)
	modal.find('.modal-body').find('.btn').attr('data-paymentFlg', data.paymentFlg)
	modal.find('.modal-body').find('.btn').attr('data-reserveNo', data.no)
}

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
		var dateString = moment().add(amount, 'months').format('YYYY-MM-DD')
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
		console.log(amount+url)
		console.log(dateString);
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
							$(document).ready(function(){
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
									} else if (Number($(".detail__count-adult").val()) < 1){
										$(".detail__count-adult").val("1");
										$(".detail__count-child").val($(".detail__count-child").val());
									}
									$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
								});
								
								$(".detail__count-child").change(function(){
									if($(".detail__count-child").val() > parseInt(eventObj.extendedProps.max)-1){
										alert("성인이 1명 있어야 합니다.");
										$(".detail__count-child").val(parseInt(eventObj.extendedProps.max)-1);
										$(".detail__count-adult").val("1");
										$(".detail__count-child").select();
									} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(eventObj.extendedProps.max)){
										$(".detail__count-adult").val(Number(eventObj.extendedProps.max - $(".detail__count-child").val()));
										$(".detail__count-child").val(Number($(".detail__count-child").val()));
										if($(".detail__count-child").val() == parseInt(eventObj.extendedProps.max)-1){
											$(".detail__count-child").val(parseInt(eventObj.extendedProps.max)-1);
											$(".detail__count-adult").val("1");
										}
									} else if (Number($(".detail__count-child").val()) < 0){
										$(".detail__count-adult").val($(".detail__count-adult").val());
										$(".detail__count-child").val("0");
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
							})
							console.log(data);
							modal.find('.modal-body').find('.headModal-secondTr').empty();
							modal.find('.modal-body').find('.headModal-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Adult</label>'+
								'<div class="col-sm-1"><input class="form-control detail__count-adult" type="number" placeholder="" style="background-color: rgb(255, 255, 255); border: none;"/></div>'+
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>'+
								'<div class="col-sm-1"><input class="form-control detail__count-child" type="number" placeholder="" style="background-color: rgb(255, 255, 255); border: none;"/></div>'+
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>'+
								'<div class="col-sm-2"><input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'
							);
							if(data.paymentFlg === '0' && data.cancelFlg === '0' && data.deleteFlg === '0'){
								modal.find('.modal-body').find('.headModal-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
									'<div class="col-sm-2"><input type="button" value="결제" class="btn btn-success search-modalPaymentBtn"></input></div>'
								);
								changDataStatusOnBtn(data)
							}
							if(data.paymentFlg === '1'){
								modal.find('.modal-body').find('.headModal-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">決済完了</label>'+
									'<div class="col-sm-2"><input type="button" value="주문취소" class="btn btn-danger search-modalCancelBtn"></input></div>'
								);
								changDataStatusOnBtn(data)
							}
							if(data.cancelFlg === '1' && data.paymentFlg === '0'){
								modal.find('.modal-body').find('.headModal-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">取り消し</label>'+
									'<div class="col-sm-2"><input type="button" value="삭제" class="btn btn-danger search-modalDeleteBtn"></input><input type="button" value="결제" class="btn btn-success search-modalPaymentBtn"></input></div>'
								);
								changDataStatusOnBtn(data)
							}
							if(data.deleteFlg === '1'){
								modal.find('.modal-body').find('.headModal-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">삭제됨</label>'+
									'<div class="col-sm-2"></div>'
								);
								changDataStatusOnBtn(data)
							}
							
							$('.colorMark').css('background-color', eventObj.extendedProps.colorCd)
							$('.startDate').val(data.startDate);
							$('.endDate').val(data.endDate);
							$('.modal-title').text(eventObj.extendedProps.roomNum +" 号室");
							$('.detail__totalPrice').val(eventObj.extendedProps.adultCost*data.adult+eventObj.extendedProps.childCost*data.child)
							$('.detail__count-adult').val(data.adult );
							$('.detail__count-child').val(data.child);
							$('.start').val(moment(data.startDate).format('YYYY/MM/DD'))
							$('.end').val(moment(data.endDate).format('YYYY/MM/DD'))
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
							modal.find('input[type=text]').css('background-color','#fff');
							modal.find('input[type=text]').css('border','none');
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
	
	function drawTable(datas, reserveAndPage){
		console.log(datas)
		$('.wrapperCalendar').append(
				'<div class="table-responsive-lg"><table class="table table-hover">'+
					'<thead>'+
						'<tr>'+
							'<th scope="col" style="border-top: 0px !important;text-align: center;">Room</th>'+
							'<th scope="col"  style="border-top: 0px !important;text-align: center;">Name</th>'+
							'<th scope="col"  style="border-top: 0px !important;text-align: center;">Phone</th>'+
							'<th scope="col" style="border-top: 0px !important;text-align: center;">Cost</th>'+
							'<th scope="col" style="border-top: 0px !important;text-align: center;">Date</th>'+
							'<th scope="col" style="border-top: 0px !important;text-align: center;">Status</th>'+
							'<th scope="col" style="border-top: 0px !important;text-align: center;">RegDate</th>'+
						'</tr>'+
					'</thead>'+
					
					
				'</table></div>'
			);
		$.each(datas.dtoList, function(i, data){
			$('.wrapperCalendar').find('thead').after(
				'<tbody class="table-originTbody'+data[0].no+'" style="border-top: none;">'+
				'<tr data-trReserveNo='+data[0].no+'>'+
				'<th class="result__no" scope="row" style="vertical-align: middle;">'+data[1].roomNum+'号室'+
				'<span class="dot span__colorCd" style="height: 15px; width: 15px; background-color:'+ data[1].colorCd +'; border-radius: 50%; display: inline-block; border: 0.5px solid; text-align: center;"></span></th>'+
				'<td class="result__name" style="text-align: center;">'+data[0].name+'</td>'+
				'<td class="result__phone" style="text-align: center;">'+data[0].phone.replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3")+'</td>'+
				'<td class="result__totalCostAndPeople" style="text-align: center;"><span class="totalCost">'+data[0].totalCost.toLocaleString('ja-JP')+'</span>(<i class="fas fa-male"></i>:'+data[0].adult+'/<i class="fas fa-child"></i>:'+data[0].child+')</td>'+
				'<td class="result__date base'+i+'" style="text-align: center;">'+moment(data[0].startDate).format('YYYY/MM/DD')+'~'+moment(data[0].endDate).format('YYYY/MM/DD')+'</td>'+
				'<td class="result__createdAt" style="text-align: center;">'+moment(data[0].createdAt).format('YYYY年MM月DD日')+'</td>'+
				'</tr></tbody>'
			);
			
			if(data[1].deleteFlg === '1'){
				$('.base'+i).after(
					'<td class="result__status" style="text-align: center;"><i class="fas fa-hammer" style="color: #2c3e50;"></i></td>'
				)
			} else {
				if(data[0].deleteFlg === '1'){
					$('.base'+i).after(
						'<td class="result__status" style="text-align: center;"><i class="fas fa-trash" style="color: #e58e26;"></i></td>'
					)
				}
				if(data[0].cancelFlg === '1'){
					$('.base'+i).after(
						'<td class="result__status" style="text-align: center;"><i class="fas fa-times" style="color: #e74c3c;"></i></td>'
					)
				}
				if(data[0].paymentFlg === '1'){
					$('.base'+i).after(
						'<td class="result__status" style="text-align: center;"><i class="fas fa-check" style="color: #2ecc71;"></i></td>'
					)
				}
				if(data[0].paymentFlg === '0' && data[0].cancelFlg === '0' && data[0].deleteFlg === '0'){
					$('.base'+i).after(
						'<td class="result__status" style="text-align: center;"><i class="fas fa-shopping-cart"></i></td>'
					)
				}
			}
		});
		$('.wrapperCalendar').find('.table-responsive-lg').append(
				'<ul class="pagination pagination-sm h-100 justify-content-center align-items-center" ></ul>'
		);
		if(datas.prev){
			$('.wrapperCalendar').find('.table-responsive-lg').find('.pagination').append(
				'<li class="page-item" style="cursor: pointer;"><span class="page-link" data-adminBookingPage="'+datas.start-1+'" style="cursor: pointer;">&laquo;</span></li>'
	        )
		}
	    $.each(datas.pageList, function(i, pages){
	    	if(Number(reserveAndPage.page) === pages){
	    		$('.wrapperCalendar').find('.table-responsive-lg').find('.pagination').append(
	    	            '<li class="page-item active"><span class="page-link" data-adminBookingPage="'+ pages +'" style="cursor: pointer;">'+pages+'</span></li>'
	    	        )
	    	} else {
	    		$('.wrapperCalendar').find('.table-responsive-lg').find('.pagination').append(
	    	            '<li class="page-item"><span class="page-link" data-adminBookingPage="'+ pages +'" style="cursor: pointer;">'+pages+'</span></li>'
	    	        )
	    	}
	    	
		});
	    if(datas.next){
	    	$('.wrapperCalendar').find('.table-responsive-lg').find('.pagination').append(
	            '<li class="page-item"><span class="page-link" data-adminBookingPage="'+datas.end+1+'" style="cursor: pointer;">&raquo;</span></li>'	
			)
	    }
			
	}
	
	//calendar icon
	$('.calendarMenu').on('click', function(){
		if(!$('#calendar').length>0){
			$(this).css('color','#ff7f50')
			$('.tableMenu').css('color','black')
			$('.wrapperCalendar').empty();
			$('.wrapperCalendar').append(
					'<div id="calendar"></div>'
				);
			checkReserve(amount);
		}
		
	});
	
	
	//table icon
	$('.tableMenu').on('click', function(){
		$(this).css('color','#ff7f50')
		$('.calendarMenu').css('color','black')
		const sysdate = moment();
		$('.wrapperCalendar').empty();
		let reserveAndPage = {
			buildCd: '7',
			startDate: sysdate.format('YYYYMMDD'),
			page: '1',
		}
		console.log(reserveAndPage)
		$.ajax({
			url: '/api/getReserve/monthly',
			method: 'POST',
			data: JSON.stringify(reserveAndPage),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(datas){
				drawTable(datas, reserveAndPage);
				
			}
		});
		
	});
	
	//paging
	$('.wrapperCalendar').on('click', '.page-link', function(){
		$('.wrapperCalendar').empty();
		//console.log($(this).attr('data-modalheadpage'))
		let modalHeadPage = $(this).attr('data-adminBookingPage');
		let reserveAndPage = {
			buildCd: '7',
			startDate: '20220208',
			page: $(this).attr('data-adminBookingPage'),
		}
		console.log(reserveAndPage)
		//console.log(reserveAndPage);
		$.ajax({
			url: '/api/getReserve/monthly',
			method: 'POST',
			data: JSON.stringify(reserveAndPage),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(datas){
				//console.log(datas)
				drawTable(datas, reserveAndPage);
			}
		});
	});
	
	//상세 보기 클릭 시 주문 상태 버튼에 저장
	function buttonFlgSetting(data){
		$('.wrapperCalendar').find('.table-secondTr').find('.table-statusBtn').attr('data-deleteFlg', data[0][0].deleteFlg)
		$('.wrapperCalendar').find('.table-secondTr').find('.table-statusBtn').attr('data-cancelFlg', data[0][0].cancelFlg)
		$('.wrapperCalendar').find('.table-secondTr').find('.table-statusBtn').attr('data-paymentFlg', data[0][0].paymentFlg)
		$('.wrapperCalendar').find('.table-secondTr').find('.table-statusBtn').attr('data-reserveNo', data[0][0].no)
	}
	
   
	
	//table tr클릭 시 상세 보기 append
	$('.wrapperCalendar').on('click', 'tbody', function(event){
		let target = event.target;
		let tr = event.target.closest('tr');
		let tbody = event.target.closest('tbody');
		let reserveNo = $(tr).data('trreserveno');
		if(reserveNo !== undefined){
			$.ajax({
				url: '/api/getReserve/reserveNo/'+reserveNo,
				method: 'get',
				dataType: 'json',
				success: function(data){
					$.getJSON('/api/checkReserveSpecify/'+amount+'/'+data[0][1].no+'/'+reserveNo ,function(arr){
						let jsonList = new Array();
				       	  $.each(arr, function(i, data){
				       		disabledArr.push(getRange(data[1].startDate, data[1].endDate, 'days').flat(Infinity));
				       	  });
				       	  //console.log(disabledArr)
					});
					if($('.wrapperCalendar').find('.loadData').length !== 0 && $('.wrapperCalendar').find('.appendTbody'+data[0][0].no).length === 0){
						$('.loadData').hide(300);
						setTimeout(function(){
							$('.loadData').remove();
						},300)
					}
					setTimeout(function(){
						if($('.wrapperCalendar').find('.appendTbody'+data[0][0].no).length === 0){
							console.log(data)
							$(tbody).after(
								'<tbody class="loadData appendTbody'+data[0][0].no+'" data-tbodyReserveNo='+data[0][0].no+' style="border-top: none; display: none;">'+
								'<tr>'+
									'<th colspan="7">'+
									'<input class="reserveNo" type="hidden">'+
									'<input class="buildCd" type="hidden">'+
									'<input class="colorCd" type="hidden">'+
									'<input class="roomNo" type="hidden">'+
									'<input class="startDate" type="hidden">'+
									'<input class="endDate" type="hidden">'+
									'<div class="form-group row" style="justify-content: flex-end; margin-left: 0px;">'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">phone</label>'+
										'<div class="col-sm-2"><input class="form-control phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>'+
										'<input class="form-control phone__clone" type="hidden" placeholder="" style="display: none;"/></div>'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Bank</label>'+
										'<div class="col-sm-2"><select class="bankSelect form-control mx-sm-10"><option value="">---</option></select></div>'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;font-size: 14px; padding-left: 1px;padding-right: 1px;display: flex;align-items: center;justify-content: center;">チェックイン</label>'+
										'<div class="col-sm-2"><input class="form-control start" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;font-size: 14px; padding-left: 1px;padding-right: 1px;display: flex;align-items: center;justify-content: center;">チェックアウト</label>'+
										'<div class="col-sm-2" ><input class="form-control end" type="text" placeholder="" readonly style="background-color: #fff;"/></div></div>'+
									'<div class="form-group row table-secondTr" style="justify-content: flex-end; margin-left: 0px;">'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Adult</label>'+
										'<div class="col-sm-1"><input class="form-control detail__count-adult" type="number" placeholder=""/></div>'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>'+
										'<div class="col-sm-1"><input class="form-control detail__count-child" type="number" placeholder=""/></div>'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>'+
										'<div class="col-sm-2"><input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'+
									'</div>'+
									'<div class="form-group row table-thirdTr" style="justify-content: flex-end; margin-left: 0px;">'+
										'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Name</label>'+
										'<div class="col-sm-2">'+
											'<input class="form-control customer" type="text" placeholder=""/>'+
										'</div>'+
										'<div class="col-sm-7"></div>'+
										'<div class="col-sm-2" style="justify-content: flex-end; display: flex; padding-right: 5%;"><button type="button" class="btn btn-secondary table-backPwBtn">Back</button>&nbsp;<button type="button" class="btn btn-primary table-modifyPwBtn">Modify</button><button type="button" class="btn btn-success table-checkPwBtn" style="display: none;">Confirm</button></div>'+
									'</th>'+
								'</tr></tbody>'
							)
							setTimeout(function(){
								$('.wrapperCalendar').find('.appendTbody'+data[0][0].no).show(700);
							},300)
							if(data[0][0].paymentFlg === '0' && data[0][0].cancelFlg === '0' && data[0][0].deleteFlg === '0'){
								$('.loadData').find('th').find('.table-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
									'<div class="col-sm-2"><input type="button" value="결제" class="btn btn-success table-statusBtn table-paymentBtn"></input></div>'
								);
								buttonFlgSetting(data)
							}
							if(data[0][0].paymentFlg === '1'){
								$('.loadData').find('th').find('.table-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">決済完了</label>'+
									'<div class="col-sm-2"><input type="button" value="주문취소" class="btn btn-danger table-statusBtn table-cancelBtn"></input></div>'
								);
								buttonFlgSetting(data)
							}
							if(data[0][0].cancelFlg === '1' && data[0][0].paymentFlg === '0'){
								$('.loadData').find('th').find('.table-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">取り消し</label>'+
									'<div class="col-sm-2"><input type="button" value="삭제" class="btn btn-danger table-statusBtn table-deleteBtn"></input>&nbsp;'+
									'<input type="button" value="결제" class="btn btn-success table-statusBtn table-paymentBtn"></input></div>'
								);
								buttonFlgSetting(data)
							}
							if(data[0][0].deleteFlg === '1'){
								$('.loadData').find('th').find('.table-secondTr').append(
									'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">삭제됨</label>'+
									'<div class="col-sm-2"></div>'
								);
								buttonFlgSetting(data)
							}
							
							//console.log($('.search-modal').find('.detail__totalPrice'))
							//console.log(data[0][0])
							setTimeout(function(){
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
										if(bank.bankCd == data[0][0].bankNo){
											optionGroup.setAttribute ("selected", true);
										}
										
										$('.bankSelect').append(optionGroup);
									})
								});//
								$('.loadData').find('.detail__totalPrice').val(data[0][0].totalCost);
								$('.loadData').find('.detail__count-adult').val(data[0][0].adult);
								$('.loadData').find('.detail__count-child').val(data[0][0].child);
								$('.loadData').find('.start').val(moment(data[0][0].startDate).format('YYYY/MM/DD'));
								$('.loadData').find('.end').val(moment(data[0][0].endDate).format('YYYY/MM/DD'));
								$('.loadData').find('.reserveNo').val(data[0][0].no);
								$('.loadData').find('.roomNo').val(data[0][1].no);
								$('.loadData').find('.buildCd').val(data[0][1].buildCd);
								$('.loadData').find('.colorCd').val(data[0][1].colorCd);
								$('.loadData').find('.startDate').val(data[0][0].startDate);
								$('.loadData').find('.endDate').val(data[0][0].endDate);
								
								$('.loadData').find('.customer').val(data[0][0].name);
								$('.loadData').find('.search-detail__romNum').text(data[0][1].roomNum +"号室");
								$('.loadData').find('.phone').val( data[0][0].phone.replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
								$('.loadData').find('.phone__clone').val( data[0][0].phone);
								$('.loadData').find('.regDate').val(moment(data[0][0].createdAt).format('YYYY年MM月DD日'));
								
								$('.loadData').find('input').attr('disabled', true);
								$('.loadData').find('select').attr('disabled', true);
								$('.loadData').find('input[type=text]').css('background-color','#fff');
								$('.loadData').find('input[type=text]').css('border','none');
								$('.loadData').find('input[type=number]').css('background-color','#fff');
								$('.loadData').find('input[type=number]').css('border','none');
								$('.loadData').find('select').css('background-color','#fff');
								$('.loadData').find('select').css('border','none');
								$(document).ready(function(){
									$(".detail__count-adult").change(function(){
										if($(".detail__count-adult").val() > parseInt(data[0][1].max)){
											alert(data[0][1].max+"명 이하로 예약할 수 있습니다.");
											$(".detail__count-adult").val(parseInt(data[0][1].max));
											$(".detail__count-child").val("0");
											$(".detail__count-adult").select();
										} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(data[0][1].max)){
											$(".detail__count-adult").val(Number($(".detail__count-adult").val()));
											$(".detail__count-child").val(Number(data[0][1].max-$(".detail__count-adult").val()));
											if($(".detail__count-adult").val() == data[0][1].max){
												$(".detail__count-adult").val(parseInt(data[0][1].max));
												$(".detail__count-child").val("0");
											}
										} else if (Number($(".detail__count-adult").val()) < 1){
											$(".detail__count-adult").val("1");
											$(".detail__count-child").val($(".detail__count-child").val());
										}
										$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
									});
									
									$(".detail__count-child").change(function(){
										if($(".detail__count-child").val() > parseInt(data[0][1].max)-1){
											alert("성인이 1명 있어야 합니다.");
											$(".detail__count-child").val(parseInt(data[0][1].max)-1);
											$(".detail__count-adult").val("1");
											$(".detail__count-child").select();
										} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(data[0][1].max)){
											$(".detail__count-adult").val(Number(data[0][1].max - $(".detail__count-child").val()));
											$(".detail__count-child").val(Number($(".detail__count-child").val()));
											if($(".detail__count-child").val() == parseInt(data[0][1].max)-1){
												$(".detail__count-child").val(parseInt(data[0][1].max)-1);
												$(".detail__count-adult").val("1");
											}
										} else if (Number($(".detail__count-child").val()) < 0){
											$(".detail__count-adult").val($(".detail__count-adult").val());
											$(".detail__count-child").val("0");
										}
										$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
									});
									
									function calculateTotal(a, c){
										let total = 0;
										let adultCost = parseInt(data[0][1].adultCost);
										let childCost = parseInt(data[0][1].childCost);
										total = adultCost*a + childCost*c
										return total;
									}
								})
							}, 50);
						}
						
					},300)
					
				}
			});
		}
			
	});
	
	
	
	//click modify on detail
	$('.wrapperCalendar').on('click', '.table-modifyPwBtn', function(){
		$('.table-checkPwBtn').show();
		$('.table-modifyPwBtn').hide();
		$('.loadData ').find('input').attr('disabled', false);
		$('.loadData ').find('select').attr('disabled', false);
		$('.loadData ').find('input[type=text]').css('background-color','#fff');
		$('.loadData ').find('input[type=text]').css('border','1px solid #ced4da');
		$('.loadData ').find('input[type=number]').css('background-color','#fff');
		$('.loadData ').find('input[type=number]').css('border','1px solid #ced4da');
		$('.loadData ').find('select').css('border-radius','0.25rem');
		$('.loadData ').find('select').css('border','1px solid #ced4da');
		$('.loadData ').find('select').css('border-radius','0.25rem');
		$('.loadData ').find('.regDate').css('border','none');
		$(document).ready(function(){
			$('.loadData').on('keyup', '.phone' , function(){
				let str = $(this).val();
				let tmp = str.replace(/\-/g,'');
				$(".phone__clone").val(tmp);
			});
			$('.loadData').on('keyup', '.phone' , function(){
				$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
			});
			
			
			$('.wrapperCalendar').find('.loadData').find('.start').daterangepicker({
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
			}, 
			$(".start").on("apply.daterangepicker",function(e,picker){

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
			        $('.wrapperCalendar').find('.loadData').find('.start').val(moment($('.wrapperCalendar').find('.loadData').find('.startDate').val()).format('YYYY/MM/DD'));
			        $('.wrapperCalendar').find('.loadData').find('.end').val(moment($('.wrapperCalendar').find('.loadData').find('.endDate').val()).format('YYYY/MM/DD'));
			        //console.log("Cleared the input field...");

			        // Alert user!
			        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
			        return;
			    } 
				if(!clearInput) {
			    	let dayStart = new Date(picker.startDate._d);
					let dayEnd = new Date(picker.endDate._d);
					let weekStart = WEEKDAY[dayStart.getDay()];
					let weekEnd = WEEKDAY[dayEnd.getDay()];
					//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
					$('.wrapperCalendar').find('.startDate').val(picker.startDate.format('YYYYMMDD'));
					$('.wrapperCalendar').find('.endDate').val(picker.endDate.format('YYYYMMDD'));
					
					$('.wrapperCalendar').find('.start').val(picker.startDate.format('YYYY/MM/DD'));
					$('.wrapperCalendar').find('.end').val(picker.endDate.format('YYYY/MM/DD'));
					return;
			    }
			}),
			function (start, end, label) { 
				/* let dayStart = new Date(start._d);
				let dayEnd = new Date(end._d);
				let weekStart = WEEKDAY[dayStart.getDay()];
				let weekEnd = WEEKDAY[dayEnd.getDay()];
				//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
				$('.wrapperCalendar').find('.startDate').val(start.format('YYYYMMDD'));
				$('.wrapperCalendar').find('.endDate').val(end.format('YYYYMMDD'));
				
				$('.wrapperCalendar').find('.start').val(start.format('YYYY/MM/DD'));
				$('.wrapperCalendar').find('.end').val(end.format('YYYY/MM/DD')); */
			});
		   	
			$('.wrapperCalendar').find('.loadData').find('.end').daterangepicker({
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
			}, 
			$(".end").on("apply.daterangepicker",function(e,picker){

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
			        $('.wrapperCalendar').find('.loadData').find('.start').val(moment($('.wrapperCalendar').find('.loadData').find('.startDate').val()).format('YYYY/MM/DD'));
			        $('.wrapperCalendar').find('.loadData').find('.end').val(moment($('.wrapperCalendar').find('.loadData').find('.endDate').val()).format('YYYY/MM/DD'));
			        //console.log("Cleared the input field...");

			        // Alert user!
			        alert("해당기간에 예약된 날짜가 있습니다. 다시 입력해주세요.");
			        return;
			    } 
				if(!clearInput) {
			    	let dayStart = new Date(picker.startDate._d);
					let dayEnd = new Date(picker.endDate._d);
					let weekStart = WEEKDAY[dayStart.getDay()];
					let weekEnd = WEEKDAY[dayEnd.getDay()];
					//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
					$('.wrapperCalendar').find('.startDate').val(picker.startDate.format('YYYYMMDD'));
					$('.wrapperCalendar').find('.endDate').val(picker.endDate.format('YYYYMMDD'));
					
					$('.wrapperCalendar').find('.start').val(picker.startDate.format('YYYY/MM/DD'));
					$('.wrapperCalendar').find('.end').val(picker.endDate.format('YYYY/MM/DD'));
					return;
			    }
			}),
			function (start, end, label) { 
				/* let dayStart = new Date(start._d);
				let dayEnd = new Date(end._d);
				let weekStart = WEEKDAY[dayStart.getDay()];
				let weekEnd = WEEKDAY[dayEnd.getDay()];
				//console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
				$('.wrapperCalendar').find('.startDate').val(start.format('YYYYMMDD'));
				$('.wrapperCalendar').find('.endDate').val(end.format('YYYYMMDD'));
				
				$('.wrapperCalendar').find('.start').val(start.format('YYYY/MM/DD'));
				$('.wrapperCalendar').find('.end').val(end.format('YYYY/MM/DD')); */
			});
			
		})
	});
	
	//Modify table-status
	$('.wrapperCalendar').on('click','.table-statusBtn', function(){
		console.log($(this))
		$('.wrapperCalendar ').find('.loadData').find('.table-statusBtn').attr('data-deleteFlg')
		$('.wrapperCalendar ').find('.loadData').find('.table-statusBtn').attr('data-cancelFlg')
		$('.wrapperCalendar ').find('.loadData').find('.table-statusBtn').attr('data-paymentFlg')
		
		//console.log($(this).attr('data-deleteFlg'))
		//console.log($(this).attr('data-cancelFlg'))
		//console.log($(this).attr('data-paymentFlg'))
		let reserveNo = $(this).attr('data-reserveNo')
		console.log(reserveNo)
		//결제 취소
		let reserveStatus = {};
		let statusCode = "";
		if($(this).attr('data-cancelFlg') === '0' && $(this).attr('data-paymentFlg') === '1' && $(this).attr('data-deleteFlg') === '0'){
			console.log("결제 취소"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 1,
				paymentFlg: 0,
			}
			console.log(reserveStatus)
			statusCode = '1';
		}
		//삭제 표시 - 재결제
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).val().includes('결제')){
			console.log("삭제 표시-결제"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 0,
				paymentFlg: 1,
			}
			console.log(reserveStatus)
			statusCode = '3';
		}
		//삭제 표시 - 삭제
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).val().includes('삭제')){
			console.log("삭제 표시"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 1,
				cancelFlg: 0,
				paymentFlg: 0,
			}
			console.log(reserveStatus)
			statusCode = '2';
		}
		//결제 가능
		else if($(this).attr('data-cancelFlg') === '0' && $(this).attr('data-paymentFlg') === '0' && $(this).attr('data-deleteFlg') === '0'){
			console.log("결제 가능"+$(this).attr('data-paymentFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 0,
				paymentFlg: 1,
			}
			console.log(reserveStatus)
			statusCode = '3';
		}
		$.ajax({
			url: '/api/getReserve/search/statusChange',
			method: 'post',
			data: JSON.stringify(reserveStatus),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(datas){
				console.log(datas)
				/* let reserveAndPage = {
						buildCd: '7',
						startDate: '20220208',
						page: $('.wrapperCalendar').find('.table-responsive-lg').find('.pagination ').find('.active').data('adminbookingpage'),
					}
				console.log(reserveAndPage)
				drawTable(datas, reserveAndPage); */
				if(statusCode === '1'){
					$('.toast').css('right','2%');
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 취소되었습니다.");
					$('.table-originTbody'+reserveNo).find('.result__status').html('<i class="fas fa-times" style="color: #e74c3c;"></i>');
					$('.mr-auto').text("Success");
					$('.toast-parent').show();
					$('.toast').toast('show')
					
				//$('.table-originTbody'+data).find('.result__status').html('<i class="fas fa-hammer" style="color: #2c3e50;"></i>');
				//$('.table-originTbody'+data).find('.result__status').html('<i class="fas fa-trash" style="color: #e58e26;"></i>');
				//$('.table-originTbody'+data).find('.result__status').html('<i class="fas fa-times" style="color: #e74c3c;"></i>');
				//$('.table-originTbody'+data).find('.result__status').html('<i class="fas fa-check" style="color: #2ecc71;"></i>');
				//$('.table-originTbody'+data).find('.result__status').html('<i class="fas fa-shopping-cart"></i>');
					
				} else if(statusCode === '2'){
					$('.toast').css('right','2%');
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 삭제되었습니다.");
					$('.table-originTbody'+reserveNo).find('.result__status').html('<i class="fas fa-trash" style="color: #e58e26;"></i>');
					$('.mr-auto').text("Success");
					$('.toast-parent').show();
					$('.toast').toast('show')
				} else if(statusCode === '3'){
					$('.toast').css('right','2%');
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 결제되었습니다.");
					$('.table-originTbody'+reserveNo).find('.result__status').html('<i class="fas fa-check" style="color: #2ecc71;"></i>');
					$('.mr-auto').text("Success");
					$('.toast-parent').show();
					$('.toast').toast('show')
				}
				//console.log(dataArr)
				//checkReserve(amount);
				let reserve = {
						no: datas[0][0].no,
						roomNo: datas[0][0].roomNo,
					}
				$.ajax({
					url: '/api/getReserve',
					method: 'post',
					data: JSON.stringify(reserve),
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					success: function(data){
						console.log(data);
						$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').empty();
						$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').append(
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px; ">Adult</label>'+
							'<div class="col-sm-1"><input class="form-control detail__count-adult" type="number" placeholder=""/></div>'+
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>'+
							'<div class="col-sm-1"><input class="form-control detail__count-child" type="number" placeholder=""/></div>'+
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>'+
							'<div class="col-sm-2"><input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'
						);
						if(data.paymentFlg === '0' && data.cancelFlg === '0' && data.deleteFlg === '0'){
							$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
								'<div class="col-sm-2"><input type="button" value="결제" class="btn btn-success table-statusBtn"></input></div>'
							);
							buttonFlgSetting(datas)
						}
						if(data.paymentFlg === '1'){
							$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">決済完了</label>'+
								'<div class="col-sm-2"><input type="button" value="주문취소" class="btn btn-danger table-statusBtn"></input></div>'
							);
							buttonFlgSetting(datas)
						}
						if(data.cancelFlg === '1' && data.paymentFlg === '0'){
							$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">取り消し</label>'+
								'<div class="col-sm-2"><input type="button" value="삭제" class="btn btn-danger table-statusBtn"></input><input type="button" value="결제" class="btn btn-success table-statusBtn"></input></div>'
							);
							buttonFlgSetting(datas)
						}
						if(data.deleteFlg === '1'){
							$('.wrapperCalendar ').find('.loadData').find('.table-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">삭제됨</label>'+
								'<div class="col-sm-2"></div>'
							);
							buttonFlgSetting(datas)
						}
						
						$('.colorMark').css('background-color', datas[0][1].colorCd)
						$('.startDate').val(data.startDate);
						$('.endDate').val(data.endDate);
						$('.detail__totalPrice').val(datas[0][1].adultCost*data.adult+datas[0][1].childCost*data.child)
						$('.detail__count-adult').val(data.adult );
						$('.detail__count-child').val(data.child);
						$('.start').val(moment(data.startDate).format('YYYY/MM/DD'))
						$('.end').val(moment(data.endDate).format('YYYY/MM/DD'))
						$('.customer').val(data.name)
						$('.phone').val(data.phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"))
						$('.phone__clone').val(data.phone)
						$('.reserveNo').val(data.no)
						$('.loadData').find('.detail__totalPrice').val(data.totalCost);
						$('.loadData').find('.detail__count-adult').val(data.adult);
						$('.loadData').find('.detail__count-child').val(data.child);
						/* $('.regDate').val(moment(data.createdAt).format('YY年MM月DD日 HH:mm:ss'));
						if(today>moment(data.startDate,'YYYYMMDD')){
							$('.modifyPwBtn').hide();
						} */
						/* modal.find('input').attr('disabled', true);
						modal.find('select').attr('disabled', true);
						modal.find('input').css('background-color','#fff');
						modal.find('input').css('border','none');
						modal.find('select').css('background-color','#fff');
						modal.find('select').css('border','none');
						
						modal.modal('show'); */
						
						$(document).ready(function(){
							$(".detail__count-adult").change(function(){
								if($(".detail__count-adult").val() > parseInt(datas[0][1].max)){
									alert(datas[0][1].max+"명 이하로 예약할 수 있습니다.");
									$(".detail__count-adult").val(parseInt(datas[0][1].max));
									$(".detail__count-child").val("0");
									$(".detail__count-adult").select();
								} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(datas[0][1].max)){
									$(".detail__count-adult").val(Number($(".detail__count-adult").val()));
									$(".detail__count-child").val(Number(datas[0][1].max-$(".detail__count-adult").val()));
									if($(".detail__count-adult").val() == datas[0][1].max){
										$(".detail__count-adult").val(parseInt(datas[0][1].max));
										$(".detail__count-child").val("0");
									}
								} else if (Number($(".detail__count-adult").val()) < 1){
									$(".detail__count-adult").val("1");
									$(".detail__count-child").val($(".detail__count-child").val());
								}
								$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
							});
							
							$(".detail__count-child").change(function(){
								if($(".detail__count-child").val() > parseInt(datas[0][1].max)-1){
									alert("성인이 1명 있어야 합니다.");
									$(".detail__count-child").val(parseInt(datas[0][1].max)-1);
									$(".detail__count-adult").val("1");
									$(".detail__count-child").select();
								} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > parseInt(datas[0][1].max)){
									$(".detail__count-adult").val(Number(datas[0][1].max - $(".detail__count-child").val()));
									$(".detail__count-child").val(Number($(".detail__count-child").val()));
									if($(".detail__count-child").val() == parseInt(datas[0][1].max)-1){
										$(".detail__count-child").val(parseInt(datas[0][1].max)-1);
										$(".detail__count-adult").val("1");
									}
								} else if (Number($(".detail__count-child").val()) < 0){
									$(".detail__count-adult").val($(".detail__count-adult").val());
									$(".detail__count-child").val("0");
								}
								$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
							});
							
							function calculateTotal(a, c){
								let total = 0;
								let adultCost = parseInt(datas[0][1].adultCost);
								let childCost = parseInt(datas[0][1].childCost);
								total = adultCost*a + childCost*c
								return total;
							}
						})
						
						$.getJSON('/api/checkReserveSpecify/'+amount+'/'+datas[0][1].no+'/'+datas[0][0].no ,function(arr){
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
								if(bank.bankCd == data.bankNo){
									optionGroup.setAttribute ("selected", true);
								}
								
								$('.bankSelect').append(optionGroup);
							})
						});//
						
					}
				});//
			}
		}); 
	});//modify
	
	//table-modify
	$('.wrapperCalendar').on('click','.table-checkPwBtn',function(){
		if($('.bankSelect').val() == ''){
			alert('Select Bank');
			let selectMenu = document.querySelector('.bankSelect');
			$('.bankSelect').focus();
			return true;
		}
		if($('.customer').val() == ''){
			$('.customer').focus();
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
			buildCd : $('.buildCd').val(),
			bankbranchcde : $('.bankSelect option:selected').val(),
			startDate : $('.startDate').val(),
			endDate : $('.endDate').val(),
			totalCost : $('.detail__totalPrice').val(),
			phone : $('.phone__clone').val(),
			roomNo : $('.roomNo').val(),
		}
		console.log(reserve);
		$.ajax({
			url: '/api/reserve/modify',
			method: 'post',
			data: JSON.stringify(reserve),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success:function(data){
				$('.loadData').find('input').attr('disabled', true);
				$('.loadData').find('select').attr('disabled', true);
				$('.loadData').find('input[type=text]').css('background-color','#fff');
				$('.loadData').find('input[type=text]').css('border','none');
				$('.loadData').find('input[type=number]').css('background-color','#fff');
				$('.loadData').find('input[type=number]').css('border','none');
				$('.loadData').find('select').css('background-color','#fff');
				$('.loadData').find('select').css('border','none');
				console.log(data);
				let newNo = parseInt(data);
				
				$('.table-checkPwBtn').hide();
				$('.table-modifyPwBtn').show();
				
				$('.table-originTbody'+data).find('.result__name').text(reserve.name);
				$('.table-originTbody'+data).find('.result__phone').text(reserve.phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"));
				$('.table-originTbody'+data).find('.totalCost').text(Number(reserve.totalCost).toLocaleString('ja-JP'));
				$('.table-originTbody'+data).find('.fa-male').text(reserve.adult);
				$('.table-originTbody'+data).find('.fa-child').text(reserve.child);
				$('.table-originTbody'+data).find('.result__date').text(moment(reserve.startDate).format('YYYY/MM/DD')+"~"+moment(reserve.endDate).format('YYYY/MM/DD'));
				
				$('.colorMark').css('background-color',$('.colorCd').val());
				$('.toast-parent').show();
				$('.toast').toast('show')
				$('.toast-body').text($('.table-originTbody'+data).find('.result__no').text()+"号室 "+data+"번 예약이 수정되었습니다.");
				//checkReserve(amount);
			}
		});
	});
	
	//modify
	$('.checkPwBtn').click(function(){
		if($('.bankSelect').val() == ''){
			alert('Select Bank');
			let selectMenu = document.querySelector('.bankSelect');
			$('.bankSelect').focus();
			return true;
		}
		if($('.customer').val() == ''){
			$('.customer').focus();
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
				$('.toast-parent').show();
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
				$('.toast-parent').show();
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
				$('.toast-parent').show();
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
	
	
	//Modify status
	modal.on('click','.modal-body .btn', function(){
		//console.log($(this))
		modal.find('.modal-body').find('.btn').attr('data-deleteFlg')
		modal.find('.modal-body').find('.btn').attr('data-cancelFlg')
		modal.find('.modal-body').find('.btn').attr('data-paymentFlg')
		//console.log($(this).attr('data-deleteFlg'))
		//console.log($(this).attr('data-cancelFlg'))
		//console.log($(this).attr('data-paymentFlg'))
		let reserveNo = $(this).attr('data-reserveNo')
		//결제 취소
		let reserveStatus = {};
		let statusCode = "";
		if($(this).attr('data-cancelFlg') === '0' && $(this).attr('data-paymentFlg') === '1' && $(this).attr('data-deleteFlg') === '0'){
			console.log("결제 취소"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 1,
				paymentFlg: 0,
			}
			console.log(reserveStatus)
			statusCode = '1';
		}
		//삭제 표시 - 재결제
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).val().includes('결제')){
			console.log("삭제 표시-결제"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 0,
				paymentFlg: 1,
			}
			console.log(reserveStatus)
			statusCode = '3';
		}
		//삭제 표시 - 삭제
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).val().includes('삭제')){
			console.log("삭제 표시"+$(this).attr('data-cancelFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 1,
				cancelFlg: 0,
				paymentFlg: 0,
			}
			console.log(reserveStatus)
			statusCode = '2';
		}
		//결제 가능
		else if($(this).attr('data-cancelFlg') === '0' && $(this).attr('data-paymentFlg') === '0' && $(this).attr('data-deleteFlg') === '0'){
			console.log("결제 가능"+$(this).attr('data-paymentFlg'))
			reserveStatus = {
				no: reserveNo,
				deleteFlg: 0,
				cancelFlg: 0,
				paymentFlg: 1,
			}
			console.log(reserveStatus)
			statusCode = '3';
		}
		$.ajax({
			url: '/api/getReserve/search/statusChange',
			method: 'post',
			data: JSON.stringify(reserveStatus),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(datas){
				console.log(datas)
				if(statusCode === '1'){
					$('.toast').css('right','2%');
					$('.toast-parent').show();
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 취소되었습니다.");
					$('.mr-auto').text("Success");
				} else if(statusCode === '2'){
					$('.toast').css('right','2%');
					$('.toast-parent').show();
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 삭제되었습니다.");
					$('.mr-auto').text("Success");
				} else {
					$('.toast').css('right','2%');
					$('.toast-parent').show();
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 결제되었습니다.");
					$('.mr-auto').text("Success");
				}
				//console.log(dataArr)
				checkReserve(amount);
				let reserve = {
						no: datas[0][0].no,
						roomNo: datas[0][0].roomNo,
					}
				$.ajax({
					url: '/api/getReserve',
					method: 'post',
					data: JSON.stringify(reserve),
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					success: function(data){
						console.log(data);
						modal.find('.modal-body').find('.headModal-secondTr').empty();
						modal.find('.modal-body').find('.headModal-secondTr').append(
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px; ">Adult</label>'+
							'<div class="col-sm-1"><input class="form-control detail__count-adult" type="number" placeholder=""/></div>'+
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>'+
							'<div class="col-sm-1"><input class="form-control detail__count-child" type="number" placeholder=""/></div>'+
							'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>'+
							'<div class="col-sm-2"><input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'
						);
						if(data.paymentFlg === '0' && data.cancelFlg === '0' && data.deleteFlg === '0'){
							modal.find('.modal-body').find('.headModal-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
								'<div class="col-sm-2"><input type="button" value="결제" class="btn btn-success search-modalPaymentBtn"></input></div>'
							);
							changDataStatusOnBtn(data)
						}
						if(data.paymentFlg === '1'){
							modal.find('.modal-body').find('.headModal-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">決済完了</label>'+
								'<div class="col-sm-2"><input type="button" value="주문취소" class="btn btn-danger search-modalCancelBtn"></input></div>'
							);
							changDataStatusOnBtn(data)
						}
						if(data.cancelFlg === '1' && data.paymentFlg === '0'){
							modal.find('.modal-body').find('.headModal-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">取り消し</label>'+
								'<div class="col-sm-2"><input type="button" value="삭제" class="btn btn-danger search-modalDeleteBtn"></input><input type="button" value="결제" class="btn btn-success search-modalPaymentBtn"></input></div>'
							);
							changDataStatusOnBtn(data)
						}
						if(data.deleteFlg === '1'){
							modal.find('.modal-body').find('.headModal-secondTr').append(
								'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">삭제됨</label>'+
								'<div class="col-sm-2"></div>'
							);
							changDataStatusOnBtn(data)
						}
						
						$('.colorMark').css('background-color', eventObj.extendedProps.colorCd)
						$('.startDate').val(data.startDate);
						$('.endDate').val(data.endDate);
						$('.modal-title').text(eventObj.extendedProps.roomNum +" 号室");
						$('.detail__totalPrice').val(eventObj.extendedProps.adultCost*data.adult+eventObj.extendedProps.childCost*data.child)
						$('.detail__count-adult').val(data.adult );
						$('.detail__count-child').val(data.child);
						$('.start').val(moment(data.startDate).format('YYYY/MM/DD'))
						$('.end').val(moment(data.endDate).format('YYYY/MM/DD'))
						$('.customer').val(data.name)
						$('.phone').val(data.phone.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"))
						$('.phone__clone').val(data.phone)
						$('.reserveNo').val(data.no)
						$('.regDate').val(moment(data.createdAt).format('YY年MM月DD日 HH:mm:ss'));
						if(today>moment(data.startDate,'YYYYMMDD')){
							$('.modifyPwBtn').hide();
						}
						/* modal.find('input').attr('disabled', true);
						modal.find('select').attr('disabled', true);
						modal.find('input').css('background-color','#fff');
						modal.find('input').css('border','none');
						modal.find('select').css('background-color','#fff');
						modal.find('select').css('border','none');
						
						modal.modal('show'); */
						
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
			}
		}); 
	});//modify
</script>

</body>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />