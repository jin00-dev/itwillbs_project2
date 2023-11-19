<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<%@ include file="../include/header.jsp"%>

<hr>
<div class="container mt-5">
	<div class="row">
		<h5 class="card-title">관리자페이지</h5>

		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link " id="home-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="home" aria-selected="true" onclick="location.href = '/user/adminMain';">회원관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" onclick="location.href = '/user/reportList';">신고관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link " id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick="location.href = '/qna/adminQnaListPage';">1:1 문의 관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick="location.href = '/class/admnOrderBoard';">회원 예약관리</button>
			</li>
		</ul>

		<table class="table">
			<thead class="thead-light">
				<tr>
					<th scope="col">회원아이디</th>
					<th scope="col">회원이름</th>
					<th scope="col">체험이름</th>
					<th scope="col">결제가격</th>
					<th scope="col">결제일시</th>
					<th scope="col">결제상태</th>
					<th></th>
				</tr>
			</thead>
			<c:forEach var="i" items="${list }">
				<tbody>
					<tr>
						<td>${i.buyer_email }</td>
						<td>${i.buyer_name }</td>
						<td>${i.name }</td>
						<td>${i.paid_amount }</td>
						<td>${i.payment_date }</td>
						<td><c:choose>
								<c:when test="${i.status eq 'paid' }">
									결제완료
								</c:when>
								<c:when test="${i.status eq 'cancelled' }">환불완료</c:when>
							</c:choose></td>
					</tr>
				</tbody>
			</c:forEach>
		</table>

		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:if test="${pageVO.preview }">
					<li class="page-item"><a class="page-link" href="/class/admnOrderBoard?page=${pageVO.startPage - 1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
					<li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item"><a class="page-link" href="/class/admnOrderBoard?page=${i }">${i }</a></li>
				</c:forEach>

				<c:if test="${pageVO.next }">
					<li class="page-item"><a class="page-link" aria-label="Next" href="/class/admnOrderBoard?page=${pageVO.endPage + 1 }"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
</div>
<script>
	function cancelPay(order_num) {
		jQuery.ajax({
			url : "/class/cancelPay",
			type : "POST",
			contentType : "application/json",
			data : order_num,
			success : function(refundResponse) {
				// refund ajax 실행 후 작업 수행

				if (refundResponse === "ok") {
					alert('환불 요청이 완료되었습니다.');
					location.reload();
					// 예약취소 버튼 수정하기
				} else if (refundResponse === "already refund") {
					alert('이미 환불 처리된 주문 건입니다.');

				} else {
					alert('실패: 관리자에게 문의해주세요');
				}

			},
			error : function(error) {
				// refund ajax 실행 중 에러 발생 시 처리
			}
		}); // refund ajax
	}
</script>











<%@ include file="../include/footer.jsp"%>