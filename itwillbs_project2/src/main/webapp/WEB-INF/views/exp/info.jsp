<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="../include/header.jsp"%>
<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- Section-->
<section class="py-5">
	<!-- 요약정보 및 결제 -->
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-6">
				<!-- 첫 번째 섹션 내용 -->
				<section>
					<div class="card">
						<div class="card-horizontal">
							<div class="img-square-wrapper">
								<img src="https://dummyimage.com/300x300/dee2e6/6c757d.jpg" class="card-img-left" alt="...">
							</div>
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="btn btn-primary">Go somewhere</a>
							</div>
						</div>
					</div>
				</section>
			</div>
			<div class="col-6">
				<!-- 두 번째 섹션 내용 -->
				<section>
					<div class="card">

						<div class="card-body">
							<div id="calendar" style="position: relative;"></div>
							<h5 class="card-title">Card title</h5>
							<div id="selectedDateResult"></div>
							<div id="totalQuantityResult"></div>
							<div id="totalPriceResult"></div>
							<a href="#" class="btn btn-primary">Go somewhere</a>
						</div>
					</div>
				</section>
			</div>
		</div>
	</div>

	<!-- 하단메뉴 -->
	<div>
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link ${param.category == '안내' || param.category == null ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=안내">안내</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '후기' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=후기">후기</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '장소' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=장소">장소</a></li>
			<li class="nav-item"><a class="nav-link ${param.category == '환불규정' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=환불규정">환불규정</a></li>
		</ul>
	</div>

</section>
<!-- footer -->
<%@include file="../include/footer.jsp"%>
<!-- script  -->
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		flatpickr("#calendar", {
			enable : [ {
				from : "2023-11-01",
				to : "2023-11-15"
			} ],
			defaultDate : "today", // 초기 날짜 설정
			altFormat : "F j, Y", // 텍스트 입력 형식 설정
			dateFormat : "Y-m-d", // 선택된 날짜 형식 설정
			inline : true, // inline 모드 활성화
			minDate : "2023-11-01", // 최소 선택 가능 날짜 설정
			maxDate : "2023-11-15" // 최대 선택 가능 날짜 설정
		});
	});
</script>
