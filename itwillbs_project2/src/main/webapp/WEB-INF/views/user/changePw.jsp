<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
  
</head>
<body>
    <h2>비밀번호 변경</h2>

    <!-- 비번 변경 성공  -->
    
    <div style="color: green;">
        ${success}
    </div>

    <!-- 비번 변경 실패 -->
  
    <div style="color: red;">
        ${error}
    </div>

    <!-- 비번 변경 폼 -->
    <form action="/user/changePassword" method="post">
        <!-- 사용자의 이름과 아이디는 hidden으로 전송 -->
        <input type="hidden" name="user_name" value="${user_name}">
        <input type="hidden" name="user_id" value="${user_id}">

        <!-- 새비번 -->
        <label for="new_password">새로운 비밀번호:</label>
        <input type="password" id="new_password" name="new_password" required>
        <br>

        <!-- 비번확인  -->
        <label for="confirm_password">비밀번호 확인:</label>
        <input type="password" id="confirm_password" name="confirm_password" required>
        <br>
  <!-- 비밀번호 변경 버튼 -->
        <input type="submit" value="비밀번호 변경">
    </form>

    
</body>
</html>
