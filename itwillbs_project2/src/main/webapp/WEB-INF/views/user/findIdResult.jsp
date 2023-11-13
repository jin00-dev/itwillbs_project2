<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<hr>

    <h1>아이디 찾기 결과</h1>
    <p>회원님의 아이디는 <span>${userId}</span> 입니다.</p>
    
    <button type="button" class="btn btn-default" onclick=" location.href='/';">메인페이지로</button>
    
    
<hr>    
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>