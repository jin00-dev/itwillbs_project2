<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<h3>이벤트</h3>


<div>
	<!-- 이벤트 진행 상태 -->
	<div>
		<span>진행 상태: <c:out
				value="${resultVO.enf_event_type == 1 ? '이벤트 진행 중' : '종료된 이벤트'}" />
		</span>
	</div>

	<!-- 이벤트 제목 -->
	<h5>${resultVO.enf_title}</h5>

	<!-- 이벤트 사진 -->
	<div>
		<img src="/resources/event_img/${resultVO.enf_img}" alt="이벤트 사진" />
	</div>

	<!-- 이벤트 작성일 -->
	<div>
		<span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}"
				pattern="yyyy-MM-dd" /></span>
	</div>

	<!-- 이벤트 내용 -->
	<div>
		<p>
			<c:out value="${resultVO.enf_content}" />
		</p>
	</div>

	<form id="actionForm" method="POST">
		<input type="hidden" name="enf_event_num"
			value="${resultVO.enf_event_num}">
	</form>

	<!-- 목록/수정/삭제 버튼 -->
	<div>
		<button id="btnList">목록</button>

		<c:if
			test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
			<button id="btnUpdate">수정</button>
			<button id="btnDelete">삭제</button>
		</c:if>

	</div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
