<%@ page pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<h2>${user_name }님의마이페이지입니다.</h2>
<h3>예매내역</h3>

<!-- 로그인 정보가 없으면 로그인 페이지로 이동 -->
<%-- <c:if test="${empty user_id}"> --%>
<%-- 	<c:redirect url="/user/login" /> --%>
<%-- </c:if> --%>


<div class="container mt-5">
	<div class="row">
			<div class="card">

				<div class="card-body pt-3">
					<ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

						<li class="nav-item" role="presentation">
							<button class="nav-link " data-bs-toggle="tab"
								onclick="location.href='/user/userMain';" aria-selected="true"
								role="tab">회원 정보 조회</button>
						</li>

						<li class="nav-item" role="presentation">
							<button class="nav-link" data-bs-toggle="tab"
								onclick="location.href='/user/update';" aria-selected="false"
								role="tab" tabindex="-1">회원 정보 수정</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link active" data-bs-toggle="tab"
								onclick="location.href='/class/paymentList';"
								aria-selected="false" role="tab" tabindex="-1">클래스 예약
								관리</button>
						</li>
						<c:if test="${user_type eq 1 }">
							<li class="nav-item" role="presentation">
								<button class="nav-link" data-bs-toggle="tab"
								onclick="location.href='/class/hostPage';"
									data-bs-target="#profile-change-password" aria-selected="false"
									role="tab" tabindex="-1">사업자 클래스 관리</button>
							</li>
						</c:if>
					</ul>


					<table class="table">
					<thead class="thead-light">
						<tr>
							<td>사진</td>
							<td>주문번호</td>
							<td>클래스이름</td>
							<td>가격</td>
							<td>주문수</td>
							<td>총결제금액</td>
							<td>상세내역</td>
							<td>결제</td>
						</tr>
						</thead>
						<c:forEach var="i" items="${list }" varStatus="status">
							<tr>
								<td>${i.exp_summary_img }</td>
								<td>${i.order_num }</td>
								<td>${i.exp_name }</td>
								<td>${i.exp_price }</td>
								<td><fmt:formatNumber
										value="${i.paid_amount / i.exp_price }" type="number"
										pattern="0.#" /></td>
								<td>${i.paid_amount }</td>
								<td><button class="btn1"
										onclick="location.href='/class/paymentInfo?order_num=${i.order_num }'">상세내역</button></td>
								<td><c:if test="${i.status eq 'paid'}">
										<button class="btn2" onclick="cancelPayCheck('${i.order_num}')">환불</button>
									</c:if> <c:if test="${i.status eq 'cancelled'}">
							환불완료
						</c:if></td>

							</tr>
						</c:forEach>
					</table>

					<div class="box-footer clearfix">
						<ul class="pagination pagination-sm no-margin pull-right">
							<c:if test="${pageVO.preview }">
								<li><a
									href="/class/paymentList?page=${pageVO.startPage - 1 }">«</a></li>
							</c:if>

							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li ${pageVO.cri.page == i? 'class="active"':'' }><a
									href="/class/paymentList?page=${i }">${i }</a></li>
							</c:forEach>

							<c:if test="${pageVO.next }">
								<li><a
									href="/class/paymentList?page=${pageVO.endPage + 1 }">»</a></li>
							</c:if>

						</ul>
					</div>

				</div>
		</div>
	</div>
</div>
	
	<%@ include file="../include/footer.jsp"%>


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


