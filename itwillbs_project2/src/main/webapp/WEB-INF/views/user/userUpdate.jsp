<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
		
		<h2> 회원수정 페이지 </h2>
		
<!-- 		<fieldset> -->
<!-- 			<!-- action="" 인경우 자기자신의 경로 호출 -->
<!-- 			<form action="" method="post"> -->
<%-- 				아이디 : <input type="text" name="user_id" value="${vo.user_id }" readonly><br> --%>
<!-- 				비밀번호 : <input type="password" name="user_pw" ><br> -->
<!-- 				비밀번호 확인 : <input type="password" name="user_pw2" ><br> -->
<%-- 				이름 : <input type="text" name="user_name" value="${vo.user_name }"><br> --%>
<%-- 				핸드폰 : <input type="text" name="user_phone" value="${vo.user_phone }"><hr> --%>
				
<!-- 				<input type="submit" value=" 회 원 수 정 ">			 -->
<!-- 			</form>		 -->
<!-- 		</fieldset> -->

<div class="container mt-5">
	<div class="row">		
      <div class="card">
		<div class="card-body pt-3">
              <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

                <li class="nav-item" role="presentation">
                  <button class="nav-link" data-bs-toggle="tab" onclick= "location.href='/user/userMain';" aria-selected="true" role="tab">회원 정보 조회 및 수정</button>
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
         </div>
		
		  <!-- 회원정보 수정 -->
                <div class="tab-pane fade profile-edit pt-3" >

                  <form action="" method="post">
                  
                  	<div class="row mb-3">
                      <label for="user_id" class="col-md-4 col-lg-3 col-form-label">아이디 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_id" type="text" class="form-control" id="user_id" value="${vo.user_id }" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="user_name" class="col-md-4 col-lg-3 col-form-label">이름 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_name" type="text" class="form-control" id="user_name" value="${vo.user_name } ">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="user_phone" class="col-md-4 col-lg-3 col-form-label">휴대폰 번호 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_phone" type="text" class="form-control" id="user_phone" value="${vo.user_phone }">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="Job" class="col-md-4 col-lg-3 col-form-label">비밀번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_pw" type="text" class="form-control" id="user_pw" placeholder="비밀번호를 입력 해 주세요.">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">정보수정하기</button>
                    </div>
                  </form>
                </div>
                <!-- 회원정보 수정 -->
               </div>
            </div>
		</div>
		
<%@include file="../include/footer.jsp"%>