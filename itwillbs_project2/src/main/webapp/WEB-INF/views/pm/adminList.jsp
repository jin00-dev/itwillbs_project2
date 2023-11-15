<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

	<h3> 관리자 </h3>
	<h3> 회원예매관리 </h3>
	
	<table id="table">
	
		<tr>
			<td>회원아이디</td>
			<td>회원이름</td>
			<td>체험이름</td>
			<td>결제가격</td>
			<td>결제일시</td>
			<td>결제상태</td>
		</tr>	
		
		
	<c:forEach var="i" items="${list }">
		<tr>
			<td>${i.buyer_email }</td>
			<td>${i.buyer_name }</td>
			<td>${i.name }</td>
			<td>${i.paid_amount }</td>
			<td>${i.payment_date }</td>
			
			<td>
				<c:choose>
					<c:when test="${i.status eq 'paid' }">결제완료</c:when>
					<c:when test="${i.status eq 'cancelled' }">취소완료</c:when>
				</c:choose>
			</td>
			
		</tr>
		</c:forEach>

		
		
		<script>
		
		function cancelPay(order_num) {
		      jQuery.ajax({
		       url: "/class/cancelPay", 
		       type: "POST",
		       contentType: "application/json",
		       data: order_num,
		       success: function(refundResponse) {
		         // refund ajax 실행 후 작업 수행
		         
		            if(refundResponse === "ok"){ 
		                 alert('환불 요청이 완료되었습니다.');
		                 location.reload();
		              // 예약취소 버튼 수정하기
		             }else if(refundResponse === "already refund"){ 
		               alert('이미 환불 처리된 주문 건입니다.');
		                 
		         }else{
		                 alert('실패: 관리자에게 문의해주세요');
		             }   
		         
		       },
		       error: function(error) {
		         // refund ajax 실행 중 에러 발생 시 처리
		       }
		     }); // refund ajax
		}
		
		</script>
		
		
		
	</table>
	






<%@ include file="../include/footer.jsp" %>