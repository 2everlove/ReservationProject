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
            <c:forEach items="${roomInfoList}" var="roomInfo" varStatus="status">
	        	<section class="projects-section bg-light" style="margin-top: 5px;">
		            <div class="container px-4 px-lg-5">
		            	<div style="">
		                <!-- Featured Project Row-->
		               
		                <div class="row gx-0 mb-4 mb-lg-5 align-items-center" OnClick="location.href ='booking/${roomInfo.no}'" style="cursor:pointer; display: flex; justify-content: flex-end; margin-bottom: 0rem !important; padding: 1rem 0 1rem 0;" onmouseout="this.style.background='#F8F9F7';" onmouseover="this.style.background= 'rgba(170, 166, 157,0.3)';">
		                	<c:url value="/api/display" var="firstImage">
								<c:param name="fileName" value="${roomInfo.images[0]}"></c:param>
							</c:url>
		                    <div class="col-xl-3 col-lg-7">
		                    	<h2 style="padding-top: 10px;">${roomInfo.roomNum }号</h2>
		                    	<img class="img-fluid mb-3 mb-lg-0" src="${firstImage }" alt="..." style=""/>
		                    </div>
		                    <div class="col-xl-4 col-lg-5">
		                        <div class="featured-text text-center text-lg-left">
		                         	
		                            <h4>${roomInfo.roomTitle }</h4>
		                            <p class="text-black mb-0" style="text-align: right; word-wrap: break-word; width:300px; overflow: auto;">
		                            <br/>
		                            <br/>
		                            </p>
		                            <p class="text-black mb-0" style="text-align: right; margin-right: 30px;">
		                            	<b>￥</b><span style="color: #e12d2d;"><fmt:formatNumber type="number" value="${roomInfo.adultCost }"/></span>
		                            	<br/>
		                            	<br/>
			                            <button type="button" class="btn btn-primary btn-lg">Reserve</button>
		                            </p>
		                            <p></p>
		                            <br/>
		                            <div class="table-responsive-lg">
										<table class="table table-hover">
											<thead>
												<tr>
													<th scope="col">Info</th>
													<th scope="col">Adult</th>
													<th scope="col">Child</th>
													<th scope="col">最大人数</th>
												</tr>
											</thead>
											<tbody>
											<tr>
												<th scope="row">${roomInfo.buildCd}層　${roomInfo.roomNum }号</th>
												<td><b>￥</b><b><fmt:formatNumber type="number" value="${roomInfo.adultCost }"/></b></td>
												<td><b>￥</b><b><fmt:formatNumber type="number" value="${roomInfo.childCost }"/></b></td>
												<td><b>${roomInfo.max}</b> 人</td>
											</tr>
											</tbody>
										</table>
									</div>
		                        </div>
		                    </div>
		                </div>
		                
		                
	                <!-- 
	                <div class="row gx-0 mb-5 mb-lg-0 justify-content-center">
	                    <div class="col-lg-6"><img class="img-fluid" src="/resources/assets/img/room/room2.jpg" alt="..." /></div>
	                    <div class="col-lg-6">
	                        <div class="bg-black text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-left">
	                                    <h4 class="text-white">Misty</h4>
	                                    <p class="mb-0 text-white-50">An example of where you can put an image of a project, or anything else, along with a description.</p>
	                                    <hr class="d-none d-lg-block mb-0 ms-0" />
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                Project Two Row
	                <div class="row gx-0 justify-content-center">
	                    <div class="col-lg-6"><img class="img-fluid" src="/resources/assets/img/room/room3.jpg" alt="..." /></div>
	                    <div class="col-lg-6 order-lg-first">
	                        <div class="bg-black text-center h-100 project">
	                            <div class="d-flex h-100">
	                                <div class="project-text w-100 my-auto text-center text-lg-right">
	                                    <h4 class="text-white">Mountains</h4>
	                                    <p class="mb-0 text-white-50">Another example of a project with its respective description. These sections work well responsively as well, try this theme on a small screen!</p>
	                                    <hr class="d-none d-lg-block mb-0 me-0" />
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div> -->
	            </div>
	            </div>
	        	</section>			
                <hr style="border: none; font-size: 0; line-height: 0; margin: 10px 0 10px 0; color: rgba(132, 129, 122,1.0); background:rgba(132, 129, 122,1.0); height: 3px;"/>
           	</c:forEach>
				<!-- <div class="table-responsive-lg">
					<table class="table table-hover">
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">First</th>
					      <th scope="col">Last</th>
					      <th scope="col">Handle</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">1</th>
					      <td>Mark</td>
					      <td>Otto</td>
					      <td>@mdo</td>
					    </tr>
					    <tr>
					      <th scope="row">2</th>
					      <td>Jacob</td>
					      <td>Thornton</td>
					      <td>@fat</td>
					    </tr>
					    <tr>
					      <th scope="row">3</th>
					      <td colspan="2">Larry the Bird</td>
					      <td>@twitter</td>
					    </tr>
					  </tbody>
					</table>
				</div> -->
		</div>
	</div>
<script type="text/javascript">
	
</script>
</body>

