
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- header-->
<%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>join.jsp</h1>
      
      <h2> 회원가입 페이지 </h2>
      
     
	<fieldset>
	 <form action="/register" method="post">
        <label for="user_id">이메일:</label>
        <input type="email" name="user_id" required>
      
           <!--  아이디 : <input type="text" name="user_id"><br> -->
            비밀번호 : <input type="password" name="user_pw"><br>
            이름 : <input type="text" name="user_name"><br>
            핸드폰번호 : <input type="text" name="user_phone"><br>
             
            <input type="submit" value=" 회 원 가 입 ">         
         </form>      
      </fieldset>

</body>
</html>

<%@include file="../include/footer.jsp"%>