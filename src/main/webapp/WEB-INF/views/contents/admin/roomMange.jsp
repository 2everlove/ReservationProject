<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />

<style>
	.sortable {display: -webkit-box; list-style-type: none; margin: 0; padding: 0; }
	.sortable li {background-color: #fff; border: 1px solid #ccc; border-radius: 5px; float: left; margin: 5px 20px 0 0; padding: 2px; width: 150px; height: 150px; line-height: 150px; position: relative;}
	.sortable li .ui-selected {background: red;}
	.sortable li .highlight {border: 1px dashed #000; width: 150px; background-color: #ccc; border-radius: 5px;}
	.sortable li span { position: absolute; margin:1em 0 0 1em; background-color: black; color: white; width: 15px; height: 25px; text-align: center;}
	.sortable li .delete-btn {width: 24px; border: 0; position: absolute; top: -12px; right: -14px;}
</style>
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
				<div class="form-group row" style="align-items: center;">
					<h2 class="col-sm-10 title">RoomManage</h2>
					<div class="col-sm-2">
						<button type="button" class="form-control btn btn-primary result__register btn-sm">Register</button>
					</div>
				</div>
					<hr/>
					<div class="table-responsive-lg">
						<table class="table table-hover">
							<thead class="tHead">
								<tr class="newTemplate">
									<th scope="col" style="border-top: 0px !important; max-width: 150px !important; width: 0px !important;"></th>
									<th scope="col" style="border-top: 0px !important;" colspan="2">RoomNo</th>
									<th scope="col" style="border-top: 0px !important;">Title</th>
									<th scope="col" style="border-top: 0px !important;">Content</th>
									<th scope="col" style="border-top: 0px !important;">Max</th>
									<th scope="col" style="border-top: 0px !important;">Adult</th>
									<th scope="col" style="border-top: 0px !important;">Child</th>
									<th scope="col" style="border-top: 0px !important;">Floor</th>
									<th scope="col" style="border-top: 0px !important;">Delete</th>
									<th scope="col" class="result__regDate" style="border-top: 0px !important;">RegDate</th>
									<th scope="col" style="border-top: 0px !important;"></th>
								</tr>
							</thead>
							<tbody class="baseLine"></tbody>
							<%-- <tbody>
								<tr data-room="${i.count}">
									<td style="max-width: 150px !important; width: 0px !important;">
										<img src="" class="thumbnail" height=50 width=100>
									</td>
									<th scope="row" class="td-result__roomNum" style="max-width: 150px !important;">
										<span class="span__roomNum" style="display: none;"> </span> <span style="display: none;">&nbsp;</span>
										<input type="text" class="form-control result__roomNum" value="" style="max-width: 150px !important;">
										<input type="hidden" class="form-control result__roomNo" value="">
										<span class="dot span__colorCd" style="height: 15px; width: 15px; background-color: #fffff; border-radius: 50%; display: none; border: 0.5px solid;"></span>
									</th>
									<td>
										<input type="color" class="form-control result__color" value="" style="">
									</td>
									<td class="td-result__title"><span class="span__roomTitle" style="display: none;"> </span>
										<input type="text" class="form-control result__title" value="" style="">
									</td>
									<td class="td-result__explanation">
										<span class="span__explanation" style="display: none;"></span>
										<input type="text" class="form-control result__explanation" value="" style="">
									</td>
									<td class="td-result__max">
										<span class="span__max" style="display: none;"></span>
										<input type="text" class="form-control result__max" value="" style="max-width: 80px;">
									</td>
									<td class="td-result__adultCost">
										<span class="span__adultCost" style="display: none;"></span>
										<input type="text" class="form-control result__adultCost" value="" style="">
									</td>
									<td class="td-result__childCost">
										<span class="span__childCost" style="display: none;"></span>
										<input type="text" class="form-control result__childCost" value="" style="">
									</td>
									<td class="td-result__buildCd">
										<span class="span__buildCd" style="display: none;"></span>
										<select class="form-select result__buildCd" aria-label="Default select example" style="min-width: 70px;">
											<option value=''>---</option>
										</select>
									</td>
									<td class="ts-result__deleteFlg">
										<span class="span__deleteFlg" style="display: none;"></span>
										<select class="form-select result__deleteFlg" style="min-width: 60px;">
											<option value="0">Y</option>
											<option value="1">N</option> 
										</select>
									</td>
									<td class="td-result__regDate"><span class="result__regDate"></span></td>
									<td class="group__btn">
										<button type="button" class="registerBtn btn-primary">追加</button>
									</td>
								</tr>
								<tr class="imagesShowing__new" onmouseover="loadSoratables(this)" data-file="" style="">
									<td class="" colspan="12">
										<ul class="sortable imageOrder__new"></ul>
									</td>
								</tr>
								<tr class="fileUpload__new" style="align-items: center !important; min-width: 350px;">
									<td colspan="12" style="padding: 0 ">
										<input data-file="new" type="file" class="form-control fileUpload" onchange="readInputFile(this)" multiple="multiple" max="4" style=" max-width: 300px; margin: 0; display: inline-block;">
										<input type="hidden" class="form-control result__sort order" style=" max-width: 200px; margin: 0; display: inline-block;">
									</td>
								</tr>
							</tbody> --%>
							
							<c:forEach var="dto" items="${result.dtoList}" varStatus="i">
								<tbody>
								<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
								<fmt:formatDate value="${regDate}" var="reg" pattern="yyyy/MM/dd"/>
								<fmt:formatDate value="${regDate}" var="regTime" pattern="HH:mm:ss"/>
									<tr data-room="${i.count}">
										<td style="max-width: 150px !important; width: 0px !important;">
											<c:url value="/api/display" var="firstImage">
												<c:param name="fileName" value="${dto.images[0]}"></c:param>
											</c:url>
											<img src="${firstImage }" class="thumbnail" height=50 width=100>
										</td>
										<th scope="row" class="td-result__roomNum" style="max-width: 150px !important;">
											<span class="span__roomNum">${dto.roomNum } </span> <span>&nbsp;</span>
											<input type="text" class="form-control result__roomNum" value="${dto.roomNum }" style="display: none; max-width: 150px !important;">
											<input type="hidden" class="form-control result__roomNo" value="${dto.no }">
											<span class="dot span__colorCd" style="height: 15px; width: 15px; background-color: ${dto.colorCd}; border-radius: 50%; display: inline-block; border: 0.5px solid;"></span>
										</th>
										<td>
											<input type="color" class="form-control result__color" value="${dto.colorCd}" style="display: none;">
										</td>
										<td class="td-result__title"><span class="span__roomTitle">${dto.roomTitle }</span>
											<input type="text" class="form-control result__title" value="${dto.roomTitle }" style="display: none;">
											<c:if test="${nowDate == reg}">&nbsp;&nbsp;<i class="fas fa-plus-square"></i></c:if>
											<c:if test="${dto == '1'}">&nbsp;&nbsp;<i class="fas fa-lock"></i></c:if>
										</td>
										<td class="td-result__explanation">
											<span class="span__explanation"><c:out value="${fn:length(dto.explanation) > 5 ? fn:substring(dto.explanation,0,5) : dto.explanation}"/><c:out value="${fn:length(dto.explanation) > 5 ? '...' : ''}"/></span>
											<input type="text" class="form-control result__explanation" value="${dto.explanation }" style="display: none;">
										</td>
										<td class="td-result__max"><span class="span__max">${dto.max }</span><input type="text" class="form-control result__max" value="${dto.max }" style="display: none; max-width: 80px;"></td>
										<td class="td-result__adultCost"><span class="span__adultCost">${dto.adultCost }</span><input type="text" class="form-control result__adultCost" value="${dto.adultCost }" style="display: none;"></td>
										<td class="td-result__childCost"><span class="span__childCost">${dto.childCost }</span><input type="text" class="form-control result__childCost" value="${dto.childCost }" style="display: none;"></td>
										<td class="td-result__buildCd"><span class="span__buildCd">${dto.buildCd }</span>
											<select class="form-select result__buildCd" aria-label="Default select example" style="display: none; min-width: 70px;">
											<option value=''>---</option>
											<c:forEach items="${buildCdList}" var="buildCd">
												<option value="${buildCd}" <c:if test ="${dto.buildCd eq buildCd}">selected</c:if>>${buildCd }層</option>
											</c:forEach>
										</select>
										</td>
										<td class="ts-result__deleteFlg"><span class="span__deleteFlg">
											${dto.deleteFlg }</span><select class="form-select result__deleteFlg" style="display: none; min-width: 65px;">
												<option value="0" <c:out value="${dto.deleteFlg == 0 ? 'selected':''}"></c:out>>N</option>
												<option value="1" <c:out value="${dto.deleteFlg == 1 ? 'selected':''}"></c:out>>Y</option> 
										</select></td>
										<td class="result__regDate"><c:out value="${nowDate == reg ? regTime : reg}"></c:out></td>
										<td class="group__btn">
											<button type="button" class="modify btn-primary">修正</button>
											<button data-confirm=${i.count } type="button" class="confirm btn-success" style="display: none;">確認</button>
											<button data-cancel=${i.count } type="button" class="cancel btn-danger" style="display: none;">戻る</button>
										</td>
										
									</tr>
									<tr class="tr-sortable imagesShowing__${i.count}" onmouseover="loadSoratables(this)" data-file="${i.count}" style="display: none;">
										<td class="" colspan="12"><ul class="sortable imageOrder__${i.count}">
											<c:forEach var="img" items="${dto.images }" varStatus="imageNo">
												<c:url value="/api/display" var="imagesUrl">
													<c:param name="fileName" value="${img}"></c:param>
												</c:url>
												<li file="${img }" item="${imageNo.count-1}" class="img-thumb${imageNo.count-1 }">
													<img src="${imagesUrl}" height=150 width=150/>
													<a href = '#' class = 'delete_image' title='Cancel' data-name=${imagesUrl }><img class = 'delete-btn' src = 'https://w7.pngwing.com/pngs/776/921/png-transparent-x-mark-check-mark-scalable-graphics-computer-file-red-cross-mark-red-x-illustration-miscellaneous-angle-hand.png' /></a>
												</li>
												
											</c:forEach>
										</ul></td>
									</tr>
									<tr class="tr-fileUpload fileUpload__${i.count}" style="align-items: center !important; display: none; min-width: 350px;">
										<td colspan="12" style="padding: 0 ">
											<input data-file="${i.count}" type="file" class="form-control fileUpload" onchange="readInputFile(this)" multiple="multiple" max="4" style=" max-width: 300px; margin: 0; display: inline-block;">
											<input type="hidden" class="form-control result__sort order${i.count}" style=" max-width: 200px; margin: 0; display: inline-block;">
										</td>
									</tr>
								</tbody>
								
							</c:forEach>
						</table>
						<ul class="pagination pagination-sm h-100 justify-content-center align-items-center">
							<c:if test="${result.prev}">
					            <li class="page-item" >
					                <a class="page-link" href="/admin/roomManage?page=${result.start -1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}" tabindex="-1">&laquo;</a>
					            </li>
							</c:if>
							<c:forEach var="page" items="${result.pageList}">
					            <li class="page-item ${result.page == page? 'active':''}">
					                <a class="page-link" href="/admin/roomManage?page=${page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">
					                    ${page}
					                </a>
					            </li>
				            </c:forEach>
							<c:if test="${result.next}">
					            <li class="page-item">
					                <a class="page-link" href="/admin/roomManage?page=${result.end + 1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">&raquo;</a>
					            </li>
				            </c:if>
				        </ul>
					</div>
				</div>
				


				<div id="preview"></div>
			</section>
		</div>
	</div>
<script type="text/javascript">
let storedFiles = [];

$(document).ready(function(){
	/* $('.result__title').closest('tr').click(function(){
		location.href = $(this).find('.result__no').attr('href')+'?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	}); */
	
	
	$('.result__no').text()
	let msg = '${msg}';
	if(msg !== undefined || msg !== null)
		console.log(msg);
});

$('.result__register').on('click', function(){
	$('.baseLine').fadeIn(200);
	document.querySelector('.baseLine').innerHTML = '';
	$('.tr-sortable').hide();
	$('.confirm').hide();
	$('.cancel').hide();
	$('.tr-fileUpload').hide();
	$('.modify').show();
	$('span').show();
	$('select').hide();
	$('input').hide();
	$('.result__regDate').hide();
	initHtml();
	//document.querySelector('.baseLine').appendChild(template.content);
	
	//location.href = '/admin/roomManage/register?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
});

//const template = document.createElement('template');

function initHtml(){
	document.querySelector('.baseLine').innerHTML = `
		<tr data-room="${i.count}">
	<td style="max-width: 150px !important; width: 0px !important;">
		<img src="" class="thumbnail" height=50 width=100>
	</td>
	<th scope="row" class="td-result__roomNum" style="max-width: 150px !important;">
		<span class="span__roomNum" style="display: none;"> </span> <span style="display: none;">&nbsp;</span>
		<input type="text" class="form-control result__roomNum" value="" style="max-width: 150px !important;">
		<input type="hidden" class="form-control result__roomNo" value="">
		<span class="dot span__colorCd" style="height: 15px; width: 15px; background-color: #fffff; border-radius: 50%; display: none; border: 0.5px solid;"></span>
	</th>
	<td>
		<input type="color" class="form-control result__color" value="" style="">
	</td>
	<td class="td-result__title"><span class="span__roomTitle" style="display: none;"> </span>
		<input type="text" class="form-control result__title" value="" style="">
	</td>
	<td class="td-result__explanation">
		<span class="span__explanation" style="display: none;"></span>
		<input type="text" class="form-control result__explanation" value="" style="">
	</td>
	<td class="td-result__max">
		<span class="span__max" style="display: none;"></span>
		<input type="text" class="form-control result__max" value="" style="max-width: 80px;">
	</td>
	<td class="td-result__adultCost">
		<span class="span__adultCost" style="display: none;"></span>
		<input type="text" class="form-control result__adultCost" value="" style="">
	</td>
	<td class="td-result__childCost">
		<span class="span__childCost" style="display: none;"></span>
		<input type="text" class="form-control result__childCost" value="" style="">
	</td>
	<td class="td-result__buildCd">
		<span class="span__buildCd" style="display: none;"></span>
		<select class="form-select result__buildCd" aria-label="Default select example" style="min-width: 70px;">
			<option value=''>---</option>
			<c:forEach items="${buildCdList}" var="buildCd">
				<option value="${buildCd}">${buildCd }層</option>
			</c:forEach>
		</select>
	</td>
	<td class="ts-result__deleteFlg">
		<span class="span__deleteFlg" style="display: none;"></span>
		<select class="form-select result__deleteFlg" style="min-width: 65px;">
			<option value="0">N</option>
			<option value="1">Y</option> 
		</select>
	</td>
	<td class="td-result__regDate" style="display:none;"><span class="result__regDate"></span></td>
	<td class="group__btn">
		<button type="button" class="registerBtn btn-success" data-confirm="new">追加</button>
		<button type="button" class="registerCancelBtn btn-danger" data-confirm="new">戻る</button>
	</td>
</tr>
<tr class="imagesShowing__new" onmouseover="loadSoratables(this)" data-file="" style="">
	<td class="" colspan="12">
		<ul class="sortable imageOrder__new"></ul>
	</td>
</tr>
<tr class="fileUpload__new" style="align-items: center !important; min-width: 350px;">
	<td colspan="12" style="padding: 0 ">
		<input data-file="new" type="file" class="form-control fileUpload" onchange="readInputFile(this)" multiple="multiple" max="4" style=" max-width: 300px; margin: 0; display: inline-block;">
		<input type="hidden" class="form-control result__sort ordernew" style=" max-width: 200px; margin: 0; display: inline-block;">
	</td>
</tr>
`;
}

$('.baseLine').on('click', '.registerCancelBtn', function(){
	$(this).closest('tbody').empty();
	$('.result__regDate').show();
});
	
let = tempDelete = '';
let deleteFiles = [];

function reload_order(e) {
	let findName = '.imageOrder__'+$(e).data('confirm');
	let hiddenFind = '.order'+$(e).data('confirm');
	/* console.log(findName)
	console.log($(e).closest('td')) */
	let hiddenOrder = $(e).closest('tbody').find(hiddenFind);
    let order = $(e).closest('tbody').find(findName).sortable('toArray', {attribute: 'item'});
    /* console.log("hiddenOrder: "+$(e).closest('tbody'))
    console.log("hiddenOrder: "+$(e).closest('tbody').find(hiddenFind))
    console.log("reload_order: "+$(e).closest('tbody').find(findName))
    */
    console.log("reload_order: "+order)
    $(hiddenOrder).val(order);
   }
function add_order(e) {
	console.log(e);
    e.children().each(function(n) {
    	//console.log(n);
    	//console.log($(this));
    	console.log($(this).attr('item'));
    	if($(this).attr('item') === undefined)
        	$(this).attr('item',n);
    		
    });
    console.log('test');
}


function loadSoratables(object){
	$(object).find('ul').sortable({ 
		cursor: 'move',
		placeholder:"highlight", /* 이동할 위치 css 적용 */ 
		start:function(event,ui){ 
			// 드래그 시작 시 호출 
			ui.item.toggleClass('highlight');
		}, 
		stop:function(event,ui){ 
			// 드래그 종료 시 호출 
			ui.item.toggleClass('highlight');
			reorder(); 
		},
		update: function () {
			
        },
        create:function(){
        	
        }
	});
}//

function initStoredFiles(e){
	let li = $(e).closest('tbody').find('.sortable li')
	li.each(function(n){
		//console.log($(this).attr('file'))
		storedFiles.push($(this).attr('file'));
	})
	console.log(storedFiles)
	
}

$('.baseLine').on('click', '.registerBtn', function(){
	reload_order($(this));
	console.log($(this));
    let formData = new FormData();
   	let tbody = $(this).closest('tbody');
	console.log(tbody);
    let items_array = $(this).closest('tbody').find('.result__sort').val();
    let sortable  = $(this).closest('tbody').find('.sortable li>img:eq(0)');
    //console.log( sortable);
    $(this).closest('tbody').find('.thumbnail').attr('src', sortable.attr('src'));
    console.log($(this).closest('tbody').find('.result__sort').val())
    console.log(items_array);
    //console.log(storedFiles);
    let items = items_array.split(',');
	console.log(items)
    for (let i in items){
        let item_number = items[i];
        console.log(item_number+" "+i)
       	formData.append('uploadFiles', storedFiles[item_number]);
        console.log("stored"+item_number +":"+storedFiles[item_number])
    }
	
	let formArr = formData.getAll('uploadFiles');
	
    console.log(storedFiles)
    console.log(formData.getAll('uploadFiles'))
    
    $.ajax({
    	url: '/api/uploadAjax',
		processData: false,
		contentType: false,
		data: formData,
		type: 'post',
		dataType: 'json',
		success: function(data){
			//$( "#sortable" ).sortable( "option", "disabled", true );
			console.log(data);
			let dataLength = 0;
			console.log(formArr)
			for(let i in formArr){
				//console.log(typeof(formArr[i]));
				if(typeof(formArr[i]) === 'object'){
					formArr[i] = data[dataLength].imageURL
					/* console.log(tbody);
					console.log(tbody.find('.sortable li'));
					console.log(tbody.find('.sortable li')[i]);
					console.log(tbody.find('.sortable li')[i].getAttribute('file')); */
					tbody.find('.sortable li')[i].setAttribute('file', data[dataLength].imageURL);
					dataLength++
				}
			}
			
			console.log(formArr);
			console.log("deleteFiles: "+deleteFiles);
			
			
			let roomInfo = {
				colorCd: tbody.find('.result__color').val(),
				roomTitle: tbody.find('.result__title').val(),
				roomNum: tbody.find('.result__roomNum').val(),
				max: tbody.find('.result__max').val(),
				adultCost: tbody.find('.result__adultCost').val(),
				childCost: tbody.find('.result__childCost').val(),
				explanation: tbody.find('.result__explanation').val(),
				images: formArr,
				buildCd: tbody.find('.result__buildCd option:selected').val(),
				deleteFlg: tbody.find('.result__deleteFlg option:selected').val(),
			}
			console.log(roomInfo);
			
			$.ajax({
				url: '/api/roomManage/register',
				method: 'post',
				data: JSON.stringify(roomInfo),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				success: function(data){
					console.log(data);
					tbody.find('.span__adultCost').text(data.adultCost);
					tbody.find('.span__buildCd').text(data.buildCd);
					tbody.find('.span__childCost').text(data.childCost);
					tbody.find('.span__colorCd').css('background-color', data.colorCd);
					tbody.find('.span__deleteFlg').text(data.deleteFlg);
					tbody.find('.span__explanation').text(data.explanation);
					tbody.find('.span__max').text(data.max);
					tbody.find('.span__roomNum').text(data.roomNum);
					tbody.find('.span__roomTitle').text(data.roomTitle);
					
					
					let tr = $(this).closest('tr');
					tbody.find('.confirm').hide();
					tbody.find('.modify').show();
					tbody.find('.cancel').hide();
					tbody.find('.fileUpload').val('');
					tbody.find('span').show();
					tbody.find('select').hide();
					tbody.find('input').hide();
					let data_tr = tbody.data('room');
					let imageTr = '.imagesShowing__'+data_tr;
					let fileTr = '.fileUpload__'+data_tr;
					let fileObject = $(fileTr);
					let imageTrObject = $(imageTr);
					$('.result__regDate').show();
					
					tbody.find('.tr-sortable').hide();
					tbody.find(fileObject).hide();
				}
			});
			
			
			$('.baseLine').removeClass('baseLine');
			let templateClone = tbody.clone();
			tbody.empty();
			tbody.addClass('baseLine');
			console.log(templateClone)
			$('table').append(templateClone)
			
			/* let afterTbody = document.createElement('template');
			template.innerHTML = `
				<tbody class="baseLine"></tbody>
			`;
			$('tHead').after(afterTbody.content); */
		}
    });
});//


$('.cancel').click(function(){
	document.querySelector('.baseLine').innerHTML = '';
	let tbody = $(this).closest('tbody');
	
	let tr = $(this).closest('tr');
	$(this).hide();
	$(this).closest('td').find('.modify').show();
	$(this).closest('td').find('.confirm').hide();
	$(this).closest('tbody').find('.fileUpload').val('');
	tr.find('span').show();
	tr.find('select').hide();
	tr.find('input').hide();
	let data_tr = tr.data('room');
	let imageTr = '.imagesShowing__'+data_tr;
	let fileTr = '.fileUpload__'+data_tr;
	let fileObject = $(fileTr);
	let imageTrObject = $(imageTr);
	$('.result__regDate').show();
	
	tbody.find('.sortable').append(tempDelete);
	imageTrObject.fadeOut(200);
	fileObject.fadeOut(200);
})

$('.modify').click(function(){
	$('.baseLine').fadeOut(200);
	document.querySelector('.baseLine').innerHTML = '';
	$('.tr-sortable').fadeOut(200);
	$('.tr-fileUpload').fadeOut(200);
	$('span').show();
	$('select').hide();
	$('input').hide();
	$('.modify').show();
	$('.confirm').hide();
	$('.cancel').hide();
	storedFiles.length = 0;
	initStoredFiles($(this));
	let tr = $(this).closest('tr');
	$(this).hide();
	$(this).closest('td').find('.confirm').show();
	$(this).closest('td').find('.cancel').show();
	tr.find('span').hide();
	tr.find('select').show();
	tr.find('input').show();
	let data_tr = tr.data('room');
	let imageTr = '.imagesShowing__'+data_tr;
	let fileTr = '.fileUpload__'+data_tr;
	let fileObject = $(fileTr);
	let imageTrObject = $(imageTr);
	$('.result__regDate').hide();
	imageTrObject.fadeIn(200);
	fileObject.fadeIn(200);
});

$('.confirm').click(function(){
	document.querySelector('.baseLine').innerHTML = '';
    reload_order($(this));
   
    let formData = new FormData();
   	let tbody = $(this).closest('tbody');
    let items_array = $(this).closest('tbody').find('.result__sort').val();
    let sortable  = $(this).closest('tbody').find('.sortable li>img:eq(0)');
    //console.log( sortable);
    $(this).closest('tbody').find('.thumbnail').attr('src', sortable.attr('src'));
    console.log($(this).closest('tbody').find('.result__sort').val())
    console.log(items_array);
    //console.log(storedFiles);
    let items = items_array.split(',');
	console.log(items)
    for (let i in items){
        let item_number = items[i];
        console.log(item_number+" "+i)
       	formData.append('uploadFiles', storedFiles[item_number]);
        console.log("stored"+item_number +":"+storedFiles[item_number])
    }
	
	let formArr = formData.getAll('uploadFiles');
	
    console.log(storedFiles)
    console.log(formData.getAll('uploadFiles'))
    
    $.ajax({
    	url: '/api/uploadAjax',
		processData: false,
		contentType: false,
		data: formData,
		type: 'post',
		dataType: 'json',
		success: function(data){
			//$( "#sortable" ).sortable( "option", "disabled", true );
			console.log(data);
			let dataLength = 0;
			console.log(formArr)
			for(let i in formArr){
				//console.log(typeof(formArr[i]));
				if(typeof(formArr[i]) === 'object'){
					formArr[i] = data[dataLength].imageURL
					/* console.log(tbody);
					console.log(tbody.find('.sortable li'));
					console.log(tbody.find('.sortable li')[i]);
					console.log(tbody.find('.sortable li')[i].getAttribute('file')); */
					tbody.find('.sortable li')[i].setAttribute('file', data[dataLength].imageURL);
					dataLength++
				}
			}
			
			console.log(formArr);
			console.log("deleteFiles: "+deleteFiles);
			
			if(deleteFiles.length > 0){
				if(tbody.find('.ui-sortable-handle').length !== 0){
					$.post('//api/removeFile', {fileName: deleteFiles.join(',')}, function(result){
						console.log(result);
						deleteFiles.length = 0;
					}, "json");
				} else {
					alert('이미지를 전부 지울 수 없습니다.');
					tbody.find('.sortable').append(tempDelete);
					return false;
				}
			} 
			
			if(tbody.find('.result__roomNo').val() === ''){
				tbody.find('.result__roomNo').focus();
				return false;
			}
			if(tbody.find('.result__color').val() === ''){
				tbody.find('.result__color').focus();
				return false;
			}
			if(tbody.find('.result__title').val() === ''){
				tbody.find('.result__title').focus();
				return false;
			}
			if(tbody.find('.result__roomNum').val() === ''){
				tbody.find('.result__roomNum').focus();
				return false;
			}
			if(tbody.find('.result__max').val() === ''){
				tbody.find('.result__max').focus();
				return false;
			}
			if(tbody.find('.result__adultCost').val() === ''){
				tbody.find('.result__adultCost').focus();
				return false;
			}
			if(tbody.find('.result__childCost').val() === ''){
				tbody.find('.result__childCost').focus();
				return false;
			}
			if(tbody.find('.result__explanation').val() === ''){
				tbody.find('.result__explanation').focus();
				return false;
			}
			if(tbody.find('.result__buildCd').val() === ''){
				tbody.find('.result__buildCd').focus();
				return false;
			}
			if(tbody.find('.result__buildCd').val() === ''){
				tbody.find('.result__buildCd').focus();
				return false;
			}
			if(tbody.find('.result__deleteFlg').val() === ''){
				tbody.find('.result__deleteFlg').focus();
				return false;
			}
			if(formArr.length === 0){
				alert('이미지를 업로드 해주세요');
				return false;
			}
			
			
			let roomInfo = {
					no: tbody.find('.result__roomNo').val(),
					colorCd: tbody.find('.result__color').val(),
					roomTitle: tbody.find('.result__title').val(),
					roomNum: tbody.find('.result__roomNum').val(),
					max: tbody.find('.result__max').val(),
					adultCost: tbody.find('.result__adultCost').val(),
					childCost: tbody.find('.result__childCost').val(),
					explanation: tbody.find('.result__explanation').val(),
					images: formArr,
					buildCd: tbody.find('.result__buildCd option:selected').val(),
					deleteFlg: tbody.find('.result__deleteFlg option:selected').val(),
			}
			console.log(roomInfo);
			$.ajax({
				url: '/api/roomManage',
				method: 'post',
				data: JSON.stringify(roomInfo),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				success: function(data){
					console.log(data);
					tbody.find('.span__adultCost').text(data.adultCost);
					tbody.find('.span__buildCd').text(data.buildCd);
					tbody.find('.span__childCost').text(data.childCost);
					tbody.find('.span__colorCd').css('background-color', data.colorCd);
					tbody.find('.span__deleteFlg').text(data.deleteFlg);
					tbody.find('.span__explanation').text(data.explanation);
					tbody.find('.span__max').text(data.max);
					tbody.find('.span__roomNum').text(data.roomNum);
					tbody.find('.span__roomTitle').text(data.roomTitle);
					
					
					let tr = $(this).closest('tr');
					tbody.find('.confirm').hide();
					tbody.find('.modify').show();
					tbody.find('.cancel').hide();
					tbody.find('.fileUpload').val('');
					tbody.find('span').show();
					tbody.find('select').hide();
					tbody.find('input').hide();
					let data_tr = tbody.data('room');
					let imageTr = '.imagesShowing__'+data_tr;
					let fileTr = '.fileUpload__'+data_tr;
					let fileObject = $(fileTr);
					let imageTrObject = $(imageTr);
					$('.result__regDate').show();
					
					tbody.find('.tr-sortable').fadeOut(200);
					tbody.find(fileObject).fadeOut(200);
				}
			});
			
			
		}
    })
    
    
	
});

function validation(){
	
}


function reorder() { 
	$(".sortable li").each(function(i, box) {
		$(box).closest('li').find('span').text(i+1);
		$(box).val(i + 1); 
	}); 
}

function readInputFile(e){
	
	let sel_files = [];
    let sortObject = $('.imageOrder__'+$(e).data('file'));
    sel_files = [];
    //sortObject.empty();
    console.log(e.files)
    
    let files = e.files;
    let fileArr = Array.prototype.slice.call(files);
    let index = 0;
    
    fileArr.forEach(function(f){
    	//console.log(f);
    	if(!f.type.match("image/.*")){
        	alert("이미지 확장자만 업로드 가능합니다.");
            return;
        };
        if(files.length < 11){
        	storedFiles.push(f);
        	let reader = new FileReader();
            reader.onload = function(e){
            	//console.log(e.target)
            	let s = f.name.substring(0, f.name.indexOf('.'))
            	//console.log(s)
            	let html = "<li file = '" + f.name + "'>" +                                
                    "<img class = 'img-thumb' src = '" + e.target.result + "' height=150 width=150 />" +
                    "<a href = '#' class = 'delete_image' title = 'Cancel'><img class = 'delete-btn' src = 'https://w7.pngwing.com/pngs/776/921/png-transparent-x-mark-check-mark-scalable-graphics-computer-file-red-cross-mark-red-x-illustration-miscellaneous-angle-hand.png' /></a>" +
                "</li>";
            	sortObject.append(html);
                index++;
                
            };
            //console.log(files.length)
            //console.log(index)
            if(files.length === (index+1)){
            	setTimeout(function(){
                    add_order($('.imageOrder__'+$(e).data('file')));
                }, 500);
            }
            reader.readAsDataURL(f);
            
        }
    })
    if(files.length > 11){
    	alert("최대 10장까지 업로드 할 수 있습니다.");
    }
}

$('body').on('click','a.delete_image',function(e){
	e.preventDefault();
	tempDelete = $(this).parent().detach();
	$(this).parent().remove('');
	console.log(tempDelete);
	let file = $(this).parent().attr('file');
	deleteFiles.push(file);
	//console.log(deleteFiles);
	console.log(deleteFiles.join(','));
	for(let i = 0; i < storedFiles.length; i++) {
	    if(storedFiles[i].name == file) {
	        storedFiles.splice(i, 1);
	        break;
	    }
	}
});


</script>
</body>

