<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>
 
<div class="container mt-3">
    <h3 class="mb-3">1:1문의 수정</h3>
    <form method="post">
        <div class="mb-3">
            <label for="qna_title" class="form-label">제목:</label>
            <input type="text" class="form-control" id="qna_title" name="qna_title" value="${resultVO.qna_title}">
        </div>
        
        <div class="mb-3">
            <label for="qna_content" class="form-label">내용:</label>
            <textarea class="form-control" id="qna_content" name="qna_content" rows="5">${resultVO.qna_content}</textarea>
        </div>

        <input type="hidden" name="qna_num" value="${resultVO.qna_num}">

        <div class="text-center">
            <button type="submit" class="btn btn-primary">수정하기</button>
            <button type="button" class="btn btn-secondary" onclick="history.back();">수정취소</button>
        </div>
    </form>  
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
