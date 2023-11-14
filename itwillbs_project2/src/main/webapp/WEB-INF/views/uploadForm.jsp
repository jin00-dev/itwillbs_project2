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
	        <form method="post" action="/fileUpload" enctype="multipart/form-data">
	            <div class="mb-3">
	                <input type="text" class="form-control" name="id" placeholder="ID">
	            </div>
	            <div class="mb-3">
	                <input type="text" class="form-control" name="name" placeholder="Name">
	            </div>
	
	            <div class="mb-3">
	                <input id="fileBtn" type="button" class="btn btn-primary" value="파일추가" name="fileBtn">
	            </div>
	
	            <div class="mb-3">
	                <input  type="submit" class="btn btn-success" value="업로드">
	                <div class="mb-3" id="fileDiv"></div>
	            </div>
	        </form>
	    </div>
	</div>
<!-- footer -->
<%@include file="./include/footer.jsp"%>
<script>
	var cnt = 1;
	
	$('#fileBtn').click(function(){
		$('#fileDiv').append("<br> <input type='file' name='file"+cnt+"'>");
		cnt++;
	});
</script>
