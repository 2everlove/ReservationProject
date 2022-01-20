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
				<h2 class="col-sm-10 title-detail">相談-詳細</h2>
				<h2 class="col-sm-10 title-modify" style="display: none;">相談-修正</h2>
				<hr/>
					<c:if test="${result.depth == 0 || result == null}">
						<div class="card">
							<div class="card-header">
								<div class="input-group">
									<div class="col-sm-3">
									<label for="staticEmail" class="col-sm col-form-label" style="text-align: center;">${result.no }</label>
									</div>
									<div class="col-sm-4">
									<c:if test="${result != null}">
										<label for="staticEmail" class="col-sm col-form-label" style="text-align: center;">${result.name }</label>
									</c:if>
									<c:if test="${result == null}">
										<div class="form-check" style="display: flex; justify-content: space-between; align-items: center;">
											<label class="form-check-label" for="defaultCheck1">
												<input class="form-check-input result__checkedPw" name="lockFlg" type="checkbox" value="${result.lockFlg }" >
												<input class="form-check-input result__checkdeleteFlg" name="deleteFlg" type="hidden" value="0" >
												<i class="fas fa-lock-open"></i>
												<i class="fas fa-lock" style="display: none;"></i>
											</label>
											<input type="password" name="passwd" placeholder="Password" class="form-check result__passwd" style="width: 80%; padding-left: 0.5rem !important; display: none;">
										</div>
									</c:if>
									</div>
									<div class="col-sm-5">
									<c:if test="${result != null}">
										<fmt:parseDate value="${result.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modDate" type="both"/>
										<label for="staticEmail" class="col-sm col-form-label result__updatedAt" style="text-align: center;"><fmt:formatDate value="${modDate}" pattern="yyyy-MM-dd HH:mm"/></label>
									</c:if>
									<c:if test="${result == null}">
										<input type="input" value="" name="name" placeholder="Name" class="form-control form-control-sm result__name" style="width: 80%;">
									</c:if>
									</div>
								</div>
							</div>
							
							<div class="card-body">
								<c:if test="${result == null}">
									<input type="text" aria-label="Last name" class="form-control form-control-lg result__title" placeholder="Title" value="${result.title }" readonly>
								</c:if>
								<c:if test="${result != null}">
									<div class="form-check" style="display: flex; justify-content: space-between; align-items: center;">
										<input type="text" aria-label="Last name" class="form-check form-control-lg result__title" placeholder="Title" value="${result.title }" readonly style="width: 50%; padding-left: 0.5rem !important;">
										<label class="form-check-label" for="defaultCheck1" style="display: none;">
											<input class="form-check-input result__checkedPw" name="lockFlg" type="checkbox" value="${result.lockFlg }" >
											<input class="form-check-input result__checkdeleteFlg" name="deleteFlg" type="hidden" value="0" >
											<i class="fas fa-lock-open"></i>
											<i class="fas fa-lock" style="display: none;"></i>
										</label>
										<input type="password" name="passwd" value="${result.passwd }" placeholder="Password" class="form-check result__passwd" style="width: 30%; padding-left: 0.5rem !important; display: none;">
									</div>
								</c:if>
							</div>
							<div class="card-body" style="height:50%; min-height: 100px;">
								<div id="summernote">${result.contents }</div>
								<input type="hidden" name="contents">
							</div>
						</div>
					</c:if>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 1rem">
						<c:if test="${result != null}">
							<input type="button" value="Delete" class="btn btn-warning result__delete" style="display: none;">
							<input type="button" value="Modify" class="btn btn-primary result__modify">
						</c:if>
						<c:if test="${result == null}">
							<input type="button" value="Register" class="btn btn-primary result__register">
						</c:if>
					</div>
					<hr/>
					<!--  -->
				</div>
			</section>
		</div>
	</div>
<div class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Modal title</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-4">
						<input class="form-control reply__register-name" type="text" placeholder="" />
					</div>
					<label for="" class="col-sm-2 col-form-label">Passwd</label>
					<div class="col-sm-4">
						<form>
							<input class="form-control reply__register-pw" autocomplete="off" type="password" placeholder="" />
						</form>
					</div>
				</div>
				<p class="response__data"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary payReserve">Payment</button>
				<button type="button" class="btn btn-primary checkOrder" style="display: none">checkOrder</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	let checkContents = '<c:out value="${result == null ? 'emp': 'full'}"></c:out>';
	if('emp'==checkContents){
		$('#summernote').summernote({
		    tabsize: 2,
		    placeholder: 'Content',
		    minHeight: 200,
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
	}
	
});//
$('.result__checkedPw').click(function(){
	checkPwFlg();
});

function checkPwFlg(){
	if($('.result__checkedPw').is(":checked")){
		$('.result__checkedPw').val(1);
		$('.fa-lock-open').hide();
		$('.fa-lock').show();
		$('.result__passwd').show();
	} else {
		$('.result__checkedPw').val(0);
		$('.fa-lock-open').show();
		$('.fa-lock').hide();
		$('.result__passwd').hide();
		$('.result__passwd').val('');
	}
}
<c:if test="${result == null}">

	let actionForm = document.createElement("form");
	$('.result__register').click(function(){
		submit('/consultation/register', 'POST', [
		    { name: 'title', value: $('.result__title').val() },
		    { name: 'contents', value: $('#summernote').summernote('code') },
		    { name: 'name', value: $('.result__name').val() },
		    { name: 'lockFlg', value: $('.result__checkedPw').val() },
		    { name: 'deleteFlg', value: $('.result__checkdeleteFlg').val() },
		    { name: 'passwd', value: $('.result__passwd').val() },
		    { name: 'depth', value: '0' },
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

<c:if test="${result != null}">
let modal = $('.modal');
$('.result__modify').click(function(){
	
	$('#summernote').summernote({
	    tabsize: 2,
	    minHeight: 200,
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
		console.log($('.result__checkedPw').val());
		console.log(1 == $('.result__checkedPw').val());
		if(1 == $('.result__checkedPw').val()){
			$('.result__checkedPw').prop("checked",true);
			$('.form-check-label').show();
			$('.fa-lock-open').hide();
			$('.fa-lock').show();
			checkPwFlg();
		}
		
		$(".result__title").attr("readonly",false);
		$('.form-check-label').show();
		$('.title-detail').hide();
		$('.title-modify').show();
		$('.result__delete').show();
		$('#contents').hide();
		document.querySelector('.result__modify').value = 'Confirm';
		document.querySelector('.result__modify').classList.add('result__confirm');
		document.querySelector('.result__confirm').classList.remove('result__modify');
		$('.card 1rem 0rem 1remdding', '1rem 1rem 0rem 1rem');
	} else {
		let consultation = {
				no: '${result.no}',
				title: $('.result__title').val(),
			    contents: $('#summernote').summernote('code'),
			    name: '${result.name}',
			    lockFlg: $('.result__checkedPw').val(),
			    deleteFlg: $('.result__checkdeleteFlg').val(),
			    passwd: $('.result__passwd').val(),
			    grno: '${result.no}',
			    depth: '0'
			}
		console.log(consultation);
		$.ajax({
			url: '/api/consultation',
			method: 'post',
			data: JSON.stringify(consultation),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			success: function(data){
				$('.title-modify').hide();
				$('.title-detail').show();
				$('.title-modify').hide();
				$('.form-check-label').hide();
				$('#summernote').summernote('destroy');
				$('.result__delete').hide();
				$('#contents').show();
				document.querySelector('.result__confirm').value = 'Modify';
				document.querySelector('.result__confirm').classList.add('result__modify');
				document.querySelector('.result__modify').classList.remove('result__confirm');
				$('.card-body').css('padding', '1rem 1rem');
				$('.result__updatedAt').text(data.updatedAt);
				console.log(data)
				$('.result__checkedPw').val(data.lockFlg);
				if(data.lockFlg == '1'){
					$('.result__checkedPw').prop("checked",true);
					$('.result__passwd').val(data.passwd);
					$('.result__passwd').hide();
				} else {
					$('.result__checkedPw').prop("checked",false);
					$('.result__passwd').val(data.passwd);
					$('.result__passwd').hide();
				}
				$(".result__title").attr("readonly",true);
			}
		})
	
	}
		/* $('.title-detail').show();
		$('.title-modify').hide();
		$('#summernote').summernote('destroy');
		$('.result__delete').hide();
		$('#contents').show();
		document.querySelector('.result__confirm').value = 'Modify';
		document.querySelector('.result__confirm').classList.add('result__modify');
		document.querySelector('.result__modify').classList.remove('result__confirm');
		$('.card-body').css('padding', '1rem 1rem'); */
	
});//

$('.result__delete').click(function(){
	if('<c:out value="${result.passwd != null && result.passwd != ''? 'lock':'unlock'}"></c:out>' == 'lock'){
		modal.modal('show');
	}
	else {
		
	}
});
//close modal
$('.modal-footer .btn-secondary, .close').click(function(){
	modal.modal('hide');
});
</c:if>
</script>
</body>

