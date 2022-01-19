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
				${result }
					<c:if test="${result.depth == 0}">
						<div class="card">
							<div class="card-header">
								<div class="input-group">
									<div class="col-sm-3">
									<label for="staticEmail" class="col-sm col-form-label" style="text-align: center;">${result.no }</label>
									</div>
									<div class="col-sm-4">
									<label for="staticEmail" class="col-sm col-form-label" style="text-align: center;">${result.name }</label>
									</div>
									<div class="col-sm-5">
										
									<fmt:parseDate value="${result.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="modDate" type="both"/>
									<label for="staticEmail" class="col-sm col-form-label result__updatedAt" style="text-align: center;"><fmt:formatDate value="${modDate}" pattern="yyyy-MM-dd HH:mm"/></label>
									</div>
								</div>
							</div>
							
							<div class="card-body">
								<input type="text" aria-label="Last name" class="form-control form-control-lg result__title" value="${result.title }">
							</div>
							<div class="card-body" style="height:50%; min-height: 100px;">
								<div id="summernote">${result.contents }</div>
							</div>
						</div>
					</c:if>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-top: 1rem">
						<input type="button" value="Delete" class="btn btn-warning result__delete" style="display: none;">
						<input type="button" value="Modify" class="btn btn-primary result__modify">
					</div>
					<hr/>
					<!--  -->
					<div class="card mb-2">
						<div class="card-header bg-light">
					        <i class="fa fa-comment fa"></i> REPLY
						</div>
						<div class="card-body">
							<ul class="list-group list-group-flush">
							    <li class="list-group-item">
									<div class="form-inline mb-10" style="justify-content: space-around;">
										<div class="form-group row" >
											<label for="replyId" class="col-sm-2 col-form-label"><i class="fa fa-user-circle-o fa-2x"></i></label>
											<div class="col-sm-4">
												<input type="text" class="form-control ml-2" placeholder="Enter yourId" id="replyId">
											</div>
										</div>
										<div class="form-group row">
											<label for="replyPassword" class="col-sm-2 col-form-label"><i class="fa fa-unlock-alt fa-2x"></i></label>
											<div class="col-sm-4">
												<form>
													<input type="password" class="form-control ml-2" placeholder="Enter password" autocomplete="off" id="replyPassword">
												</form>
											</div>
										</div>
									</div>
									<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
									<button type="button" class="btn btn-dark mt-3" onClick="javascript:addReply();">post reply</button>
							    </li>
							</ul>
						</div>
					</div>
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
	
});//
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
		$('.result__delete').show();
		$('#contents').hide();
		document.querySelector('.result__modify').value = 'Confirm';
		document.querySelector('.result__modify').classList.add('result__confirm');
		document.querySelector('.result__confirm').classList.remove('result__modify');
		$('.card-body').css('padding', '0rem 0rem');
	} else {
		$('#summernote').summernote('destroy');
		$('.result__delete').hide();
		$('#contents').show();
		document.querySelector('.result__confirm').value = 'Modify';
		document.querySelector('.result__confirm').classList.add('result__modify');
		document.querySelector('.result__modify').classList.remove('result__confirm');
		$('.card-body').css('padding', '1rem 1rem');
	}
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

</script>
</body>

