<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<li><a href="/board/">1:1문의</a></li>
			</ul>
		</td>
		
		<!-- 1대1 문의사항 쓰기 섹션 -->
		<td>
			<h3>1대1 문의사항 쓰기</h3>
			<form method="post">
				<label for="title">제목:</label><br>
				<input type="text" id="title" name="qna_title" required><br>
				
				<label for="content">내용:</label><br>
				<textarea id="content" name="qna_content" rows="4" cols="50" required></textarea><br>
				
				<input type="submit" value="확인">
				<button type="button" onclick="history.back();">취소</button>
			</form>
		</td>
	</tr>
</table>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

