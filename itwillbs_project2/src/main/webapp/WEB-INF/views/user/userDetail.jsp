<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>User Detail</h1>

<form method="post" action="/user/userDetail">
    <table border="1">
        <tr>
            <td>아이디</td>
            <td><input type="text" name="user_id" value="${user.user_id}" readonly></td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td><input type="text" name="user_pw" value="${user.user_pw}" readonly></td>
        </tr>
        <tr>
            <td>이름</td>
            <td><input type="text" name="user_name" value="${user.user_name}"></td>
        </tr>
        <tr>
            <td>핸드폰</td>
            <td><input type="text" name="user_phone" value="${user.user_phone}"></td>
        </tr>
        <tr>
            <td>회원가입일</td>
            <td><input type="text"  value="${user.user_regdate}" readonly></td>
        </tr>
        <tr>
            <td>회원등급</td>
            <td>
                <select name="user_type">
                    <option value="0" <c:if test="${user .user_type == 0}">selected</c:if>>일반회원</option>
                    <option value="1" <c:if test="${user.user_type == 1}">selected</c:if>>사업자</option>
                </select>
            </td>
        </tr>
    </table>

    <input type="submit" value="수정">
         <input type="button" value="회원삭제" onclick="deleteUser('${user.user_id}')">
</form>

<a href="/user/userMain">메인페이지로...</a>

<script>
    function deleteUser(user_id) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            location.href = "/user/deleteUser?user_id=" + user_id;
        }
    }
</script>