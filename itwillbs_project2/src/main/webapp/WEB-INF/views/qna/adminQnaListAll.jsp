<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container mt-5">
    <div class="row">
        <!-- 고객센터 섹션 -->
        <div class="col-md-3">
            <div class="list-group mb-4">
                <h5 class="list-group-item list-group-item-action active" aria-current="true">고객센터</h5>
                <a href="/board/boardListAll" class="list-group-item list-group-item-action">공지사항</a>
                <a href="/board/" class="list-group-item list-group-item-action">챗봇 상담</a>
                <a href="/board/qnaList" class="list-group-item list-group-item-action">1:1문의</a>
            </div>
        </div>

        <!-- 1대1 문의사항 리스트 섹션 -->
        <div class="col-md-9">
            <h3 class="mb-4">전체 회원 1대1 문의사항 리스트</h3> 
            <table class="table">
                <thead class="thead-light">
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성일</th>
                        <th scope="col">답변 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="qna" items="${qnaListAll}" varStatus="status">
                        <tr>
                            <td>${fn:length(qnaListAll) - status.index}</td> <!-- 역순 번호 계산 -->
                            <td><a href="/qna/qnaRead?qna_num=${qna.qna_num}">${qna.qna_title}</a></td>
                            <td><fmt:formatDate value="${qna.qna_regdate}" pattern="yyyy-MM-dd" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${qna.qna_state == 0}">답변대기</c:when>
                                    <c:otherwise>답변완료</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div> 

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
