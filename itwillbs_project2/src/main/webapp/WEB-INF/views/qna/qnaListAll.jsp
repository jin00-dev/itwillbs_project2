<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%> 

 <div class="container mt-5">
	<div class="row">
          <div class="card">
              <!-- 회원정보 확인 -->
            <div class="card-body pt-3">
              <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">
				
                <li class="nav-item" role="presentation">
                  <button class="nav-link " data-bs-toggle="tab" onclick= "location.href='/user/userMain';" aria-selected="true" role="tab">회원 정보 조회 및 수정</button>
                </li>
                <li class="nav-item" role="presentation">
		           <button class="nav-link" data-bs-toggle="tab" onclick= "location.href='/class/paymentList';" aria-selected="false" role="tab" tabindex="-1">클래스 예약 관리</button>
		        </li>
				<c:if test="${user_type eq 1 }">
					<li class="nav-item" role="presentation">
		                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">사업자 클래스 관리</button>
		            </li>
				</c:if>
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" data-bs-toggle="tab" onclick= "location.href='/qna/qnaListAll';" aria-selected="false" role="tab" tabindex="-1">1:1문의</button>
                </li>
              </ul>

            <!-- 1대1 문의사항 리스트 섹션 -->
            <a href="/qna/qnaCreate" class="btn btn-primary mb-3">글쓰기</a>
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
                    <!-- 문의사항 목록 -->
                    <c:forEach var="qna" items="${qnaListAll}" varStatus="status">
                        <tr>
                            <td>${fn:length(qnaListAll) - status.index}</td> <!-- 역순 번호 계산 -->
                            <td><a href="/qna/qnaRead?qna_num=${qna.qna_num}">${qna.qna_title}</a></td>
                            <td><fmt:formatDate value="${qna.qna_regdate}" pattern="yyyy-MM-dd"/></td>
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
            
            <nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:if test="${pageVO.prev }">	
                  <li class="page-item">
                    <a class="page-link" href="/qna/qnaListAll?page=${pageVO.startPage - 1 }" aria-label="Previous">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  </c:if>
                  
                <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
                  <li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item">
                  <a class="page-link" href="/qna/qnaListAll?page=${i }">${i }</a></li>
				</c:forEach>
				
				<c:if test="${pageVO.next }">
                  <li class="page-item">
                    <a class="page-link" aria-label="Next" href= "/qna/qnaListAll?page=${pageVO.endPage + 1 }">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  </c:if>
                </ul>		
	</nav>
            
            
            
           
        </div>
    </div>
</div>
</div>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%> 

<!-- 부트스트랩 JS 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
