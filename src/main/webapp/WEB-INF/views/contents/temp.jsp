<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    html, body { box-sizing: border-box; padding: 0; margin: 0; text-align: center; }
    *, *:before, *:after { box-sizing: inherit; }
    .clearfix:after { content: ''; display: block; clear: both; float: none; }
    .title { margin-bottom: 0; text-align: center; font-size: 30px; color: #333; }
    .link, .link:visited { display: inline-block; margin: 20px 0; color: #555; text-decoration: none; font-weight: bold; }
    .link:hover, .link:focus { color: #9fd6c2; }
    /* container - body */
    #container { width: 1000px; margin: auto; }
    .slide_wrap { position: relative; width: 800px; margin: auto; padding-bottom: 30px; }
    .slide_box { width: 100%; margin: auto; overflow-x: hidden; }
    .slide_content { display: table; float: left; width: 400px; height: 400px; }
    .slide_content > p { display: table-cell; vertical-align: middle; text-align: center; font-size: 100px; font-weight: bold; color: #555; }
    
    .slide_btn_box > button { position: absolute; top: 50%; margin-top: -45px; width: 60px; height: 80px; font-size: 16px; color: #999; background: none; border: 1px solid #ddd; cursor: pointer; }
    .slide_btn_box > .slide_btn_prev { left: 0px; font-size: 50px; }
    .slide_btn_box > .slide_btn_next { right: 0px; font-size: 50px; }
    .slide_pagination { position: absolute; left: 50%; bottom: 35px; list-style: none; margin: 0; padding: 0; transform: translateX(-50%); }
    .slide_pagination .dot { display: inline-block; width: 15px; height: 15px; margin: 0 5px; overflow: hidden; background: #ddd; border-radius: 50%; transition: 0.3s; }
    .slide_pagination .dot.dot_active { background: #333; }
    .slide_pagination .dot a { display: block; width: 100%; height: 100%; }
    .input-group {
    	align-items: center
    }
    .col-lg-4{
    	padding: 5px;
    }
    .input-group-text{
    	height: 38px;
    }
    .row{
    	align-items: center;
    }
  </style>
<body>
	
	<div class="container">
	    <div class='row'> 
	    <div class="col-lg-2">
		    <label>部屋 <select>
	    		<option value="">---</option>
	    	</select></label>
	    </div>
	    <div class="col-lg-3">
	    	<div class="input-group"> 
	    		<div class="input-group date" id="datetimepicker7" data-target-input="nearest">
	                <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker7"/>
	                <div class="input-group-append" data-target="#datetimepicker7" data-toggle="datetimepicker">
	                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                </div>
	            </div>
    		</div> 
   		</div>
   		<div class="col-lg-3">
    		<div class="input-group"> 
    			<div class="input-group date" id="datetimepicker8" data-target-input="nearest">
	                <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker8"/>
	                <div class="input-group-append" data-target="#datetimepicker8" data-toggle="datetimepicker">
	                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
	                </div>
	            </div>
    		</div> 
    	</div>
	</div>
  
  <div id="container">
	<div class="slide_wrap">
	  <div class="slide_box">
	    <div class="slide_list clearfix">
	      <div class="slide_content slide01">
	        <p><img alt="" src="">1</p>
	      </div>
	      <div class="slide_content slide02">
	        <p>2</p>
	      </div>
	      <div class="slide_content slide03">
	        <p>3</p>
	      </div>
	      <div class="slide_content slide04">
	        <p>4</p>
	      </div>
	      <div class="slide_content slide05">
	        <p>5</p>
	      </div>
	    </div>
	    <!-- // .slide_list -->
		</div>
		<!-- // .slide_box -->
		<div class="slide_btn_box">
		  <button type="button" class="slide_btn_prev"><i class="fas fa-chevron-left"></i></button>
		  <button type="button" class="slide_btn_next"><i class="fas fa-chevron-right"></i></button>
		</div>
		<!-- // .slide_btn_box -->
		<ul class="slide_pagination"></ul>
		<!-- // .slide_pagination -->
		</div>
		<!-- // .slide_wrap -->
		</div>
  <!-- // .container -->
	</div>
	<script>
    (function () {
      const slideList = document.querySelector('.slide_list');  // Slide parent dom
      const slideContents = document.querySelectorAll('.slide_content');  // each slide dom
      const slideBtnNext = document.querySelector('.slide_btn_next'); // next button
      const slideBtnPrev = document.querySelector('.slide_btn_prev'); // prev button
      const pagination = document.querySelector('.slide_pagination');
      const slideLen = slideContents.length;  // slide length
      const slideWidth = 400; // slide width
      const slideSpeed = 300; // slide speed
      const startNum = 0; // initial slide index (0 ~ 4)
      
      slideList.style.width = slideWidth * (slideLen + 2) + "px";
      
      // Copy first and last slide
      let firstChild = slideList.firstElementChild;
      let lastChild = slideList.lastElementChild;
      let clonedFirst = firstChild.cloneNode(true);
      let clonedLast = lastChild.cloneNode(true);

      // Add copied Slides
      slideList.appendChild(clonedFirst);
      slideList.insertBefore(clonedLast, slideList.firstElementChild);

      // Add pagination dynamically
      let pageChild = '';
      for (var i = 0; i < slideLen; i++) {
        pageChild += '<li class="dot';
        pageChild += (i === startNum) ? ' dot_active' : '';
        pageChild += '" data-index="' + i + '"><a href="#"></a></li>';
      }
      pagination.innerHTML = pageChild;
      const pageDots = document.querySelectorAll('.dot'); // each dot from pagination

      slideList.style.transform = "translate3d(-" + (slideWidth * (startNum + 1)) + "px, 0px, 0px)";

      let curIndex = startNum; // current slide index (except copied slide)
      let curSlide = slideContents[curIndex]; // current slide dom
      curSlide.classList.add('slide_active');

      /** Next Button Event */
      slideBtnNext.addEventListener('click', function() {
        if (curIndex <= slideLen - 1) {
          slideList.style.transition = slideSpeed + "ms";
          slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 2)) + "px, 0px, 0px)";
        }
        if (curIndex === slideLen - 1) {
          setTimeout(function() {
            slideList.style.transition = "0ms";
            slideList.style.transform = "translate3d(-" + slideWidth + "px, 0px, 0px)";
          }, slideSpeed);
          curIndex = -1;
        }
        curSlide.classList.remove('slide_active');
        pageDots[(curIndex === -1) ? slideLen - 1 : curIndex].classList.remove('dot_active');
        curSlide = slideContents[++curIndex];
        curSlide.classList.add('slide_active');
        pageDots[curIndex].classList.add('dot_active');
      });

      /** Prev Button Event */
      slideBtnPrev.addEventListener('click', function() {
        if (curIndex >= 0) {
          slideList.style.transition = slideSpeed + "ms";
          slideList.style.transform = "translate3d(-" + (slideWidth * curIndex) + "px, 0px, 0px)";
        }
        if (curIndex === 0) {
          setTimeout(function() {
            slideList.style.transition = "0ms";
            slideList.style.transform = "translate3d(-" + (slideWidth * slideLen) + "px, 0px, 0px)";
          }, slideSpeed);
          curIndex = slideLen;
        }
        curSlide.classList.remove('slide_active');
        pageDots[(curIndex === slideLen) ? 0 : curIndex].classList.remove('dot_active');
        curSlide = slideContents[--curIndex];
        curSlide.classList.add('slide_active');
        pageDots[curIndex].classList.add('dot_active');
      });

      /** Pagination Button Event */
      let curDot;
      Array.prototype.forEach.call(pageDots, function (dot, i) {
        dot.addEventListener('click', function (e) {
          e.preventDefault();
          curDot = document.querySelector('.dot_active');
          curDot.classList.remove('dot_active');
          
          curDot = this;
          this.classList.add('dot_active');

          curSlide.classList.remove('slide_active');
          curIndex = Number(this.getAttribute('data-index'));
          curSlide = slideContents[curIndex];
          curSlide.classList.add('slide_active');
          slideList.style.transition = slideSpeed + "ms";
          slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 1)) + "px, 0px, 0px)";
        });
      });
    })();
  </script>
  	


  <script type="text/javascript">
  $(function () {
      $('#datetimepicker7').datetimepicker({format: 'L'});
      $('#datetimepicker8').datetimepicker({
          useCurrent: false,
          format: 'L'
      });
      $("#datetimepicker7").on("change.datetimepicker", function (e) {
          $('#datetimepicker8').datetimepicker('minDate', e.date);
      });
      $("#datetimepicker8").on("change.datetimepicker", function (e) {
          $('#datetimepicker7').datetimepicker('maxDate', e.date);
      });
  });
            
    </script>
</body>
