<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/calendar.css">
<script type="text/javascript" src="/resources/js/calendar.js"></script>

<style>
a{text-decoration: none;}
@media (max-width: 576px) {
    .card-columns {
        column-count: 1 !important;
    }
}
@media (min-width: 576px) {
    .card-columns {
        column-count: 1 !important;
    }
}

@media (min-width: 768px) {
    .card-columns {
        column-count: 1 !important;
    }
}

@media (min-width: 992px) {
    .card-columns {
        column-count: 1 !important;
    }
}

@media (min-width: 1200px) {
    .card-columns {
        column-count: 2 !important;
    }
}
</style>
<body>
	<!-- <div id="calendarForm"></div> -->
	<div class="bg-dark " style="height: 94px"></div>
	<div class="masthead">
		<div style="padding-top: 0px;">
			<div class="container px-4 px-lg-5">
		<c:if test="${showingKey == '0' }">
            <div class="row gx-4 gx-lg-5 justify-content-center" style="margin-top: 60px;">
                <div class="col-md-10 col-lg-8 col-xl-7">
                    <!-- Post preview-->
                    <div class="post-preview">
						<h2 class="post-title">찾으시는 객실이 없습니다.</h2>
						<h3 class="post-subtitle"></h3>
                        <p class="post-meta">
                            Oops. there is full
                            <a href="#!"></a>
                        </p>
                    </div>
                    <div class="d-flex justify-content-end mb-4" onclick="javascript:void(0);"><a class="btn btn-primary text-uppercase" href="#!">이전페이지 →</a></div>
                </div>
            </div>
		</c:if>
	           	<div class="card-columns" style="column-count: 2; padding-top: 2%;">        
            <c:forEach items="${roomInfoList}" var="roomInfo" varStatus="status">
            
	            <c:url value="/api/display" var="firstImage">
					<c:param name="fileName" value="${roomInfo.images[0]}"></c:param>
				</c:url>
			        <div class="card" style="cursor: pointer; width: 500px;" 
			        OnClick="location.href ='/booking/${roomInfo.no}<c:if test="${dateObject.startDate != null && dateObject.startDate != ''}">?startDate=${dateObject.startDate}&endDate=${dateObject.endDate}&adult=${dateObject.adult }&child=${dateObject.child }</c:if>'" onmouseout="this.style.background='#F8F9F7';" onmouseover="this.style.background= 'rgba(170, 166, 157,0.3)';">
			            <div class="row no-gutters" style="align-items: center; justify-content: flex-end; width: 100%; margin: 0; --bs-gutter-x: 0;">
			            	<div style="position: absolute;left: -0.2%;transform: rotate(180deg);top: 9%;width: 0;height: 0;border-bottom: 25px solid ${roomInfo.colorCd};border-left: 25px solid transparent;-webkit-transform-origin-y: top;"></div>
			            	<%-- <div style="background-color: ${roomInfo.colorCd}; position: absolute;width: 5%;left: 0; top: 11.5%;height: 5px; z-index: 1;"></div>
			            	<div style="background-color: ${roomInfo.colorCd}; position: absolute;width: 4%;left: 0; top: 15%;height: 5px; z-index: 1;"></div> --%>
			                <div class="col-sm-4">
			                    <img class="card-img" src="${firstImage }" alt="Suresh Dasari Card">
			                </div>
			                <div class="col-sm-7">
			                    <div class="card-body" style="text-align: right; padding-right: 60px;">
			                        <h5 class="card-title">${roomInfo.roomTitle }</h5>
			                        <p class="card-text"><b>￥</b><span style="color: #e12d2d;"><fmt:formatNumber type="number" value="${roomInfo.adultCost }"/></span></p>
			                        <a onclick="javascript:void(0);" class="btn btn-primary">Reserve</a>
			                    </div>
			                </div>
			            </div>
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
									<th scope="row">${roomInfo.buildCd}層　${roomInfo.roomNum }号室</th>
									<td><b>￥</b><b><fmt:formatNumber type="number" value="${roomInfo.adultCost }"/></b></td>
									<td><b>￥</b><b><fmt:formatNumber type="number" value="${roomInfo.childCost }"/></b></td>
									<td><b>${roomInfo.max}</b> 名</td>
								</tr>
								</tbody>
							</table>
						</div>
			        </div>
				</c:forEach>
           	</div>
		</div>
	</div>
	
<script type="text/javascript">
<c:if test="${showingKey == '0' }">
	$('.d-flex').click(function(){
		location.href = "/";
	})
</c:if>

$(document).ready(function(){
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
</script>
</body>

