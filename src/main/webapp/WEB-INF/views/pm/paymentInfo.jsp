<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<div class="container mt-5">
	<div class="row">
			<div class="card">
			<h2>예매 상세 내역</h2>
<br>
<table class="table table-bordered">
	<tr>
	<td>체험번호</td><td>${testVO.exp_num }</td><td>체험이름</td><td>${testVO.exp_name }</td>
	</tr>
	<tr>
	<td>주문날짜</td><td>${testVO.custom_data}</td><td>예매 상태</td>
	<td>
	<c:choose>
	<c:when test="${testVO.status eq 'paid' }">결제완료</c:when>
	<c:when test="${testVO.status eq 'cancelled' }">취소완료</c:when>
	</c:choose></td>
	</tr>
	<tr>
	<td>결제수단</td><td>${testVO.pay_method }</td><td>결제금액</td><td>${testVO.paid_amount }</td>
	</tr>
	<tr>
	<td>장소</td><td>${testVO.exp_name }</td><td>결제일시</td><td>${testVO.payment_date }</td>
	</tr>
	<tr>
	<td>주소</td><td colspan="3">${testVO.exp_region }</td>
	</tr>
	<tr>
	<td>사업자연락처</td><td colspan="3">${testVO.exp_phone }</td>
	</tr>
	</table>
	<br> 환불기간 : 티켓 유효기간 결제 후 7일 전까지 신청 가능
	
	<div class="text-center">
     <button type="button" class="btn btn-primary" onclick= "location.href='/class/paymentList';">확인</button>
    </div>
	</div>
	</div>
	</div>
	
	
<%@ include file="../include/footer.jsp" %>