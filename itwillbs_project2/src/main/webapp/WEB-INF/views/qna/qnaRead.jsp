<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

<%@include file="/WEB-INF/views/include/header.jsp"%>
<div class="container mt-5">
	<div class="card">
		<h3 class="card-header">1:1 문의사항 상세</h3>
		<div class="card-body">
			<div class="row mb-3 pb-2 border-bottom">
				<div class="col-8">
					<h5 class="card-title">제목: ${resultVO.qna_title}</h5>
				</div>
				<div class="col-4 text-right">
					<h6 class="card-subtitle mb-2 text-muted">
						작성일:
						<fmt:formatDate value="${resultVO.qna_regdate}"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</h6>
				</div>
			</div>

			<div class="mb-3 pb-2 border-bottom">
				<p class="card-text">
					<strong>현재 상태:</strong>
					<c:choose>
						<c:when test="${resultVO.qna_state == 0}">
							<span class="badge badge-warning">답변 대기</span>
						</c:when>
						<c:otherwise>
							<span class="badge badge-success">답변 완료</span>
						</c:otherwise>
					</c:choose>
				</p>
			</div>

			<div class="mb-3 pb-2">
				<p class="card-text">${resultVO.qna_content}</p>
			</div>


			<c:choose>
				<c:when test="${resultVO.qna_state == 1}">
					<!-- 답변 내용 -->
					<div class="border-top pt-3">
						<h6 class="font-weight-bold">답변 내용:</h6>
						<p>${resultVO.qna_answer}</p>
					</div>
				</c:when>
				<c:otherwise>
					<!-- 답변 대기 메시지 -->
					<div class="border-top pt-3">
						<h5 class="text-muted">답변 대기 중...</h5>
					</div>
				</c:otherwise>
			</c:choose>

			<c:if test="${user_type == '2' and resultVO.qna_state == 0}">
			
			<div>
				<h5>답변 작성</h5>
				<form action="/qna/qnaAnswer" method="post">
					<div class="form-group">
						<textarea class="form-control" name="qna_answer" rows="4"></textarea>
					</div>
					<input type="hidden" name="qna_num" value="${resultVO.qna_num}">
					<button type="submit" class="btn btn-primary">답변 등록</button>
				</form>
			</div>
			</c:if>

			<form id="actionForm" method="POST">
				<input type="hidden" name="qna_num" value="${resultVO.qna_num}">
			</form>

			<!-- 목록/수정/삭제 버튼 -->
			<div class="mt-3">
				<button id="btnList" class="btn btn-secondary">목록</button>
				<button id="btnUpdate" class="btn btn-secondary">수정</button>
				<button id="btnDelete" class="btn btn-secondary">삭제</button>
				<c:if test="${user_type == '2' }">
				<button id="bbtnDelete" class="btn btn-secondary">답변 삭제</button>
				</c:if>
			</div>
		</div>
		<%-- <c:if
			test="${sessionScope.user_num == resultVO.user_num && resultVO.qna_state == 0}"> --%>
		<!-- 로그인한 사용자가 작성자이며 답변이 없을 경우에만 수정 및 삭제 버튼을 보여줍니다. -->
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
			// 답변 내용을 검사
			var answerContent = "${resultVO.qna_answer}";

			// 답변 내용이 비어있는지 확인
			if (!answerContent.trim()) {
				alert('답변이 없습니다.');
				return false; // 이벤트 중단
			}

			if (confirm('답변을 정말 삭제하시겠습니까?')) {
				// form의 action을 설정하고 서버로 POST 요청을 보냄
				$('#actionForm').attr('action', '/qna/removeAnswer').submit();
			}
		});
	});
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.9.3/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
