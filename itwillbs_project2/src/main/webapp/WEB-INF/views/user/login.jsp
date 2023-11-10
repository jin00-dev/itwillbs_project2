<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
	
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
			
			<button class="btn btn-default">로그인</button>
			<button class="btn btn-default" onclick=" location.href='/user/join';">회원가입</button>
			<button type="btn btn-default">아이디찾기</button>
			<button type="btn btn-default">비밀번호찾기</button>
			
		</form>
	</div>
<%@include file="../include/footer.jsp"%>