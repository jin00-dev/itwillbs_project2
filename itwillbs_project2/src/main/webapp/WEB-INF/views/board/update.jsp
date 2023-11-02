<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%> 

<form method="post">
	<div>
		<h3>공지사항 수정</h3>

		<!-- 공지사항 제목 -->
		<div>
			<label>제목:</label> <input type="text" name="enf_title"
				value="${resultVO.enf_title}">
		</div>

		<!-- 작성일 -->
		<div>
			<span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}"
					pattern="yyyy-MM-dd" /></span>
		</div>

		<!-- 공지사항 내용 -->
		<div>
			<label for="enf_content">내용:</label>
			<textarea id="enf_content" name="enf_content" rows="10" cols="30">
                <c:out value="${resultVO.enf_content}" />
            </textarea>
		</div>

		<!-- hidden field for enf_notice_num -->
		<input type="hidden" name="enf_notice_num"
			value="${resultVO.enf_notice_num}">
</form>
<!-- 버튼 -->
<div>
	<button type="submit" class="btn-update">수정하기</button>
	<button type="submit" class="btn-cancle">수정취소</button>
</div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var updateForm = $('#updateForm');

        // 수정하기 버튼 클릭
        $('.btn-update').click(function() {
            updateForm.submit();
        });

        // 취소하기 버튼 클릭
        $('.btn-cancle').click(function() {
            location.href = '/board/read';
        }); 
    });
</script>




<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
