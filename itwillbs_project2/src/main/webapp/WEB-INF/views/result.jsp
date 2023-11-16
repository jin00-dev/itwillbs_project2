<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="./include/header.jsp"%>
<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 	<div class="card">
	    <div class="card-body">
	            <div class="mb-3">
	               	이름: ${paramMap.name } <br>
	            </div>
	            <div class="mb-3">
					아이디: ${paramMap.id } <br>
	            </div>
	            <c:forEach var="i" items="${paramMap.fileList }">
	    	        <div class="mb-3">
						파일: <a href="/download?fileName=${i }">${i }</a> <br>
		            </div>
	            </c:forEach>
	
	
	    </div>
	</div>
<!-- footer -->
<%@include file="./include/footer.jsp"%>
<script>
</script>
