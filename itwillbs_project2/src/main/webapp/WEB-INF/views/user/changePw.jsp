<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
.abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>


<div class="row justify-content-center abx">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h4 class="card-title text-center pb-0 fs-4">비밀번호 변경 </h4>
                  </div>

                  <form class="row g-3 needs-validation" action="/user/changePassword" method="post">
	                  <!-- 사용자의 이름과 아이디는 hidden으로 전송 -->
				        <input type="hidden" name="user_name" value="${user_name}">
				        <input type="hidden" name="user_id" value="${user_id}">

                    <div class="col-12">
                      <label for="yourUsername" class="form-label">비밀번호</label>
                      <div class="input-group has-validation">
                        <input type="password" id="new_password" name="new_password"   class="form-control" required="" placeholder="비밀번호를 입력해주세요.">
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">비밀번호 확인</label>
                      <input type="password" id="confirm_password" name="confirm_password" class="form-control" required=""  placeholder="비밀번호를 한 번 더 입력해주세요.">
                      <div class="invalid-feedback">Please enter your password!</div>
                    </div>

                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">비밀번호 변경</button>
                    </div>
                  </form>

                </div>
              </div>
            </div>
          </div>

    
<!-- footer -->
<%-- <%@include file="/WEB-INF/views/include/footer.jsp"%> --%>
