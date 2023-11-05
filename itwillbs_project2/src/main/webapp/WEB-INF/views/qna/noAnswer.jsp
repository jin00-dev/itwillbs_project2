<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<h4> 관리자) 문의사항 미답변 질문 리스트 </h4>

<table class="table">
    <tr>
        <th>번호</th>
        <th>제목</th> 
        <th>작성일</th>
        <th>답변 상태</th>
    </tr>
    <c:forEach var="qna" items="${qnaListAll}" varStatus="status">
        <c:if test="${qna.qna_state == 0}"> 
            <tr>
                <td>${fn:length(qnaListAll) - status.index}</td>
                <td><a href="/qna/qnaRead?qna_num=${qna.qna_num}">${qna.qna_title}</a></td>
                <td><fmt:formatDate value="${qna.qna_regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>답변 대기</td>
            </tr>
        </c:if>
    </c:forEach>
</table>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
