<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
.abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>

<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>
 
 
<div class="container mt-5 abx">
	<div class="row">
		<div class="col-md-3">
			<div class="list-group mb-4 h-100">
				<h5 class="list-group-item list-group-item-action active"
					aria-current="true">고객지원</h5>
				<a href="/board/boardListAll"
					class="list-group-item list-group-item-action">공지사항</a> 
				<a href="/board/faqListAll" class="list-group-item list-group-item-action">자주 묻는 질문</a> 
				<a href="/qna/qnaCreate" class="list-group-item list-group-item-action">1:1문의</a>
			</div>
		</div>

		<div class="col-md-9">
			<h2 class="mb-4">자주 묻는 질문</h2>
			<c:if test="${uer_type eq 2}">
			<a href="/board/insert" class="btn btn-primary mb-3">글쓰기</a>
			</c:if>

			<!-- <c:if
				test="${sessionScope.user_id != null && sessionScope.user_id.equals('admin')}">
				<a href="/board/insert" class="btn btn-primary mb-3">글쓰기</a>
			</c:if> -->
<div class="card">
            <div class="card-body">

              <div class="accordion accordion-flush" id="faq-group-1">

				<c:forEach var="faq" items="${faqList}" varStatus="status">
				<c:if test="${faq.enf_category == 2}">
                <div class="accordion-item">
                  <h2 class="accordion-header">
                    <button class="accordion-button collapsed" data-bs-target="#faqsOne-${faq.enf_faq_num }" type="button" data-bs-toggle="collapse" aria-expanded="false">
                      ${faq.enf_title}
                    </button>
                  </h2>
                  <div id="faqsOne-${faq.enf_faq_num }" class="accordion-collapse collapse" data-bs-parent="#faq-group-1" style="">
                    <div class="accordion-body">
                      ${faq.enf_content}
                    </div>
                  </div>
                </div>
				</c:if>
				</c:forEach>
              </div>

            </div>
          </div>
	</div>
</div>
</div>
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
