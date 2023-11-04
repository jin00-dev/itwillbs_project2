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

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Vue.js 스크립트 불러오기 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.min.js"></script>

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
</section>
<!-- 하단메뉴 전체 섹션 -->
<section class="py-5">
	<div class="col-md-8 mx-auto p-5 border ">
		<!-- 하단메뉴(네비게이션) -->
		<div>
			<ul class="nav nav-underline justify-content-center">
				<li class="nav-item mx-4"><a class="nav-link ${param.category == '안내' || param.category == null ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=안내"><h4>안내</h4></a></li>
				<li class="nav-item mx-4"><a class="nav-link ${param.category == '후기' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=후기"><h4>후기(${rList.size() < 0 && empty rList ? 0 : rList.size() })</h4></a></li>
				<li class="nav-item mx-4"><a class="nav-link ${param.category == '장소' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=장소"><h4>장소</h4></a></li>
				<li class="nav-item mx-4"><a class="nav-link ${param.category == '환불규정' ? 'active' : ''}" href="/exp/info?exp_num=${param.exp_num}&category=환불규정"><h4>환불규정</h4></a></li>
			</ul>
		</div>

		<!-- 하단메뉴 내용 -->
		<div class="tab-content justify-content-center">
			<div class="tab-pane ${param.category == '안내' || param.category == null ? 'active' : ''}">
				<!-- '안내' 탭 내용을 여기에 넣으세요 -->
				11111111111
			</div>
			<div class="tab-pane ${param.category == '후기' ? 'active' : ''}">
				<div class="container">
					<div class="row p-3">
						<div class="col-md-6 text-center">
							<h4>평균 별점</h4>
							<p class="display-4" id="avgStar">${avgStar }</p>
							<div class="justify-content-center">
								<div class="star-ratings " id="app">
									<div class="star-ratings-fill" :style="{ width: ratingToPercent + '%' }">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
									<div class="star-ratings-base">
										<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
									</div>
								</div>
							</div>
							<h5>${rList.size() < 0 && empty rList ? 0 : rList.size() }</h5>
						</div>
						<div class="col-md-6">
							<table class="table table-borderless">
								<tbody>
									<tr>
										<td class="align-middle col-2"><span>5점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="5point" style="width:" aria-valuenow="5" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>4점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="4point" style="width: 50%" aria-valuenow="4" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>3점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="3point" style="width: 25%" aria-valuenow="3" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>2점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="2point" style="width: 10%" aria-valuenow="2" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="align-middle col-2"><span>1점</span></td>
										<td class="align-middle">
											<div class="progress">
												<div class="progress-bar bg-warning" id="1point" style="width: 5%" aria-valuenow="1" aria-valuemin="0" aria-valuemax="5"></div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- review 하나 -->
				<c:set var="revNum" value="0" />
				<c:forEach var="review" items="${rList }">
					<div class="border-top">
						<div class="row">
							<div class="col-md-3">
								<!-- 별점 -->
								<div class="star-rating">${review.rev_star }</div>
							</div>
							<div class="col-md-3">${review.user_name }</div>
							<div class="col-md-6 justify-content-end d-flex">
								<!-- 날짜 -->
								<p>
									날짜:
									<fmt:formatDate value="${review.rev_regdate }" />
								</p>
							</div>
						</div>
						<div class="row">
							<div class="container">
								<span class="d-inline-block text-truncate" style="max-width: 90%;" id="myText"> ${review.rev_content } </span> <span class="text-info toggle-button" style="cursor: pointer;" id="toggleButton"> 더보기 </span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<!-- 이미지 -->
								<c:if test="${review.rev_img ne null }">
									<img src="${review.rev_img }" alt="이미지 설명">
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="tab-pane ${param.category == '장소' ? 'active' : ''}">
				<!-- '장소' 탭 내용을 여기에 넣으세요 -->
				33333333
			</div>
			<div class="tab-pane ${param.category == '환불규정' ? 'active' : ''}">
				<div class="container">
					<br>
					<h2>안내사항(수정필요)</h2>
					<br>

					<h3>환불방법</h3>
					<div class="alert alert-secondary">
						<ul>
							<li>마이티켓 > 예매내역 > 환불신청 버튼 클릭</li>
							<li>결제수단에 따라 환불/입금까지 최대 5영업일 소요</li>
						</ul>
					</div>

					<h3>환불규정</h3>
					<div class="alert alert-secondary">
						<p>티켓 예매 후 4주 이내 : 전액 환불</p>
						<p>티켓 예매 후 4주 이후 : 환불 불가</p>
						<p>티켓 유효기간 만료 후 : 환불 불가</p>
						<p>유효기간은 예매시 선택 옵션에서 확인 가능합니다.</p>
					</div>

					<h3>주의사항</h3>
					<div class="alert alert-secondary">
						<ul>
							<li>유효기간이 만료되거나 사용한 티켓 환불 불가 (동일 상품이라도 옵션마다 유효기간이 다를 수 있음)</li>
							<li>일부 수량 환불 및 날짜/시간 변경 불가 (전체 환불 후 재예매)</li>
							<li>일정 예약 후 방문하지 않은 경우(No Show) 환불 불가</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- footer -->
<%@include file="../include/footer.jsp"%>

<style>
<!--
.star-ratings {
	color: #aaa9a9;
	position: relative;
	unicode-bidi: bidi-override;
	width: max-content;
	-webkit-text-fill-color: transparent;
	/* Will override color (regardless of order) */
	-webkit-text-stroke-width: 1.3px;
	-webkit-text-stroke-color: #2b2a29;
	margin: 0 auto;
}

.star-ratings-fill {
	color: #fff58c;
	padding: 0;
	position: absolute;
	z-index: 1;
	display: flex;
	top: 0;
	left: 0;
	overflow: hidden;
	-webkit-text-fill-color: gold;
}

.star-ratings-base {
	z-index: 0;
	padding: 0;
}

.star-rating {
	font-size: 24px;
}

.star {
	color: gold; /* 별 색상 */
}
-->
</style>
<!-- script  -->
<script type="text/javascript">
	//달력 -------------------------------------------------------------------
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
	
	//평균 별점 구하기 --------------------------------------------------
	const ratingValue =$('#avgStar').text();

	new Vue({
	    el: '#app',
	    data: {
	        ratingValue: ratingValue, // 별점 값을 입력하세요
	    },
	    computed: {
	        ratingToPercent() {
	            return (this.ratingValue / 5) * 100;
	        },
	    },
	});
	
	//별점 각각 갯수
	const appleCounts = [${ratings[0]}, ${ratings[1]}, ${ratings[2]}, ${ratings[3]}, ${ratings[4]}]; // 각 방에 있는 사과 갯수
	const totalApples = appleCounts.reduce((acc, count) => acc + count, 0); // 전체 사과 수 계산

	// 각 방의 백분율 계산
	const percentages = appleCounts.map(count => (count / totalApples) * 100);

	//console.log(percentages);
	
	$('#1point').css('width',percentages[0] +"%");
	$('#2point').css('width',percentages[1] +"%");
	$('#3point').css('width',percentages[2] +"%");
	$('#4point').css('width',percentages[3] +"%");
	$('#5point').css('width',percentages[4] +"%");
	
	//리뷰마다 별점 표시해주기
	// 별점을 표시할 요소들에 접근합니다.
    $('[class="star-rating"]').each(function() {
        const $starRating = $(this);
        const ratingValue = parseInt($starRating.text()); // div 내부의 숫자 값 가져옴

        // 숫자 뒤에 별점을 추가하여 설정합니다.
        $starRating.text("");
        $starRating.append(' ' + generateStars(ratingValue));
    });

    // 별점을 생성하는 함수
    function generateStars(ratingValue) {
        let stars = '';
        for (let i = 0; i < ratingValue; i++) {
            stars += '<span class="star">&#9733;</span>';
        }
        return stars;
    }
	
	//리뷰 긴글 접기 펴기 -----------------------------------------------------------------
	$(document).ready(function() {
    $('.container').each(function() {
        const container = $(this);
        const text = container.find('.text-truncate');
        const toggleButton = container.find('.toggle-button');

        toggleButton.hide(); // 초기에는 숨김

        if (text.length > 0) { // 요소가 존재하는지 확인
            // 텍스트가 max-width를 초과하는지 확인
            if (text[0].scrollWidth > text.innerWidth()) {
                toggleButton.show(); // 초과하면 "더보기" 버튼 보이기
            }

            // "더보기" 버튼 클릭 시
            toggleButton.click(function() {
                text.toggleClass('text-truncate'); // text-truncate 클래스를 토글
                if (text.hasClass('text-truncate')) {
                    toggleButton.text('더보기');
                } else {
                    toggleButton.text('간략히');
                }
            });
        }
    });
});
    
 
</script>
