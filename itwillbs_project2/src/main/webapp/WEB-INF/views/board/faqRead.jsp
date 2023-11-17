<%@ page
	import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp"%>
 
<div class="notice-detail">
	<h3 class="notice">자주 묻는 질문</h3>
 
 
	<div class="title-date">
		<h6 class="enf_title">${faqList.enf_title}</h6>

		<span>작성일: <fmt:formatDate value="${faqList.enf_regdate}"
				pattern="yyyy-MM-dd" /></span>
	</div>
	<hr>


	<div class="content">
		<p>
			<c:out value="${faqList.enf_content}" />
		</p>
	</div>

	<form id="actionForm" method="POST">
		<input type="hidden" name="enf_faq_num" value="${faqList.enf_faq_num}">
	</form>


	<div>
		<button id="btnList">목록</button>
		<button id="btnUpdate">수정</button>
		<button id="btnDelete">삭제</button>

		<!-- <c:if
			test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
			<button id="btnUpdate">수정</button>
			<button id="btnDelete">삭제</button>
		</c:if> -->

	</div>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						// 목록 버튼 클릭 이벤트
						$('#btnList').click(function() {
							location.href = 'faqListAll';
						});

						// 수정 버튼 클릭 이벤트
						$('#btnUpdate')
								.click(
										function() {
											location.href = '/board/faqUpdate?enf_faq_num=${faqList.enf_faq_num}';
										});

						// 삭제 버튼 클릭 이벤트
						$('#btnDelete')
								.click(
										function() {
											// 사용자에게 삭제 확인을 요청
											var confirmation = confirm('이 글을 삭제하시겠습니까?');

											// 사용자가 확인을 눌렀다면
											if (confirmation) {
												// 폼의 action 속성을 설정하고, submit을 호출하여 서버에 삭제 요청
												$('#actionForm').attr('action',
														'/board/faqRemove')
														.submit();
											}
										});
					});
</script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>