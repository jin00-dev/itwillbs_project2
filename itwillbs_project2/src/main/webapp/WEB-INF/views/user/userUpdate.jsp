<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
	<h1>userUpdate.jsp</h1>
		
		<h2> 회원수정 페이지 </h2>
		
		<fieldset>
			<!-- action="" 인경우 자기자신의 경로 호출 -->
			<form action="" method="post">
				아이디 : <input type="text" name="user_id" value="${vo.user_id }" readonly><br>
				비밀번호 : <input type="password" name="user_pw" ><br>
				비밀번호 확인 : <input type="password" name="user_pw2" ><br>
				이름 : <input type="text" name="user_name" value="${vo.user_name }"><br>
				핸드폰 : <input type="text" name="user_phone" value="${vo.user_phone }"><hr>
				
				<input type="submit" value=" 회 원 수 정 ">			
			</form>		
		</fieldset>
<%@include file="../include/footer.jsp"%>