<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>Reservation Mail Send</h1>
<hr><br>

<div>
	<form action="${pageContext.request.contextPath}/mail/mailSend" method="post">
		<div class="input_1">
			<laber>성</laber>
			<input type="text" name="name" placeholder="Name" required="">
		</div>	
		<div class="input_2">
			<laber>이름</laber>
			<input type="text" name="last_name" placeholder="last_Name" required="">
		</div>	
		<div class="input_3">
			<input type="email" name="email" placeholder="Email" required="">
		</div>	
		<div class="input_4">
			<textarea type="message" name="Message" placeholder="Message" required=""></textarea>
		</div>	
		<div>
			<div class="click">
				<input type="submit" value="SEND">			
			</div>
		</div>
	
	</form>
</div>

</body>
</html>
 