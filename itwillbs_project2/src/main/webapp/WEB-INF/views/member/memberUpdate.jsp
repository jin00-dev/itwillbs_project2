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
	<legend>회원정보 수정</legend>
		<form action="" method="post">
			아이디: <input type="text" value="${memberVO.user_id }" name="userid" readonly>  <br>
			비밀번호: <input type="text" value="${memberVO.user_pw }" name="userpw"> <br>
			이름:<input type="text" value="${memberVO.user_name }" name="username">  <br>
			전화번호:<input type="text" value="${memberVO.user_phone }" name="useremail">  <br>
			
			<input type="submit" value="정보 수정">
		</form>
	</fieldset>
</body>
</html>