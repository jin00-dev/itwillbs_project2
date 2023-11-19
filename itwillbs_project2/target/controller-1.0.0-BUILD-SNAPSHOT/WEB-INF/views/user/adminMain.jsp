<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<%@include file="../include/header.jsp"%>

<hr>
<div class="container mt-5">
	<div class="row">
		<h5 class="card-title">관리자 페이지</h5>


		<!-- Default Tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="home" aria-selected="true" onclick="location.href = '/user/adminMain';">회원관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" onclick="location.href = '/user/reportList';">신고관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick="location.href = '/qna/adminQnaListPage';">1:1 문의 관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick="location.href = '/class/admnOrderBoard';">회원 예약관리</button>
			</li>
		</ul>




		<!-- Default Table -->
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th scope="col">회원번호</th>
					<th scope="col">이름</th>
					<th scope="col">휴대폰 번호</th>
					<th scope="col">회원가입일</th>
					<th scope="col">회원 등급</th>
				</tr>
			</thead>
			<c:forEach var="vo" items="${userList }" varStatus="status">
				<tbody>
					<tr>
						<th>${vo.user_num }</th>
						<td>${vo.user_name }</td>
						<td>${vo.user_phone }</td>
						<td>${vo.user_regdate }</td>
						<c:choose>
							<c:when test="${vo.user_type eq 0}">
								<td>일반회원</td>
							</c:when>
							<c:when test="${vo.user_type eq 1}">
								<td>사업자</td>
							</c:when>
							<c:when test="${vo.user_type eq 2}">
								<td>관리자</td>
							</c:when>
						</c:choose>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		<!-- End Default Table Example -->
	</div>
</div>

<nav aria-label="Page navigation">
	<ul class="pagination justify-content-center">
		<c:if test="${pageVO.preview }">
			<li class="page-item"><a class="page-link" href="/user/adminMain?page=${pageVO.startPage - 1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>

		<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
			<li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item"><a class="page-link" href="/user/adminMain?page=${i }">${i }</a></li>
		</c:forEach>

		<c:if test="${pageVO.next }">
			<li class="page-item"><a class="page-link" aria-label="Next" href="/user/adminMain?page=${pageVO.endPage + 1 }"> <span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>
	</ul>
</nav>

<%@include file="../include/footer.jsp"%>
<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

