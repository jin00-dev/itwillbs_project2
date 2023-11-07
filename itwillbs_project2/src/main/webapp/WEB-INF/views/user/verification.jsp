<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/verify" method="post">
    <label for="verificationCode">인증 코드:</label>
    <input type="text" id="verificationCode" name="verificationCode" required>
    <button type="submit">인증</button>
</form>

</body>
</html>