<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.notice-detail h3.notice{color:#495057;border-bottom:2px solid #007bff;padding-bottom:.5rem}.title-date{display:flex;justify-content:space-between;align-items:center;margin-bottom:1rem}.title-date h6{margin-bottom:0;font-size:1.25rem;font-weight:500;color:#007bff}.title-date span{font-size:.875rem;color:#6c757d}hr{margin-top:0;margin-bottom:1rem}.content{white-space:pre-wrap;background:#f8f9fa;border:1px solid #e9ecef;padding:1rem;border-radius:.25rem;margin-bottom:1rem}.content pre{margin-bottom:0}.notice-detail button{font-size:.875rem;border:none;transition:background-color .15s ease-in-out}#btnList{background-color:#6c757d;color:#fff}#btnDelete,#btnUpdate{background-color:#007bff;color:#fff}.notice-detail button:hover{filter:brightness(90%)}.notice-detail button:not(:disabled):not(.disabled):hover{box-shadow:0 .5rem 1rem rgba(0,0,0,.15)}
.shift-left{margin-left:-10px}
</style>




<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="container mt-5">
	<div class="row">
		<!-- 사이드바 -->
		<div class="col-md-3 shift-left">
			<div class="list-group mb-4 h-100">
				<h5 class="list-group-item list-group-item-action active"
					aria-current="true">고객지원</h5>
				<a href="/board/boardListAll"
					class="list-group-item list-group-item-action">공지사항</a> <a
					href="/board/faqListAll"
					class="list-group-item list-group-item-action">자주 묻는 질문</a> <a
					href="/board/" class="list-group-item list-group-item-action">1:1문의</a>
			</div>
		</div>

		<!-- 공지사항 상세 정보 -->
		<div class="col-md-9 shift-left">
			<div class="notice-detail">
				<h3 class="notice">공지사항</h3>
				<div class="title-date">
					<h6 class="enf_title">${resultVO.enf_title}</h6>
					<span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}"
							pattern="yyyy-MM-dd" /></span>
				</div>
				<hr>
				<div class="content">
					<pre>
						<c:out value="${resultVO.enf_content}" />
					</pre>
				</div>
				<form id="actionForm" method="POST">
					<input type="hidden" name="enf_notice_num"
						value="${resultVO.enf_notice_num}">
				</form>
				<div>
					<button id="btnList">목록</button>
					<button id="btnUpdate">수정</button>
					<button id="btnDelete">삭제</button>
				</div>
			</div>
		</div>
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