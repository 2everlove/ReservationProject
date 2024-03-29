<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
       	<section class="projects-section bg-light" style="padding-top: 20px; padding-bottom: 40px;">
            	<div class="container px-4 px-lg-4">
            	<div style="display: flex;flex-direction: row;justify-content: center;align-items: center;flex-wrap: wrap;">
            		
	                <div class="row gx-0 mb-5 mb-lg-0 justify-content-center" style="width: 70%">
	                    <div class="col-lg-7">
							<c:url value="/api/display" var="thumbnail">
								<c:param name="fileName" value="${roomInfo.images[0]}"></c:param>
							</c:url>
							<div style=" display: flex;justify-content: space-around;">
		                    	<img class="img-fluid" src="${thumbnail }" alt="..." width="430" height="280" style="width: 430px; height: 280px;" />
							</div>
	                    	<ul style="display: flex;flex-direction: row;flex-wrap: nowrap;align-items: center;margin: 0rem;justify-content: center; padding-left: 0rem">
		                    	<c:forEach var="img" items="${roomInfo.images }" varStatus="imageNo">
									<c:url value="/api/display" var="imagesUrl">
										<c:param name="fileName" value="${img}"></c:param>
									</c:url>
									<li file="${img }" item="${imageNo.count-1}" class="img-thumb${imageNo.count-1 } thumbList" style="margin: 5px 5px 0px 0px" onmouseover="changeImage(this)">
										<img src="${imagesUrl}" height=80 width=80/>
									</li>
								</c:forEach>
	                    	</ul>
	                    </div>
	                    <div class="col-lg-5">
	                        <div class="bg-light text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-left">
	                                <h4 class="text-dark">${roomInfo.roomNum } 号室</h4>
	                                    <h4 class="text-dark">
					                   		${roomInfo.roomTitle}
						                </h4>
	                                    <p class="mb-0 text-dark">
		                                    <form>
		                                    	<div style="text-align: right; text-align: right;display: flex;justify-content: flex-end;flex-direction: row;flex-wrap: nowrap;align-items: center;">
													<label for="" class="col-form-label" style="margin: 0 5px 0 5px">大人数</label>
														<input type="number" value="<c:out value="${dateObject.adult != null ? dateObject.adult: '1' }"></c:out>" class="form-control detail__count-adult" min="1"　max="5" placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="1" style="display: inline-block; width: 80px;">
													<label for="" class="col-form-label" style="margin: 0 5px 0 5px">子供数</label>
														<input type="number" value="<c:out value="${dateObject.child != null ? dateObject.child: '0' }"></c:out>" class="form-control detail__count-child" value="0"　placeholder="1人" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="display: inline-block; width: 80px;">
		                                    	</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="" class="col-sm-3 col-form-label">期&nbsp;&nbsp;&nbsp;&nbsp;間</label>
													<div class="col-sm-6">
														<input type="text" class="form-control" id="demo" name="demo" value="" readonly style="background-color: #fff !important"/>
													</div>
												</div>
			                                    <div class="form-group row" style="justify-content: flex-end;">
													<label for="" class="col-sm-3 col-form-label">総金額</label>
													<div class="col-sm-6">
														
														<input class="form-control detail__totalPrice" type="text" value="${dateObject.adult != null || dateObject.child != null ? dateObject.adult*roomInfo.adultCost+dateObject.child*roomInfo.childCost: roomInfo.adultCost }" placeholder="" readonly/>
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
	                </div>
					<div style="padding-top: 20px;"></div>
					<hr style="border: none; font-size: 0; line-height: 0; margin: 40px 0 40px 0; color: rgba(132, 129, 122,1.0); background:rgba(132, 129, 122,1.0); height: 3px;"/>
					<div style="padding: 20px 20px;">
						${roomInfo.explanation}
					</div>
            	
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
       	</section>
	</div>
</div>
<div class="modal roomInfo-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">결재</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">総金額</label>
					<div class="col-sm-4">
						<input class="form-control detail__totalPrice-payment" type="text" placeholder="" readonly/>
						<input class="startDate" type="hidden">
						<input class="endDate" type="hidden">
					</div>
					<label for="" class="col-sm-2 col-form-label">Bank</label>
					<div class="col-sm-4">
						<select class="bankSelect form-control mx-sm-10">
							<option value="">---</option>
						</select>
					</div>
				</div>
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Adult</label>
					<div class="col-sm-4">
						<input class="form-control adult-clone" type="text" placeholder="" readonly/>
					</div>
					<label for="" class="col-sm-2 col-form-label">Child</label>
					<div class="col-sm-4">
						<input class="form-control child-clone" type="text" placeholder="" readonly/>
					</div>
				</div>
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-4">
						<input class="form-control name" type="text" placeholder=""/>
					</div>
					<label for="" class="col-sm-2 col-form-label">Phone</label>
					<div class="col-sm-4">
						<input class="form-control phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>
						<input class="form-control phone__clone" type="hidden" placeholder="" style="display: none;"/>
					</div>
				</div>
				<p class="response__data"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary payReserve">Payment</button>
				<button type="button" class="btn btn-primary checkOrder naverPayBtn" style="display: none">checkOrder</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

function changeImage(e){
	console.log(e);
	$('.img-fluid').attr('src', $(e).children().attr('src'));
	$(e).children().css('border','2px solid ${roomInfo.colorCd}')
}

$('.thumbList').on('mouseout', function(){
	$(this).children().css('border','1px solid transparent')
	//$('.img-fluid').attr('src', $('.img-thumb0').children().attr('src'));
})
let roomInfoDataArr = new Array();
let reserveSearchJson ={};
$(document).ready(function(){
	let disabledArr = [];
	let amount = 0;
	
	let modal = $('.roomInfo-modal');
	$('.registerReserve').click(function(){
		$('.payReserve').show();
		$('.checkOrder').hide();
		if($('.startDate').val() == ''){
			alert('Select Date');
			$('#demo').click();
			return true;
		}
		modal.modal('show');
		$('.bankSelect').html('<option value="">---</option>');
		$('.detail__totalPrice-payment').val($('.detail__totalPrice').val());
		$('.adult-clone').val($('.detail__count-adult').val());
		$('.child-clone').val($('.detail__count-child').val());
		
		//bankInfo
		$.getJSON('/api/payment/list' ,function(arr){
			console.log(arr);
			$.each(arr, function(i, bank){
				//console.log(bank);
				let optionGroup = document.createElement('option');
				//console.log(bank.bankName + bank.bankCd)
				optionGroup.innerText = bank.bankName;
				optionGroup.value=bank.bankCd;
				$('.bankSelect').append(optionGroup);
			})
		});
	});
	//close modal
	$('.modal-footer .btn-secondary, .close').click(function(){
		modal.modal('hide');
	});
	
	//payment
	$('.payReserve').click(function(){
		if($('.bankSelect').val() == ''){
			alert('Select Bank');
			let selectMenu = document.querySelector('.bankSelect');
			$('.bankSelect').focus();
			return true;
		}
		if($('.name').val() == ''){
			$('.name').focus();
			return true;
		}
		if($('.phone__clone').val() == ''){
			$('.phone').focus();
			return true;
		}
		let reserve = {
			name : $('.name').val(),
			adult : $('.detail__count-adult').val(),
			child : $('.detail__count-child').val(),
			builCd: ${roomInfo.buildCd},
			bankName : $('.bankSelect option:selected').text(),
			bankNo : $('.bankSelect option:selected').val(),
			bankbranchcde : $('.bankSelect option:selected').val(),
			startDate : $('.startDate').val(),
			endDate : $('.endDate').val(),
			totalCost : $('.detail__totalPrice-payment').val(),
			phone : $('.phone__clone').val(),
			paymentFlg: '0',
			roomNo : ${roomInfo.no },
			cancelFlg : '0',
			deleteFlg : '0',
		}
		console.log(reserve);
		$.ajax({
			url: '/api/reserve/register',
			method: 'post',
			data: JSON.stringify(reserve),
			contentType: 'application/json; charset=utf-8',
			dataType:'json',
			success:function(data){
				console.log(data);
				let newNo = parseInt(data);
				$('.checkOrder').show();
				$('.payReserve').hide();
				$('.response__data').text('예약번호:'+data+'\n결제가 완료되었습니다.');
				reserveSearchJson ={
					no: data,
					name: reserve.name,
					phone: reserve.phone,
				}
				$('.colorMark').css('background-color', "#2ed573")
				$('.toast').css('z-index','2560');
				$('.toast').css('right','2%');
				$('.toast').toast('show')
				$('.toast-body').text("예약(예약번호:"+data+")이 완료되었습니다.");
				$('.mr-auto').text("Success");
			}
		})
	})
	
	
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
			$(".detail__count-adult").val("${roomInfo.max}");
			$(".detail__count-child").val("0");
			$(".detail__count-adult").select();
		} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > ${roomInfo.max}){
			$(".detail__count-adult").val(Number($(".detail__count-adult").val()));
			$(".detail__count-child").val(Number(${roomInfo.max}-$(".detail__count-adult").val()));
			if($(".detail__count-adult").val() == ${roomInfo.max}){
				$(".detail__count-adult").val("${roomInfo.max}");
				$(".detail__count-child").val("0");
			}
		}
		$(".detail__totalPrice").val(calculateTotal($(".detail__count-adult").val(), $(".detail__count-child").val()));
	});
	
	$(".detail__count-child").change(function(){
		if($(".detail__count-child").val() > ${roomInfo.max}-1){
			alert("성인이 1명 있어야 합니다.");
			$(".detail__count-child").val("${roomInfo.max-1}");
			$(".detail__count-adult").val("1");
			$(".detail__count-child").select();
		} else if (Number($(".detail__count-adult").val())+Number($(".detail__count-child").val()) > ${roomInfo.max}){
			$(".detail__count-adult").val(Number(${roomInfo.max} - $(".detail__count-child").val()));
			$(".detail__count-child").val(Number($(".detail__count-child").val()));
			if($(".detail__count-child").val() == ${roomInfo.max}-1){
				$(".detail__count-child").val("${roomInfo.max-1}");
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
		for (let i = 0; i <= diff; i++) {
		  range.push(moment(moment(startDate).add(i, type)).format('YYYY-MM-DD'));
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
		$.getJSON('/api/checkReserveSpecify/'+amount+"/${roomNum}" ,function(arr){
			console.log(arr);
			let jsonList = new Array();
	       	  $.each(arr, function(i, data){
	       		disabledArr.push(getRange(data[1].startDate, data[1].endDate, 'days').flat(Infinity));
	       		//console.log(data[1]);
	       		console.log(data[1].startDate+ " " + data[1].endDate);
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
	<c:if test="${dateObject.startDate != null && dateObject.startDate != ''}">
	 	let startDate1=moment('${dateObject.startDate}','YYYYMMDD');
	 	let endDate1=moment('${dateObject.endDate}','YYYYMMDD');
	 	$('.startDate').val('${dateObject.startDate}');
		$('.endDate').val('${dateObject.endDate}');
	 </c:if>
	
	let options = function(arg){

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
        console.log(uniteUnique(disabledArr));
		
        if($.inArray(thisCompare,uniteUnique(disabledArr))!=-1){
           console.log("      ^--------- DATE FOUND HERE");
            return true;
        }
        if(disabledArr.length == 0){
       	 console.log(disabledArr.length);
       	 return false;
        }
    }
	 
	console.log(uniteUnique(disabledArr));
	let today = new Date();
	$('#demo').daterangepicker({
		isInvalidDate: options,
	     <c:if test="${dateObject.startDate != null && dateObject.startDate != ''}">
		 	startDate:startDate1,
		 	endDate:endDate1,
		 </c:if>
	     opens: 'left',
	     minDate: today,
	     maxSpan: {
	    	    "days": ${roomInfo.max}
    	},
		"locale": { 
			"format": "MM/DD", 
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
		
		"drops": "auto" 
	}, function (start, end, label) { 
		
		console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
		<c:if test="${dateObject.startDate != null && dateObject.startDate != ''}">
			$('.startDate').val(moment('${dateObject.startDate}','YYYYMMDD'));
			$('.endDate').val(moment('${dateObject.endDate}','YYYYMMDD'));
	 	</c:if>
		<c:if test="${dateObject.startDate == null || dateObject.startDate == ''}">
			$('.startDate').val(start.format('YYYYMMDD'));
			$('.endDate').val(end.format('YYYYMMDD'));
	 	</c:if>
	 	
		
	});
	
	$("#demo").on("apply.daterangepicker",function(e,picker){

	    // Get the selected bound dates.
	    var startDate = picker.startDate.format('YYYY-MM-DD')
	    var endDate = picker.endDate.format('YYYY-MM-DD')
	    //console.log(startDate+" to "+endDate);
	    
	    // Compare the dates again.
	    var clearInput = false;
	    let disableD = uniteUnique(disabledArr);
	    console.log(disableD)
	    for(i=0;i<disableD.length+1;i++){
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
	
	$('.checkOrder').on('click', function(){
		
	});
	
	$('.phone').keyup(function(){
		//console.log($(this).val().length);
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
	});
	$(".phone").change(function(){
		let str = $(this).val();
		let tmp = str.replace(/\-/g,'');
		$(".phone__clone").val(tmp);
	});
	
	function changDataStatusOnBtn(data){
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-deleteFlg', data[0][0].deleteFlg)
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-cancelFlg', data[0][0].cancelFlg)
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-paymentFlg', data[0][0].paymentFlg)
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-reserveNo', data[0][0].no)
	}
		
	$('.checkOrder').on('click', function(){
		$.ajax({
			url: '/api/getReserve/search/'+reserveSearchJson.no,
			method: 'post',
			data: JSON.stringify(reserveSearchJson),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(datas){
				console.log(datas)
				let json = new Object();
				$.each(datas , function (i, data){
					//console.log(data)
			   		json.roomNo = data[1].no;
			   		json.reserveNo = data[0].no;
			   		json.title = (data[0].paymentFlg==0?"❌ ":"✔ ") + data[1].roomNum + "号室 " ;
			   		json.roomNum = data[1].roomNum;
			   		json.bankNo = data[0].bankNo;
			   		json.adultCost = data[1].adultCost;
			   		json.childCost = data[1].childCost;
			   		json.buildCd = data[1].buildCd;
			   		json.max = data[1].max;
			   		json.colorCd = data[1].colorCd;
			   		json.images = data[1].images;
			   		json.start = moment(data[0].startDate).format('YYYY-MM-DD');
			   		json.end = moment(moment(data[0].endDate).add(1, 'days')).format('YYYY-MM-DD');
			   		json.color =data[1].colorCd;
			   		roomInfoDataArr.push(json);
				});
				
				$('.roomInfo-modal').find('.modal-content').css('width','900px');
				$('.roomInfo-modal').find('.modal-body').html(
					'<div class="form-group row" style="justify-content: flex-end;">'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">phone</label>'+
					'<div class="col-sm-2"><input class="form-control phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>'+
					'<input class="form-control phone__clone" type="hidden" placeholder="" style="display: none;"/></div>'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Bank</label>'+
					'<div class="col-sm-2"><select class="bankSelect form-control mx-sm-10"><option value="">---</option></select></div>'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">입실일</label>'+
					'<div class="col-sm-2"><input class="form-control start" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">퇴실일</label>'+
					'<div class="col-sm-2" ><input class="form-control end" type="text" placeholder="" readonly style="background-color: #fff;"/></div></div>'+
					'<div class="form-group row headModal-secondTr" style="justify-content: flex-end;">'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Adult</label>'+
					'<div class="col-sm-1"><input class="form-control detail__count-adult" type="number" placeholder=""/></div>'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Child</label>'+
					'<div class="col-sm-1"><input class="form-control detail__count-child" type="number" placeholder=""/></div>'+
					'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">総金額</label>'+
					'<div class="col-sm-2"><input class="form-control detail__totalPrice" type="text" placeholder="" readonly style="background-color: #fff;"/></div>'+
					
					'</div>'
				);
				//console.log(data[0][0])
				if(datas[0][0].paymentFlg === '0' && datas[0][0].cancelFlg === '0' && datas[0][0].deleteFlg === '0'){
					$('.roomInfo-modal').find('.modal-body').find('.headModal-secondTr').append(
						'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label statusLabel">결제대기중</label>'+
						'<div class="col-sm-2 statusBtnDiv"><button type="button" class="btn btn-success search-modalPaymentBtn">결제</button></div>'
					);
					changDataStatusOnBtn(datas)
				}
				if(datas[0][0].paymentFlg === '1'){
					$('.roomInfo-modal').find('.modal-body').find('.headModal-secondTr').append(
						'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제완료</label>'
					);
					changDataStatusOnBtn(datas)
				}
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
							if(bank.bankCd == datas[0][0].bankNo){
								optionGroup.setAttribute ("selected", true);
							}
							
							$('.bankSelect').append(optionGroup);
						})
					});//
					$('.roomInfo-modal').find('.detail__totalPrice').val(datas[0][0].totalCost.toLocaleString('ja-JP'));
					$('.roomInfo-modal').find('.detail__count-adult').val(datas[0][0].adult);
					$('.roomInfo-modal').find('.detail__count-child').val(datas[0][0].child);
					$('.roomInfo-modal').find('.start').val(moment(datas[0][0].startDate).format('YYYY/MM/DD'));
					$('.roomInfo-modal').find('.end').val(moment(datas[0][0].endDate).format('YYYY/MM/DD'));
					$('.roomInfo-modal').find('.modal-header').html('<h5 class="modal-title search-detail__romNum"></h5>'+
						'<label for="" class="col-sm-1 col-form-label "></label>'+
						'<div class="col-sm-2">'+
							'<input class="form-control customer" type="text" placeholder=""/>'+
							'<input class="reserveNo" type="hidden">'+
							'<input class="startDate" type="hidden">'+
							'<input class="endDate" type="hidden">'+
						'</div>'+
						'<label for="" class="col-sm-2 col-form-label">顧客様</label>'+
						'<label for="" class="col-sm-1 col-form-label">regDate</label>'+
						'<div class="col-sm-4">'+
							'<input class="form-control regDate" type="text" placeholder="" readonly="readonly" style="background-color: #fff; border:none;"/>'+
						'</div>'+
						'<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
							'<span aria-hidden="true">&times;</span>'+
						'</button>'
					);
					$('.roomInfo-modal').find('.search-detail__romNum').text(datas[0][1].roomNum +"号室");
					$('.roomInfo-modal').find('.customer').val(datas[0][0].name);
					$('.roomInfo-modal').find('.phone').val( datas[0][0].phone.replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
					$('.roomInfo-modal').find('.regDate').val(moment(datas[0][0].createdAt).format('YYYY年MM月DD日'));
					
					$('.roomInfo-modal').find('input').attr('disabled', true);
					$('.roomInfo-modal').find('select').attr('disabled', true);
					$('.roomInfo-modal').find('input').css('background-color','#fff');
					$('.roomInfo-modal').find('input').css('border','none');
					$('.roomInfo-modal').find('select').css('background-color','#fff');
					$('.roomInfo-modal').find('select').css('border','none');
				}, 50);
				$('.modal-dialog').animate({margin: '5.75rem auto'},{transform: 'translateX(-35%)'});
			}
		});	
	});

	function searchedSpecificData(data){
		//console.log(data[0][0])
		if(data[0][0].paymentFlg === '0' && data[0][0].cancelFlg === '0' && data[0][0].deleteFlg === '0'){
			$('.roomInfo-modal').find('.modal-body').find('.statusBtnDiv').append(
				'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
				'<div class="col-sm-2 statusBtnDiv"><button type="button" class="btn btn-success search-modalPaymentBtn">결제</button></div>'
			);
			changDataStatusOnBtn(data)
		}
		if(data[0][0].paymentFlg === '1'){
			$('.roomInfo-modal').find('.modal-body').find('.statusLabel').text(
				'결제완료'
			);
			changDataStatusOnBtn(data)
			$('.search-modalPaymentBtn').hide();
		}
	};

	//Modify status
	$('.roomInfo-modal').on('click','.modal-body .btn', function(){
		//console.log($(this))
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-deleteFlg')
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-cancelFlg')
		$('.roomInfo-modal').find('.modal-body').find('.btn').attr('data-paymentFlg')
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
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).text() === '결제'){
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
		else if($(this).attr('data-deleteFlg') === '0' && $(this).attr('data-cancelFlg') === '1' && $(this).attr('data-paymentFlg') === '0' && $(this).text() === '삭제'){
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
					$('.toast').css('z-index','2560');
					$('.toast').css('right','2%');
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 취소되었습니다.");
					$('.mr-auto').text("Success");
				} else if(statusCode === '2'){
					$('.toast').css('z-index','2560');
					$('.toast').css('right','2%');
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 삭제되었습니다.");
					$('.mr-auto').text("Success");
				} else {
					$('.toast').css('z-index','2560');
					$('.toast').css('right','2%');
					$('.toast').toast('show')
					$('.toast-body').text('예약번호 '+datas[0][0].no + "번이 결제되었습니다.");
					$('.mr-auto').text("Success");
				}
				searchedSpecificData(datas);
				$('.startDate').val('')
				$('.endDate').val('')
				$.getJSON('/api/checkReserveSpecify/'+amount+"/${roomNum}" ,function(arr){
					console.log(arr);
					let jsonList = new Array();
			       	  $.each(arr, function(i, data){
			       		disabledArr.push(getRange(data[1].startDate, data[1].endDate, 'days').flat(Infinity));
			       		//console.log(data[1]);
			       		console.log(data[1].startDate+ " " + data[1].endDate);
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
		}); 
	});
	
});//


	
		
	
</script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</body>

