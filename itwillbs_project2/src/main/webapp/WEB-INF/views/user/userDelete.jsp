<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>

<style>
.container-xxl, .container-xl, .container-lg, .container-md, .container-sm, .container {
    max-width: 800px;
}
  /* footer 고정  */
  .abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>

		
<div class="container abx">
	<div class="card mb-3">
	<div class="card-body">
	  <div class="pt-4 pb-2">
      <h5 class="card-title text-center pb-0 fs-4">회원탈퇴</h5>
      <p class="text-center" style="color : red;'"><strong>주의하세요!</strong></p>
      <p class="text-center small">탈퇴시 한번 삭제된 정보는 복구가 불가능합니다.</p>
      <p class="text-center"><strong>회원탈퇴 안내사항</strong></p>
      <p class="text-center small">회원 탈퇴 후 3개월 동안은 회원가입이 불가능합니다.
      			<br> 탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가능 하오니 신중하게 선택하시기 바랍니다.
      			<br> 탈퇴와 재가입을 통해 아이디를 교체하면서 선량한 이용자들에게<br> 피해를 끼치는 행위를 방지하기 위한 조치이니 양해 부탁드립니다.
      			<br> 회원 정보 변경은 '회원정보 수정'을 이용해 주세요.
      			<br> 탈퇴를 원하신다면 아래 정보를 확인하시고 비밀번호를 입력해 주세요</p>
      </div>
	
	<form action="/user/delete" method="post">
		<div class="row mt-1">
			<div class="form-group ">
			<label for="id">아이디</label>
				<input id="id" name="user_id" required="required" class="form-control" type="text" value="${user_id }" readonly>
			</div>
		</div>
		<div class="row mt-1">
			<div class="form-group ">
			<label for="name">이름</label>
				<input id="name" name="user_name" required="required" class="form-control" type="text" value="${user_name }" readonly>
			</div>
		</div>
		<div class="row mt-1">
			<div class="form-group">
				<label for="pw">비밀번호</label> 
				<input id="pw" name="user_pw" required="required"  placeholder="비밀번호 입력"
					class="form-control" type="password">
			</div>
		</div>
		<div class="row mt-1">
			<div class="col-lg-5">
				<button type="submit" class="btn btn-secondary infoModBtn pull-right" id="deleteButton">회원탈퇴</button>
				<a type="button" class="btn btn-primary infoModBtn pull-right" href="../user/update">취소</a>
			</div>
		</div>
	</form>
	</div>
	</div>
</div>	
		
<%@include file="../include/footer.jsp"%>