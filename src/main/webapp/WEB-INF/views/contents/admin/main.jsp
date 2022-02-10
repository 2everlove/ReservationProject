<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    let storedFiles = [];
    $(document).ready(function(){
   		$('.confirm').click(function(){
   	    	console.log("confirm")
   	    	 reload_order($(this));
   	    })
   	 	$('.sortable').on('click','.toggle', function(){
   	 		$($(this)[0]).toggleClass('on off')
   	 	})
    })
    
    function reload_order(e) {
        let order = $('.sortable').sortable('toArray', {attribute: 'item'});
        console.log("reload_order: "+order)
        $('.result__sort').val(order);
       }
    function add_order(e) {
    	console.log(e);
        e.children().each(function(n) {
        	console.log(n);
        	console.log($(this));
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
    	let li = $(e).closest('ul').find('.sortable li')
    	li.each(function(n){
    		//console.log($(this).attr('file'))
    		storedFiles.push($(this).attr('file'));
    	})
    	console.log(storedFiles)
    }
    
    function reorder() { 
    	$(".sortable li").each(function(i, box) {
    		$(box).closest('li').find('orderNo').text(i+1);
    		$(box).val(i + 1); 
    	}); 
    }

    function readInputFile(e){
    	
    	let sel_files = [];
        let sortObject = $('.sortable');
        
        sel_files = [];
        //sortObject.empty();
        console.log(e.files)
        
        let files = e.files;
        let fileArr = Array.prototype.slice.call(files);
        var index = 0;
        
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
                	let html = '<li file="'+f.name+'" class="img-thumb">'+
										'<div class="card">'+
										'<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">'+
											'<span class="orderNo" data-spanOrder="'+(Number(sortObject.find('li').length)+1)+'">'+(Number(sortObject.find('li').length)+1)+'</span>'+
											'<img src="'+e.target.result+'" height=200 width=200/>'+
											'<div class="toggle btn btn-primary on deleteFlg" data-toggle="toggle" role="button" style="width: 88.8125px; height: 38px; position: absolute; top: 20%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-on="Disply" data-off="Delete" data-onstyle="primary" data-offstyle="danger"><div class="toggle-group"><label for="" class="btn btn-primary toggle-on">Disply</label><label for="" class="btn btn-danger toggle-off">Delete</label><span class="toggle-handle btn btn-light"></span></div></div>'+
											'<div class="toggle btn btn-success on activation" data-toggle="toggle" role="button" style="width: 118.062px; height: 38px; position: absolute; top: 60%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-on="Activation" data-off="Disabled" data-onstyle="success" data-offstyle="outline-secondary"><div class="toggle-group"><label for="" class="btn btn-success toggle-on">Activation</label><label for="" class="btn btn-secondary toggle-off">Disabled</label><span class="toggle-handle btn btn-light"></span></div></div>'+
										'</div>'+
									'</div>'+
								'</li>';
                	sortObject.append(html);
                	index++;
                };
               	setTimeout(function(){
                       add_order($('.sortable'));
                   }, 1000);
                reader.readAsDataURL(f);
                
            }
        })
        if(files.length > 11){
        	alert("최대 10장까지 업로드 할 수 있습니다.");
        }
    }
   
   
    </script>
    <style>
	   	.sortable {display: -webkit-box; list-style-type: none; margin: 60px auto; padding: 0; display: flex;flex-direction: row;flex-wrap: wrap;}
		.sortable li {background-color: #fff; border: 1px solid #ccc; border-radius: 5px; float: left; margin: 5px 10px 0 0; padding: 2px; width: 420px; height: 212px; line-height: 200px; position: relative;}
		.sortable li .ui-selected {background: red;}
		.sortable li .highlight {border: 1px dashed #000; width: 150px; background-color: #ccc; border-radius: 5px;}
		.sortable li .orderNo { position: absolute; background-color: black; top: 2px; color: white; width: 15px; left: 15px; transform: translateX(-15px);text-align: center; border-radius: 3px;}
		.sortable li .delete-btn {width: 24px; border: 0; position: absolute; top: -12px; right: -14px;}
    </style>
        
      	<div class="bg-dark " style="height: 94px"></div>
        <header class="masthead" style="padding-top: 30px !important">
			<div class="container">
				<div onmouseover="loadSoratables(this)">
					<ul class="sortable imageOrder__${i.count}">
						<c:forEach var="img" items="${dto.images }" varStatus="imageNo">
							<c:url value="/api/display" var="imagesUrl">
								<c:param name="fileName" value="${img}"></c:param>
							</c:url>
							<li file="${img }" item="${imageNo.count-1}" class="img-thumb${imageNo.count-1 }">
								<img src="${imagesUrl}" height=150 width=150/>
							</li>
						</c:forEach>
						<!-- <li file="0" item="0" class="img-thumb">
							<div class="card">
								<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">
									<span class="orderNo" data-spanOrder="0">1</span>
									<img src="/api/display?fileName=2022%252F01%252F26%252F076b2e37-7e990bb-b82a85a-4b17099_118275354.jpg" height=200 width=200/>
								</div>
							</div>
						</li>
						<li file="" item="1" class="img-thumb">
							<div class="card">
								<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">
									<span class="orderNo" data-spanOrder="1">2</span>
									<img src="/api/display?fileName=2022%252F01%252F26%252Ff2e13a03-625927e-b7444c9-1a7350b_307735083.jpg" height=200 width=200/>
								</div>
							</div>
						</li>
						<li file="" item="2" class="img-thumb">
							<div class="card">
								<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">
									<span class="orderNo" data-spanOrder="2">3</span>
									<img src="/api/display?fileName=2022%252F01%252F26%252F311ff537-c2559f3-dd91769-b6e5d76_206614280.jpg" height=200 width=200/>
								</div>
							</div>
						</li> -->
					</ul>
				</div>
				<input data-file="" type="file" class="form-control fileUpload" onchange="readInputFile(this)" style=" max-width: 300px; margin: 0; display: inline-block;">
				<input type="text" class="form-control result__sort order" style=" max-width: 200px; margin: 0; display: inline-block;">
				<button type="button" class="confirm btn-success">確認</button>
				<input type="checkbox" checked data-toggle="toggle" data-on="Disply" data-off="Delete" data-onstyle="primary" data-offstyle="danger">
				<input type="checkbox" checked data-toggle="toggle" data-on="Activation" data-off="Disabled" data-onstyle="success" data-offstyle="outline-secondary">
			</div>
        </header>
        <!-- <div class="d-block h-100" style="width:70rem !important; height:40rem !important; background-image: url('/resources/assets/img/room/room3.jpg');  background-size: cover;"></div> -->
        
</html>
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>