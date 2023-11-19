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
                    <h4 class="card-title text-center pb-0 fs-4">아이디 찾기 결과 </h4>
                  </div>

                  <form class="row g-3 needs-validation" action="" method="post">

                    <div class="col-12">
                      <h5 class="form-label text-center">회원님의 아이디는 <span>${userId}</span> 입니다.</h5>
                      
                      <div class="input-group has-validation">
                      </div>
                    </div>


                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="button" onclick=" location.href='/user/login';">확인</button>
                  </form>

                </div>
              </div>
            </div>
          </div>


<!-- footer -->
<%-- <%@include file="/WEB-INF/views/include/footer.jsp"%> --%>
