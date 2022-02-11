<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>

<html lang="en">
<script type="text/javascript">
    $(document).ready(function(){
    	
    	
    	
    	let owl = $('.owl-carousel');
    	owl.owlCarousel({
    		animateOut: 'slideOutDown',
    	    animateIn: 'flipInX',
    		items:5,
    	    center:true,
    	    autoplay:true,
    	    autoplayTimeout:5000,
    	    autoplayHoverPause:true,
    	    smartSpeed:700,
    	    loop:true,
    	    margin:10,
    	    nav:false,
    	    responsiveClass:true,
    	    responsive:{
    	        0:{
    	            items:1,
    	        },
    	        600:{
    	            items:3,
    	        },            
    	        960:{
    	            items:4,
    	       
    	        },
    	        
    	    }
    	});
    	owl.on('mousewheel', '.owl-stage', function (e) {
    		if (e.originalEvent.wheelDelta >= 120) {
            	owl.trigger('prev.owl');
            } else if (e.originalEvent.wheelDelta <= -120) {
    			owl.trigger('next.owl');
            }
    	    e.preventDefault();
            return false;
    	});
    	
    	
    	var swiper = new Swiper(".mySwiper", {
            direction: "vertical",
            slidesPerView: 1,
            spaceBetween: 30,
            mousewheel: true,
            pagination: {
              el: ".swiper-pagination",
              clickable: true,
            },
          });
    	
    	/* var myelement = document.getElementById("carouselExampleDark"); 
	    
	    function makeItSo() {
	        // this is where you tell it to go to the next slide
	        $('.carousel').carousel('next')
	      }

	      myelement.addEventListener('wheel', function(e) {      
	            makeItSo();
	            $(document).off(".disableScroll"); 

	      });
	      
	      /* $.fn.extend({
	    	    mouse_wheel: function() {
	    	        $(this).on('mousewheel', function(e) {
	    	            if (e.originalEvent.wheelDelta >= 120) {
	    	                this.scrollTop -= 50;
	    	            } else if (e.originalEvent.wheelDelta <= -120) {
	    	                this.scrollTop += 50;
	    	            }
	    	            return false;
	    	        });
	    	    }
	    	});


	    	 
	      $('#carouselExampleDark').mouse_wheel(); */

    	let today = new Date();
	      
	    $('.startDateText').text(moment(today).format('YYYY年　MM月　DD日'));
		$('.endDateText').text(moment(today).format('YYYY年　MM月　DD日'));
		$('.startDate').val(moment(today).format('YYYYMMDD'));
		$('.endDate').val(moment(today).format('YYYYMMDD'));
		const WEEKDAY = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"];
		let weekStart = WEEKDAY[today.getDay()];
		$('.dateStartText').text(weekStart);
		$('.dateEndText').text(weekStart);
        $('.start').daterangepicker({
    	     opens: 'left',
    	     startDate: today,
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
    		"autoApply": true,
    		"drops": "down",
    	}, function (start, end, label) { 
    		let dayStart = new Date(start._d);
    		let dayEnd = new Date(end._d);
    		let weekStart = WEEKDAY[dayStart.getDay()];
    		let weekEnd = WEEKDAY[dayEnd.getDay()];
    		console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
    		$('.startDateText').text(start.format('YYYY年　MM月　DD日'));
    		$('.endDateText').text(end.format('YYYY年　MM月　DD日'));
    		$('.dateStartText').text(weekStart);
    		$('.dateEndText').text(weekEnd);
    		$('.adult').val('2');
    		$('.child').val('2');
    		
    		$('.startDate').val(start.format('YYYYMMDD'));
    		$('.endDate').val(end.format('YYYYMMDD'));
    		$('.peoplePopup').fadeIn('300');
    		$('.btn-Search').fadeOut('300');
    	});
        $('.end').daterangepicker({
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
    		"autoApply": true,
    		"drops": "down",
    	}, function (start, end, label) { 
    		let dayStart = new Date(start._d);
    		let dayEnd = new Date(end._d);
    		let weekStart = WEEKDAY[dayStart.getDay()];
    		let weekEnd = WEEKDAY[dayEnd.getDay()];
    		console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
    		$('.startDateText').text(start.format('YYYY年　MM月　DD日'));
    		$('.endDateText').text(end.format('YYYY年　MM月　DD日'));
    		$('.dateStartText').text(weekStart);
    		$('.dateEndText').text(weekEnd);
    		$('.adult').val('2');
    		$('.child').val('2');
    		
    		
    		$('.startDate').val(start.format('YYYYMMDD'));
    		$('.endDate').val(end.format('YYYYMMDD'));
    		$('.startDate').val(start.format('YYYYMMDD'));
    		$('.endDate').val(end.format('YYYYMMDD'));
    		$('.peoplePopup').fadeIn('300');
    		$('.btn-Search').fadeOut('300');
    	});
        $('.people').on('click', function(e){
        	if($('.startDate').val() === ''){
    			$('.start').click();
	   			$('.btn-Search').hide();
    			return false;
    		}
        	$('.peoplePopup').fadeIn('300');
        });//
        
        $('.peopleGroup').click(function(e){
        	console.log($(this));
        	
        	console.log($(this).data('people'));
        	if($('.peopleGroup').hasClass('activePeople'))
        		$('.peopleGroup').removeClass('activePeople');
        	if($(this).data('people') === 'solo'){
        		$('.numberOfPeople').fadeOut('300');
        		$(this).addClass('activePeople');
        		$('.adult').val('1');
        		$('.child').val('0');
        		$('.showingPeople').text('Adult '+$('.adult').val() +'名');
        		$('.peoplePopup').fadeOut('300');
        		$('.btn-Search').fadeIn('300');
        	} else if($(this).data('people') === 'couple'){
        		$('.numberOfPeople').fadeOut('300');
        		$(this).addClass('activePeople');
        		$('.adult').val('2');
        		$('.child').val('0');
        		
        		$('.showingPeople').text('Adult '+$('.adult').val() +'名');
        		$('.peoplePopup').fadeOut('300');
        		$('.btn-Search').fadeIn('300');
        	} else if($(this).data('people') === 'family'){
        		$('.adult').val('2');
        		$('.child').val('2');
        		$('.adultPopup').text('2');
   				$('.childPopup').text('2');
        		$('.showingPeople').text('Adult '+$('.adult').val() +' 名 , Child '+$('.child').val()+' 名');
        		$(this).addClass('activePeople');
        		$('.numberOfPeople').css('display','table-cell');
        	}
        });
    	
        $('html').on('click',  function(e){
        	//console.log($(e.target).closest('div'))
        	
        	if($(e.target).hasClass("people")){
       			$('.btn-Search').fadeOut('300');
        		$('.peoplePopup').fadeIn('300');
        		return false;
        	} else if(!$(e.target).hasClass("people")){
        		if($(e.target).closest('.people').hasClass("people")){
	       			$('.btn-Search').fadeOut('300');
        			$('.peoplePopup').fadeIn('300');
            		return false;
        		}
        	}
        	if(!$(e.target).closest('.peoplePopup').hasClass("peoplePopup")){
       			$('.numberOfPeople').css('display','none');
       			if($('.startDate').val() !== '')
       				$('.btn-Search').fadeIn('600');
       			$('.peoplePopup').fadeOut('300');
        	}
        });//
        
        $('.reservePeople').click(function(e){
        	let event = $(e.target);
        	if($(e.target).hasClass('fas')){
        		event =$(e.target).closest('span');
        	}
        	if(event.hasClass('minus')){
        		event.closest('.reservePeople').find('.numberOf').text();
        		if(event.closest('.reservePeople').find('.numberOf').hasClass('adultPopup')){
        			if($('.adult').val() > 1){
        				$('.adult').val($('.adult').val()-1);
        			} else {
        				$('.adult').val('1');
        				return false;
        			}
        		}else{
        			if($('.child').val() > 0){
        				$('.child').val($('.child').val()-1);
        			} else {
        				$('.child').val('0');
        				return false;
        			}
        		}
        	} else if(event.hasClass('plus')){
        		event.closest('.reservePeople').find('.numberOf').text();
        		if(event.closest('.reservePeople').find('.numberOf').hasClass('adultPopup')){
       				$('.adult').val(parseInt($('.adult').val())+1);
       				$('.adultPopup').text($('.adult').val());
        		}else{
       				$('.child').val(parseInt($('.child').val())+1);
       				$('.childPopup').text($('.child').val());
        		}
        	}
        	if($('.adult').val() > 0 && $('.child').val() > 0){
	        	$('.showingPeople').text('Adult '+$('.adult').val() +' 名 , Child '+$('.child').val()+' 名');
       				$('.adultPopup').text($('.adult').val());
       				$('.childPopup').text($('.child').val());
        	} else if($('.adult').val() > 0 && $('.child').val() == 0){
	        	$('.showingPeople').text('Adult '+$('.adult').val() +' 名 ');
       				$('.adultPopup').text($('.adult').val());
       				$('.childPopup').text($('.child').val());
        	}
        });
        
        $('.btn-Search').on('click', function(){
        	search();
        });
        
	});//
    
	function search(){
		submit('/booking/search', 'GET', [
		    { name: 'startDate', value: $('.startDate').val() },
		    { name: 'endDate', value: $('.endDate').val() },
		    { name: 'adult', value: parseInt($('.adult').val()) },
		    { name: 'child', value: parseInt($('.child').val()) },
		]);
	}
    
	function submit(action, method, values) {
	    let form = $('<form/>', {
	        action: action,
	        method: method
	    });
	    $.each(values, function() {
	        form.append($('<input/>', {
	            type: 'hidden',
	            name: this.name,
	            value: this.value
	        }));
	    });
	    form.appendTo('body').submit();
	}
    
    
</script>
<style>
.activePeople{
	color: #ff7f50 !important;
    background-color: #fff;
    -webkit-box-shadow: 0 2px 3px 0 rgb(0 0 0 / 10%);
    box-shadow: 0 2px 3px 0 rgb(0 0 0 / 10%);
    font-weight: bold;
}
</style>
    
      	<div class="bg-dark " style="height: 94px"></div>
        <header class="masthead" style="padding-top: 0% !important">
        <div class="container-fluid px-2 px-lg-2">
			<div class="owl-carousel owl-drag">
				<c:forEach items="${slideList}" var="slideImage">
					<c:url value="/api/display" var="thumbnail">
						<c:param name="fileName" value="${slideImage.filename}"></c:param>
					</c:url>
					 <div><img src="${thumbnail}" alt="Los Angeles" width="800" height="300"></div>
				</c:forEach>
				  <!-- <div><img src="/resources/assets/img/room/room1.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room2.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room3.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room4.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room5.jpg" alt="Los Angeles" width="800" height="300"></div> -->
			</div>
		</div>
        <div class="container px-4 px-lg-5" style="margin-top: 20px;">
        	<div style="position: relative; margin: 0 auto;">
        	<div>
        	<div class="demo start" style="width: 25%;background-color: #fff !important; border-color: #dddfe2; border: 1px solid; height: 66px; border-radius: 8px; font-size: 16px; cursor: pointer; display: inline-block; vertical-align: top;box-shadow: none;">
        		<div style="padding: 0 10px; position: absolute; top: 15%;">
        			<i class="far fa-calendar-alt" style="padding: 12px 14px; font-size: 20px; color: #333; vertical-align:middle; display: inline-block;"></i>
	        		<div style="width: calc(100% - 60px); vertical-align: middle; display: inline-block; width: auto; ">
	        			<div class="startDateText" style="font-weight: 400; text-overflow: ellipsis;"></div>
	        			<div class="dateStartText" style="color: #999; font-size: 14px; line-height: 1.25; text-overflow: ellipsis;"></div>
	        		</div>
	        		
        		</div>
        	</div>
        	<div class="demo end" style="width: 25%;background-color: #fff !important; border-color: #e7e7e7; border: 1px solid; height: 66px; border-radius: 8px; font-size: 16px; cursor: pointer; display: inline-block; vertical-align: top;box-shadow: none;">
        		<div style="padding: 0 10px; position: absolute; top: 15%;">
        			<i class="far fa-calendar-alt" style="padding: 12px 14px; font-size: 20px; color: #333; vertical-align:middle; display: inline-block;"></i>
	        		<div style="width: calc(100% - 60px); vertical-align: middle; display: inline-block; width: auto; ">
	        			<div class="endDateText" style="font-weight: 400; text-overflow: ellipsis;"></div>
	        			<div class="dateEndText" style="color: #999; font-size: 14px; line-height: 1.25; text-overflow: ellipsis;"></div>
	        		</div>
	        		
        		</div>
        	</div>
        	<div class="people" style="width: calc(50% - 122px);background-color: #fff !important; border-color: #e7e7e7; border: 1px solid; height: 66px; border-radius: 8px; font-size: 16px; display: inline-block; margin-left: 20px; cursor: pointer;">
        		<div style="width: 40%;padding: 0 20px;position: absolute;top: 14%;-webkit-transform: translateY(-13%);transform: translateY(-13%);">
        			<i class="fas fa-users" style="padding-right: 16px;display: inline-block;vertical-align: middle;text-align: left;"></i>
        			<div style="width: calc(100% -180px);vertical-align: middle;display: inline-block;box-sizing: border-box;">
        				<div style="width: auto;padding: 10px 0;font-size: 16px;">
        					<div style="font-weight: 400;padding-right: 44px;white-space: nowrap;overflow: hidden;">
        						<span class="showingPeople" style="box-sizing: border-box;font-weight: 400;white-space: nowrap;">Adult 1人</span>
        					</div>
        					<div style="font-size: 14px;color: #999;line-height: 1.25;text-overflow: ellipsis;">
        						Room 1 号室
        					</div>
        					<div style="right: 50px;position: absolute;transform: translateX(-150%); top: 35%;">
        						<i class="fas fa-chevron-down" style="color: #ff7f50; overflow: hidden;"></i>
        					</div>
        				</div>
        			</div>
        		</div>
        	</div>
   			<div class="peoplePopup" style="left: calc(50% + 32px); op: calc((100% + 52px)/3*2 + 12px); max-width: 500px; position: absolute; transition: left .3s ease-out; display: none;">
   				<div class="peoplePopup" style="width: 580px; background-color: #fff; transition: width .3s ease-out,height .3s ease-out,max-height .3s ease-out; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 10px 0 rgb(0 0 0 / 15%);">
   					<div style="width: 100%; display: table;">
   						<div style="width: 50%; background-color: #f8f7f9; display: table-cell;">
   							<div style="">
   								<div class="peopleGroup" data-people="solo" style="color: #555; height: 66px; display: table; width: 100%; padding: 0 20px; font-size: 14px; cursor: pointer;">
   									<div style="text-align: left; border-top-color: #dddfe2; display: table-cell; vertical-align: middle;">
   										Solo
   									</div>
   									<div style="text-align: right; border-top-color: #dddfe2; font-size: 11px; width: 65%; margin: 0 auto; display: table-cell; vertical-align: middle;">
   										Room 1 号室 / Adult 1名
   									</div>
   								</div>
   								<div class="peopleGroup" data-people="couple" style="color: #555; height: 66px; display: table; width: 100%; padding: 0 20px; font-size: 14px; cursor: pointer;">
   									<div style="text-align: left; border-top-color: #dddfe2; display: table-cell; vertical-align: middle; border-top: 1px solid;">
   										Couple / 2名
   									</div>
   									<div style="text-align: right; border-top-color: #dddfe2; font-size: 11px; width: 65%; margin: 0 auto; display: table-cell; vertical-align: middle; border-top: 1px solid;">
   										Room 1 号室 / Adult 2名
   									</div>
   								</div>
   								<div class="peopleGroup" data-people="family" style="color: #555; height: 66px; display: table; width: 100%; padding: 0 20px; font-size: 14px; cursor: pointer;">
   									<div style="text-align: left; border-top-color: #dddfe2; display: table-cell; vertical-align: middle; border-top: 1px solid;">
   										Family / Group
   									</div>
   									<div style="text-align: right; border-top-color: #dddfe2; font-size: 11px; width: 65%; margin: 0 auto; display: table-cell; vertical-align: middle; border-top: 1px solid;">
   										<i class="fas fa-chevron-right" style="float: right; font-size: 15px;"></i>
   									</div>
   								</div>
   							</div>
   						</div>
   						<div class="numberOfPeople" style="width: 50%; background-color: #f8f7f9; display: none;">
   							<div style="">
   								<div class="reservePeople" style="position: relative;overflow: hidden;min-height: 40px;line-height: 28px;height: 54px;margin: 0px 10px;padding-top: 6px; border-radius: 2px;border-bottom: 1px solid rgb(221, 223, 226);text-align: center;">
									<span class="minus" style="position: absolute;width: 40px;top: 15px;cursor: pointer;user-select: none;left: 15px; line-height: 28px; text-align: center;"><i class="fas fa-minus" style="color: #ff7f50; overflow: hidden;"></i></span>
									<span class="numberOf adultPopup" style="margin-top: 6px; line-height: 28px; display: inline-block;font-size: 22px;color: #ff7f50;padding: 0px 5px 0px 0px;font-weight: 400; text-align: center;">2</span>
									<span style="margin-top: 6px;line-height: 28px; display: inline-block;text-align: left; min-width: 45px;font-size: 14px;letter-spacing: 0.32px;margin-left: 2px;color: #ff7f50;text-align: center;">Adult</span>
									<span class="plus" style="position: absolute;width: 40px;top: 15px;cursor: pointer;user-select: none; right: 30px; line-height: 28px; text-align: center;"><i class="fas fa-plus" style="color: #ff7f50; overflow: hidden;"></i></span>
   								</div>
   								<div class="reservePeople" style="position: relative;overflow: hidden;min-height: 40px;line-height: 28px;height: 54px;margin: 0px 10px;padding-top: 6px; border-radius: 2px;border-bottom: 1px solid rgb(221, 223, 226);text-align: center;">
									<span class="minus" style="position: absolute;width: 40px;top: 15px;cursor: pointer;user-select: none;left: 15px; line-height: 28px; text-align: center;"><i class="fas fa-minus" style="color: #ff7f50; overflow: hidden;"></i></span>
									<span class="numberOf childPopup" style="margin-top: 6px; line-height: 28px; display: inline-block;font-size: 22px;color: #ff7f50;padding: 0px 5px 0px 0px;font-weight: 400; text-align: center;">2</span>
									<span style="margin-top: 6px;line-height: 28px; display: inline-block;text-align: left; min-width: 45px;font-size: 14px;letter-spacing: 0.32px;margin-left: 2px;color: #ff7f50;text-align: center;">Children</span>
									<span class="plus" style="position: absolute;width: 40px;top: 15px;cursor: pointer;user-select: none; right: 30px; line-height: 28px; text-align: center;"><i class="fas fa-plus" style="color: #ff7f50; overflow: hidden;"></i></span>
   								</div>
   							</div>
   						</div>
   					</div>
   				</div>
   			</div>
        	<div class="btn-Search" style="margin: -32px auto auto; box-sizing: border-box; position: absolute; left: 50% ;top: 480%; display: none;transform: translateX(-50%);">
        		<div style="">
        		</div>
	        	<button type="button" class="" style="position: relative;border: none;user-select: none;padding: 12px;border-radius: 8px;background-color: #ff7f50; color: rgb(255, 255, 255);width: 490px;height: 64px;box-shadow: rgb(0 0 0 / 20%) 0px 1px 3px 1px;transition: all 0.15s ease-in-out 0s;cursor: pointer;text-align: center;">Search</button>
        	</div>
	        	
        	</div>
	        	<input type="hidden" class="form-control startDate" value="" readonly style="width: 50%;background-color: #fff !important"/>
	        	<input type="hidden" class="form-control endDate" value="" readonly style="width: 50%;background-color: #fff !important"/>
	        	<input type="hidden" class="form-control adult" value="2" readonly style="width: 50%;background-color: #fff !important"/>
	        	<input type="hidden" class="form-control child" value="2" readonly style="width: 50%;background-color: #fff !important"/>
		</div>
        </div>
        </header>
        
        
        
</html>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />