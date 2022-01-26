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
									<tr>
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
<script type="text/javascript">
$(document).ready(function(){
	$('.result__title').closest('tr').click(function(){
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
</script>
</body>

