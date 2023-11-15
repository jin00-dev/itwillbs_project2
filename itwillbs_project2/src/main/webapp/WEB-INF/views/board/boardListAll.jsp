<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>


<div class="container mt-5">
	<div class="row">
		<div class="col-md-3">
			<div class="list-group mb-4 h-100">
<<<<<<< HEAD
				<h5 class="list-group-item list-group-item-action active"
					aria-current="true">고객지원</h5>
				<a href="/board/boardListAll"
					class="list-group-item list-group-item-action">공지사항</a> 
				<a href="/board/faqListAll" class="list-group-item list-group-item-action">자주 묻는 질문</a> 
				<a href="/board/"
					class="list-group-item list-group-item-action">1:1문의</a>
=======
				<h5 class="list-group-item list-group-item-action active" aria-current="true">고객지원</h5>
				<a href="/board/boardListAll" class="list-group-item list-group-item-action">공지사항</a> 
<!-- 				<a href="/board/" class="list-group-item list-group-item-action">챗봇상담</a>  삭제 -->
				<a href="/qna/qnaCreate" class="list-group-item list-group-item-action">1:1 문의</a>
				<a href="#" class="list-group-item list-group-item-action">자주 묻는 질문</a>
>>>>>>> 3265dc4c53e76c5b123817c2ae0ee71a93762fae
			</div>
		</div>

		<div class="col-md-9">
			<h2 class="mb-4">공지사항</h2>
			<a href="/board/insert" class="btn btn-primary mb-3">글쓰기</a>
			
			<!-- 검색 바 -->
			<form class="form-inline my-2 my-lg-0" action="/board/boardSearch"
				method="get">
				<input class="form-control mr-sm-2" type="search" placeholder="검색"
					aria-label="Search" name="searchTerm">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>

			<!-- <c:if
				test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
				<a href="/board/insert" class="btn btn-primary mb-3">글쓰기</a>
			</c:if> -->

			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<!-- 고정된 공지사항 -->
					<c:forEach var="vo" items="${boardListAll}">
						<c:if
							test="${vo.enf_category == 1 && pinnedNotices.contains(vo.enf_notice_num)}">
							<tr class="font-weight-bold">
								<td><a
									href="/board/read?enf_notice_num=${vo.enf_notice_num}">📌
										${vo.enf_title}</a></td>
								<td><fmt:formatDate value="${vo.enf_regdate}"
										pattern="yy-MM-dd" /></td>
								<td>${vo.enf_viewcnt}</td>
							</tr>
						</c:if>
					</c:forEach>

					<!-- 일반 공지사항 -->
					<c:forEach var="vo" items="${boardListAll}">
						<c:if
							test="${vo.enf_category == 1 && !pinnedNotices.contains(vo.enf_notice_num)}">
							<tr>
								<td><a
									href="/board/read?enf_notice_num=${vo.enf_notice_num}">${vo.enf_title}</a></td>
								<td><fmt:formatDate value="${vo.enf_regdate}"
										pattern="yy-MM-dd" /></td>
								<td>${vo.enf_viewcnt}</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<nav aria-label="Page navigation">
				<c:if test="${!empty boardListAll && boardListAll.size() > 1}">
					<ul class="pagination justify-content-center">
						<c:if test="${pageVO.prev}">
							<li class="page-item"><a class="page-link"
								href="/board/boardListAll?page=${pageVO.startPage - 1}"
								aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						</c:if>

						<c:forEach var="i" begin="${pageVO.startPage}"
							end="${pageVO.endPage}" step="1">
							<li class="page-item ${pageVO.cri.page == i? 'active':''}"><a
								class="page-link" href="/board/boardListAll?page=${i}">${i}</a></li>
						</c:forEach>

						<c:if test="${pageVO.next}">
							<li class="page-item"><a class="page-link"
								href="/board/boardListAll?page=${pageVO.endPage + 1}"
								aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</ul>
				</c:if>
			</nav>

			



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