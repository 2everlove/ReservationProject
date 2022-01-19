<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
    <script type="text/javascript">
	    $(document).ready(function(){
	    	var owl = $('.owl-carousel');
	    	owl.owlCarousel({
	    		items:4,
	    	    autoWidth:true,
	    	    center:true,
	    	    autoplay:true,
	    	    autoplayTimeout:5000,
	    	    autoplayHoverPause:true,
	    	    animateOut: 'slideOutDown',
	    	    smartSpeed:700,
	    	    stagePadding: 50,
	    	    loop:true,
	    	    nav:true,
	    	    dots: true,
	    	    navText : ['<i class="fa fa-angle-left" aria-hidden="true"></i>','<i class="fa fa-angle-right" aria-hidden="true"></i>'],
	    	    margin:10,
	    	    responsiveClass:true,
	    	    rewind: true,
	    	    responsive:{
	    	        0:{
	    	            items:1
	    	        },
	    	        600:{
	    	            items:3
	    	        },            
	    	        960:{
	    	            items:4
	    	        },
	    	        
	    	    }
	    	});
	    	owl.on('mousewheel', '.owl-stage', function (e) {
	    	    if (e.deltaY>0) {
	    	        owl.trigger('next.owl');
	    	    } else {
	    	        owl.trigger('prev.owl');
	    	    }
	    	    e.preventDefault();
	    	});
		});
    </script>
    <style>
    	.owl-carousel{position: relative;}
    	.owl-nav{font-size: 80px;}
    	.owl-prev:hover, .owl-next:hover{transition: all ease 300ms 0s !important;; background-color: rgba(255, 255, 255, .8) !important;;}
    	.owl-dots {display: block; position:relative; text-align: center;} 
    	.owl-prev{margin: 0px !important; background-color: rgba(255, 255, 255, .3) !important; left: 0 !important; border-radius: 5px; position: absolute; top: 0; width: 10%; height: 95%; display: flex !important; align-items: center; justify-content: center;}
    	.owl-next{margin: 0px !important; background-color: rgba(255, 255, 255, .3) !important; right: 0 !important; border-radius: 5px; position: absolute; top: 0; width: 10%; height: 95%; display: flex !important; flex-direction: column; justify-content: center; align-items: center}
    	.owl-nav .owl-prev, .owl-nav .owl-next{ display:inline-block; margin:5px;} 
    	.owl-dots .owl-dot {display: inline-block; background-color: #a4b0be !important; width: 12px; height: 12px; border-radius: 50%; margin:5px ; } 
    	.owl-dots .active {background-color:#666 !important;}
    </style>
        
      	<div class="bg-dark " style="height: 94px"></div>
        <header class="masthead" style="padding-top: 10% !important">
			<!-- <div class="owl-carousel owl-theme owl-loaded owl-drag">
				  <div><img src="/resources/assets/img/room/room1.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/room/room2.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/room/room3.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/room/room4.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/room/room5.jpg" alt="Los Angeles" width="1100" height="500"></div>
			</div> -->
			<div class="container px-4 px-lg-5">
			<div class="table-responsive-lg">
			
        <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel" style="width: 100%; height: 100%; max-height: 600px; margin: 0 auto;">
  <div class="carousel-indicators" style="background-color: rgba(255, 218, 121,0.1)">
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="10000" style="width:100%; max-height: 600px;">
      <img src="/resources/assets/img/room/room3.jpg" alt="Los Angeles" class="d-block w-100">
      <div class="carousel-caption d-none d-md-block" style="background-color: rgba(255, 218, 121,0.3)">
        <h5>First slide label</h5>
        <p>Some representative placeholder content for the first slide.</p>
      </div>
    </div>
    <div class="carousel-item" data-bs-interval="2000" style="width:100%; max-height: 600px;">
      <img src="/resources/assets/img/room/room2.jpg" alt="Los Angeles"  class="d-block w-100" >
      <div class="carousel-caption d-none d-md-block" style="background-color: rgba(255, 218, 121,0.3)">
        <h5>Second slide label</h5>
        <p>Some representative placeholder content for the second slide.</p>
      </div>
    </div>
    <div class="carousel-item" style="width:100%; max-height: 600px;">
      <img src="/resources/assets/img/room/room4.jpg" alt="Los Angeles" class="d-block w-100" style="max-height: 600px;">
      <div class="carousel-caption d-none d-md-block" style="background-color: rgba(255, 218, 121,0.3)">
        <h5>Third slide label</h5>
        <p>Some representative placeholder content for the third slide.</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</div>
</div>
        </header>
        <!-- <div class="d-block h-100" style="width:70rem !important; height:40rem !important; background-image: url('/resources/assets/img/room/room3.jpg');  background-size: cover;"></div> -->
        
</html>
