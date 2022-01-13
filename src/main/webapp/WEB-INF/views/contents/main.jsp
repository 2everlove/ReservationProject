<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
    <script type="text/javascript">
	    $(document).ready(function(){
	    	var owl = $('.owl-carousel');
	    	owl.owlCarousel({
	    	    autoWidth:true,
	    	    stagePadding: 50,
	    	    loop:true,
	    	    nav:true,
	    	    navText : ['<i class="fa fa-angle-left" aria-hidden="true"></i>','<i class="fa fa-angle-right" aria-hidden="true"></i>'],
	    	    margin:10,
	    	    responsive:{
	    	        0:{
	    	            items:1
	    	        },
	    	        600:{
	    	            items:3
	    	        },            
	    	        960:{
	    	            items:5
	    	        },
	    	        1200:{
	    	            items:6
	    	        }
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
        <header class="masthead">
			<div class="owl-carousel owl-theme owl-loaded owl-drag">
				  <div><img src="/resources/assets/img/portfolio/thumbnails/1.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/portfolio/thumbnails/2.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/portfolio/thumbnails/3.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/portfolio/thumbnails/4.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div><img src="/resources/assets/img/portfolio/thumbnails/5.jpg" alt="Los Angeles" width="1100" height="500"></div>
				  <div class="owl-nav"></div>
				  <div class="owl-dot"></div>
			</div>
        </header>
        
</html>
