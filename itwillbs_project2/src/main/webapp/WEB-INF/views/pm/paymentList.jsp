<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	
	<h2> 한 회원이 주문한 모든 클래스 내용 리스트 </h2>
	
	<table>
		<tr>
			<td>사진</td>
			<td>주문번호</td>
			<td>클래스이름</td>
			<td>클래스 옵션:</td>
			
		</tr>
			<c:forEach var="i" items="${list }">
				<tr>
					<td>${i.exp_summary_img }</td>
					<td>${i.order_num }</td>
					<td>${i.exp_name }</td>
					<td>${i.exp_capacity } * ${i.exp_price }</td>
					<td><button class="btn1" onclick="location.href='/class/paymentInfo?user_num=${param.user_num}&order_num=${i.order_num }'">상세내역</button></td>
					<td><button class="btn2" onclick="cancelPay()">환불</button><br></td>
					
				</tr>
			</c:forEach>	
			
		<script>
	    function cancelPay() {
	        jQuery.ajax({
	          // 예: http://www.myservice.com/payments/cancel
	          "url": "/class/paymentList", 
	          "type": "POST",
	          "contentType": "application/json",
	          "data": order_num, ({
	            "merchant_uid": "{결제건의 주문번호}", // 예: ORD20180131-0000011
	            "cancel_request_amount": 2000, // 환불금액
	            "reason": "테스트 결제 환불", // 환불사유
	            // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
	            "refund_holder": "홍길동", 
	            // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
	            "refund_bank": "88",
	            // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
	            "refund_account": "56211105948400"
	          }),
	          "dataType": "json"

	        }); //ajax
	      }
		</script>
			
			
	</table>
	
	<
	
	
	

<%@ include file="../include/footer.jsp" %>