<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/header.jsp"%>



 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <h2> 메인페이지 </h2>
    <!-- 로그인 정보가 없으면 로그인 페이지로 이동 -->
    
	
    <c:if test="${empty vo.user_id}">
       <c:redirect url="/user/login" />
    </c:if>
    
    사용자 아이디 : ${vo.user_id }<hr>
    사용자 이름 : ${vo.user_name }<hr>
    사용자 핸드폰 번호 : ${vo.user_phone }<hr>  
<%--     사용자 아이디 : ${sessionScope.vo.user_id }<hr> --%>
    
    ${vo.user_name }님 환영합니다.
    
    <input type="button" value="로그아웃" onclick=" location.href='/user/logout'; ">
    <hr>
    
    
    <h3><a href="/user/userInfo">회원정보 조회</a></h3>
   
    <hr><hr>
    
    <h3><a href="/user/userUpdate">회원정보 수정</a></h3>
    <hr><hr>
    <h3><a href="/user/pwUpdateView">비밀번호 변경</a></h3>
    <hr><hr>
    
    <h3><a href="/user/userDelete">회원정보 삭제</a></h3>
                                  
    <%-- <c:if test="${!empty id && id eq 'admin'}"> --%>
    <c:if test="${!empty user_id && user_id.equals('admin')}">
       <!-- 관리자(admin)일때 확인가능한 메뉴 -->    
       <hr><hr>
       <h3><a href="/user/list">회원정보 목록</a></h3>
    </c:if>
<%@include file="../include/footer.jsp"%>    
    
