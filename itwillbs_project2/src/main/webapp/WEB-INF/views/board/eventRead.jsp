<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/custom.css">
<style>
.event-header {
	background-color: #e9ecef;
	padding: 20px;
	border-radius: 10px;
	margin-bottom: 15px;
}

.event-status {
	display: inline-block;
	padding: 5px 10px;
	border-radius: 10px;
	background-color: #ff6b6b;
	color: white;
	font-weight: bold;
	margin-bottom: 5px;
}

.event-title {
	font-size: 1.5em;
	color: #333;
}

.event-date {
	font-size: 0.9em;
	color: #666;
}

.event-content img {
	width: 100%;
	height: auto;
	border-radius: 10px;
	overflow: hidden;
}
 
.responsive-img {
	max-width: 50%;
	height: auto;
	display: block;
	margin-left: auto;
	margin-right: auto;
}

.content-center {
	text-align: center;
	margin: 20px 0;
}

.content-text {
	font-size: 1.1rem;
	line-height: 1.6;
	color: #333;
	max-width: 800px;
	margin: 0 auto;
	padding: 10px;
}
</style>


<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container mt-5">
	<div class="event-header">
		<span class="event-status">${resultVO.enf_event_type == 1 ? '이벤트 진행 중' : '종료된 이벤트'}</span>
		<h2 class="event-title">${resultVO.enf_title}</h2>
		<div class="event-date">
			작성일:
			<fmt:formatDate value="${resultVO.enf_regdate}" pattern="yyyy-MM-dd" />
		</div>
	</div>

	<!-- 이벤트 사진과 내용 -->
	<div class="event-content mb-4">
		<img src="/resources/event_img/${resultVO.enf_img}"
			class="img-fluid responsive-img" alt="이벤트 사진"
			style="max-width: 50%; height: auto;">
		<div class="content-center">
			<p class="content-text">${resultVO.enf_content}</p>
		</div>
	</div>

	<div class="card-footer text-muted">
		<form id="actionForm" method="POST">
			<input type="hidden" name="enf_event_num"
				value="${resultVO.enf_event_num}">
		</form>

		
		<div class="text-center">
			<button id="btnList" class="btn btn-danger">목록</button>
			<button id="btnUpdate" class="btn btn-danger">수정</button>
			<button id="btnDelete" class="btn btn-danger">삭제</button>
		</div>
 

		<!-- <c:if test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
                <button id="btnUpdate" class="btn btn-warning">수정</button>
                <button id="btnDelete" class="btn btn-danger">삭제</button>
            </c:if> -->
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
<script>
	$(document)
			.ready(
					function() {
						// 목록 버튼 클릭 이벤트
						$('#btnList').click(function() {
							location.href = 'eventListAll';
						});

						// 수정 버튼 클릭 이벤트
						$('#btnUpdate')
								.click(
										function() {
											location.href = '/board/eventUpdate?enf_event_num=${resultVO.enf_event_num}';
										});

						// 삭제 버튼 클릭 이벤트
						$('#btnDelete').click(
								function() {
									if (confirm('정말 삭제하시겠습니까?')) {
										// form의 action을 설정하고 서버로 POST 요청을 보냄
										$('#actionForm').attr('action',
												'/board/eventRemove').submit();
									}
								});
					});
</script>

