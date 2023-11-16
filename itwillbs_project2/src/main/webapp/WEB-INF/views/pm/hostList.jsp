<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h3> 예약 관리 목록 </h3>

	<table class="table">
		<tr class="table-warning">
			<td>예약 클래스 이름 : </td>
			<td>예약날짜 : </td>
			<td>예매자 이름 : </td>
			<td>예매자 전화 번호 : </td>
			<td>결제 가격 : </td>
			<td>결제 상태 : </td>
		</tr>
		
		
		<c:forEach var="i" items="${list }">
		<tr>
			<td>${i.exp_name }</td>
			<td>${i.custom_data }</td>
			<td>${i.user_name }</td>
			<td>${i.user_phone }</td>
			<td>${i.exp_price }원</td>
			<td>
				<c:choose>
					<c:when test="${i.status eq 'paid' }">결제완료</c:when>
					<c:when test="${i.status eq 'cancelled' }">취소완료</c:when>
				</c:choose>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="box-footer clearfix">
		<ul class="pagination pagination-sm no-margin pull-right">
			<c:if test="${pageVO.preview }">
			<li><a href="/class/hostPage?user_num=${user_num }&page=${pageVO.startPage - 1 }">«</a></li>
			</c:if>
			
			<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
			<li ${pageVO.cri.page == i? 'class="active"':'' }>
			<a href="/class/hostPage?user_num=${user_num }&page=${i }">${i }</a>
			</li>
			</c:forEach>
			
			<c:if test="${pageVO.next }">
			<li><a href="/class/hostPage?user_num=${user_num }&page=${pageVO.endPage + 1 }">»</a></li>
			</c:if>
			
		</ul>
	</div>


<%@ include file="../include/footer.jsp" %>