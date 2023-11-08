<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/header.jsp"%>

    <h2> 메인페이지 </h2>
    <!-- 로그인 정보가 없으면 로그인 페이지로 이동 -->
    

    <c:if test="${empty id}">
       <c:redirect url="/user/login" />
    </c:if>
    
    사용자 아이디 : ${id }<hr>
    사용자 아이디 : ${sessionScope.id }<hr>
    
    <input type="button" value="로그아웃" onclick=" location.href='/user/logout'; ">
    <hr>
    
    
    <h3><a href="/user/info">회원정보 조회</a></h3>
   
    <hr><hr>
    
    <h3><a href="/user/update">회원정보 수정</a></h3>
    <hr><hr>
    
    <h3><a href="/user/delete">회원정보 삭제</a></h3>
                                  
    <%-- <c:if test="${!empty id && id eq 'admin'}"> --%>
    <c:if test="${!empty id && id.equals('admin')}">
       <!-- 관리자(admin)일때 확인가능한 메뉴 -->    
       <hr><hr>
       <h3><a href="/user/list">회원정보 목록</a></h3>
    </c:if>
<%@include file="../include/footer.jsp"%>    
    
