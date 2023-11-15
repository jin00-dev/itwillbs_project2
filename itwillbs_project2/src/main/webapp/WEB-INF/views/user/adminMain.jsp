<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<hr>

<div class="card-body">
              <h5 class="card-title">관리자 페이지</h5>

              <!-- Default Tabs -->
              <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" id="home-tab" data-bs-toggle="tab" type="button" role="tab" aria-controls="home" aria-selected="true" href = "/user/adminMain">회원관리</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">관리페이지1</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false" tabindex="-1">관리페이지2</button>
                </li>
              </ul>
            

<div class="card-body">

	<!-- Default Table -->
	<table class="table">
		<thead>
			<tr>
				<th scope="col">회원번호</th>
				<th scope="col">이름</th>
				<th scope="col">휴대폰 번호</th>
				<th scope="col">회원가입일</th>
				<th scope="col">회원 등급</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="vo" items="${userList }">
			<tr>
				<th>${vo.user_num }</th>
				<td>${vo.user_name }</td>
				<td>${vo.user_phone }</td>
				<td>${vo.user_regdate }</td>
				<td>${vo.user_type }</td>
			</tr>
		</tbody>
		</c:forEach>
	</table>
	<!-- End Default Table Example -->
</div>

	<div class="card-body">
			<ul class="pagination">
				<c:if test="${pageVO.prev }">	
                  <li class="page-item">
                    <a class="page-link" href="/user/adminMain?page=${pageVO.startPage - 1 }" aria-label="Previous">
                      <span aria-hidden="true">«</span>
                    </a>
                  </li>
                  </c:if>
                  
                <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
                  <li ${pageVO.cri.page == i? 'class="active"':'' } class="page-item">
                  <a class="page-link" href="/user/adminMain?page=${i }">${i }</a></li>
				</c:forEach>
				
				<c:if test="${pageVO.next }">
                  <li class="page-item">
                    <a class="page-link" aria-label="Next" href= "/user/adminMain?page=${pageVO.endPage + 1 }">
                      <span aria-hidden="true">»</span>
                    </a>
                  </li>
                  </c:if>
                </ul>		
		
	</div>
</div>
<%@include file="../include/footer.jsp"%>
