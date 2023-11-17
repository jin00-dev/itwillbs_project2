<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<h1>userUpdate.jsp</h1>
	<script type="text/javascript">

	$(document).ready(function() {
		
		
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		
		// 비밀번호 정규식
		var pwRegex =  /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
// 		var pwRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	
	
		// id 중복체크 변수, 비밀번호와 비밀번호 확인이 같은지 체크 변수
		
		var pwCheck = false;
		
		$("#pwUpdate").on("click", function(){
			if($("#pw3").val==""){
				alert("현재 비밀번호를 입력해주세요"); 
				$("#pw3").focus();
				return false
			}
			if($("#pw").val==""){
				alert("변경비밀번호를 입력해주세요");
				$("#pw").focus();
				return false 
			}
			if($("#pw2").val==""){
				alert("변경비밀번호를 입력해주세요");
				$("#pw2").focus();
				return false
			}
			if ($("#pw").val() != $("#pw2").val()) {
				alert("변경비밀번호가 일치하지 않습니다.");
				$("#pw2").focus();
			}
				$.ajax({
					url : "/user/pwCheck",
					type : "POST",
					dataType : "json",
					data : $("#pwUpdateForm").serializeArray(),
					success: function(data){
						
						if(data==1){
							if(confirm("변경하시겠습니까?")){
								$("#pwUpdateForm").submit();
							}
							
						}else{
							alert("패스워드가 틀렸습니다.");
							return;
							
						}
					}
				})
			
				
			});
			
			
		// 비밀번호  처리 이벤트
		$("#pw").keyup(function() {
			pwCheck = false;
			var pw = $("#pw").val();
			var pw2 = $("#pw2").val();
			
			if (pwRegex.test(pw)) {
				pwCheck = true;
				$("#pwCheckDiv").removeClass("alert-danger");
				$("#pwCheckDiv").addClass("alert-success");
				$("#pwCheckDiv").text("적당한 비밀번호입니다.");
				return;
			}
			else if (pw.length < 8) {
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 8자 이상이어야 합니다.");
				return;
			}
			// 20자 초과 처리
			else if (pw.length > 20) {
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 20자 이내여야 합니다.");
				return;
			}
			else if (!pwRegex.test(pw)) { // 비밀번호 유효성 검사
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 영문자+숫자+특수문자 조합으로 8~20자리 사용해야합니다.");
// 				pw.focus();
				return ;
			}

});

		//비밀번호 확인 처리 이벤트
		$("#pw2").keyup(function() {
			pwCheck = false;
			var pw2 = $(this).val();
			var pw = $("#pw").val();

			
			if(pw == pw2) {
				
				$("#pw2CheckDiv, #pwCheckDiv").removeClass("alert-danger");
				$("#pw2CheckDiv, #pwCheckDiv").addClass("alert-success");
				$("#pw2CheckDiv, #pwCheckDiv").text("비밀번호가 일치합니다.");
				pwCheck = true;
			} else {
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
				$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			}

			

		});

		// 비밀번호 이벤트 끝





// 		$("#updatePassForm").submit(function() {
// 			var $thisForm = $(this);
// 			var pw = $thisForm.find('input[name=user_pw]').val();
// 			var pw2 = $thisForm.find('input[name=user_pw2]').val();
			
			

			// 비밀번호와 비밀번호 확인
// 			if (!pwCheck) {
// 				alert("비밀번호와 비밀번호 확인의 길이가 8~20이여야하고 같아야 합니다.");
// 				$("#pw").focus();
// 				// form 전송을 무시시킴->나중에 꼭 주석처리해야만 한다.
// 				return ;
// 			}
			
				
// 				alert("비밀번호 변경이 완료되었습니다.");
			
			
// 		});
		
	}); // $(function(){})의 끝

	</script>


<div class="container">
	<h2>비밀번호 변경 페이지</h2>
	<!-- action="" 인경우 자기자신의 경로 호출 -->
	<form action="/user/pwUpdate" id="pwUpdateForm" name="pwUpdateForm" method="post">
		<input type="hidden" id="user_id" name="user_id" value=${vo.user_id }>
	
		<div class="row mt-1"> 
			
			<div class="form-group">
				<label for="pw3">현재 비밀번호</label> <input id="pw3" name="user_pw"
					required="required" placeholder=" 현재 비밀번호 입력" class="form-control"
					type="password"></div>
				
			<div class="form-group">
				<label for="pw">새로운 비밀번호</label> <input id="pw" name="user_pw2"
					required="required" placeholder="변경할 비밀번호 입력" class="form-control"
					type="password">
				<div id="pwCheckDiv" class="alert alert-danger">비밀번호는 8자
					이상이어야합니다.</div>
			</div>
			<div class="form-group">
				<label for="pw2">비밀번호 확인</label> <input id="pw2" name="user_pw3"
					required="required" placeholder="변경할 비밀번호 입력 확인" class="form-control"
					type="password">
				<div id="pw2CheckDiv" class="alert alert-danger">비밀번호는 8자
					이상이어야합니다.</div> 
			</div>
			</div>
			
		<a type="button" class="btn btn-default pull-left" 
			href="../user/userInfo">취소</a> 
			 <button type="button" id="pwUpdate" name="pwUpdate" class="btn btn-primary" >비밀번호 변경</button>
</form>
</div>


<%@include file="../include/footer.jsp"%>