/*!
* Start Bootstrap - Creative v7.0.5 (https://startbootstrap.com/theme/creative)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-creative/blob/master/LICENSE)
*/
//
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Navbar shrink function
    var navbarShrink = function () {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
            document.body.querySelector(".dropdown-menu").classList.add('bg-dark')
            document.body.querySelectorAll('.dropdown-item')[0].classList.add("text-white")
            document.body.querySelectorAll('.dropdown-item')[1].classList.add("text-white")
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
            document.body.querySelector(".dropdown-menu").classList.remove('bg-dark')
            document.body.querySelectorAll('.dropdown-item')[0].classList.remove("text-white")
            document.body.querySelectorAll('.dropdown-item')[1].classList.remove("text-white")
        }

    };
    
    if (window.matchMedia("(min-width: 992px)").matches) {
    	  /* 뷰포트 너비가  픽셀 이상 */
	    	document.body.querySelector(".dropdown-menu").classList.add('bg-dark')
	        document.body.querySelectorAll('.dropdown-item')[0].classList.add("text-white")
	        document.body.querySelectorAll('.dropdown-item')[1].classList.add("text-white")
    	} else {
    		document.body.querySelector(".dropdown-menu").classList.remove('bg-dark')
            document.body.querySelectorAll('.dropdown-item')[0].classList.remove("text-white")
            document.body.querySelectorAll('.dropdown-item')[1].classList.remove("text-white")
    	  /* 뷰포트 너비가  픽셀 미만 */
    	}

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    // Activate Bootstrap scrollspy on the main nav element
    

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

    // Activate SimpleLightbox plugin for portfolio items
    new SimpleLightbox({
        elements: '#portfolio a.portfolio-box'
    });

});
