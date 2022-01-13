<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.work_area {
		margin: 0px auto;
	}
	a{
		color: black;
	}
	ul{
		list-style: none;
	}
	#navbar__log-bar {
		font-size: 50px;
		color: #ff7f50;
	}
	
</style>

	<body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/main"><i class="fas fa-hotel" id="navbar__log-bar"></i></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="/notice">お知らせ</a></li>
                        <li class="nav-item"><a class="nav-link" href="/booking">予約</a></li>
                        <li class="nav-item"><a class="nav-link" href="/consultation">相談</a></li>
                        <li class="nav-item"><a class="nav-link" href="/admin">Admin</a></li>
                    </ul>
                </div>
            </div>
        </nav>
