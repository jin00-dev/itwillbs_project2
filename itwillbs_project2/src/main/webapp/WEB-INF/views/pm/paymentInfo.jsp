<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<form action="" method="get">
		체험번호: ${testVO.exp_num }<br>
		체험이름 : ${testVO.exp_name }<br>
		예매 상태 : 
				<c:choose>
					<c:when test="${testVO.status eq 'paid' }">결제완료</c:when>
					<c:when test="${testVO.status eq 'cancelled' }">취소완료</c:when>
				</c:choose><br>
		장소 : ${testVO.exp_name }<br>
		주소 : ${testVO.exp_region }<br>
		사업자연락처 : ${testVO.exp_phone }<br>
		결제금액 : ${testVO.paid_amount }<br>
		결제수단 : ${testVO.pay_method }<br>
		주문날짜 : ${testVO.custom_data}<br>
		결제일시 : ${testVO.payment_date }<br>
		환불기간 : 티켓 유효기간 결제 후 7일 전까지 신청 가능
	</form>
	
	
	
<%@ include file="../include/footer.jsp" %>