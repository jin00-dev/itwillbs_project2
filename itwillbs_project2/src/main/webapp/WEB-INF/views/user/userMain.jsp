<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/header.jsp"%>

    <h2>${user_id }님의 마이페이지 입니다. </h2>
    
    <!-- 로그인 정보가 없으면 로그인 페이지로 이동 -->
    <c:if test="${empty user_id}">
       <c:redirect url="/user/login" />
    </c:if>
    
    <!-- <input type="button" value="로그아웃" onclick=" location.href='/user/logout'; ">
    <hr> 상단에 로그아웃 버튼 있음 -->
   
   <div class="col-xl-8">
          <div class="card">
              <!-- 회원정보 확인 -->
            <div class="card-body pt-3">
              <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

                <li class="nav-item" role="presentation">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview" aria-selected="true" role="tab">회원 정보 조회</button>
                </li>

                <li class="nav-item" role="presentation">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit" aria-selected="false" role="tab" tabindex="-1">회원 정보 수정</button>
                </li>
                <li class="nav-item" role="presentation">
		           <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">클래스 예약 관리</button>
		        </li>
				<c:if test="${user_type eq 1 }">
					<li class="nav-item" role="presentation">
		                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">사업자 클래스 관리</button>
		            </li>
				</c:if>
              </ul>
              
              <div class="tab-content pt-2">

                <div class="tab-pane fade profile-overview active show" id="profile-overview" role="tabpanel">

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">이름 : </div>
                    <div class="col-lg-9 col-md-8">${vo.user_name }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">아이디 : </div>
                    <div class="col-lg-9 col-md-8">${vo.user_id }</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">휴대폰 번호 : </div>
                    <div class="col-lg-9 col-md-8">${vo.user_phone }</div>
                  </div>

                </div>
                  <!-- 회원정보 조회 끝 -->
                
                  <!-- 회원정보 수정 -->
                <div class="tab-pane fade profile-edit pt-3" id="profile-edit" role="tabpanel">

                  <form>

                    <div class="row mb-3">
                      <label for="user_name" class="col-md-4 col-lg-3 col-form-label">이름 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_name" type="text" class="form-control" id="user_name" value="${vo.user_name }">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="user_id" class="col-md-4 col-lg-3 col-form-label">아이디 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_id" type="text" class="form-control" id="user_id" value="${vo.user_id }">
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

                  <!-- Change Password Form -->
                <div class="tab-pane fade pt-3" id="profile-change-password" role="tabpanel">
                  <form>

                    <div class="row mb-3">
                      <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="password" type="password" class="form-control" id="currentPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="newpassword" type="password" class="form-control" id="newPassword">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">Change Password</button>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
   
    
    
<!--     <h3><a href="/user/info">회원정보 조회</a></h3> -->
   
<!--     <hr><hr> -->
    
    <h3><a href="/user/update">회원정보 수정</a></h3>
    <hr><hr>
    
    <h3><a href="/user/delete">회원정보 삭제</a></h3>
                                  
    <%-- <c:if test="${!empty id && id eq 'admin'}"> --%>
    <c:if test="${!empty id && id.equals('admin')}">
       <!-- 관리자(admin)일때 확인가능한 메뉴 -->    
       <hr><hr>
       <h3><a href="/user/list">회원정보 목록</a></h3>
    </c:if>
<%@include file="../include/footer.jsp"%>    
    
