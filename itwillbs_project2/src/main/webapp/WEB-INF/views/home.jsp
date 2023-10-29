<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="./include/header.jsp"%>
<div>
		<ul class="nav justify-content-center">
			<li class="nav-item"><a class="nav-link" href="#">공예</a></li>
			<li class="nav-item"><a class="nav-link" href="#">운동</a></li>
			<li class="nav-item"><a class="nav-link" href="#">쿠킹</a></li>
			<li class="nav-item"><a class="nav-link" href="#">뷰티</a></li>
		</ul>
	</div>
<!-- Section-->
<div>
	<ul class="nav">
		<li class="nav-item"><a class="nav-link" href="#">전체</a></li>
		<li class="nav-item"><a class="nav-link" href="#">서울경기</a></li>
		<li class="nav-item"><a class="nav-link" href="#">경상대구부산</a></li>
		<li class="nav-item"><a class="nav-link" href="#">충청대전</a></li>
		<li class="nav-item"><a class="nav-link" href="#">전라강원</a></li>
		<li class="nav-item"><a class="nav-link" href="#">제주</a></li>
		</ul>
	<ul class="nav justify-content-end">
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">정렬기준</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="#">인기순</a></li>
				<li><a class="dropdown-item" href="#">별점순</a></li>
				<li><a class="dropdown-item" href="#">최고가</a></li>
				<li><a class="dropdown-item" href="#">최저가</a></li>
			</ul>
		</li>
		
	</ul>
</div>

<section class="py-5">
	<div class="container px-4 px-lg-5 mt-5">
		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<!---------------------------------------------  -->
			<c:if test="${!empty list }">
				<c:forEach var="list" items="${list }">
					<div class="col mb-5">
						<div class="card h-100">
							<!-- Product image-->
							<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder">${list.exp_name }</h5>
									<!-- Product price-->
									<fmt:formatNumber>${list.exp_price }</fmt:formatNumber>원 
								</div>
							</div>
							<!-- Product actions-->
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
									<a class="btn btn-outline-dark mt-auto" href="#">장바구니로</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<!---------------------------------------------  -->
		</div>
	</div>

</section>
<!-- footer -->
<%@include file="./include/footer.jsp"%>
