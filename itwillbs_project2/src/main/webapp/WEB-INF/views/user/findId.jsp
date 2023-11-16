<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<hr>



    <h1>아이디 찾기</h1>
    <form method="post" action="">
=======
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
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
        <label for="name">이름:</label>
        <input type="text" name="user_name" id="name" required><br>
        <label for="phone">휴대폰 번호:</label>
        <input type="text" name="user_phone" id="phone" required><br>
        <button type="submit">아이디 찾기</button>
    </form>
<<<<<<< HEAD
    
  <hr>
  
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
=======
<<<<<<< Updated upstream
</body>
</html>
=======
    
  <hr>
  

<%@include file="/WEB-INF/views/include/footer.jsp"%>
>>>>>>> Stashed changes
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
