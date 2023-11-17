<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp"%>

<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var cnt = 1;
						$('#fileBtn')
								.click(
										function() {
											// 클릭시마다 파일업로드 버튼 추가	
											$('#fileDiv')
													.append(
															"<br> <input type='file' name='file"+cnt+"'>");
											cnt++;
										});

					});
</script>

<h1>/views/uploadForm.jsp</h1>

<h2>파일업로드(다중)</h2>

<form action="/board/fileUpload" method="post" enctype="multipart/form-data">
	아이디 : <input type="text" name="id"><br> 이름 : <input
		type="text" name="name"><br> <input type="button"
		value="파일추가" id="fileBtn">
	<hr>
	<div id="fileDiv"></div>

	<input type="submit" value="파일 업로드">
</form>

<%@include file="/WEB-INF/views/include/footer.jsp"%>