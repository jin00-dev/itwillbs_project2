<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<h3>1:1 문의사항 상세 정보</h3>

<div>
	<!-- 문의 제목 -->
	<div>
		<span>제목: ${resultVO.qna_title}</span>
	</div>
	<!-- 문의 작성일 -->
	<div>
		<span>작성일: <fmt:formatDate value="${resultVO.qna_regdate}"
				pattern="yyyy-MM-dd HH:mm:ss" /></span>
	</div>

	<!-- 문의 상태 -->
	<div>
		<span>상태: <c:out
				value="${resultVO.qna_state == 0 ? '답변 대기' : '답변 완료'}" /></span>
	</div>

	<!-- 문의 내용 -->
	<div>
		<p>
			<c:out value="${resultVO.qna_content}" />
		</p>
	</div>

	<form id="actionForm" method="POST">
		<input type="hidden" name="qna_num" value="${resultVO.qna_num}">
	</form>

	
	<c:choose>
		<c:when test="${resultVO.qna_state == 1}">
			<!-- 이미 답변이 있는 경우 -->
			<div>
				<h6>답변 내용</h6>
				<p>
					<c:out value="${resultVO.qna_answer}" />
				</p>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 관리자가 아니며 답변이 없는 경우 -->
			<div>
				<h5>답변 대기 중</h5>
			</div>
		</c:otherwise>
	</c:choose>
		<%-- <c:when test="${sessionScope.user_id == 'admin'}"> --%>
			<!-- 관리자일 경우 답변 입력 폼을 보여줌 -->
			<div>
				<h5>답변 작성</h5>  
				<form action="/qna/qnaAnswer" method="post">
					<textarea name="qna_answer" rows="4" cols="50"></textarea>
					<input type="hidden" name="qna_num" value="${resultVO.qna_num}">
					<input type="submit" value="답변 등록">
				</form>
			</div>
		<%-- </c:when> --%>


	<!-- 목록/수정/삭제 버튼 -->
	<div>
		<button id="btnList">목록</button>

		<%-- <c:if
			test="${sessionScope.user_num == resultVO.user_num && resultVO.qna_state == 0}"> --%>
		<!-- 로그인한 사용자가 작성자이며 답변이 없을 경우에만 수정 및 삭제 버튼을 보여줍니다. -->
		<button id="btnUpdate">수정</button>
		<button id="btnDelete">삭제</button>
		<button id="bbtnDelete">답변 삭제</button>		
		<%-- </c:if> --%>

	</div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		// 목록 버튼 클릭 이벤트
		$('#btnList').click(function() {
			location.href = 'qnaListAll';
		});

		// 수정 버튼 클릭 이벤트
		$('#btnUpdate').click(function() {
			location.href = '/qna/updateQna?qna_num=${resultVO.qna_num}';
		});

		// 삭제 버튼 클릭 이벤트
		$('#btnDelete').click(function() {
			if (confirm('정말 삭제하시겠습니까?')) {
				// form의 action을 설정하고 서버로 POST 요청을 보냄
				$('#actionForm').attr('action', '/qna/removeQna').submit();
			}
		});
		
		// 답변 삭제 버튼 클릭 이벤트
		$('#bbtnDelete').click(function() {
			if (confirm('답변을 정말 삭제하시겠습니까?')) {
				// form의 action을 설정하고 서버로 POST 요청을 보냄
				$('#actionForm').attr('action', '/qna/removeAnswer').submit();
			}
		});
	});
</script>
