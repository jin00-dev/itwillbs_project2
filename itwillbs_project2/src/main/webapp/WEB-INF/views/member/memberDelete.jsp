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
	<legend>회원 탈퇴</legend>
		<form action="" method="post">
			아이디: <input type="text" value="${sessionScope.id }" name="user_id" readonly>  <br>
			비밀번호: <input type="password" value="" name="user_pw"> <br>
			
			<input type="submit" value="회원 탈퇴">
		</form>
	</fieldset>
</body>
</html>