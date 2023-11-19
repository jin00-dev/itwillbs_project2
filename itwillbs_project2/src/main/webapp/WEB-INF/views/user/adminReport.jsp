<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
 .text {
  color: inherit;
  text-decoration: none;
  }

</style>

<%@include file="../include/header.jsp"%>

<hr>
<div class="container mt-5">
	<div class="row">
		<h5 class="card-title">관리자 페이지</h5>



		<!-- Default Tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link " id="home-tab" data-bs-toggle="tab" type="button" role="tab" onclick="location.href = '/user/adminMain'">회원관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="profile-tab" data-bs-toggle="tab" type="button" role="tab" onclick="location.href = '/user/reportList'">신고관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" onclick="location.href = '/qna/adminQnaListPage';">1:1 문의 관리</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1" onclick="location.href = '/class/admnOrderBoard';">회원 예약관리</button>
			</li>
		</ul>


		<div class="card-body">

			<!-- Default Table -->
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th scope="col">신고번호</th>
						<th scope="col">신고내용</th>
						<th scope="col">신고날짜</th>
						<th scope="col">처리날짜</th>
						<th scope="col">처리상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${reportList }" varStatus="status">
						<tr>
							<th>${vo.report_num }</th>
							<td><a class="text" data-bs-toggle="modal" data-bs-target="#basicModal_${vo.report_num }">${vo.report_content }</a></td>
							<td>${vo.report_regdate }</td>
							<td>${vo.report_updatedate }</td>
							<c:choose>
								<c:when test="${vo.report_state eq 0 }">
									<td>처리대기</td>
								</c:when>
								<c:when test="${vo.report_state eq 1 }">
									<td>처리완료</td>
								</c:when>
							</c:choose>
						</tr>
				</tbody>
				<!-- Start Basic Modal -->
				<div class="modal fade" id="basicModal_${vo.report_num }" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">신고 처리</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>신고번호 : ${vo.report_num }</p>
								<br>
								<p>신고 날짜 : ${vo.report_updatedate }</p>
								<br>
								<p>신고내용 : ${vo.report_content }</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-primary">차단</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End Basic Modal-->
				</c:forEach>
			</table>


		</div>

		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:if test="${pageVO.preview }">
					<li class="page-item"><a class="page-link" href="/user/reportList?page=${pageVO.startPage - 1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>

				<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
					<li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item"><a class="page-link" href="/user/reportList?page=${i }">${i }</a></li>
				</c:forEach>

				<c:if test="${pageVO.next }">
					<li class="page-item"><a class="page-link" aria-label="Next" href="/user/reportList?page=${pageVO.endPage + 1 }"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>
			</ul>

		</nav>
	</div>
</div>
<%@include file="../include/footer.jsp"%>