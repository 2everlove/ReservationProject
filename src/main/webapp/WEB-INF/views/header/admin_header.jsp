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
                <a class="navbar-brand" href="/admin"><i class="fas fa-hotel" id="navbar__log-bar"></i></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="/admin/notice">お知らせ</a></li>
                        <li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								部屋&予約管理
							</a>
							<div class="dropdown-menu bg-dark" aria-labelledby="navbarDropdownMenuLink">
								<a class="dropdown-item text-white" href="/admin/booking">予約目録</a>
								<a class="dropdown-item text-white" href="/admin/roomManage">部屋目録</a>
							</div>
						</li>
                        <li class="nav-item"><a class="nav-link" href="/admin/consultation">相談</a></li>
                        <li class="nav-item"><a class="nav-link" href="/">User</a></li>
                    </ul>
                </div>
            </div>
        </nav>