<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/calendar.css">
<script type="text/javascript" src="/resources/js/calendar.js"></script>

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
				<div class="form-group row" style="align-items: center;">
					<h2 class="col-sm-10 title">相談</h2>
					<div class="col-sm-2">
						<input type="button" value="Register" class="form-control btn btn-primary result__register btn-sm">
					</div>
				</div>
					<hr/>
					<div class="table-responsive-lg">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col" style="border-top: 0px !important;">#</th>
									<th scope="col" style="border-top: 0px !important;">Title</th>
									<th scope="col" style="text-align: center; border-top: 0px !important;">Name</th>
									<th scope="col" style="text-align: center; border-top: 0px !important;" >RegDate</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${result.dtoList}">
									<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
									<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" var="nowDate" />
									<fmt:formatDate value="${regDate}" var="reg" pattern="yyyy/MM/dd"/>
									<fmt:formatDate value="${regDate}" var="regTime" pattern="HH:mm:ss"/>
									<c:choose>
										<c:when test="${dto.deleteFlg != '1'}">
											<tr data-flg="${dto.lockFlg }" data-no="${dto.no }">
												<th class="result__no" scope="row">
												<c:if test="${dto.depth != 0 }">
													<c:forEach begin="0" end="${dto.depth - 1}"><span style="margin-left: 20px;"></span></c:forEach>
													<i class="fas fa-reply-all" style="transform: rotate(180deg);"></i>
												</c:if>
													${dto.no }
												</th>
												<td class="result__title"><a href="/consultation/${dto.no }?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">
													<c:if test="${dto.name == 'Admin'}">
														<span style="background-color: #dfe6e9;border-radius: 3px;">${dto.title }</span>
													</c:if>
													<c:if test="${dto.name != 'Admin'}">
														${dto.title }
													</c:if>
												</a>
													<c:if test="${nowDate == reg}">&nbsp;&nbsp;<i class="fas fa-plus-square"></i></c:if>
													<c:if test="${dto.lockFlg == '1'}">&nbsp;&nbsp;<i class="fas fa-lock" style="color: #FFC312;"></i></c:if>
												</td>
												
												<td class="result__name" style="text-align: center;"><span style="text-align: center; <c:if test="${dto.name == 'Admin'}">background-color: #dfe6e9;border-radius: 3px;</c:if>">${dto.name }</span></td>
												<td class="result__createdAt" style="text-align: center;"><c:out value="${nowDate == reg ? regTime : reg}"></c:out></td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="4" class="result__unShowing" style="text-align: center;background-color: lightgrey;">削除された掲示板です</td>
											</tr>
										</c:otherwise>
									</c:choose>
										
									
								</c:forEach>
							</tbody>
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
			</section>
		</div>
	</div>
<div class="modal consultation-modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Check PassWord</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group row" style="justify-content: flex-end;">
					<label for="" class="col-sm-2 col-form-label">Passwd</label>
					<div class="col-sm">
						<input class="form-control reply__register-pw" autocomplete="off" type="password" placeholder="" />
					</div>
				</div>
				<p class="response__data"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary checkPwBtn">check</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
let modal = $('.consultation-modal');
let no = "";
$(document).ready(function(){
	$(".consultation-modal").on('keyup', '.reply__register-pw', function(key){
		if(key.keyCode == 13)
			$('.checkPwBtn').click();
	});
	$('.result__title').closest('tr').click(function(){
		if($(this).data('flg') === 1){
			modal.modal('show');
			$('.reply__register-pw').focus();
			no=$(this).data('no');
			return false
		}
		location.href = '/consultation/'+$(this).find('.result__no').text()+'?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	});
	$('.result__register').click(function(){
		location.href = '/consultation/register?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	})
	let = '&nsbp;';
	$('.result__no').text()
	let msg = '${msg}';
	console.log(msg);
	if(msg !== ''){
		$('.colorMark').css('background-color', '#0be881');
		$('.toast').toast('show');
		$('.toast-body').text(msg+" 番の文が登録されました。");
	}
	if(localStorage.msg !== '' && localStorage.msg !== undefined){
		$('.colorMark').css('background-color', '#EA2027');
		$('.toast').toast('show');
		$('.toast-body').text(localStorage.msg+" 番の文が削除されました。");
		localStorage.removeItem('msg')
	}
});

//close modal
$('.modal-footer .btn-secondary, .close').click(function(){
	modal.modal('hide');
});

$('.checkPwBtn').click(function(){
	checkPassword();
});

function checkPassword(){
	let formData = new FormData();
	formData.append('no',no)
	formData.append('passwd', $('.reply__register-pw').val());
	$.ajax({
		url: '/api/consultation/chkPasswd',
		method: 'post',
		dataType : 'text',
		data: formData,
		processData: false, //프로세스 데이터 설정 : false 값을 해야 form data로 인식합니다
        contentType: false, //헤더의 Content-Type을 설정 : false 값을 해야 form data로 인식합니다
		success: function(data){
			console.log(data)
			lockDisplay = data;
			if(data != ''){
				location.href = '/consultation/'+no+'?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
			}
		}
	});
}
</script>
</body>

