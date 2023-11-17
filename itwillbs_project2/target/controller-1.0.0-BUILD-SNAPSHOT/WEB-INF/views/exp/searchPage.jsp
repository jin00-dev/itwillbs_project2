<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="../include/header.jsp"%>
	
<!-- Section-->
<section class="py-5">
	<h1 class="text-center">검색 결과</h1>
	<hr>
	<!-- 게시물 없음 -->
	<c:if test="${empty list}">
		<h1 class="text-center">
			조건을 만족하는 클래스가 없어요...
		</h1>
	</c:if>
	<!-- 일반 게시물 --------------------------------------- -->
	<c:if test="${!empty list }">
		<div class="container px-4 px-lg-5 mt-5">
			<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<!---------------------------------------------  -->
					<c:forEach var="list" items="${list }">
							<div class="col mb-5" style="cursor:pointer;" onclick="location.href='/exp/info?exp_num=${list.exp_num}';">
								<div class="card h-100">
									<!-- Product image-->
									<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
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
									</div>
								</div>
							</div>
					</c:forEach>
				<!---------------------------------------------  -->
			</div>
		</div>
	</c:if>

</section>
<!-- footer -->
<%@include file="../include/footer.jsp"%>
<!-- script  -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

//클래스 세부 카테고리 동작----------------------------------------------------
/*$('#category a[class="nav-link"]').hover(function(){
	$(this).css('font-weight','900');
},function(){
	 // 마우스를 뗐을 때, 클릭된 링크는 빨간색을 유지하고 나머지는 파란색으로 변경
    $('#category a[class="nav-link"]').not('#clicked1').css('font-weight','100');
});
//클래스 세부 내역 클릭시
$('#category a[class="nav-link"]').click(function(){
	// 모든 링크의 아이디를 "clicked"로 변경
	$('#category a[class="nav-link"]').removeAttr('id','clicked1');
	$(this).attr('id','clicked1');
});

//지역 선택창 동작---------------------------------------------------------------
$('#region a[class="nav-link"]').hover(function() {
        $(this).css('color', 'red');
    }, function() {
        // 마우스를 뗐을 때, 클릭된 링크는 빨간색을 유지하고 나머지는 파란색으로 변경
        $('#region a[class="nav-link"]').not('#clicked2').css('color', 'blue');
    });

// 클릭 이벤트 핸들러
$('#region a[class="nav-link"]').click(function() {
    // 모든 링크의 아이디를 "clicked"로 변경
    $('#region a[class="nav-link"]').removeAttr('id','clicked2');
    $(this).attr('id','clicked2');
});
*/
</script>
