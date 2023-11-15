<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<h1>회원 관리</h1>

<div class="card-body">
	<h5 class="card-title">회원관리</h5>

	<!-- Default Table -->
	<table class="table">
		<thead>
			<tr>
				<th scope="col">회원번호</th>
				<th scope="col">이름</th>
				<th scope="col">휴대폰 번호</th>
				<th scope="col">회원가입일</th>
				<th scope="col">회원 등급</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="vo" items="${userList }">
			<tr>
				<th>${vo.user_num }</th>
				<td>${vo.user_name }</td>
				<td>${vo.user_phone }</td>
				<td>${vo.user_regdate }</td>
				<td>${vo.user_type }</td>
			</tr>
		</tbody>
		</c:forEach>
	</table>
	<!-- End Default Table Example -->
</div>



<%@include file="../include/footer.jsp"%>
