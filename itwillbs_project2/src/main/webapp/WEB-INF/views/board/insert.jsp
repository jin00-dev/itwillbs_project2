<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>
  
<div>
	<div>
		<h3>공지사항 글쓰기</h3>
	</div>


	<form method="post" role="form"> 
		<div>
			<div>
				<label for="exampleInputPassword1">제목</label> 
				<input type="text" name="enf_title">
			</div>
			<div>
				<label>내 용</label>
				<textarea rows="3" name="enf_content"></textarea>
			</div>

		</div>

		<div>
			<button type="submit">글쓰기</button>
		</div>
	</form>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

