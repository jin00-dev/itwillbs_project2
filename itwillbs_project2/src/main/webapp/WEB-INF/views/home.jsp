<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
@font-face{font-family:KBO-Dia-Gothic_bold;src:url(https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/KBO-Dia-Gothic_bold.woff) format('woff');font-weight:700;font-style:normal}.nav-underline .nav-link{border-bottom:3px solid transparent;padding:.5rem 1rem}.nav-underline .nav-link.active{color:#495057;background-color:#fff;border-color:#007bff}.nav-tabs .nav-link{color:#495057;background-color:#f8f9fa;border:1px solid transparent;border-top-left-radius:.25rem;border-top-right-radius:.25rem}.nav-tabs .nav-link.active{color:#495057;background-color:#fff;border-color:#dee2e6 #dee2e6 #fff}.card:hover{box-shadow:0 4px 8px 0 rgba(0,0,0,.2)}.card-img-top{width:100%;border-top-left-radius:calc(.25rem - 1px);border-top-right-radius:calc(.25rem - 1px)}.text-no-data{color:#6c757d;font-size:1.2rem}.recommended-section{background-color:#f8f9fa;border:1px solid #e9ecef;border-radius:.25rem;padding:20px;margin-bottom:20px}.recommended-title{font-family:KBO-Dia-Gothic_bold;font-size:24px;margin-bottom:10px}.recommended-subtitle{font-size:18px;color:#6c757d;margin-bottom:20px}body{margin-top:-20px}.recommended-title::after{content:"";display:inline-block;width:50px;height:50px;background-image:url(https://cdn-icons-png.flaticon.com/128/962/962638.png);background-size:contain;background-repeat:no-repeat;margin-left:5px;position:relative;top:10px}
</style>


<!-- header-->
<%@include file="./include/header.jsp"%>

	<div>
		<ul class="nav nav-underline justify-content-center">
			<li class="nav-item"><a class="nav-link ${param.category == '전체' || param.category == null || param.category == '' ? 'active' : ''}" href="/?category=전체" id="clicked1" >전체</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '공예' ? 'active' : ''}" href="/?category=공예" >공예</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '운동' ? 'active' : ''}" href="/?category=운동">운동</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '쿠킹' ? 'active' : ''}" href="/?category=쿠킹">쿠킹</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '뷰티' ? 'active' : ''}" href="/?category=뷰티">뷰티</a></li>
		</ul>
	</div>
	
<!-- Section-->
<div>
	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link ${param.region1 == '전체' || param.region1 == null || param.region1 == '' ? 'active' : ''}" href="/?category=${param.category }&region1=전체&sort=${param.sort}" id="clicked2">전체지역</a></li>
		<li class="nav-item"><a class="nav-link ${param.region1 == '서울' ? 'active' : ''}" href="/?category=${param.category }&region1=서울&region2=경기&sort=${param.sort}" id="clicked2">서울경기</a></li>
		<li class="nav-item"><a class="nav-link ${param.region1 == '경상' ? 'active' : ''}" href="/?category=${param.category }&region1=경상&region2=부산&sort=${param.sort}">경상부산</a></li>
		<li class="nav-item"><a class="nav-link ${param.region1 == '충청' ? 'active' : ''}" href="/?category=${param.category }&region1=충청&region2=대전&sort=${param.sort}">충청대전</a></li>
		<li class="nav-item"><a class="nav-link ${param.region1 == '전라' ? 'active' : ''}" href="/?category=${param.category }&region1=전라&region2=강원&sort=${param.sort}">전라강원</a></li>
		<li class="nav-item"><a class="nav-link ${param.region1 == '제주' ? 'active' : ''}" href="/?category=${param.category }&region1=제주&region2=/&sort=${param.sort}">제주</a></li>
	</ul>
	<ul class="nav justify-content-end">
		<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">정렬기준</a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="/?category=${param.category }&region1=${param.region1 }&region2=${param.region2 }&sort=star">별점순</a></li>
				<li><a class="dropdown-item" href="/?category=${param.category }&region1=${param.region1 }&region2=${param.region2 }&sort=priceDesc">최고가</a></li>
				<li><a class="dropdown-item" href="/?category=${param.category }&region1=${param.region1 }&region2=${param.region2 }&sort=priceAsc">최저가</a></li>
			</ul>
		</li>
	</ul>
</div>

<section class="py-5">
	<!-- 게시물 없음 -->
	<c:if test="${empty list}">
		<div class="text-center mt-4 mb-4">
			<div class="card border-0">
				<img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='80' height='80' viewBox='0 0 80 80'%3E %3Cg fill='none' fill-rule='evenodd'%3E %3Cpath fill='%23FFF' fill-opacity='0' fill-rule='nonzero' d='M0 0h80v80H0z'/%3E %3Cg transform='translate(10 10)'%3E %3Ccircle cx='26.2' cy='26.2' r='24.6' fill-rule='nonzero' stroke='%23DDD' stroke-width='2'/%3E %3Cpath fill='%23DDD' d='M19.8 24.6a1.6 1.6 0 1 1 0-3.2 1.6 1.6 0 0 1 0 3.2zm12.8 0a1.6 1.6 0 1 1 0-3.2 1.6 1.6 0 0 1 0 3.2z'/%3E %3Cpath stroke='%23DDD' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M23 29.4c2.133-2.133 4.267-2.133 6.4 0'/%3E %3Cpath fill-rule='nonzero' stroke='%23DDD' stroke-width='2' d='M43.8 43.8l14.708 14.708'/%3E %3C/g%3E %3C/g%3E %3C/svg%3E" class="card-img-top"
					style="max-width: 10%; margin: 0 auto;"> 
				<div class="card-body">
					<h4 class="card-title">조건을 만족하는 클래스가 없어요...</h4>
					<p class="card-text">다른 조건으로 검색해 보세요.</p>
				</div>
			</div>
		</div>
	</c:if>
	<!-- 광고 게시물 --------------------------------------- -->
		<c:if test="${!empty list}">
			<div class="container border-bottom">
					<h3 class="recommended-title">오늘의 추천 클래스</h3>
			<p class="recommended-subtitle">당신을 위한 특별한 클래스를 만나보세요.</p>
				<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
					<!---------------------------------------------  -->
						<c:forEach var="list" items="${list }">
							<c:if test="${list.exp_ad_state eq 1 }">
								<div class="col mb-5" style="cursor:pointer;" onclick="location.href='/exp/info?exp_num=${list.exp_num}';">
									<div class="card h-100">
										<!-- Product image-->
											<img class="card-img-top" src="/exp/thumbDownload?fileName=${list.exp_summary_img}&wid=268&hei=200" style="height: 200px;" alt="이미지 설명">
<!-- 										<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
										<!-- Product details-->
										<div class="card-body p-4">
											<div class="text-center">
												<!-- region -->
												${list.exp_region } <br>
												<!-- category -->
												${list.exp_category } <br>
												<!-- Product name-->
												<h5 class="fw-bolder">${list.exp_name }</h5>
												<!-- star point -->
												★ ${list.rev_avgStar == 0? 0 : list.rev_avgStar }<br>									
												<!-- Product price-->
												<fmt:formatNumber>${list.exp_price }</fmt:formatNumber>원 <br>
											</div>
										</div>
										<!-- Product actions-->
									    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> 
			<!-- 							<div class="text-center"> -->
			<!-- 									<a class="btn btn-outline-dark mt-auto" href="#">장바구니로</a>  -->
			<!-- 								</div> -->
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					<!---------------------------------------------  -->
				</div>
			</div>
		</c:if>
	<!-- 일반 게시물 --------------------------------------- -->
	<c:if test="${!empty list }">
		<div class="container px-4 px-lg-5 mt-5">
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<!---------------------------------------------  -->
					<c:forEach var="list" items="${list }">
						<c:if test="${list.exp_ad_state eq 0 }">
							<div class="col mb-5" style="cursor:pointer;" onclick="location.href='/exp/info?exp_num=${list.exp_num}';">
								<div class="card h-100">
									<!-- Product image-->
<!-- 									<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
										<img class="card-img-top" src="/exp/thumbDownload?fileName=${list.exp_summary_img}&wid=268&hei=200" style="height: 200px;" alt="이미지 설명">
									<!-- Product details-->
									<div class="card-body p-4">
										<div class="text-center">
											<!-- region -->
											${list.exp_region } <br>
											<!-- category -->
											${list.exp_category } <br>
											<!-- Product name-->
											<h5 class="fw-bolder">${list.exp_name }</h5>
											<!-- star point -->
											★ ${list.rev_avgStar == 0? 0 : list.rev_avgStar }<br>									
											<!-- Product price-->
											<fmt:formatNumber>${list.exp_price }</fmt:formatNumber>원 <br>
										</div>
									</div>
									<!-- Product actions-->
								    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent"> 
		<!-- 							<div class="text-center"> -->
		<!-- 									<a class="btn btn-outline-dark mt-auto" href="#">장바구니로</a>  -->
		<!-- 								</div> -->
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				<!---------------------------------------------  -->
			</div>
		</div>
	</c:if>

</section>
<!-- footer -->
<%@include file="./include/footer.jsp"%>