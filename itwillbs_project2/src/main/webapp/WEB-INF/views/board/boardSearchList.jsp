<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
.post-title{color:inherit;text-decoration:none}.post-title:hover{text-decoration:underline}.font-weight-bold a{font-weight:700;color:#000;text-decoration:none}.font-weight-bold a:hover{text-decoration:underline}
</style>
 
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container mt-5">
	<div class="row">
		<div class="col-md-3">
			<div class="list-group mb-4 h-100">
				<h5 class="list-group-item list-group-item-action active"
					aria-current="true">고객지원</h5>
				<a href="/board/boardListAll"
					class="list-group-item list-group-item-action">공지사항</a> <a
					href="/board/faqListAll"
					class="list-group-item list-group-item-action">자주 묻는 질문</a> <a
					href="/board/" class="list-group-item list-group-item-action">1:1문의</a>
			</div>
		</div>
		<div class="col-md-9">
			<h2 class="mb-4">공지사항</h2>

			<!-- 검색 바 -->
			<form class="form-inline my-2 my-lg-0" action="/board/boardSearch"
				method="get">
				<input class="form-control mr-sm-2" type="search" placeholder="검색"
					aria-label="Search" name="searchTerm">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>

			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<!-- 고정된 공지사항 표시 -->
					<c:forEach items="${boardListAll}" var="vo">
						<c:if
							test="${vo.enf_category == 1 && pinnedNotices.contains(vo.enf_notice_num)}">
							<tr class="font-weight-bold">
								<td>📌</td>
								<td><a
									href="/board/read?enf_notice_num=${vo.enf_notice_num}">${vo.enf_title}</a></td>
								<td><fmt:formatDate value="${vo.enf_regdate}"
										pattern="yy-MM-dd" /></td>
								<td>${vo.enf_viewcnt}</td>
							</tr>
						</c:if>
					</c:forEach>

					<!-- 검색된 게시글 처리 -->
					<c:forEach items="${searchResults}" var="vo" varStatus="status">
						<tr>
							<!-- 역순 번호 계산 -->
							<td>${searchResults.size() - status.index}</td>
							<td><a
								href="/board/read?enf_notice_num=${vo.enf_notice_num}" class="post-title">${vo.enf_title}</a></td>
							<td><fmt:formatDate value="${vo.enf_regdate}"
									pattern="yy-MM-dd" /></td>
							<td>${vo.enf_viewcnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
