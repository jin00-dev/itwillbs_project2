<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<<<<<<< HEAD
<!-- 	<h1>/user/userDelete.jsp</h1> -->
		
		<h2> 회원 탈퇴 </h2>
=======
	<h1>/user/userDelete.jsp</h1>
		
		<h2> 회원정보 탈퇴 </h2>
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
		
		<fieldset>
			<form action="" method="post">
			  <input type="hidden" name="user_id" value="${id }">
			  비밀번호 : <input type="password" name="user_pw" >
			  <input type="submit" value="탈퇴하기">
			</form>		
		</fieldset>
<%@include file="../include/footer.jsp"%>