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
		
	}); // $(function(){})의 끝

	</script>

<div class="row justify-content-center abx">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h4 class="card-title text-center pb-0 fs-4">비밀번호 변경 </h4>
                  </div>

                  <form class="row g-3 needs-validation" action="/user/pwUpdate" method="post">
                  <input type="hidden" id="user_id" name="user_id" value=${user_id }>
	                  <!-- 사용자의 이름과 아이디는 hidden으로 전송 -->

                    <div class="col-12">
                      <label for="pw" class="form-label">비밀번호</label>
                      <div class="input-group has-validation">
                        <input type="password" id="pw" name="user_pw2" class="form-control" required="" placeholder="변경 할 비밀번호를 입력해주세요.">
                      </div>
                    </div>

                    <div class="col-12">
                      <label for="pw2" class="form-label">비밀번호 확인</label>
                      <input type="password" id="pw2" name="user_pw3" class="form-control" required=""  placeholder="비밀번호를 한 번 더 입력해주세요.">
                     </div>
                    <div class="col-12 text-center">
                      <button class="btn btn-primary" type="submit" id="pwUpdate" name="pwUpdate">비밀번호 변경</button>
                      <a type="button" class="btn btn-secondary" href="../">취소</a> 
                    </div>
                  </form>

                </div>
              </div>
            </div>
          </div>

    
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>
