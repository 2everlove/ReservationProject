<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="toast-parent" aria-live="polite" aria-atomic="true" style="position: fixed;right: 10%;bottom: 3%;width: 30%;height: 10%;z-index: 2000;">
  <div class="toast" style="position: absolute; top: 0; right: 0; z-index: 1;">
    <div class="toast-header">
      <div class="rounded mr-2 colorMark" style="width: 20px; height: 20px; border-radius: 3px;"></div>
      <strong class="mr-auto">Success</strong>
      <small></small>
    </div>
    <div class="toast-body">
    	
    </div>
  </div>
</div>

<div></div>

<!-- Footer-->
        <footer class="bg-light py-5">
            <div class="container px-4 px-lg-5"><div class="small text-center text-muted">Copyright &copy; 2021 - (株式会社) Booking</div></div>
            <div class="footer__map">
	    		 <div id="map" style="position: relative;overflow: hidden;width: 800px;height: 500px; margin: 0 auto;margin-top: 1%;"></div>
	    	</div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- SimpleLightbox plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
        <!-- Core theme JS-->
        <script src="/resources/js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="/resources/owlcarousel/owl.carousel.min.js"></script>
        <!-- Swiper JS -->
    	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    	<meta name = "google-signin-client_id" content = "528792888517-7i28jjcjf91j33gj5rtjfbn4fh7h671s.apps.googleusercontent.com">
    	<!--
  Copyright 2021 Google LLC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<!DOCTYPE html>
<html>
  <head>
    <title>Locator</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/handlebars/4.7.7/handlebars.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <script>
    
    
    	/*function initMap() {
    		const building = { lat: 35.691864243850034, lng: 139.8029598111616 };
    		  const map = new google.maps.Map(document.getElementById("map"), {
    		    zoom: 18,
    		    center: building,
    		  });
    	  const contentString =
  		    '<div id="content">' +
  		    '<div id="siteNotice">' +
  		    "</div>" +
  		    '<h3 id="firstHeading" class="firstHeading">Hotel</h3>' +
  		    '<div id="bodyContent">' +
  		    '<p>ホテルの住所 : 東京都千代田区東神田　2-10-14　日本ｾﾝﾁﾞﾐｱﾋﾞﾙ4F</p>'+
  		    "</div>" +
  		    "</div>";
  		  const infowindow = new google.maps.InfoWindow({
  		    content: contentString,
  		  });
  		  const marker = new google.maps.Marker({
  		    position: building,
  		    map,
  		    title: "Uluru (Ayers Rock)",
  		  });

  		  marker.addListener("click", () => {
  		    infowindow.open({
  		      anchor: marker,
  		      map,
  		      shouldFocus: false,
  		    });
  		  });
    	}*/




    </script>
    <script id="locator-result-items-tmpl" type="text/x-handlebars-template">
      {{#each locations}}
        <li class="location-result" data-location-index="{{index}}">
          <button class="select-location">
            <h2 class="name">{{title}}</h2>
          </button>
          <div class="address">{{address1}}<br>{{address2}}</div>
        </li>
      {{/each}}
    </script>
  </head>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAZRGXPhAmgXxh4MfwcjUOV9X9IDazaSIc&callback=initMap&libraries=places,geometry&solution_channel=GMP_QB_locatorplus_v4_cA" async defer></script>
    </body>