<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<form method="post" enctype="multipart/form-data">
	<div>
		<h3>이벤트 수정</h3>

		<!-- 이벤트 제목 -->
		<div>
			<label>제목:</label> <input type="text" name="enf_title"
				value="${resultVO.enf_title}">
		</div>

		<!-- 작성일 -->
		<div>
			<span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}"
					pattern="yyyy-MM-dd" /></span>
		</div>

		<!-- 기존 이미지 표시 (수정하지 않을 경우에 대비) -->
		<div>
			<label>현재 이미지:</label> <img src="/resources/event_img/${resultVO.enf_img}"
				alt="현재 이미지" /> 
				
			<!-- 기존 이미지 URL을 hidden field로 전송 -->
			<input type="hidden" name="enf_img"
				value="${resultVO.enf_img}">
		</div>


		<!-- 공지사항 내용 -->
		<div>
			<label for="enf_content">내용:</label>
			<textarea id="enf_content" name="enf_content" rows="10" cols="30">
                <c:out value="${resultVO.enf_content}" />
            </textarea>
		</div>

		<!-- hidden field for enf_notice_num -->
		<input type="hidden" name="enf_event_num"
			value="${resultVO.enf_event_num}">
	</div>

	<!-- 버튼 -->
	<div> 
		<button type="submit">수정하기</button>
		<button type="submit">수정취소</button>
	</div>
</form>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
