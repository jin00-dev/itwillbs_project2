<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<h1>이벤트 게시판</h1>


<c:if
	test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
	<a href="/board/eventInsert">글쓰기</a>
</c:if> 

<table class="table">
	<thead>
		<tr>
			<th>이미지</th>
			<th>제목</th>
			<th>진행 상태</th>
		</tr>
	</thead>
	<tbody>
		<!-- 가정: 각 게시물을 item 객체로 반복 -->
		<c:forEach var="item" items="${eventListAll}">
			<!-- enf_category 가 0인 경우에만 출력 -->
			<c:if test="${item.enf_category == 0}">
				<tr>
					<!-- 이미지 클릭 시 이벤트 상세페이지 이동 링크 추가 -->
					<td><a
						href="/board/eventRead?enf_event_num=${item.enf_event_num}"> <img
							src="/resources/event_img/${item.enf_img}" alt="이벤트 이미지"
							style="width: 100px; height: auto;">
					</a></td>

					<!-- 제목 -->
					<td><a
						href="/board/eventRead?enf_event_num=${item.enf_event_num}">${item.enf_title}</a></td>

					<!-- 진행 상태 -->
					<td>${item.enf_event_type == 1 ? "이벤트 진행중" : "종료된 이벤트"}</td>
				</tr>
			</c:if>
		</c:forEach>
	</tbody>
</table>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
