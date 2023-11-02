<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>


<!-- 좌측 고객센터 카테고리  -->
<table class="table">
	<tr>
		<td>
			<h3>고객센터</h3>
			<ul>
				<li><a href="/board/boardListAll">공지사항</a></li>
				<li><a href="/board/">챗봇 상담</a></li>
				<li><a href="/board/">1:1문의</a></li>
			</ul>
		</td>
		<td>
			
			<table class="table">
			
				<h3>공지사항</h3>
				
				
				<%-- <c:if test="${sessionScope.user_id == 'admin'}">  --%>
					<a href="/board/insert">글쓰기</a>
				<%-- </c:if> --%>
				<tr>
					<th>제목</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>

				<!-- 공지사항 고정 -->
				<c:forEach var="vo" items="${boardListAll}">
					<c:if test="${pinnedNotices.contains(vo.enf_notice_num)}">
						<tr style="font-weight: bold;">
							<td><a
								href="/board/read?enf_notice_num=${vo.enf_notice_num}">📌
									${vo.enf_title }</a></td>
							<td><fmt:formatDate value="${vo.enf_regdate }"
									pattern="yy-MM-dd" /></td>
							<td>${vo.enf_viewcnt}</td>
						</tr>
					</c:if>
				</c:forEach>

				<!-- 일반 공지사항 -->
				<c:forEach var="vo" items="${boardListAll}">
					<c:if test="${!pinnedNotices.contains(vo.enf_notice_num)}">
						<tr>
							<td><a
								href="/board/read?enf_notice_num=${vo.enf_notice_num}">${vo.enf_title }</a></td>
							<td><fmt:formatDate value="${vo.enf_regdate }"
									pattern="yy-MM-dd" /></td>
							<td>${vo.enf_viewcnt}</td>
						</tr>
					</c:if> 
				</c:forEach>
			</table> 
			
			<form action="">
				<input type="search">
				<button type="submit">검색</button>
			</form>
			
		</td>
	</tr>
</table> 

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
