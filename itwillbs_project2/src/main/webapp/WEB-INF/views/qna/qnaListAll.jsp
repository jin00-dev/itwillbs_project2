<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<table class="table">
	<tr>
		<!-- 고객센터 섹션 -->
		<td>
			<h3>고객센터</h3>
			<ul>
				<li><a href="/board/boardListAll">공지사항</a></li>
				<li><a href="/board/">챗봇 상담</a></li>
				<li><a href="/board/qnaList">1:1문의</a></li>
			</ul>
		</td>

		<!-- 1대1 문의사항 리스트 섹션 -->
		<td>
			<h3>1대1 문의사항 리스트</h3> <a href="/qna/qnaCreate"> 글쓰기 </a>
			<table class="table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>답변 상태</th>
				</tr>
				<c:forEach var="qna" items="${qnaListAll}" varStatus="status">
					<tr>
						<td>${fn:length(qnaListAll) - status.index}</td> <!-- 역순 번호 계산 -->
						<td><a href="/qna/qnaRead?qna_num=${qna.qna_num}">${qna.qna_title}</a></td>
						<td><fmt:formatDate value="${qna.qna_regdate}"
								pattern="yyyy-MM-dd" /></td>
						<td><c:choose>
								<c:when test="${qna.qna_state == 0}">답변대기</c:when>
								<c:otherwise>답변완료</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</table>
		</td>
	</tr>
</table>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

