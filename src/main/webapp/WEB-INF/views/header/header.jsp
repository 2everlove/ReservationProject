<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.work_area {
		margin: 0px auto;
	}
	a{
		color: black;
	}
	ul{
		list-style: none;
	}
	#navbar__log-bar {
		font-size: 50px;
		color: #ff7f50;
	}
	
</style>

	<body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/main"><i class="fas fa-hotel" id="navbar__log-bar"></i></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="/notice">お知らせ</a></li>
                        <li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								部屋&予約
							</a>
							<div class="dropdown-menu bg-dark" aria-labelledby="navbarDropdownMenuLink">
								<a class="dropdown-item text-white" href="/booking/1">予約</a>
								<a class="dropdown-item text-white" href="/booking">部屋</a>
								<a class="reserveCheckModal dropdown-item text-white" href="javascript:void(0);">予約確認</a>
							</div>
						</li>
                        <li class="nav-item"><a class="nav-link" href="/consultation">相談</a></li>
                        <li class="nav-item"><a class="nav-link" href="/admin">Admin</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
<div class="search-modal modal" tabindex="-1">
	
</div>
<script type="text/javascript">
let amount = 0;
let dataArr = new Array();
let reserve = {};
$(document).ready(function(){
	$('.search-modal__phone').keyup(function(){
		//console.log($(this).val().length);
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
	});
	$(".search-modal__phone").change(function(){
		let str = $(this).val();
		let tmp = str.replace(/\-/g,'');
		$(".search-modal__phone__clone").val(tmp);
	});
	
	$('.reserveCheckModal').click(function(){
		headerInitModal();
		$('.search-modal').modal('show')
	});
	$('.search-modal').on('keyup', '.search-modal__phone' , function(){
		let str = $(this).val();
		let tmp = str.replace(/\-/g,'');
		$(".search-modal__phone__clone").val(tmp);
	});
	$('.search-modal').on('keyup', '.search-modal__phone' , function(){
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
	});
	reserve = {
		name: $('.search-modal').find('.search-modal__name').val(),
		phone: $('.search-modal').find('.search-modal__phone__clone').val(),
	};
});//ready

function headerInitModal(){
	dataArr.length = 0;
	$('.search-modal').empty();
	$('.search-modal').append(`
			<div class="modal-dialog search-modal-dialog" style="margin: 10.75rem auto;max-width: 600px;">
			<div class="modal-content search-modal-content">
				<div class="modal-header">
					<h5 class="modal-title">予約確認</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body search-modal-body">
					<div class="form-group row" style="justify-content: flex-end;">
				<label for="" class="col-sm-2 col-form-label">Name</label>
				<div class="col-sm-4">
					<input class="form-control search-modal__name" type="text" placeholder="" value="guest239"/>
					</div>
					<label for="" class="col-sm-2 col-form-label">phone</label>
					<div class="col-sm-4">
						<input class="form-control search-modal__phone" type="text" placeholder="" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"/>
						<input class="form-control search-modal__phone__clone" type="hidden" placeholder="" value="41" style="display: none;"/>
					</div>
				</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary search-modalModifyBtn" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary search-modalListBtn">List</button>
					<button type="button" class="btn btn-primary search-modalSearchBtn">Search</button>
				</div>
			</div>
		</div>
		`);
}
function bodyGetDataModal(datas){
	$('.search-modal').find('.search-modalListBtn').hide();
	console.log(datas);
	$('.search-modal-content').animate({width: '900px'});
	$('.search-modal-body').animate({height: '620px'});
	$('.search-modal-dialog').animate({marginLeft: '31%',margin: '5.75rem auto'});
	$('.search-modal-content').animate({margin: '0 auto'});
	$('.search-modal-body').css('display','flex');
	$('.search-modal-body').css('flex-direction','column');
	$('.search-modal-body').css('justify-content','space-evenly');
	$('.search-modal-body').css('align-items','stretch');
	let originSearchModalBody = $('.search-modal').find('.search-modal-body').find('.form-group').detach();
	$('.search-modal').find('.search-modal-body').append(
		'<div class="table-responsive-lg"><table class="table table-hover">'
	);
	$('.search-modal').find('.search-modal-body').find('.table').append(
			'<thead>'+
				'<tr>'+
					'<th scope="col" style="border-top: 0px !important;">Room</th>'+
					'<th scope="col"  style="border-top: 0px !important;">Date</th>'+
					'<th scope="col"  style="border-top: 0px !important;">Cost</th>'+
					'<th scope="col" style="border-top: 0px !important;">RegDate</th>'+
				'</tr>'+
			'</thead>'
	);
	$('.search-modal').find('.search-modal-body').find('.table').append(
				'<tbody style="border-top: none;">'+
				'</tbody>'+
			'</table>'+
		'</div>'
	);
	$.each(datas.dtoList, function(i, data){
		//console.log(data)
		let json = new Object();
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
   		json.color =data[0].colorCd;
   		dataArr.push(json);
		//console.log(data)
		//console.log(dataArr)
		$('.search-modal').find('.search-modal-body').find('.table').find('tbody').append(
			'<tr data-trReserveNo='+data[0].no+'>'+
				'<th class="result__no" scope="row" style="display: flex; align-items: center;">'+data[1].roomNum+'号室'+
				'<span class="dot span__colorCd" style="height: 15px; width: 15px; background-color:'+ data[1].colorCd +'; border-radius: 50%; display: inline-block; border: 0.5px solid;"></span></th>'+
				'<td class="result__title">'+moment(data[0].startDate).format('YYYY/MM/DD')+'~'+moment(data[0].endDate).format('YYYY/MM/DD')+'</td>'+
				'<td class="result__buildCd">'+data[0].totalCost.toLocaleString('ja-JP')+'(<i class="fas fa-male"></i>:'+data[0].adult+'/<i class="fas fa-child"></i>:'+data[0].child+')</td>'+
				'<td class="result__createdAt">'+moment(data[0].createdAt).format('YYYY年MM月DD日')+'</td>'+
			'</tr>'
		);
	});
	$('.search-modal').find('.search-modal-body').append(
			'<ul class="pagination pagination-sm h-100 justify-content-center align-items-center"></ul>'
	);
	if(datas.prev){
		$('.search-modal').find('.search-modal-body').find('.pagination').append(
			'<li class="page-item" ><span class="page-link" data-modalHeadPage="'+datas.start-1+'">&laquo;</span></li>'
        )
	}
    $.each(datas.pageList, function(i, pages){
		$('.search-modal').find('.search-modal-body').find('.pagination').append(
            '<li class="page-item"><span class="page-link" data-modalHeadPage="'+ pages +'">'+pages+'</span></li>'
        )
	});
    if(datas.next){
		$('.search-modal').find('.search-modal-body').find('.pagination').append(
            '<li class="page-item"><span class="page-link" data-modalHeadPage="'+datas.end+1+'">&raquo;</span></li>'	
		)
    }
}

function initheadCaledarModal(amount, dataArr, data){
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
	var calendarEl = $('.search-modal').find('.search-modal-content').find('.modal-calendar').find('.search-modalBodyCalendar')[0];
		var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth',
		initialDate: moment(data[0][0].startDate).format('YYYY-MM-DD'),
		dayMaxEvents: true, // allow "more" link when too many events
		contentHeight: 400,
		height: 500,
		aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
		events: dataArr,
	    dayMaxEvents: true,
		});
		calendar.render();
}

//close modal
$('.search-modal').on('click', '.modal-footer .btn-secondary, .close', function(){
	$('.search-modal-dialog').css('max-width','600px');
	$('.search-modal').modal('hide');
});

$('.search-modal').on('click', '.close' , function(){
	$('.search-modal-dialog').css('max-width','600px');
	
	$('.search-modal').modal('hide');
});


//search
$('.search-modal').on('click', '.search-modalSearchBtn, .search-modalListBtn' , function(){
	if($('.search-modal').find('.search-modal__name').val() !== undefined){
		reserve = {
				name: $('.search-modal').find('.search-modal__name').val(),
				phone: $('.search-modal').find('.search-modal__phone__clone').val(),
			};
	}
	let searchmodalListBtn = $(this)
	$('.search-modal').find('.search-modal-content').find('.modal-calendar').empty();
	
	//console.log(reserve)
	$.ajax({
		url: '/api/getReserve/search',
		method: 'post',
		data: JSON.stringify(reserve),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		success: function(datas){
			if(searchmodalListBtn.hasClass('search-modalListBtn')){
				bodyGetDataModal(datas);
			} else if(datas.dtoList.length !== 0) {
				$('.search-modal').find('.search-modalSearchBtn').hide();
				$('.search-modal').find('.search-modalListBtn').hide();
				bodyGetDataModal(datas);
				$('.colorMark').css('background-color', "#2ed573")
				$('.toast').css('z-index','2560');
				$('.toast').css('right','2%');
				$('.toast').toast('show')
				$('.toast-body').text(datas.dtoList.length + "건의 예약이 검색되었습니다.");
				$('.mr-auto').text("Success");
				
			} else if(datas.dtoList.length === 0) {
				$('.colorMark').css('background-color', "#ff4757")
				$('.toast').css('z-index','2560');
				$('.toast').css('right','2%');
				$('.toast').toast('show')
				$('.toast-body').text("일치하는 사용자가 없습니다.");
				$('.mr-auto').text("Fail");
				$('.search-modal').find('.search-modal__name').select();
			}
		}
	});
});

//paging
$('.search-modal').on('click', '.page-link', function(){
	$('.search-modal').find('.search-modal-body').empty();
	console.log($(this).attr('data-modalheadpage'))
	let modalHeadPage = $(this).attr('data-modalheadpage');
	let reserveAndPage = {
		name: reserve.name,
		phone: reserve.phone,
		page: $(this).attr('data-modalheadpage'),
	}
	//console.log(reserveAndPage);
	$.ajax({
		url: '/api/getReserve/search',
		method: 'post',
		data: JSON.stringify(reserveAndPage),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		success: function(datas){
			//console.log(datas)
			bodyGetDataModal(datas);
		}
	});
});

$('.search-modal').on('click', 'td', function(){
	let trReserveNo = $(this).closest('tr').attr('data-trreserveno');
	console.log(trReserveNo);
	let reserveAndPage = {
			name: reserve.name,
			phone: reserve.phone,
		}
		console.log(reserveAndPage);
		$.ajax({
			url: '/api/getReserve/search/'+trReserveNo,
			method: 'post',
			data: JSON.stringify(reserveAndPage),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(data){
				
				
				
				$('.search-modal').find('.search-modalListBtn').show();
				$('.search-modal-body').animate({height: '130px'});
				console.log(data);
				document.querySelector('.search-modal-body').innerHTML = `
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
				`;
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
					$('.search-modal').find('.detail__totalPrice').val(data[0][0].totalCost.toLocaleString('ja-JP'));
					$('.search-modal').find('.detail__count-adult').val(data[0][0].adult);
					$('.search-modal').find('.detail__count-child').val(data[0][0].child);
					$('.search-modal').find('.start').val(moment(data[0][0].startDate).format('YYYY年MM月DD日'));
					$('.search-modal').find('.end').val(moment(data[0][0].endDate).format('YYYY年MM月DD日'));
					$('.search-modal').find('.modal-header').html(`<h5 class="modal-title search-detail__romNum"></h5>
					<label for="" class="col-sm-1 col-form-label "></label>
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
					</button>`);
					$('.search-modal').find('.search-detail__romNum').text(data[0][1].roomNum +"号室");
					$('.search-modal').find('.customer').val(data[0][0].name);
					$('.search-modal').find('.phone').val( data[0][0].phone.replace(/[^0-9]/g, "").replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3") );
					$('.search-modal').find('.regDate').val(moment(data[0][0].createdAt).format('YYYY年MM月DD日'));
					
					$('.search-modal').find('input').attr('disabled', true);
					$('.search-modal').find('select').attr('disabled', true);
					$('.search-modal').find('input').css('background-color','#fff');
					$('.search-modal').find('input').css('border','none');
					$('.search-modal').find('select').css('background-color','#fff');
					$('.search-modal').find('select').css('border','none');
					$('.search-modal').find('.search-modal-content').find('.modal-calendar').find('.search-modalBodyCalendar').css('margin','0 auto');
				}, 50);
				$('.search-modal-dialog').animate({marginLeft: '31%',margin: '3.75rem auto'});
				$('.search-modal').find('.modal-footer').before('<div class="modal-calendar style="display: flex;flex-shrink: 0;align-items: center;justify-content: space-between;padding: 1rem 1rem;border-bottom: 1px solid #dee2e6;border-top-left-radius: calc(0.3rem - 1px);border-top-right-radius: calc(0.3rem - 1px);margin: 30px 0 0 0;">'+
					'<div class="search-modalBodyCalendar" style="width: 95%"></div></div>')
				initheadCaledarModal(amount, dataArr, data)
			}
		});
});//
</script>

