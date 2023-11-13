<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container mt-5">
    <div class="row">
        <!-- 고객센터 메뉴 섹션 -->
        <div class="col-md-3">
            <div class="list-group mb-4">
				<h5 class="list-group-item list-group-item-action active" aria-current="true">고객지원</h5>
				<a href="/board/boardListAll" class="list-group-item list-group-item-action">공지사항</a> 
<!-- 				<a href="/board/" class="list-group-item list-group-item-action">챗봇상담</a>  삭제 -->
				<a href="/qna/qnaCreate" class="list-group-item list-group-item-action">1:1 문의</a>
				<a href="#" class="list-group-item list-group-item-action">자주 묻는 질문</a>
            </div>
        </div>

        <!-- 1대1 문의사항 쓰기 섹션 -->
        <div class="col-md-9">
            <div class="card shadow-lg">
                <div class="card-body">
                    <h2 class="card-title">1대1 문의사항 쓰기</h2>
                    <form method="post" role="form">
                        <div class="form-group">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" id="title" name="qna_title" required>
                        </div>
                        <div class="form-group">
                            <label for="content">내용</label>
                            <textarea class="form-control" id="content" name="qna_content" rows="4" required></textarea>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">확인</button>
                            <button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
