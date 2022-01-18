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
					<div class="table-responsive-lg">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">Title</th>
									<th scope="col">BuildCD</th>
									<th scope="col">RegDate</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${result.dtoList }">
									<tr>
										<th scope="row">${dto.no }</th>
										<td>${dto.title }</td>
										<td>${dto.buildCd }</td>
										<fmt:parseDate value="${dto.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate" type="both"/>
										<td><fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<ul class="pagination h-100 justify-content-center align-items-center">
							<c:if test="${result.prev}">
					            <li class="page-item" >
					                <a class="page-link" href="/notice?page=${result.start -1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}" tabindex="-1">Previous</a>
					            </li>
							</c:if>
							<c:forEach var="page" items="${result.pageList}">
					            <li class="page-item ${result.page == page? 'active':''}">
					                <a class="page-link" href="/notice?page=${page}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">
					                    ${page}
					                </a>
					            </li>
				            </c:forEach>
							<c:if test="${result.next}">
					            <li class="page-item">
					                <a class="page-link" href="/notice?page=${result.end + 1}&type=${pageRequestDTO.type}&keyword=${pageRequestDTO.keyword}">Next</a>
					            </li>
				            </c:if>
				        </ul>
					</div>
				</div>
			</section>
		</div>
	</div>
<script type="text/javascript">
	
</script>
</body>

