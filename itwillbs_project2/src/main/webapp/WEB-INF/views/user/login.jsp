<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
	<h1>Login.jsp</h1>
	
	<h2> 로그인 페이지 </h2>
	
	<div class="container">
		<form action="" method="post">
		<!-- <form action="login" method="post"> -->
		<div class="form-group">
		<label for="id">아이디</label>
		<input type="text" name="user_id" id="user_id" class="form-control">
		</div>
		<div class="form-group">
		<label for="id">비밀번호</label>
		<input type="password" name="user_pw" id="user_pw" class="form-control" >
		</div>
		
			
<<<<<<< Updated upstream
			<button class="btn btn-default">로그인</button>
			<input type="button" value="회원가입"
					onclick=" location.href='/user/join';">
			<button type="button">아이디찾기</button>
			<button type="button">비밀번호찾기</button>
			</form>
		
=======
			<button class="btn btn-primary infoModBtn pull-right">로그인</button>
			<button class="btn btn-primary infoModBtn pull-right" onclick=" location.href='/user/join';">회원가입</button>
			<button type="button" class="btn btn-primary infoModBtn pull-right" onclick=" location.href='/user/findId';">아이디찾기</button>
			<button type="button" class="btn btn-primary infoModBtn pull-right" onclick=" location.href='/user/findPassword';">비밀번호찾기</button>
			
		</form>
>>>>>>> Stashed changes
	</div>
<%@include file="../include/footer.jsp"%>