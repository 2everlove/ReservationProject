<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
<style>
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em;}
	#sortable li span { position: absolute; margin:1em 0 0 1em; background-color: black; color: white; width: 15px; height: 25px; text-align: center;}
</style>
<body>
<div class="bg-dark " style="height: 94px"></div>
<div class="masthead">
	<div style="padding-top: 0px;">
		<section class="projects-section bg-light" style="margin-top: 20px; padding-bottom: 40px;">
			<div class="container px-4 px-lg-5">
				
				<input name="uploadFiles" id="real-input" type="file" multiple="multiple">
				<button class="uploadBtn">Upload</button>
				
				<div id="imagePreview">
					<img id="img" />
				</div>
				
				<p>
				
				<ul id="sortable">
				</ul>
					
				</p>
			</div>
		</section>
	</div>
</div>
</body>

<script>
$( function() {
	$("#sortable").sortable({ 
		placeholder:"itemBoxHighlight", /* 이동할 위치 css 적용 */ 
		start:function(event,ui){ 
			// 드래그 시작 시 호출 
		}, 
		stop:function(event,ui){ 
			// 드래그 종료 시 호출 
			reorder(); 
		} });

  } );
  
function reorder() { 
	$("#sortable li").each(function(i, box) {
		$(box).closest('li').find('span').text(i+1);
		$(box).val(i + 1); 
	}); 
}

function readInputFile(e){
    var sel_files = [];
    
    sel_files = [];
    $('#sortable').empty();
    
    var files = e.target.files;
    var fileArr = Array.prototype.slice.call(files);
    var index = 0;
    
    fileArr.forEach(function(f){
    	//console.log(f);
    	if(!f.type.match("image/.*")){
        	alert("이미지 확장자만 업로드 가능합니다.");
            return;
        };
        if(files.length < 11){
        	sel_files.push(f);
            var reader = new FileReader();
            reader.onload = function(e){
            	//console.log(e.target)
            	let s = f.name.substring(0, f.name.indexOf('.'))
            	//console.log(s)
            	var html = '<li id="img_'+s+'" style="display: inline-block;"><span>'+index+'</span><img src="'+e.target.result+'" data-file="'+f.name+'" height=100 width=200 /></li>';
                $('#sortable').append(html);
                index++;
            };
            reader.readAsDataURL(f);
        }
    })
    if(files.length > 11){
    	alert("최대 10장까지 업로드 할 수 있습니다.");
    }
}

$('#real-input').on('change',readInputFile);


$('.uploadBtn').click(function(){
	let formData = new FormData();
	let inputFile = $('input[name="uploadFiles"]');
	let files = inputFile[0].files;
	let orderString = $("#sortable").sortable("toArray");
	for(let i = 0; i < files.length; i++){
		for(let j = 0; j< orderString.length; j++){
			//console.log(files[j].name.substring(0, files[j].name.indexOf('.')));
			//console.log(orderString[i]);
			//console.log(orderString[i].includes(files[j].name.substring(0, files[j].name.indexOf('.'))));
			if(orderString[i].includes(files[j].name.substring(0, files[j].name.indexOf('.')))){
				console.log(files[j]);
				formData.append("uploadFiles", files[j]);
			}
		}
	}
	
	console.log(formData.getAll('uploadFiles'));
	console.log($("#sortable").sortable("serialize"));
	console.log($("#sortable").sortable("toArray"));
	
	$.ajax({
		url: '/api/uploadAjax',
		processData: false,
		contentType: false,
		data: formData,
		type: 'post',
		dataType: 'json',
		success: function(data){
			$( "#sortable" ).sortable( "option", "disabled", true );
			console.log(data);
		}
	});
	
})
</script>