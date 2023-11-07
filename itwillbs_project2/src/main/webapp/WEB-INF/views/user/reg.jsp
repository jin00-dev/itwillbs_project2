<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
		<div class="titleStyle">
			<h1>MS :p</h1>
		</div>
		<form method="POST">
			<!-- 세션에 저장한 카카오 아이디를 가져옴 --> 
			<input type="hidden" name="kakao_id" value="${kakao_id}"/>
			<!-- 아이디 -->
			<div class="form-group">
				<label for="user_id">아이디</label>
					<input type="text" class="form-control" id="user_id" name="user_id" placeholder="ID" required>
				<div class="check_font" id="id_check"></div>
			</div>

<div class="reg_button">
				<a class="btn btn-danger px-3" href="${pageContext.request.contextPath}">
					<i class="fa fa-rotate-right pr-2" aria-hidden="true"></i>취소하기
				</a>&emsp;&emsp;
				<button class="btn btn-primary px-3" id="reg_submit">
					<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
				</button>
			</div>
		</form>
		
		
</body>
</html>