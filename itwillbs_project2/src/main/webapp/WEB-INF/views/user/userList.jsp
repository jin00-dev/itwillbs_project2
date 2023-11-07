<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
</head>
<body>
    <h1>User List</h1>
      
    <table border="1">
        <tr>
            <td>아이디</td>
            <td>이름</td>
            <td>핸드폰</td>
            <td>회원가입일</td>
            <td>회원등급</td> 
            <td>등급변경</td> <!-- 사용자 등급 변경 옵션을 추가 -->
        </tr>
        
        <c:forEach var="vo" items="${userList}">
            <tr>
                <td>${vo.user_id}</td>
                <td>${vo.user_name}</td>
                <td>${vo.user_phone}</td>
                <td>${vo.user_regdate}</td>
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
                <td>
                    <form method="post" action="/user/changeGrade"> 
                        <input type="hidden" name="user_id" value="${vo.user_id}" /> 
                        <select name="user_type">
                            <option value="0" <c:if test="${vo.user_type == 0}">selected</c:if>>일반회원</option>
                            <option value="1" <c:if test="${vo.user_type == 1}">selected</c:if>>사업자</option>
                        </select>
                        <input type="submit" value="변경" />
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    
    <a href="/user/userMain">메인페이지로...</a>
</body>
</html>
<%@include file="../include/footer.jsp"%>