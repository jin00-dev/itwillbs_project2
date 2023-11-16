<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="/user/findPassword" method="post">
        이름: <input type="text" name="user_name" required><br>
        아이디: <input type="text" name="user_id" required><br>
        <input type="submit" value="비밀번호 찾기">
    </form>
</body>
</html>
