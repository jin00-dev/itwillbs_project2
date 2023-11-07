<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h2> 사업자 페이지 <br><br> 
		예약 관리 목록 </h2>

	<table class="table">
		<tr class="table-warning">
			<td>예약 클래스 이름 : </td>
			<td>예약날짜 : </td>
			<td>예매자 이름 : </td>
			<td>예매자 전화 번호 : </td>
			<td>예매티켓 수량 : </td>
			<td>결제 상태 : </td>
		</tr>
		
		
		<c:forEach var="i" items="${list }">
		<tr>
			<td>${i.exp_name }</td>
			<td>${i.order_date }</td>
			<td>${i.user_name }</td>
			<td>${i.user_phone }</td>
			<td>${i.order_cnt }</td>
			<td>${i.payment_state }</td>
		</tr>
		</c:forEach>
	</table>


<%@ include file="../include/footer.jsp" %>