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
                        <li class="nav-item"><a class="nav-link adminLink" href="javascript:void(0);">Admin</a></li>
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
console.log(window.location.pathname)
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

let flag = "${sessionScope.loginFlg}";
let inteFlag = "${interceptorMsg}";
console.log(flag)
console.log(inteFlag)
$('.adminLink').click(function(){
	$('.search-modal').empty();
	if(flag === "0"){
		
		$('.search-modal').append(`
				<div class="modal-dialog search-modal-dialog" style="margin: 10.75rem auto;width: 600px;">
				<div class="modal-content search-modal-content" style="width: 600px;">
					<div class="modal-header">
						<h5 class="modal-title">Login</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body search-modal-body">
						<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-4">
						<input class="form-control search-modal__username" type="text" placeholder=""/>
						</div>
						<label for="" class="col-sm-2 col-form-label">password</label>
						<div class="col-sm-4">
							<input class="form-control search-modal__password" type="password"/>
						</div>
					</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary login-modalLoginBtn">Login</button>
					</div>
				</div>
			</div>
		`);
		$('.search-modal').modal('show');
	} else {
		location.href = "/admin";
	}
});

if(inteFlag === "0"){
	$('.search-modal').empty();
	if(flag === "0"){
		
		$('.search-modal').append(`
				<div class="modal-dialog search-modal-dialog" style="margin: 10.75rem auto;width: 600px;">
				<div class="modal-content search-modal-content" style="width: 600px;">
					<div class="modal-header">
						<h5 class="modal-title">Login</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body search-modal-body">
						<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-4">
						<input class="form-control search-modal__username" type="text" placeholder=""/>
						</div>
						<label for="" class="col-sm-2 col-form-label">password</label>
						<div class="col-sm-4">
							<input class="form-control search-modal__password" type="password"/>
						</div>
					</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary login-modalLoginBtn">Login</button>
					</div>
				</div>
			</div>
		`);
		$('.search-modal').modal('show');
	} else {
		location.href = "/admin";
	}
}


$('.search-modal').on('click', '.login-modalLoginBtn', function(){
	submit('/main', 'POST', [
	    { name: 'name', value: $('.search-modal__username').val() },
	    { name: 'passwd', value: $('.search-modal__password').val() },
	]);
});

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

//처음 예약 확인 클릭 시 inner setting
function headerInitModal(){
	dataArr.length = 0;
	$('.search-modal').empty();
	$('.search-modal').append(`
			<div class="modal-dialog search-modal-dialog" style="margin: 10.75rem auto;width: 600px;">
			<div class="modal-content search-modal-content" style="width: 600px;">
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
					<button type="button" class="btn btn-primary search-modalListBtn" style="display: none;">List</button>
					<button type="button" class="btn btn-primary search-modalSearchBtn">Search</button>
				</div>
			</div>
		</div>
		`);
}

//검색 후 데이터 있을 시 테이블 생성
function bodyGetDataModal(datas){
	$('.search-modal').find('.search-modalListBtn').hide();
	//console.log(datas);
	$('.search-modal-content').animate({width: '900px'});
	$('.search-modal-body').animate({height: '580px'});
	$('.search-modal-body').css('border-bottom', 'none;')
	$('.search-modal-body').css('margin-bottom', '0px')
	$('.search-modal-body').css('padding', '1rem')
	$('.search-modal-dialog').css('transform:' ,' translateX(calc(-40%))');
	$('.search-modal-dialog').css('width' ,'900px !important');
	$('.search-modal-dialog').css('margin' ,'5.75rem 5.75rem 5.75rem 25%');
	$('.search-modal-dialog').animate({margin: '5.75rem 5.75rem 5.75rem 25%'});
	$('.search-modal-content').animate({margin: '0 auto'});
	$('.search-modal-body').css('display','flex');
	$('.search-modal-body').css('flex-direction','column');
	$('.search-modal-body').css('justify-content','space-evenly');
	$('.search-modal-body').css('align-items','stretch');
	let originSearchModalBody = $('.search-modal').find('.search-modal-body').find('.form-group').detach();
	$('.search-modal').find('.search-modal-body').append(
		'<div class="table-responsive-lg"><table class="table table-hover">'
	);
	
	$('.search-modal').find('.modal-header').html(
			'<h5 class="modal-title search-detail__romNum">'+datas.dtoList[0][0].name+'</h5>'+
			'<label for="" class="col-sm-4 col-form-label">顧客様の予約リスト</label>'+
			'<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
				'<span aria-hidden="true">&times;</span>'+
			'</button>'
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
		if(data[0].deleteFlg === '0'){
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
	   		json.color =data[1].colorCd;
	   		dataArr.push(json);
		}
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

//상세 보기 시 fullcalendar
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
		dayMaxEvents: false, // allow "more" link when too many events
		contentHeight: 400,
		height: 500,
		aspectRatio: 3,  // see: https://fullcalendar.io/docs/aspectRatio
		events: dataArr,
		});
		calendar.render();
}
//상세 보기 클릭 시 주문 상태 버튼에 저장
function buttonFlgSetting(data){
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-deleteFlg', data[0][0].deleteFlg)
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-cancelFlg', data[0][0].cancelFlg)
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-paymentFlg', data[0][0].paymentFlg)
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-reserveNo', data[0][0].no)
}

//상세 보기 
function searchedSpecificData(data, dataArr){
	$('.search-modal').find('.search-modalListBtn').show();
	$('.search-modal-body').animate({height: '145px'});
	$('.search-modal-body').css('border-bottom', '1px solid #8080804a')
	$('.search-modal-body').css('margin-bottom', '10px')
	$('.search-modal-body').css('padding', '0px 1rem 0px 1rem')
	//console.log(data);
	$('.search-modal').find('.search-modal-body').html(
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
	if(data[0][0].paymentFlg === '0' && data[0][0].cancelFlg === '0' && data[0][0].deleteFlg === '0'){
		$('.search-modal').find('.search-modal-body').find('.headModal-secondTr').append(
			'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제대기중</label>'+
			'<div class="col-sm-2"><button type="button" class="btn btn-success search-modalPaymentBtn">결제</button></div>'
		);
		buttonFlgSetting(data)
	}
	if(data[0][0].paymentFlg === '1'){
		$('.search-modal').find('.search-modal-body').find('.headModal-secondTr').append(
			'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">결제완료</label>'+
			'<div class="col-sm-2"><button type="button" class="btn btn-danger search-modalCancelBtn">주문취소</button></div>'
		);
		buttonFlgSetting(data)
	}
	if(data[0][0].cancelFlg === '1' && data[0][0].paymentFlg === '0'){
		$('.search-modal').find('.search-modal-body').find('.headModal-secondTr').append(
			'<label for="" class="col-sm-1 col-form-label" style="background-color: #dfe6e9;border-radius: 5px;">Status</label><label for="" class="col-sm-2 col-form-label">취소됨</label>'+
			'<div class="col-sm-2"><button type="button" class="btn btn-danger search-modalDeleteBtn">삭제</button><button type="button" class="btn btn-success search-modalPaymentBtn">결제</button></div>'
		);
		buttonFlgSetting(data)
	}
	if(data[0][0].deleteFlg === '1'){
		$('.search-modal').find('.search-modal-body').find('.headModal-secondTr').append(
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
		$('.search-modal').find('.detail__totalPrice').val(data[0][0].totalCost.toLocaleString('ja-JP'));
		$('.search-modal').find('.detail__count-adult').val(data[0][0].adult);
		$('.search-modal').find('.detail__count-child').val(data[0][0].child);
		$('.search-modal').find('.start').val(moment(data[0][0].startDate).format('YYYY/MM/DD'));
		$('.search-modal').find('.end').val(moment(data[0][0].endDate).format('YYYY/MM/DD'));
		$('.search-modal').find('.modal-header').html('<h5 class="modal-title search-detail__romNum"></h5>'+
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
	$('.search-modal-dialog').animate({margin: '1.75rem 3.75rem 3.75rem 25%'});
	$('.search-modal').find('.modal-footer').before('<div class="modal-calendar style="display: flex;flex-shrink: 0;align-items: center;justify-content: space-between;padding: 1rem 1rem;border-bottom: 1px solid #dee2e6;border-top-left-radius: calc(0.3rem - 1px);border-top-right-radius: calc(0.3rem - 1px);margin: 30px 0 0 0;">'+
		'<div class="search-modalBodyCalendar" style="width: 95%"></div></div>')
		//console.log(amount)
		//console.log(dataArr)
		//console.log(data)
	initheadCaledarModal(amount, dataArr, data)
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
	$('.search-modal').find('.modal-footer').find('.search-modalListBtn').show();
	
	//console.log(reserve)
	$.ajax({
		url: '/api/getReserve/search',
		method: 'post',
		data: JSON.stringify(reserve),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		success: function(datas){
			if(searchmodalListBtn.hasClass('search-modalListBtn')){
				dataArr.length = 0;
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
	//console.log($(this).attr('data-modalheadpage'))
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
		dataArr.length = 0;
});

//detail
$('.search-modal').on('click', 'td', function(){
	let trReserveNo = $(this).closest('tr').attr('data-trreserveno');
	//console.log(trReserveNo);
	let reserveAndPage = {
			name: reserve.name,
			phone: reserve.phone,
		}
		//console.log(reserveAndPage);
		$.ajax({
			url: '/api/getReserve/search/'+trReserveNo,
			method: 'post',
			data: JSON.stringify(reserveAndPage),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(data){
				searchedSpecificData(data, dataArr)
			}
		});
});//


//Modify status
$('.search-modal').on('click','.search-modal-body .btn', function(){
	//console.log($(this))
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-deleteFlg')
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-cancelFlg')
	$('.search-modal').find('.search-modal-body').find('.btn').attr('data-paymentFlg')
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
			dataArr.length = 0;
			//console.log(datas)
			let json = new Object();
			$.each(datas , function (i, data){
				if(data[0].deleteFlg === '0'){
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
			   		dataArr.push(json);
				}
			});
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
			//console.log(dataArr)
			searchedSpecificData(datas, dataArr)
			initheadCaledarModal(amount, dataArr, datas);
		}
	}); 
});


</script>

