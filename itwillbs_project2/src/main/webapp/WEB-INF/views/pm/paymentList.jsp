<%@ page pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
  /* footer 고정  */
  .abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>
	<script type="text/javascript">
		function cancelPayCheck (order_num){
			var inputPw = prompt("비밀번호를 입력해주세요", "");
			console.log(inputPw);
			jQuery.ajax({
				url : "/class/cancelPayCheck",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify({"user_id": "${user_id}", "user_pw": inputPw}),
				success : function(data) {
					// refund ajax 실행 후 작업 수행
					if(data == "true"){
						cancelPay(order_num);
					} else {
						alert('비밀번호를 다시 입력해주세요');
					}
	
				},
				error : function(error) {
					// refund ajax 실행 중 에러 발생 시 처리
				}
			}); // refund ajax
		}
     
     
	
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




<div class="container mt-5 abx">
	<div class="row">
		<div class="card">
	<h3>${user_name }님의 마이페이지 입니다.</h3>

			<div class="card-body pt-3">
				<ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

					<li class="nav-item" role="presentation">
						<button class="nav-link " data-bs-toggle="tab" onclick="location.href='/user/update';" aria-selected="true" role="tab">회원 정보 조회 및 수정</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link active" data-bs-toggle="tab" onclick="location.href='/class/paymentList';" aria-selected="false" role="tab" tabindex="-1">클래스 예약 관리</button>
					</li>
					<c:if test="${user_type eq 1 }">
						<li class="nav-item" role="presentation">
							<button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">사업자 클래스 관리</button>
						</li>
					</c:if>
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab" onclick="location.href='/qna/qnaListAll';" aria-selected="false" role="tab" tabindex="-1">1:1문의</button>
					</li>
				</ul>


				<table class="table">
					<thead class="thead-light">
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">클래스이름</th>
							<th scope="col">가격</th>
							<th scope="col">클래스 주문수</th>
							<th scope="col">총결제금액</th>
							<th scope="col">상세내역</th>
							<th scope="col">현재상태</th>
						</tr>
					</thead>
					<c:forEach var="i" items="${list }" varStatus="status">
						<tr>
							<td>${i.order_num }</td>
							<td>${i.exp_name }</td>
							<td>${i.exp_price }</td>
							<td><fmt:formatNumber
									value="${i.paid_amount / i.exp_price }" type="number"
									pattern="0.#" /></td>
							<td>${i.paid_amount }</td>
							<td><button class="btn1"
									onclick="location.href='/class/paymentInfo?user_id=${user_id}&order_num=${i.order_num }'">상세내역</button></td>
							<td><c:if test="${i.status eq 'paid'}">
									<button class="btn2" onclick="cancelPayCheck('${i.order_num}')">환불</button>
								</c:if> <c:if test="${i.status eq 'cancelled'}">
									환불완료
								</c:if></td>

						</tr>
					</c:forEach>
				</table>

				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center">
						<c:if test="${pageVO.preview }">
							<li class="page-item"><a class="page-link"
								href="/class/paymentList?page=${pageVO.startPage - 1 }"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>

						<c:forEach var="i" begin="${pageVO.startPage }"
							end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i? 'class="active"':'' }
								class="page-item"><a class="page-link"
								href="/class/paymentList?page=${i }">${i }</a></li>
						</c:forEach>

						<c:if test="${pageVO.next }">
							<li class="page-item"><a class="page-link" aria-label="Next"
								href="/class/paymentList?page=${pageVO.endPage + 1 }"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
					</ul>
				</nav>

			</div>
		</div>
	</div>
	</div>
	
	
	<%@ include file="../include/footer.jsp"%>


