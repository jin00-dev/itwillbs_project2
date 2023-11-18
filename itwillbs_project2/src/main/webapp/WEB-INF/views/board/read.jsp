<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.notice-detail{background:#fff;padding:20px;margin:20px auto;max-width:800px;border:1px solid #ddd;border-radius:5px;box-shadow:0 0 10px rgba(0,0,0,.1)}.notice-detail h3{border-bottom:2px solid #e65c00;color:#555;padding-bottom:10px;margin-bottom:20px}.notice-detail div,.notice-detail h5,.notice-detail hr{margin-bottom:10px}.notice-detail h5{color:#333}.notice-detail button{background:#f76b1c;color:#fff;border:0;padding:3px 6px;margin-right:10px;border-radius:5px;cursor:pointer}.notice-detail button:hover{background:#e65c00}.notice-detail form{display:inline}.notice-detail .title-date{display:flex;justify-content:space-between;align-items:center}.notice-detail .title-date h5{margin:0}.notice-detail hr{border:0;height:1px;background-color:#333;margin-top:10px}.notice-detail .content{padding-top:10px}.enf_title{font-weight:600;font-size:18px}.notice{font-weight:700}
</style>

<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="notice-detail">
	<h3 class="notice">공지사항</h3>


	<div class="title-date">
		<h6 class="enf_title">${resultVO.enf_title}</h6>

		<span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}"
				pattern="yyyy-MM-dd" /></span>
	</div>
	<hr>


	<div class="content">
		<p>
			<c:out value="${resultVO.enf_content}" />
		</p>
	</div>

	<form id="actionForm" method="POST">
		<input type="hidden" name="enf_notice_num"
			value="${resultVO.enf_notice_num}">
	</form>


	<div>
		<button id="btnList">목록</button>
		<c:if test="${user_type eq 2}">
		<button id="btnUpdate">수정</button>
		<button id="btnDelete">삭제</button>
		</c:if>
	</div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						// 목록 버튼 클릭 이벤트
						$('#btnList').click(function() {
							location.href = 'boardListAll';
						});

						// 수정 버튼 클릭 이벤트
						$('#btnUpdate')
								.click(
										function() {
											location.href = '/board/update?enf_notice_num=${resultVO.enf_notice_num}';
										});

						$('#btnDelete').click(function() {
						    Swal.fire({
						        title: "정말로 삭제하시겠습니까?",
						        text: "이 작업은 되돌릴 수 없습니다!",
						        icon: "warning",
						        showCancelButton: true,
						        confirmButtonColor: "#3085d6",
						        cancelButtonColor: "#d33",
						        cancelButtonText: "취소",
						        confirmButtonText: "확인"
						    }).then((result) => {
						        if (result.isConfirmed) {
						            // 사용자가 확인 버튼을 클릭했을 때 서버로 POST 요청을 보냄
						            $('#actionForm').attr('action', '/board/remove').submit();
						            
						            // 파일이 삭제되었다는 알림
						            Swal.fire({
						                title: "삭제됨!",
						                text: "글이 성공적으로 삭제되었습니다.",
						                icon: "success"
						            });
						        }
						    });
						});


					});
</script>
