<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
    <script type="text/javascript">
	    $(document).ready(function(){
	    	let owl = $('.owl-carousel');
	    	owl.owlCarousel({
	    		animateOut: 'slideOutDown',
	    	    animateIn: 'flipInX',
	    		items:5,
	    	    center:true,
	    	    autoplay:true,
	    	    autoplayTimeout:5000,
	    	    autoplayHoverPause:true,
	    	    smartSpeed:700,
	    	    loop:true,
	    	    margin:10,
	    	    nav:false,
	    	    responsiveClass:true,
	    	    responsive:{
	    	        0:{
	    	            items:1,
	    	        },
	    	        600:{
	    	            items:3,
	    	        },            
	    	        960:{
	    	            items:4,
	    	       
	    	        },
	    	        
	    	    }
	    	});
	    	owl.on('mousewheel', '.owl-stage', function (e) {
	    		if (e.originalEvent.wheelDelta >= 120) {
	            	owl.trigger('prev.owl');
	            } else if (e.originalEvent.wheelDelta <= -120) {
	    			owl.trigger('next.owl');
	            }
	    	    e.preventDefault();
	            return false;
	    	});
	    	
	    	/* var myelement = document.getElementById("carouselExampleDark"); 
		    
		    function makeItSo() {
		        // this is where you tell it to go to the next slide
		        $('.carousel').carousel('next')
		      }

		      myelement.addEventListener('wheel', function(e) {      
		            makeItSo();
		            $(document).off(".disableScroll"); 

		      });
		      
		      /* $.fn.extend({
		    	    mouse_wheel: function() {
		    	        $(this).on('mousewheel', function(e) {
		    	            if (e.originalEvent.wheelDelta >= 120) {
		    	                this.scrollTop -= 50;
		    	            } else if (e.originalEvent.wheelDelta <= -120) {
		    	                this.scrollTop += 50;
		    	            }
		    	            return false;
		    	        });
		    	    }
		    	});


		    	 
		      $('#carouselExampleDark').mouse_wheel(); */


		});
	    
    </script>
    <style>
    </style>
        
      	<div class="bg-dark " style="height: 94px"></div>
        <header class="masthead" style="padding-top: 0% !important">
        <div class="container-fluid px-2 px-lg-2">
			<div class="owl-carousel owl-drag">
				  <div><img src="/resources/assets/img/room/room1.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room2.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room3.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room4.jpg" alt="Los Angeles" width="800" height="300"></div>
				  <div><img src="/resources/assets/img/room/room5.jpg" alt="Los Angeles" width="800" height="300"></div>
			</div>
		</div>
        <div class="container px-4 px-lg-5">
		</div>
        </header>
        
</html>
