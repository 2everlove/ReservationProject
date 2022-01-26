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
			<section class="projects-section bg-light" style="margin-top: 20px; padding-bottom: 40px;">
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
									<th scope="col" style="border-top: 0px !important;">Name</th>
									<th scope="col" style="border-top: 0px !important;">RegDate</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${result.dtoList}">
									<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
									<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" var="nowDate" />
									<fmt:formatDate value="${regDate}" var="reg" pattern="yyyy/MM/dd"/>
									<fmt:formatDate value="${regDate}" var="regTime" pattern="HH:mm:ss"/>
									<tr data-flg="${dto.lockFlg }" data-no="${dto.no }">
										<th class="result__no" scope="row">
											<c:if test="${dto.depth != 0 }">
												<c:forEach begin="0" end="${dto.depth - 1}"><span style="margin-left: 20px;"></span></c:forEach>
												<i class="fas fa-reply-all" style="transform: rotate(180deg);"></i>
											</c:if>
												${dto.no }
										</th>
										<td class="result__title"><a href="/consultation/${dto.no }">${dto.title } </a>
											<c:if test="${nowDate == reg}">&nbsp;&nbsp;<i class="fas fa-plus-square"></i></c:if>
											<c:if test="${dto.lockFlg == '1'}">&nbsp;&nbsp;<i class="fas fa-lock"></i></c:if>
										</td>
										
										<td class="result__buildCd">${dto.name }</td>
										<td class="result__createdAt"><c:out value="${nowDate == reg ? regTime : reg}"></c:out></td>
										
									</tr>
									
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
					<label for="" class="col-sm-2 col-form-label">Passwd</label>
					<div class="col-sm">
						<form>
							<input class="form-control reply__register-pw" autocomplete="off" type="password" placeholder="" />
						</form>
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
let modal = $('.modal');
let no = "";
$(document).ready(function(){
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

