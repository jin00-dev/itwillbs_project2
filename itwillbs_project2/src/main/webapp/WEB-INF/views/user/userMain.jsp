<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>main.jsp</h1>
	<c:if test="${empty user_id}">
		<c:redirect url="/user/login"/>
	</c:if>
	
	
	사용자 아이디 : ${user_id }<hr>
	
	
</body>
</html>