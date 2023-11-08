	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../include/header.jsp"%>
<form _ngcontent-serverapp-c90="" novalidate=""
	class="ng-untouched ng-pristine ng-invalid">
	<div _ngcontent-serverapp-c90="" class="mb-3">
		<label _ngcontent-serverapp-c90="" for="emailInput"
			class="text-gray-600 small">Email address</label><input
			_ngcontent-serverapp-c90="" id="emailInput" data-cy="emailInput"
			type="email" aria-describedby="emailHelp" formcontrolname="email"
			class="form-control form-control-solid ng-untouched ng-pristine ng-invalid">
		<div _ngcontent-serverapp-c90="" class="invalid-feedback">Email
			required.</div>
		<!---->
		<!---->
	</div>
	<div _ngcontent-serverapp-c90="" class="mb-3">
		<label _ngcontent-serverapp-c90="" for="passwordInput"
			class="small text-gray-600">Password</label><input
			_ngcontent-serverapp-c90="" id="passwordInput"
			data-cy="passwordInput" type="password" formcontrolname="password"
			class="form-control form-control-solid ng-untouched ng-pristine ng-invalid">
		<div _ngcontent-serverapp-c90="" class="invalid-feedback">Password
			required.</div>
		<!---->
		<!---->
	</div>
	<div _ngcontent-serverapp-c90="" class="mb-3">
		<a _ngcontent-serverapp-c90=""
			routerlink="/auth/password-reset-request"
			href="/auth/password-reset-request">Forgot your password?</a>
	</div>
	<div _ngcontent-serverapp-c90=""
		class="mb-3 d-flex align-items-center justify-content-between">
		<div _ngcontent-serverapp-c90=""
			class="form-check form-check-solid custom-checkbox">
			<input _ngcontent-serverapp-c90="" id="checkInput"
				data-cy="checkInput" type="checkbox" formcontrolname="checkbox"
				class="form-check-input small ng-untouched ng-pristine ng-valid"><label
				_ngcontent-serverapp-c90="" for="checkInput"
				class="form-check-label">Remember password</label>
		</div>
		<button _ngcontent-serverapp-c90="" data-cy="로그인"
			type="submit" class="btn btn-primary" disabled="">Login</button>
			<button _ngcontent-serverapp-c90="" data-cy="로그인"
			type="button" class="btn btn-primary" disabled="">회원가입</button>
	</div>
</form>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$("#find_id_btn").click(function(){
		location.href='../user/findIdForm';
	})
})
</script>	
<body>
		<h1>/user/userLogin.jsp</h1>
		
		<h2>로그인 페이지 </h2>
		
		<fieldset>
			<form action="" method="post" >
				아이디 : <input type="text" name="user_id"><br>
				비밀번호 : <input type="password" name="user_pw"><hr>
			    <input type="submit" value="로그인">
			    <input type="button" value="회원가입" 
			           onclick=" location.href='/user/insert'; ">
			</form>		
		</fieldset>
		

		
		
		
		<a href="/user/findIdForm.jsp">아이디 찾기</a>
		

</body>
</html>

<!-- footer -->
<%@include file="../include/footer.jsp"%>