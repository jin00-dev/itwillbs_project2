<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%> 
  
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">이벤트 수정</h5>

                    <!-- 이벤트 수정 Form -->
                    <form method="post" role="form" enctype="multipart/form-data">
                        <div class="row mb-3">
                            <label for="inputTitle" class="col-sm-2 col-form-label">제목</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="enf_title" id="inputTitle" value="${resultVO.enf_title}">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inputDate" class="col-sm-2 col-form-label">작성일</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="inputDate" value="<fmt:formatDate value="${resultVO.enf_regdate}" pattern="yyyy-MM-dd"/>" disabled>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inputContent" class="col-sm-2 col-form-label">내용</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" name="enf_content" id="inputContent" rows="3">${resultVO.enf_content}</textarea>
                            </div>
                        </div>
                  
                        <input type="hidden" name="enf_event_num" value="${resultVO.enf_event_num}">
                        <div class="row mb-3">
                            <div class="col-sm-10 offset-sm-2">
                                <button type="submit" class="btn btn-primary btn-update">수정하기</button>
                                <button type="button" class="btn btn-secondary btn-cancel">수정취소</button>
                            </div>
                        </div>
                    </form><!-- End 이벤트 수정 Form -->

                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        // 수정하기 버튼 클릭 이벤트
        $('.btn-update').click(function() {
            $('form').submit();
        });

        // 수정취소 버튼 클릭 이벤트 
        $('.btn-cancel').click(function() {
            window.history.back();
        });
    });
</script>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

