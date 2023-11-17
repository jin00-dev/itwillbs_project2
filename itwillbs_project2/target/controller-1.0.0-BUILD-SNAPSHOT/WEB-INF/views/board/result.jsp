<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>result.jsp</h1>
	
	<h2> 파일 업로드 처리 결과 </h2>
	
	
	${paramMap }
	
	<h2> 전달된 정보(파라메터)</h2>
	 이름 : ${paramMap.name } <hr>
	 아이디 : ${paramMap.id } <hr>
	
	<h2> 전달된 정보(파일)</h2>
	<%-- 	 파일 : $ {paramMap.fileList[0] }<hr> --%>
	 <c:forEach var="upFile" items="${paramMap.fileList }">	 
	 	파일 : <a href="/download?fileName=${upFile }">${upFile }</a><hr> 	 
	 </c:forEach>
	
	<h3><a href="/uploadForm">다시 파일업로드 처리하기</a></h3>
	

</body>
</html>