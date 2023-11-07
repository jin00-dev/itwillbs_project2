<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h1>/user/userDelete.jsp</h1>
      
      <h2> 회원정보 탈퇴 </h2>
      
      <fieldset>
         <form action="" method="post">
           <input type="hidden" name="user_id" value="${id }">
           비밀번호 : <input type="password" name="user_pw" >
           <input type="submit" value="탈퇴하기">
         </form>      
      </fieldset>
</body>
</html>

<%@include file="../include/footer.jsp"%>