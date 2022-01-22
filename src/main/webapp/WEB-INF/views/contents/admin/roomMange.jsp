<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
					<h2 class="col-sm-10 title">RoomManage</h2>
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
									<th scope="col" style="border-top: 0px !important;">RoomNo</th>
									<th scope="col" style="border-top: 0px !important;">Title</th>
									<th scope="col" style="border-top: 0px !important;">Content</th>
									<th scope="col" style="border-top: 0px !important;">Max</th>
									<th scope="col" style="border-top: 0px !important;">RegDate</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${result.dtoList}">
								${dto }
									<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
									<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" var="nowDate" />
									<fmt:formatDate value="${regDate}" var="reg" pattern="yyyy/MM/dd"/>
									<fmt:formatDate value="${regDate}" var="regTime" pattern="HH:mm:ss"/>
									<tr>
										<th scope="row">
											<img src="${dto.images[0] }"/>
										</th>
										<th scope="row">
											${dto.roomNum } &nbsp; <span class="dot" style="height: 15px; width: 15px; background-color: ${dto.colorCd}; border-radius: 50%; display: inline-block; border: 0.5px solid;"></span>
										</th>
										<td class="result__title"><a class="result__no" href="/admin/roomManage/${dto.no }">${dto.roomTitle } </a>
											<c:if test="${nowDate == reg}">&nbsp;&nbsp;<i class="fas fa-plus-square"></i></c:if>
											<c:if test="${dto == '1'}">&nbsp;&nbsp;<i class="fas fa-lock"></i></c:if>
										</td>
										<td class="result__buildCd"><c:out value="${fn:length(dto.explanation) > 5 ? fn:substring(dto.explanation,0,5) : dto.explanation}"/><c:out value="${fn:length(dto.explanation) > 5 ? '...' : ''}"/></td>
										<td class="result__buildCd">${dto.max }</td>
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
		location.href = $(this).find('.result__no').attr('href')+'?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	});
	$('.result__register').click(function(){
		location.href = '/admin/roomManage/register?page=${result.page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}';
	})
	let = '&nsbp;';
	$('.result__no').text()
	let msg = '${msg}';
	console.log(msg);
});
</script>
</body>

