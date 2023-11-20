<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mt-5 shadow-lg">
                <div class="card-body">
                    <h2 class="card-title text-center mb-4">공지사항 글쓰기</h2>

                    <!-- 공지사항 글쓰기 Form -->
                    <form method="post" role="form">
                        <div class="form-group">
                            <label for="inputTitle">제목</label>
                            <input type="text" class="form-control" name="enf_title" id="inputTitle">
                        </div>
                        <div class="form-group">
                            <label for="inputContent">내용</label>
                            <textarea class="form-control" name="enf_content" id="inputContent" rows="3"></textarea>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">글쓰기</button>
                        </div>
                    </form><!-- End 공지사항 글쓰기 Form -->

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
