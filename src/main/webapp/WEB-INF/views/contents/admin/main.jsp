<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    let storedFiles = [];
    let = tempDelete = '';
    let deleteFiles = [];
    $(document).ready(function(){
    	$('.register').click(function(){
    		$(this).hide("slide", { direction: "up" }, 300);
    		$('.registerMenu').show("slide", { direction: "right" }, 300);
    	})
    	let sortObject = $('.sortable');
    	 if(sortObject.find('li').length>0){
     		for(let i=0;i< sortObject.find('li').length; i++){
     			if($(sortObject.find('li')[i]).hasClass('origin')){
     				storedFiles.push($(sortObject.find('li')[i]).attr('file'));
     			}
     		}
     	}
    	$('.sortable').on('mouseover', 'img', function(e){
        	
        	for(let i = 0; i<$('.sortable').find('.modifyImage').length; i++){
           		if(i+1 != $(this).closest('li').val()){
           			$($('.sortable').find('.modifyImage')[i]).hide();
           		} else {
           			$(this).closest('li').find('.modifyImage').fadeIn(200)
           		}
           		
           	}
        })
        $('.sortable .card-body').on('mouseout', '.modifyImage', function(e){
        	$(this).css("background-color", "rgba(128, 128, 128, 0.66)");
        	$(this).closest('li').find('.modifyImage').fadeOut(200)
        })
        $('.sortable').on('click', '.modifyImage', function(){
        	$(this).css("background-color", "rgba(128, 128, 128, 0.87)");
	 		$(this).closest('li').find('.fileModify').click();
        });
        $('.sortable').on('change', '.fileModify', function(e){
        	$(this).css("background-color", "rgba(128, 128, 128, 0.87)");
           	//console.log("showTranspatent")
           	//console.log($(this))
        	let sliderImagesLi = $(this).closest('li');
        	let sliderImagesNo = $(this).closest('li').data('no');
           	let fileList = [];
           	let formData = new FormData();
	 		let sliderImages = {
	 			no: sliderImagesNo,
	 			filename: '',
	 		}
	 		console.log($(this));
	 		console.log(sliderImages);
	 		console.log(sliderImagesNo);
	 		console.log(decodeURI($(this).closest('li').attr('file')))
	 		fileList.push($(this)[0].files);
	 		
			if(sliderImagesNo !== undefined){
		 		$.post('/api/removeFile', {fileName: decodeURI($(this).closest('li').attr('file'))}, function(result){
					console.log(result);
					deleteFiles.length = 0;
				}, "json");
				
		 		console.log(fileList)
		 		formData.append('uploadFiles',fileList[0][0]);
				
		 		$.ajax({
				    	url: '/api/uploadAjax',
						processData: false,
						contentType: false,
						data: formData,
						type: 'post',
						dataType: 'json',
						success: function(data){
							console.log(data[0]);
							let url = '/api/display?fileName='+data[0].imageURL;
							sliderImages.filename=data[0].imageURL;
							sliderImagesLi.find('img').attr("src", url);
							sliderImagesLi.attr('file',data[0].imageURL);
							console.log(sliderImages);
							$.ajax({
						    	url: '/api/slideImages/modify',
						    	method: 'post',
								data: JSON.stringify(sliderImages),
								contentType: 'application/json; charset=utf-8',
								dataType: 'json',
								success: function(data){
									console.log(data);
									
								}
			   	 			});
						}
		 		 });
			} else {
				storedFiles.splice(sliderImagesLi.attr('item'),1,fileList[0][0]);
				console.log(URL.createObjectURL($(this)[0].files[0]))
				sliderImagesLi.attr("file", $(this)[0].files[0].name);
				$(sliderImagesLi.find('img')[0]).attr("src", URL.createObjectURL($(this)[0].files[0]));
				console.log(storedFiles)
			}
	 		
        });
   		$('.confirm').click(function(){
   	    	console.log("confirm")
   	    	reload_order($(this));
   	     	let formData = new FormData();
   	     	let items_array = $('.result__sort').val();
   	     	let sortable  = $('.sortable li>img:eq(0)');
	   	    console.log(items_array);
	   	    let li = $('.sortable').find('li')
	   	    let registerLiList = [];
	   	    for(let i = 0 ;i < li.length;i++){
	   	    	if($(li[i]).data('no') === undefined){
	   	    		registerLiList.push(i+1);
	   	    	}
	   	    }
	   	    console.log("registerLiList")
	   	    console.log(registerLiList)
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
		    console.log("deleteFiles: "+deleteFiles);
		    
		    $.ajax({
		    	url: '/api/uploadAjax',
				processData: false,
				contentType: false,
				data: formData,
				type: 'post',
				dataType: 'json',
				success: function(data){
					console.log(data);
					let dataLength = 0;
					for(let i in formArr){
						console.log(typeof(formArr[i]));
						if(typeof(formArr[i]) === 'object'){
							formArr[i] = data[dataLength].imageURL
							/* console.log(tbody);
							console.log(tbody.find('.sortable li'));
							console.log(tbody.find('.sortable li')[i]);
							console.log(tbody.find('.sortable li')[i].getAttribute('file'));*/
							console.log(li[i]);
							console.log(li[i].getAttribute('file'));
							console.log($(li[i]).val());
							li[i].setAttribute('file', data[dataLength].imageURL);
							let url = '/api/display?fileName='+data[dataLength].imageURL;
							li[i].find('img').attr('src', url);
							
							
							let sliderImages = {
								filename: data[dataLength].imageURL,
								sortNo: registerLiList[i],
								deleteFlg: '',
								activity: '',
								builldCd: '7',
							}
							dataLength++
							if($(li[i]).find('.toggle').hasClass('deleteFlg')){
				   	 			if($(li[i]).find('.deleteFlg').hasClass('on')){
				   	 				console.log('deleteFlg: on');
				   	 				sliderImages.deleteFlg = '1'
				   	 			} else {
				   	 				console.log('deleteFlg: off');
				   	 				sliderImages.deleteFlg = '0'
				   	 			}
				   	 		}
				   	 		if($(li[i]).find('.toggle').hasClass('activation')){
				   	 			if($(li[i]).find('.activation').hasClass('on')){
				   	 				console.log('activation: on');
				   	 				sliderImages.activity = '0'
					 			} else {
				   	 				console.log('activation: off');
				   	 				sliderImages.activity = '1'
					 			}
				   	 		}
				   	 		console.log(sliderImages);
					   	 	$.ajax({
								url: '/api/slideImages/register',
								method: 'post',
								data: JSON.stringify(sliderImages),
								contentType: 'application/json; charset=utf-8',
								dataType: 'json',
								success: function(data){
									console.log('slideImages/register: ');
									console.log(data);
									$('.registerMenu').hide(200);
									$('.register').show(300);
									$('.delete_image').remove();
								}
					   	 	});
						}
					}
				}
		    }) 
   	    });
   	    
   	    function checkActivation(e){
   			if(e.closest('li').find('.activation').hasClass('on')){
				return '0';
			} else {
				return '1';
			}
   		}
   	    function checkDeleteFlg(e){
   			if(e.closest('li').find('.deleteFlg').hasClass('on')){
				return '1';
			} else {
				return '0';
			}
   		}
   	 	$('.sortable').on('click','.toggle', function(){
   	 		$($(this)[0]).toggleClass('on off')
   	 		let sliderImagesNo = $(this).closest('li').data('no');
   	 		let sliderImages = {
   	 			no: sliderImagesNo,
   	 			deleteFlg: '',
   	 			activity: '',
   	 		}
   	 		if($(this).hasClass('deleteFlg')){
   	 			if($(this).hasClass('on')){
   	 				sliderImages.deleteFlg = '1';
   	 				if($(this).closest('li').find('.activation').hasClass('on')){
	 					$(this).closest('li').find('.activation').toggleClass('on off')
	 				}
   	 				sliderImages.activity = checkActivation($(this));
   	 				console.log('deleteFlg: on')
   	 			} else {
   	 				sliderImages.deleteFlg = '0';
   	 				sliderImages.activity = checkActivation($(this));
   	 				console.log('deleteFlg: off')
   	 			}
   	 		}
   	 		if($(this).hasClass('activation')){
   	 			if($(this).hasClass('on')){
   	 				sliderImages.activity = '0';
   	 				if($(this).closest('li').find('.deleteFlg').hasClass('on')){
   	 					$(this).closest('li').find('.deleteFlg').toggleClass('on off')
   	 				}
   	 				sliderImages.deleteFlg = checkDeleteFlg($(this));
   	 				console.log('activation: on')
	 			} else {
   	 				sliderImages.activity = '1';
   	 				sliderImages.deleteFlg = checkDeleteFlg($(this));
   	 				console.log('activation: off')
	 			}
   	 		}
   	 		console.log(sliderImages)
   	 		if(sliderImages.no !== undefined){
   	 			console.log("modify")
   	 			$.ajax({
			    	url: '/api/slideImages/modify',
			    	method: 'post',
					data: JSON.stringify(sliderImages),
					contentType: 'application/json; charset=utf-8',
					dataType: 'json',
					success: function(data){
						console.log(data);
					}
   	 			});
   	 		} 
   	 	})
   	 	$('.sortable').on('click','.delete-btn', function(){
	   	 	tempDelete = $(this).closest('li').detach();
	   		$(this).closest('li').remove('');
	   		console.log(tempDelete);
	   		let file = $(this).closest('li').attr('file');
	   		let item = $(this).closest('li').attr('item');
	   		storedFiles.splice(item, 1);
	   		deleteFiles.push(file);
	   		//console.log(deleteFiles);
	   		console.log(storedFiles);
	   		console.log(deleteFiles.join(','));
	   		/* for(let i = 0; i < storedFiles.length; i++) {
	   		    if(storedFiles[i].name == file) {
	   		        //storedFiles.splice(i, 1);
	   		        break;
	   		    }
	   		} */
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
        	//console.log(n+1);
        	//console.log($(this));
        	//console.log($(this).find('li').attr('item'));
        	if($(this).attr('item') === undefined){
        		$(this).val(n+1)
            	$(this).attr('item',n);
        	}
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
    		$(box).closest('li').find('.orderNo').text(i+1);
    		$(box).val(i + 1); 
    		let sliderImagesNo = $(box).closest('li').data('no');
   	 		let sliderImages = {
   	 			no: sliderImagesNo,
   	 			sortNo: i+1,
   	 		}
   	 	console.log(sliderImages)
	 		if(sliderImages.no !== undefined){
	 			console.log("modify")
	 			$.ajax({
		    	url: '/api/slideImages/modify',
		    	method: 'post',
				data: JSON.stringify(sliderImages),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				success: function(data){
					console.log(data);
				}
	 			});
	 		}
   	 		
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
        	console.log(f);
        	if(!f.type.match("image/.*")){
            	alert("이미지 확장자만 업로드 가능합니다.");
                return;
            };
            if(files.length < 11){
            	
            	storedFiles.push(f);
            	let reader = new FileReader();
                reader.onload = function(e){
                	console.log(storedFiles)
                	//console.log(e.target)
                	let s = f.name.substring(0, f.name.indexOf('.'))
                	//console.log(s)
                	let html = '<li file="'+f.name+'" class="img-thumb">'+
										'<div class="card">'+
										'<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">'+
											'<span class="orderNo" data-spanOrder="'+(Number(sortObject.find('li').length)+1)+'">'+(Number(sortObject.find('li').length)+1)+'</span>'+
											'<img src="'+e.target.result+'" height=200 width=200 style="cursor: pointer;"/>'+
											'<input type="file" class="fileModify" accept="image/*" style="display: none;">'+
											'<div class="modifyImage text-white">Modify</div>'+
											'<div class="toggle btn btn-danger on deleteFlg" data-toggle="toggle" role="button" style="width: 118.062px; height: 38px; position: absolute; top: 30%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-off="Disply" data-on="Delete" data-offstyle="primary" data-onstyle="danger"><div class="toggle-group"><label for="" class="btn btn-danger toggle-on">Delete</label><label for="" class="btn btn-primary toggle-off">Disply</label><span class="toggle-handle btn btn-light"></span></div></div>'+
											'<div class="toggle btn btn-success on activation" data-toggle="toggle" role="button" style="width: 118.062px; height: 38px; position: absolute; top: 50%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-on="Activation" data-off="Disabled" data-onstyle="success" data-offstyle="outline-secondary"><div class="toggle-group"><label for="" class="btn btn-success toggle-on">Activation</label><label for="" class="btn btn-secondary toggle-off">Disabled</label><span class="toggle-handle btn btn-light"></span></div></div>'+
											'<span style="position: absolute;top: -80px;left: 240px;height: 20px;">'+moment().format('YYYY-MM-DD')+'</span>'+
											"<a href='javascript:void(0);' class='delete_image' title='Cancel'><img class='delete-btn' src='https://w7.pngwing.com/pngs/776/921/png-transparent-x-mark-check-mark-scalable-graphics-computer-file-red-cross-mark-red-x-illustration-miscellaneous-angle-hand.png' /></a>"+
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
		.sortable li .card-body > img {margin-left: 17px;}
		.sortable li .highlight {border: 1px dashed #000; width: 150px; background-color: #ccc; border-radius: 5px;}
		.sortable li .orderNo { position: absolute; background-color: black; top: 1px; color: white; width: 30px; left: 15px; transform: translateX(-15px);text-align: center; border-radius: 3px;}
		.sortable li .modifyImage  { height: 200px; width: 200px; position: absolute; left: 30px; display: none; text-align: center; background-color: rgba(128, 128, 128, 0.66); z-index: 2; top: 2px; cursor: pointer;}
		.sortable li .modifyImage:hover  { height: 200px; width: 200px; position: absolute; left: 30px; display: none; text-align: center; background-color: rgba(128, 128, 128, 0.66); z-index: 2; top: 2px; cursor: pointer;}
		.sortable li .delete-btn {width: 24px; border: 0; position: absolute; right: 0px;}
    </style>
        
      	<div class="bg-dark " style="height: 94px"></div>
        <header class="masthead" style="padding-top: 30px !important">
			<div class="container">
				<button type="button" class="register btn btn-primary" style="position:absolute;transform: translateX(1325%);top: 12%;">Register</button>
				<div class="registerMenu" style="display: none; position:absolute;transform: translateX(254%);top: 12%;">
					<input data-file="" type="file" class="form-control fileUpload" onchange="readInputFile(this)" multiple="multiple" accept="image/*" style=" max-width: 300px; margin: 0; display: inline-block;">
					<input type="hidden" class="form-control result__sort order" style=" max-width: 200px; margin: 0; display: inline-block;">
					<button type="button" class="confirm btn btn-success">登録</button>
				</div>
				<div onmouseover="loadSoratables(this)">
				
					<ul class="sortable imageOrder__${i.count}">
					
						<c:forEach items="${slideList}" var="slideImage" varStatus="status">
							<c:url value="/api/display" var="thumbnail">
								<c:param name="fileName" value="${slideImage.filename}"></c:param>
							</c:url>
							<li file="${slideImage.filename}" data-no="${slideImage.no}" item="${status.count-1}" value="${status.count}" class="img-thumb origin">
									<div class="card">
									<div class="card-body" style="padding: 0rem 0.8rem; height: 204px;">
										<span class="orderNo" data-spanOrder="${status.count }" style="top: 2px;">${status.count }</span>
										<img src="${thumbnail}" height=200 width=200 style="cursor: pointer;"/>
										<input type="file" class="fileModify" accept="image/*" style="display: none;">
										<div class="modifyImage text-white">Modify</div>
										<div class="toggle btn btn-danger <c:out value="${slideImage.deleteFlg =='0'? 'off' : 'on'  }"></c:out> deleteFlg" data-toggle="toggle" role="button" style="width: 118.062px; height: 38px; position: absolute; top: 30%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-off="Disply" data-on="Delete" data-offstyle="primary" data-onstyle="danger"><div class="toggle-group"><label for="" class="btn btn-danger toggle-on">Delete</label><label for="" class="btn btn-primary toggle-off">Disply</label><span class="toggle-handle btn btn-light"></span></div></div>
										<div class="toggle btn btn-success <c:out value="${slideImage.activity =='0'? 'on' : 'off'  }"></c:out> activation" data-toggle="toggle" role="button" style="width: 118.062px; height: 38px; position: absolute; top: 50%;transform: translateX(20px);"><input type="checkbox" checked="" data-toggle="toggle" data-on="Activation" data-off="Disabled" data-onstyle="success" data-offstyle="outline-secondary"><div class="toggle-group"><label for="" class="btn btn-success toggle-on">Activation</label><label for="" class="btn btn-secondary toggle-off">Disabled</label><span class="toggle-handle btn btn-light"></span></div></div>
										<fmt:parseDate value="${slideImage.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
										<span style="position: absolute;top: -80px;left: 240px;height: 20px;"><fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd"/></span>
									</div>
								</div>
							</li>
							
						</c:forEach>
					</ul>
				</div>
				
				<!-- <input type="checkbox" checked data-toggle="toggle" data-off="Disply" data-on="Delete" data-offstyle="primary" data-onstyle="danger">
				<input type="checkbox" checked data-toggle="toggle" data-on="Activation" data-off="Disabled" data-onstyle="success" data-offstyle="outline-secondary"> -->
			</div>
        </header>
        <!-- <div class="d-block h-100" style="width:70rem !important; height:40rem !important; background-image: url('/resources/assets/img/room/room3.jpg');  background-size: cover;"></div> -->
        
</html>
<link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>