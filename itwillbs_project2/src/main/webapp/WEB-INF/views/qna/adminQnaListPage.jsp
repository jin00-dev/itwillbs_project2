<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<hr>
<div class="container mt-5">
	<div class="row">
              <h5 class="card-title">관리자 페이지</h5>
              
		 <ul class="nav nav-tabs" id="myTab" role="tablist">
   <li class="nav-item" role="presentation">
    <button class="nav-link " id="home-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="home" aria-selected="true" onclick = "location.href = '/user/adminMain';">회원관리</button>
   	</li>
     <li class="nav-item" role="presentation">
     <button class="nav-link" id="profile-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" onclick = "location.href = '/user/reportList';">신고관리</button>
     </li>
     <li class="nav-item" role="presentation">
     <button class="nav-link active" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick = "location.href = '/qna/qnaListAll';">1:1 문의 관리</button>
     </li>
     </ul>

		<!-- 1대1 문의사항 리스트 섹션 -->
			<h3 class="mb-4">전체 회원 1대1 문의사항 리스트</h3>
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
						<th scope="col">답변 상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="qna" items="${QnaList}" varStatus="status">
						<tr>
							<%-- <td>${fn:length(qnaListAll) - status.index}</td> --%>
							<td>${qna.qna_num}</td>
							<!-- 역순 번호 계산 -->
							<td><a href="/qna/qnaRead?qna_num=${qna.qna_num}">${qna.qna_title}</a></td>
							<td><fmt:formatDate value="${qna.qna_regdate}"
									pattern="yyyy-MM-dd hh:mm:ss" /></td>
							<td><c:choose>
									<c:when test="${qna.qna_state == 0}">
										<span class="badge badge-warning">답변 대기</span>
									</c:when>
									<c:otherwise>
										<span class="badge badge-success">답변 완료</span></c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

<nav aria-label="Page navigation">
	<ul class="pagination justify-content-center">
		<c:if test="${pageVO.preview}">
			<li class="page-item">
			<a class="page-link" href="/qna/adminQnaListPage?page=${pageVO.startPage - 1}" aria-label="Previous">
		<span aria-hidden="true">&laquo;</span>
		</a></li>
		</c:if>

		<c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}"
			step="1">
			<li class="page-item ${pageVO.cri.page == i? 'active':''}"><a
				class="page-link" href="/qna/adminQnaListPage?page=${i}">${i}</a></li>
		</c:forEach>

		<c:if test="${pageVO.next}">
			<li class="page-item"><a class="page-link"
				href="/qna/adminQnaListPage?page=${pageVO.endPage + 1}"
				aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
		</c:if>
	</ul>
</nav>
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
