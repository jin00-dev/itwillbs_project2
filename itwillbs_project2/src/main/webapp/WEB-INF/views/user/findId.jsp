<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>


<div class="row justify-content-center">
	<div
		class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

		<div class="d-flex justify-content-center py-4"></div>
		<!-- End Logo -->

		<div class="card mb-3">

			<div class="card-body">

				<div class="pt-4 pb-2">
					<h5 class="card-title text-center pb-0 fs-4">아이디 찾기</h5>
				</div>

				<form class="row g-3 needs-validation" action="/user/findId" method="post">
					<div class="col-12">
						<label for="yourUsername" class="form-label">이름</label>
						<div class="input-group has-validation">
							<input type="text" name="user_name" id="name" class="form-control" required="" placeholder="이름을 입력해주세요.">
						</div>
					</div>

					<div class="col-12">
						<label for="yourPassword" class="form-label">휴대폰 번호</label> 
						<input type="text" name="user_phone" id="phone" class="form-control" required="" placeholder="-을 뺀 휴대폰번호를 입력해주세요.">
					</div>

					<div class="col-12">
						<button class="btn btn-primary w-100" type="submit">아이디 찾기</button>
					</div>
					<div class="col-12"></div>
				</form>
			</div>
			<div class="card-body">
				<hr>
				<div class="pt-4 pb-2">
					<h5 class="card-title text-center pb-0 fs-4">비밀번호 찾기</h5>
				</div>

				<form class="row g-3 needs-validation" action="/user/findPassword" method="post">

					<div class="col-12">
						<label for="yourUsername" class="form-label">이름</label>
						<div class="input-group has-validation">
							<input type="text" name="user_name" id="name" class="form-control" required="" placeholder="이름을 입력해주세요.">
						</div>
					</div>

					<div class="col-12">
						<label for="yourPassword" class="form-label">아이디</label> 
						<input type="text" name="user_id" id="user_id" class="form-control" required="" placeholder="이메일 아이디를 입력해주세요.">
					</div>

					<div class="col-12">
						<button class="btn btn-primary w-100" type="submit">비밀번호 찾기</button>
					</div>
					<div class="col-12"></div>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>