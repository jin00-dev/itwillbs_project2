<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 
<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mt-5 shadow-lg">
                <div class="card-body">
                    <h2 class="card-title text-center mb-4">이벤트 글쓰기</h2>
                    <form method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="eventImage">이벤트 이미지:</label>
                            <input type="file" class="form-control-file" id="eventImage" name="file">
                        </div>
                        <div class="form-group">
                            <label for="eventStatus">진행 상태:</label>
                            <select class="form-control" id="eventStatus" name="enf_event_type">
                                <option value="1">이벤트 진행중</option>
                                <option value="0">종료된 이벤트</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="eventTitle">제목:</label>
                            <input type="text" class="form-control" id="eventTitle" name="enf_title">
                        </div>
                        <div class="form-group">
                            <label for="eventContent">내용:</label>
                            <textarea class="form-control" id="eventContent" name="enf_content" rows="4"></textarea>
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="작성하기">
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

