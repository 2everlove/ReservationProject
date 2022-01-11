<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.work_area {
		margin: 0px auto;
	}
	ul{
		list-style: none;
	}
	a {
		color: black;
		text-decoration: none;
	}
	#navbar__log-bar {
		font-size: 50px;
		color: #ff7f50;
	}
	.navbar__outer-area{
		display: flex;
		justify-content: space-evenly;
	}
</style>
<header id="header">
	<div class="work_area">
		<h1>Header</h1>
		<nav>
			<div class="navbar__outer-area">
				<div>
					<a href="/main">
						<i class="fas fa-hotel" id="navbar__log-bar"></i>
					</a>
				</div>
					<nav class="navbar navbar-expand-sm bg-light">
						<ul class="navbar-nav">
							<li class="nav-item"><a class="nav-link" href="#">お知らせ</a></li>
							<li class="nav-item"><a class="nav-link" href="#">予約</a></li>
							<li class="nav-item"><a class="nav-link" href="#">相談</a></li>
						</ul>
					</nav>
				<div class="dropdown">
				  <a class="btn btn-secondary data-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
				    <i class="fas fa-bars"></i>
					<i class="fas fa-user"></i>	
				  </a>
				
				  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
				    <li><a class="dropdown-item" href="#">Reservation</a></li>
				    <li><a class="dropdown-item" href="#">Another action</a></li>
				    <li><a class="dropdown-item" href="#">Something else here</a></li>
				    <li><a class="dropdown-item" href="#">Action</a></li>
				    <li><a class="dropdown-item" href="#">Another action</a></li>
				    <li><hr class="dropdown-divider"></li>
				    <li><a class="dropdown-item" href="#">Logout</a></li>
				  </ul>
				</div>
			</div>
		</nav>
	</div>
</header>
