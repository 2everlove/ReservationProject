<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
<style>
	.sortable {display: -webkit-box; list-style-type: none; margin: 0; padding: 0; }
	.sortable li {background-color: #fff; border: 1px solid #ccc; border-radius: 5px; float: left; margin: 20px 20px 0 0; padding: 2px; width: 150px; height: 150px; line-height: 150px; position: relative;}
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
						<input type="button" value="Register" class="form-control btn btn-primary result__register btn-sm">
					</div>
				</div>
					<hr/>
					<div class="table-responsive-lg">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col" style="border-top: 0px !important; max-width: 150px !important; width: 0px !important;"></th>
									<th scope="col" style="border-top: 0px !important;" colspan="2">RoomNo</th>
									<th scope="col" style="border-top: 0px !important;">Title</th>
									<th scope="col" style="border-top: 0px !important;">Content</th>
									<th scope="col" style="border-top: 0px !important;">Max</th>
									<th scope="col" style="border-top: 0px !important;">delete?</th>
									<th scope="col" style="border-top: 0px !important;">RegDate</th>
									<th scope="col" style="border-top: 0px !important;"></th>
								</tr>
							</thead>
								<c:forEach var="dto" items="${result.dtoList}" varStatus="i">
							<tbody>
								
									<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
									<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" var="nowDate" />
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
											<span>${dto.roomNum } &nbsp;</span>
											<input type="text" class="form-control result__roomNum" value="${dto.roomNum }" style="display: none; max-width: 150px !important;">
											<span class="dot" style="height: 15px; width: 15px; background-color: ${dto.colorCd}; border-radius: 50%; display: inline-block; border: 0.5px solid;"></span>
										</th>
										<td>
											<input type="color" class="form-control result__color" value="${dto.colorCd}" style="display: none;">
										</td>
										<td class="td-result__title"><span>${dto.roomTitle }</span>
											<input type="text" class="form-control result__title" value="${dto.roomTitle }" style="display: none;">
											<c:if test="${nowDate == reg}">&nbsp;&nbsp;<i class="fas fa-plus-square"></i></c:if>
											<c:if test="${dto == '1'}">&nbsp;&nbsp;<i class="fas fa-lock"></i></c:if>
										</td>
										<td class="td-result__explanation">
											<span><c:out value="${fn:length(dto.explanation) > 5 ? fn:substring(dto.explanation,0,5) : dto.explanation}"/><c:out value="${fn:length(dto.explanation) > 5 ? '...' : ''}"/></span>
											<input type="text" class="form-control result__explanation" value="${dto.explanation }" style="display: none;">
										</td>
										<td class="td-result__max"><span>${dto.max }</span><input type="text" class="form-control result__max" value="${dto.explanation }" style="display: none;"></td>
										
										<td class="ts-result__deleteFlg"><span>${dto.deleteFlg }</span><select class="form-control result__deleteFlg" style="display: none;">
												<option value="0" <c:out value="${dto.deleteFlg == 0 ? 'selected':''}"></c:out>>0</option>
												<option value="1" <c:out value="${dto.deleteFlg == 1 ? 'selected':''}"></c:out>>1</option> 
										</select></td>
										<td class="result__createdAt"><c:out value="${nowDate == reg ? regTime : reg}"></c:out></td>
										<td class="result__createdAt"><button type="button" class="modify">修正</button><button data-confirm=${i.count } type="button" class="confirm" style="display: none;">確認</button></td>
										
									</tr>
									<tr class="imagesShowing__${i.count}" onmouseover="loadSoratables(this)" data-file="${i.count}" style="display: none;">
										<td class="" colspan="8"><ul class="sortable imageOrder__${i.count}">
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
									<tr class="fileUpload__${i.count}" style="align-items: center !important; display: none; min-width: 350px;">
										<td></td>
										<td colspan="8" style="padding: 0 ">
											<input data-file="${i.count}" type="file" class="form-control" onchange="readInputFile(this)" multiple="multiple" max="4" style=" max-width: 300px; margin: 0; display: inline-block;">
											<input type="text" class="form-control result__sort order${i.count}" style=" max-width: 200px; margin: 0; display: inline-block;">
										</td>
									</tr>
							</tbody>
								</c:forEach>
						</table>
						<ul class="pagination pagination-sm h-100 justify-content-center align-items-center">
							<c:if test="${result.prev}">
					            <li class="page-item" >
					                <a class="page-link" href="/consultation?page=${result.start -1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}" tabindex="-1">&laquo;</a>
					            </li>
							</c:if>
							<c:forEach var="page" items="${result.pageList}">
					            <li class="page-item ${result.page == page? 'active':''}">
					                <a class="page-link" href="/consultation?page=${page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">
					                    ${page}
					                </a>
					            </li>
				            </c:forEach>
							<c:if test="${result.next}">
					            <li class="page-item">
					                <a class="page-link" href="/consultation?page=${result.end + 1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">&raquo;</a>
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
	
	$('.result__register').click(function(){
		location.href = '/admin/roomManage/register?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	});
	$('.result__no').text()
	let msg = '${msg}';
	if(msg !== undefined || msg !== null)
		console.log(msg);
	
	
});

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
    	console.log(n);
    	console.log($(this));
    	console.log($(this).attr('item'));
    	if($(this).attr('item') === undefined)
        	$(this).attr('item', n);
    		
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

$('.modify').click(function(){
	while(storedFiles.length > 0) {
		storedFiles.pop();
	}
	initStoredFiles($(this));
	let tr = $(this).closest('tr');
	$(this).hide();
	$(this).closest('td').find('.confirm').show();
	tr.find('span').hide();
	tr.find('select').show();
	tr.find('input').show();
	let data_tr = tr.data('room');
	let imageTr = '.imagesShowing__'+data_tr;
	let fileTr = '.fileUpload__'+data_tr;
	let fileObject = $(fileTr);
	let imageTrObject = $(imageTr);
	
	imageTrObject.show();
	fileObject.show();
});

$('.confirm').click(function(){
    reload_order($(this));
   
    let formData = new FormData();
   
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
       	formData.append('uploadFiles' + i, storedFiles[item_number]);
        console.log("stored"+item_number +":"+storedFiles[item_number])
    }
	
    console.log(storedFiles)
    console.log(formData.get('uploadFiles0'))
    console.log(formData.get('uploadFiles1'))
    console.log(formData.get('uploadFiles2'))
    console.log(formData.get('uploadFiles3'))
    console.log(formData.get('uploadFiles4'))
	let tr = $(this).closest('tr');
	$(this).hide();
	$(this).closest('td').find('.modify').show();
	tr.find('span').show();
	tr.find('select').hide();
	tr.find('input').hide();
	let data_tr = tr.data('room');
	let imageTr = '.imagesShowing__'+data_tr;
	let fileTr = '.fileUpload__'+data_tr;
	let fileObject = $(fileTr);
	let imageTrObject = $(imageTr);
	
	imageTrObject.hide();
	fileObject.hide();
});



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
                }, 1000);
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
	$(this).parent().remove('');       
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

