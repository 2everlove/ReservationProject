<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h1>Index Page</h1>
	<i class="fas fa-hotel"></i>

	
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Upload images with Jquery</title>
    <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
   
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.3.0/bootbox.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
   
    <style>
        ul.cvf_uploaded_files {list-style-type: none; margin: 20px 0 0 0; padding: 0;}
        ul.cvf_uploaded_files li {background-color: #fff; border: 1px solid #ccc; border-radius: 5px; float: left; margin: 20px 20px 0 0; padding: 2px; width: 150px; height: 150px; line-height: 150px; position: relative;}
        ul.cvf_uploaded_files li img.img-thumb {width: 150px; height: 150px;}
        ul.cvf_uploaded_files .ui-selected {background: red;}
        ul.cvf_uploaded_files .highlight {border: 1px dashed #000; width: 150px; background-color: #ccc; border-radius: 5px;}
        ul.cvf_uploaded_files .delete-btn {width: 24px; border: 0; position: absolute; top: -12px; right: -14px;}
        .bg-success {padding: 7px;}
    </style>
    <script type="text/javascript">
        jQuery(document).ready(function() {        
           
            var storedFiles = [];      
            //$('.cvf_order').hide();
           
            // Apply sort function 
            function cvf_reload_order() {
                var order = $('.cvf_uploaded_files').sortable('toArray', {attribute: 'item'});
                $('.cvf_hidden_field').val(order);
            }
           
            function cvf_add_order() {
                $('.cvf_uploaded_files li').each(function(n) {
                    $(this).attr('item', n);
                });
                console.log('test');
            }
           
           
            $(function() {
                $('.cvf_uploaded_files').sortable({
                    cursor: 'move',
                    placeholder: 'highlight',
                    start: function (event, ui) {
                        ui.item.toggleClass('highlight');
                    },
                    stop: function (event, ui) {
                        ui.item.toggleClass('highlight');
                    },
                    update: function () {
                        //cvf_reload_order();
                    },
                    create:function(){
                        var list = this;
                        resize = function(){
                            $(list).css('height','auto');
                            $(list).height($(list).height());
                        };
                        $(list).height($(list).height());
                        $(list).find('img').load(resize).error(resize);
                    }
                });
                $('.cvf_uploaded_files').disableSelection();
            });
                   
            $('body').on('change', '.user_picked_files', function() {
               
                var files = this.files;
                var i = 0;
                           
                for (i = 0; i < files.length; i++) {
                    var readImg = new FileReader();
                    var file = files[i];
                   
                    if (file.type.match('image.*')){
                        storedFiles.push(file);
                        readImg.onload = (function(file) {
                            return function(e) {
                                $('.cvf_uploaded_files').append(
                                "<li file = '" + file.name + "'>" +                                
                                    "<img class = 'img-thumb' src = '" + e.target.result + "' />" +
                                    "<a href = '#' class = 'cvf_delete_image' title = 'Cancel'><img class = 'delete-btn' src = 'https://w7.pngwing.com/pngs/776/921/png-transparent-x-mark-check-mark-scalable-graphics-computer-file-red-cross-mark-red-x-illustration-miscellaneous-angle-hand.png' /></a>" +
                                "</li>"
                                );     
                            };
                        })(file);
                        readImg.readAsDataURL(file);
                       
                    } else {
                        alert('the file '+ file.name + ' is not an image<br/>');
                    }
                   
                    if(files.length === (i+1)){
                        setTimeout(function(){
                            cvf_add_order();
                        }, 1000);
                    }
                }
            });
           
            // Delete Image from Queue
            $('body').on('click','a.cvf_delete_image',function(e){
                e.preventDefault();
                $(this).parent().remove('');       
               
                var file = $(this).parent().attr('file');
                for(var i = 0; i < storedFiles.length; i++) {
                    if(storedFiles[i].name == file) {
                        storedFiles.splice(i, 1);
                        break;
                    }
                }
               
                //cvf_reload_order();
               
            });
                   
            // AJAX Upload
            $('body').on('click', '.cvf_upload_btn', function(e){
               
                e.preventDefault();
                cvf_reload_order();
               
                //$(".cvf_uploaded_files").html('<p><img src = "loading.gif" class = "loader" /></p>');
                var data = new FormData();
               
                var items_array = $('.cvf_hidden_field').val();
                var items = items_array.split(',');

                for (var i in items){
                    var item_number = items[i];
                    data.append('files' + i, storedFiles[item_number]);
                }
                   
                $.ajax({
                    url: 'upload.php',
                    type: 'POST',
                    contentType: false,
                    data: data,
                    processData: false,
                    cache: false,
                    success: function(response, textStatus, jqXHR) {
                        //$(".cvf_uploaded_files").html('');                                               
                        //bootbox.alert('<br /><p class = "bg-success">File(s) uploaded successfully.</p>');
                        alert(jqXHR.responseText);
                    }
                });
               
            });        

        });
    </script>
    <script type="text/javascript">
    console.log(data);
	$('.search-modal-dialog').css('max-width','900px');
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
	console.log($('.search-modal').find('.detail__totalPrice'))
	console.log(data[0][0])
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
		$('.search-modal').find('.detail__totalPrice').val(data[0][0].totalCost);
		$('.search-modal').find('.detail__count-adult').val(data[0][0].adult);
		$('.search-modal').find('.detail__count-child').val(data[0][0].child);
		$('.search-modal').find('.start').val(moment(data[0][0].endDate).format('YYYY年MM月DD日'));
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
	}, 50);
    </script>
</head>
<body>
    <div class = "container-fluid">
        <h3>Sort Files before upload</h3>
        <br />
        <div class = "col-md-6">
           
            <div class = "form-group">
                <label>Select Images</label>
                <input type = "file" name = "upload" multiple = "multiple" class = "form-control user_picked_files" />                 
            </div>                     
           
            <div class = "form-group cvf_order">                           
                <label>Order</label>                               
                <input type = "text" class = "form-control cvf_hidden_field" value = "" disabled = "disabled" />   
            </div>                     
           
            <input type = "submit" class = "cvf_upload_btn btn btn-primary" value = "Upload" />
           
            <ul class = "cvf_uploaded_files"></ul>
           
        </div>
    </div>
</body>
</html>