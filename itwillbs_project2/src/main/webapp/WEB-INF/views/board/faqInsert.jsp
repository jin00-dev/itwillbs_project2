<%@ page
	import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp"%>

<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  
<div class="container">
	<div class="row justify-content-center">
		<div class="col-md-8">
			<div class="card mt-5 shadow-lg"> 
				<div class="card-body">
					<h2 class="card-title text-center mb-4">FAQ 작성하기</h2>


					<form method="post" role="form">
						<div class="form-group">
							<label for="inputTitle">질문</label> <input type="text"
								class="form-control" name="enf_title" id="inputTitle">
						</div>
						<div class="form-group">
							<label for="inputContent">답변</label>
							<textarea class="form-control" name="enf_content"
								id="inputContent" rows="3"></textarea>
						</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary">글쓰기</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
</div>

<script src="//code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<%@include file="/WEB-INF/views/include/footer.jsp"%>
