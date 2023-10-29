<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<fieldset>
		<legend>로그인</legend>
		<form action="" method="post">
			<input type="text" name="user_id" placeholder="아이디"><br>
			<input type="password" name="user_pw" placeholder="비밀번호"><br>
			
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" 
			            onclick="location.href='/member/insert';">
		</form>
	</fieldset>
</body>
</html>