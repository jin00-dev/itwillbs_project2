<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%> 

<form method="post">
	<div>
		<h3>1:1문의 수정</h3>

		<div>
			<label>제목:</label> <input type="text" name="qna_title"
				value="${resultVO.qna_title}">
		</div>

		
		<div>
			<label for="qna_content">내용:</label>
			<textarea id="qna_content" name="qna_content" rows="10" cols="30">
                ${resultVO.qna_content}
            </textarea>
		</div>

		<input type="hidden" name="qna_num"
			value="${resultVO.qna_num}">
</form>


<div>
	<button type="submit">수정하기</button>
	<button type="submit">수정취소</button>
</div> 




<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
