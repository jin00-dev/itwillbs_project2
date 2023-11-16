<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>userList.jsp</h1>
		
		<%-- ${userList } --%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ${userList } --%>
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
		
		<table border="1">
		  <tr>
		  	<td>아이디</td>
		  	<td>이름</td>
		  	<td>핸드폰</td>
		  	<td>회원가입일</td>
<<<<<<< HEAD
=======
		  	<td>회원등급</td> 
		  	<td>상세보기</td> 
           
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
		  </tr>
		  
		 <c:forEach var="vo" items="${userList }"> 
		     <tr>
			  	<td>${vo.user_id }</td>
			  	<td>${vo.user_name }</td>
			  	<td>${vo.user_phone }</td>
			  	<td>${vo.user_regdate }</td>
<<<<<<< HEAD
=======
			  	
			  	    <td>
                    <c:choose>
                        <c:when test="${vo.user_type == 1}">
                            사업자
                        </c:when>
                        <c:when test="${vo.user_type == 0}">
                            일반회원
                        </c:when>
                        <c:otherwise>
                            기타 등급
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><a href="/user/userDetail?user_id=${vo.user_id}">상세보기</a></td>
                <td>
                    <form method="post" action="/user/changeGrade"> 
                        <input type="hidden" name="user_id" value="${vo.user_id}" /> 
                       
                    </form>
                </td>
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
			  </tr>
		 </c:forEach>
		</table>
		
		<a href="/user/userMain">메인페이지로...</a>
<<<<<<< HEAD
<%@include file="../include/footer.jsp"%>    
=======
		
	
		
>>>>>>> 26fb7997bfc552df670a8f1ac1d53750446afc12
