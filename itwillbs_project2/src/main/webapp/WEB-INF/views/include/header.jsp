<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Do+Hyeon&display=swap');
  .navbar-brand{
  	font-family : 'Bagel Fat One', swap;
  }
  .nav-item{
	font-family : 'Do Hyeon', swap; 
  }
  #searchbar{
  width : 130%;
  margin : sauto;
  margin-top : 5%;
  }
  
</style>

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>세모클레스</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/resources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	
		<a class="navbar-brand" href="/">세모클래스</a>
		
		<div>
		<form class="d-flex" id="searchbar">
			<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
			<button class="btn btn-outline-success" type="submit">Search</button>
		</form>
		</div>
		
		<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
			<ul class="navbar-nav me-2 mb-2 mb-lg-0">
				<c:choose>
					<c:when test="${empty user_num }">
						<li class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">찜목록</a></li>
					</c:when>
					<c:when test="${empty user_id }">
						<li class="nav-item"><a class="nav-link" href="/user/join">회원가입</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/login">로그인</a></li>
					</c:when>
					<c:when test="${user_type eq 0 }">
						<li class="nav-item"><a class="nav-link" >${user_name }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/userMain">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">찜목록</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
					</c:when>
					<c:when test="${user_type eq 1 }">
						<li class="nav-item"><a class="nav-link" >${user_name }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/userMain">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">찜목록</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
					</c:when>
					<c:when test="${user_type eq 2 }">
						<li class="nav-item"><a class="nav-link" >${user_name }님 환영합니다</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">관리자페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#!">찜목록</a></li>
						<li class="nav-item"><a class="nav-link" href="/user/logout">로그아웃</a></li>
					</c:when>
				</c:choose>
			</ul>
		</div>
	</nav>
	
	<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
	<div>
		<ul class="nav nav nav-pills justify-content-center">
			<li class="nav-item"><a class="nav-link ${path == '/' ? 'active' : ''}" href="/?category=공예">체험</a></li>
			<li class="nav-item"><a class="nav-link ${path == '' ? 'active' : ''}" href="/">내주변 체험</a></li>
			<li class="nav-item"><a class="nav-link ${path == '' ? 'active' : ''}" href="#">이벤트</a></li>
			<li class="nav-item"><a class="nav-link ${path == '' ? 'active' : ''}" href="#">고객지원</a></li>
		</ul>
	</div>
	