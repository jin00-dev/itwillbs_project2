<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>userList.jsp</h1>
		
		<%-- ${userList } --%>
		
		<table border="1">
		  <tr>
		  	<td>아이디</td>
		  	<td>이름</td>
		  	<td>핸드폰</td>
		  	<td>회원가입일</td>
		  </tr>
		  
		 <c:forEach var="vo" items="${userList }"> 
		     <tr>
			  	<td>${vo.user_id }</td>
			  	<td>${vo.user_name }</td>
			  	<td>${vo.user_phone }</td>
			  	<td>${vo.user_regdate }</td>
			  </tr>
		 </c:forEach>
		</table>
		
		<a href="/user/userMain">메인페이지로...</a>
<%@include file="../include/footer.jsp"%>    