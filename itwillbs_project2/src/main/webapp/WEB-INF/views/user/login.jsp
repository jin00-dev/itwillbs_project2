<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<style>
.row{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>
	
	<div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">로그인</h5>
                    <p class="text-center small">이메일과 비밀번호를 입력해주세요</p>
                  </div>

                  <form class="row g-3 needs-validation" novalidate="" action="" method="post">

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">이메일</label>
                      <div class="input-group has-validation">
                        <input type="text"  name="user_id" id="user_id"  class="form-control" required="" placeholder="이메일 아이디를 입력해주세요.">
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호</label>
                      <input type="password" name="user_pw" id="user_pw" class="form-control" required=""  placeholder="비밀번호를 입력해주세요.">
                      <div class="invalid-feedback">Please enter your password!</div>
                    </div>
	
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">로그인</button>
                    </div>
                    
					<!-- 카카오 로그인 -->
					<a class="p-2"
						href="https://kauth.kakao.com/oauth/authorize?
						client_id=b7aecba0d6b45f45c2c5b8d78a55f222&
						redirect_uri=http://localhost:8088/user/kakaoLogin&response_type=code&prompt=select_account">
						<img src="/resources/images/kakao_login_btn.png"
						style="height: 60px">
					</a>

					<div class="col-12">
                      <p class="small mb-0">회원가입을 원한다면? <a href="/user/join">회원가입</a></p>
                      <p class="small mb-0">아이디나 비밀번호를 잊었습니까? <a href="/user/findId">아이디,비밀번호 찾기</a></p>
                    </div>
                  </form>

                </div>
              </div>


            </div>
          </div>
	
	
<%@include file="../include/footer.jsp"%>