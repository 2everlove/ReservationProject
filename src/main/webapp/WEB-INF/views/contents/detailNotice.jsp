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
			<section class="projects-section bg-light" style="margin-top: 20px; padding-bottom: 40px;">
				<div class="container px-4 px-lg-5">
				
					<div class="card">
						<div class="card-header">
							<div class="input-group">
								<label for="staticEmail" class="col-sm-1 col-form-label">No |</label>
								<label for="staticEmail" class="col-sm-0 col-form-label" style="text-align: center;">${result.no }</label>
								<label for="staticEmail" class="col-sm-1 col-form-label" style="text-align: center;">| Title</label>
								<div class="col-sm-6">
									<input type="text" aria-label="Last name" class="form-control result__title" value="${result.title }">
								</div>
								<fmt:parseDate value="${result.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modDate" type="both"/>
								<label for="staticEmail" class="col-sm-0 col-form-label">修正日 |</label>
								<label for="staticEmail" class="col-sm-2 col-form-label result__updatedAt" style="text-align: center;"><fmt:formatDate value="${modDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
							</div>
						</div>
						
						<div class="card-body" style="min-height: 500px;">
							<div id="summernote">${result.contents }</div>
						</div>
					</div>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 1rem">
						<input type="button" value="Delete" class="btn btn-warning result__delete" style="display: none;">
						<input type="button" value="Modify" class="btn btn-primary result__modify">
					</div>
				</div>
			</section>
			
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	
});//

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
				document.querySelector('.result__confirm').value = 'Modify';
				document.querySelector('.result__confirm').classList.add('result__modify');
				document.querySelector('.result__modify').classList.remove('result__confirm');
				$('.card-body').css('padding', '1rem 1rem');
				$('.result__updatedAt').text(data.updatedAt);
			}
		})
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
				location.href="/notice";
			}
		}
	});
	console.log(notice);
});

</script>
</body>

