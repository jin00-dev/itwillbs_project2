<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="container mt-5">
	<div class="row">
		<div class="card">
			<div class="card-body pt-3">
				<h3>${vo.user_name }님의마이페이지입니다.</h3>
				<ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab" onclick="location.href='/user/update';" aria-selected="false" role="tab" tabindex="-1">회원 정보 조회 및 수정</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab" onclick="location.href='/class/paymentList';" aria-selected="false" role="tab" tabindex="-1">클래스 예약 관리</button>
					</li>
					<c:if test="${user_type eq 1 }">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" data-bs-toggle="tab" onclick="location.href='/class/hostPage';" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">사업자 클래스 관리</button>
						</li>
					</c:if>
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab" onclick="location.href='/qna/qnaListAll';" aria-selected="false" role="tab" tabindex="-1">1:1문의</button>
					</li>
				</ul>
				<c:choose>
					<c:when test="${empty list }">
						<h1>결제된 내역이 없습니다</h1>
					</c:when>
					<c:otherwise>
						<table class="table">
							<thead class="thead-light">
								<tr>
									<th scope="col">예약 클래스 이름</th>
									<th scope="col">예약날짜</th>
									<th scope="col">예매자 이름</th>
									<th scope="col">예매자 전화 번호</th>
									<th scope="col">주문 수</th>
									<th scope="col">결제 가격</th>
									<th scope="col">결제 상태</th>
								</tr>
							</thead>

							<c:forEach var="i" items="${list }">
								<tr>
									<td>${i.exp_name }</td>
									<td>${i.custom_data }</td>
									<td>${i.user_name }</td>
									<td>${i.user_phone }</td>
									<td><fmt:formatNumber value="${i.paid_amount / i.exp_price }" type="number" pattern="0.#" /></td>
									<td>${i.paid_amount }</td>
									<td><c:choose>
											<c:when test="${i.status eq 'paid' }">결제완료</c:when>
											<c:when test="${i.status eq 'cancelled' }">취소완료</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
						</table>


						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center">
								<c:if test="${pageVO.preview }">
									<li class="page-item"><a class="page-link" href="/class/hostPage?page=${pageVO.startPage - 1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:if>

								<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
									<li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item"><a class="page-link" href="/class/hostPage?page=${i }">${i }</a></li>
								</c:forEach>

								<c:if test="${pageVO.next }">
									<li class="page-item"><a class="page-link" aria-label="Next" href="/class/hostPage?page=${pageVO.endPage + 1 }"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:if>
							</ul>
						</nav>

					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>



<%@ include file="../include/footer.jsp"%>