<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>아이디 찾기</title>
</head>
<body>
    <h1>아이디 찾기</h1>
    <form method="post" action="/user/findId">
        <label for="name">이름:</label>
        <input type="text" name="user_name" id="name" required><br>
        <label for="phone">휴대폰 번호:</label>
        <input type="text" name="user_phone" id="phone" required><br>
        <button type="submit">아이디 찾기</button>
    </form>
</body>
</html>