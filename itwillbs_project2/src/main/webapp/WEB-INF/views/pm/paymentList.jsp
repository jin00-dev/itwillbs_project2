<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
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
					<td><button class="btn2" onclick="cancelPay('10')">환불</button><br></td>
					
				</tr>
			</c:forEach>	
			
	</table>
	
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
	
	
	
	

<%@ include file="../include/footer.jsp" %>