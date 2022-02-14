<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
a{text-decoration: none;}
</style>
<body>
	<!-- <div id="calendarForm"></div> -->
	<div class="bg-dark " style="height: 94px"></div>
	<div class="masthead">
		<div style="padding-top: 0px;">
			<section class="projects-section bg-light" style="padding-top: 20px; padding-bottom: 40px;">
				<div class="container px-4 px-lg-5">
					<div class="card">
						<div class="card-header">
							<div class="input-group" style="align-items: center;">
								<c:if test="${result != null }">
									<label for="staticEmail" class="col-sm-1 col-form-label">No |</label>
									<label for="staticEmail" class="col-sm-0 col-form-label" style="text-align: center;">${result.no }</label>
								</c:if>
								<label for="staticEmail" class="col-sm-1 col-form-label" style="text-align: center;"> Title</label>
								<div class="col-sm-6">
									<input type="text" aria-label="Last name" class="form-control result__title" value="${result.title }" disabled="disabled" style="background-color: #fff">
								</div>
								<fmt:parseDate value="${result.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modDate" type="both"/>
								<c:if test="${result != null }">
									<label for="staticEmail" class="col-sm-0 col-form-label">修正日 |</label>
									<label for="staticEmail" class="col-sm-2 col-form-label result__updatedAt" style="text-align: center;"><fmt:formatDate value="${modDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
								</c:if>
								<c:if test="${result == null }">
									<label for="staticEmail" class="col-sm-0 col-form-label"> 層數|</label>
									<label for="staticEmail" class="col-sm-2 col-form-label result__updatedAt" style="text-align: center;">
										<select class="form-select col-sm-6 result__buildCd" aria-label="Default select example">
											<option value='' disabled="disabled">---</option>
											<c:forEach items="${buildCdList}" var="buildCd">
												<option value="${buildCd }">${buildCd }層</option>
											</c:forEach>
										</select>
									</label>
								</c:if>
								
							</div>
						</div>
						
						<div class="card-body" style="min-height: 500px; overflow: auto;">
							<div id="summernote">${result.contents }</div>
						</div>
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 1rem">
						<c:if test="${result == null }">
							<input type="button" value="List" class="btn btn-secondary result__List">
							<input type="button" value="Register" class="btn btn-primary result__register">
						</c:if>
						<c:if test="${result != null }">
							<input type="button" value="List" class="btn btn-secondary result__List">
							<input type="button" value="Delete" class="btn btn-warning result__delete" <c:if test="${result.deleteFlg != '0'}">style="display: none;"</c:if>>
							<input type="button" value="Recover" class="btn btn-success result__recover" <c:if test="${result.deleteFlg == '0'}">style="display: none;"</c:if>>
							<input type="button" value="Popup" class="btn btn-info result__popup" <c:if test="${result.deleteFlg != '0'}">style="display: none;"</c:if>>
							<input type="button" value="Modify" class="btn btn-primary result__modify">
						</c:if>
					</div>
				</div>
			</section>
			
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	
});//
$('.result__List').click(function(){
	location.href = '/admin/notice?page=${page.page}&type=${page.type}&keyword=${page.keyword}';
});
<c:if test="${result == null }">
	$('.result__title').attr('disabled', false);
	$('#summernote').summernote({
	    tabsize: 2,
	    minHeight: 450,
	    toolbar: [
	      ['style', ['style']],
	      ['font', ['bold', 'underline', 'clear']],
	      ['color', ['color']],
	      ['para', ['ul', 'ol', 'paragraph']],
	      ['table', ['table']],
	      ['insert', ['link', 'picture', 'video']],
	      ['view', ['fullscreen', 'codeview', 'help']]
	    ]
	});
	
	$('.result__register').click(function(){
		if($('.result__title').val() == ''){
			$('.result__title').focus();
			return false;
		}
		if($('#summernote').summernote('code') == '<p><br></p>'){
			$('#summernote').summernote({focus: true});
			return false
		}
		if($('.result__buildCd').val() == ''){
			$('.result__buildCd').focus();
			return false
		}
		
		submit('/admin/notice/register', 'POST', [
		    { name: 'title', value: $('.result__title').val() },
		    { name: 'contents', value: $('#summernote').summernote('code') },
		    { name: 'deleteFlg', value: '0' },
		    { name: 'buildCd', value: $('.result__buildCd option:selected').val() },
		    
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
	
</c:if>

<c:if test="${result != null }">

//get Cookie for popup
function getCookie(key) {
    let result = null;
    let cookie = document.cookie.split(';');
    cookie.some(function (item) {
        // 공백을 제거
        item = item.replace(' ', '');
 
        let dic = item.split('=');
 
        if (key === dic[0]) {
            result = dic[1];
            return true;    // break;
        }
    });
    return result;
}

$('.result__popup').on('click', function(){
	$.ajax({
		url: '/api/notice/'+${result.no},
		method: 'post',
		contentType: 'application/json; charset=utf-8',
		dataType: 'text',
		success: function(data){
			console.log(data);
			console.log(getCookie('popupNotice'));
			if(data === 'OK'){
				$('.colorMark').css('background-color', "#2ed573")
				$('.toast').css('z-index','2560');
				$('.toast').css('right','2%');
				$('.toast-body').text(getCookie('popupNotice')+ "번이 공지글로 게시되었습니다.");
				$('.toast').toast('show')
			}
		}
	});
});

$('.result__modify').click(function(){
	$('#summernote').summernote({
	    tabsize: 2,
	    minHeight: 450,
	    toolbar: [
	      ['style', ['style']],
	      ['font', ['bold', 'underline', 'clear']],
	      ['color', ['color']],
	      ['para', ['ul', 'ol', 'paragraph']],
	      ['table', ['table']],
	      ['insert', ['link', 'picture', 'video']],
	      ['view', ['fullscreen', 'codeview', 'help']]
	    ]
	});
	if($('.result__modify').val() == 'Modify'){
		$('.result__delete').show();
		$('#contents').hide();
		$('.result__title').attr('disabled', false);
		document.querySelector('.result__modify').value = 'Confirm';
		document.querySelector('.result__modify').classList.add('result__confirm');
		document.querySelector('.result__confirm').classList.remove('result__modify');
		$('.card-body').css('padding', '0rem 0rem');
	} else {
		let notice = {
				no: "${result.no}",
				title: $('.result__title').val(),
				contents: $('#summernote').summernote('code'),
				deleteFlg: "${result.deleteFlg}"
			}
		console.log(notice);
		$.ajax({
			url: '/api/notice',
			method: 'post',
			data: JSON.stringify(notice),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(data){
				$('#summernote').summernote('destroy');
				$('.result__delete').hide();
				$('#contents').show();
				$('.result__title').attr('disabled',true);
				document.querySelector('.result__confirm').value = 'Modify';
				document.querySelector('.result__confirm').classList.add('result__modify');
				document.querySelector('.result__modify').classList.remove('result__confirm');
				$('.card-body').css('padding', '1rem 1rem');
				$('.result__updatedAt').text(data.updatedAt);
			}
		});
	}
});//

$('.result__delete').click(function(){
	let notice = {
		no: "${result.no}",
		deleteFlg: "1"
	}
	
	$.ajax({
		url: '/api/notice/delete',
		method: 'post',
		data: JSON.stringify(notice),
		contentType: 'application/json; charset=utf-8',
		dataType: 'text',
		success: function(data){
			if(data == 'success'){
				$('section').empty();
				alert(notice.no +'번 글이 삭제되었습니다.');
				location.href="/admin/notice?page=${page.page}&type=${page.type}&keyword=${page.keyword}";
			}
		}
	});
	console.log(notice);
});
$('.result__recover').click(function(){
	let notice = {
		no: "${result.no}",
		deleteFlg: "0"
	}
	
	$.ajax({
		url: '/api/notice/delete',
		method: 'post',
		data: JSON.stringify(notice),
		contentType: 'application/json; charset=utf-8',
		dataType: 'text',
		success: function(data){
			if(data == 'success'){
				alert(notice.no +'번 글이 복구되었습니다.');
				$('.result__recover').hide();
				$('.result__delete').show();
				$('.result__popup').show();
			}
		}
	});
	console.log(notice);
});
</c:if>
</script>
</body>

