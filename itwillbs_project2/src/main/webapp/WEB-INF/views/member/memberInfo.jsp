<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원정보</h1>
	<div>
		<h3>
			아이디: ${memberVO.user_id } <br>
			비밀번호: ${memberVO.user_pw } <br>
			이름: ${memberVO.user_name } <br>
			이메일: ${memberVO.user_phone } <br>
			가입날짜: ${memberVO.user_regdate } <br>
			수정날짜: ${memberVO.user_last_access } 
		</h3>
	</div>	
	
	<a href="/">돌아가기</a>
	
</body>
</html>