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
		font-size: 100px;
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
				<div>
					<ul>
						<li><a href="#">お知らせ</a></li>
						<li><a href="#">予約</a></li>
						<li><a href="#">相談</a></li>
					</ul>
				</div>
				<div>
					<button>
						<div>
							<i class="fas fa-bars"></i>
						</div>
						<div>
							<i class="fas fa-user"></i>	
						</div>
						<div style="display: none">
							<div>
								<ul>
									<li><a>1</a></li>
								</ul>
							</div>
						</div>
					</button>
				</div>
			</div>
		</nav>
	</div>
</header>