<%@ page pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		//아이디 정규식
		var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
		// 비밀번호 정규식
		var pwRegex =  /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
// 		var pwRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		// 이름 정규식
		var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		// 이메일 검사 정규식
		var mailJ =  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		// id 중복체크 변수, 비밀번호와 비밀번호 확인이 같은지 체크 변수
		
		var idCheck = false;
		var pwCheck = false;
		var phoneCheck = false;
		
	
		
		
		// 아이디  체크 이벤트 
		$("#id").keyup(function() {

			idCheck = false;
			var id = $("#id").val();
			// 공백 문자 처리
			id = $.trim(id);
			$("#id").val(id);

			// 4자 미만 처리
			if (id.length < 4) {
				$("#idCheckDiv").removeClass("alert-success");
				$("#idCheckDiv").addClass("alert-danger");
				$("#idCheckDiv").text("아이디는 4자 이상 영숫자여야 합니다.");
				idCheck = false;
				return;
			}

			// 20자 초과
			if (id.length > 30) {
				$("#idCheckDiv").removeClass("alert-success");
				$("#idCheckDiv").addClass("alert-danger");
				$("#idCheckDiv").text("아이디는 30자 이내 영숫자여야 합니다.");
				idCheck = false;
				return;
			}
			// user/idCheck
			
			//아이디 유효성 검사
		      if(!mailJ.test($("#id").val())){
		        //alert("이메일형식에 맞게 입력해주세요")
		        $("#idCheckDiv").val("");
		        $("#idCheckDiv").text("아이디를 이메일형식에 맞게 입력해주세요");
		        idCheck=false;
		        //$("#idCheckDiv").focus();
		        return ;
		      }else{
// 				$("#idCheckDiv").load("/user/idCheck?id=" + id, function(result) {
// 					$("#idCheckDiv").removeClass("alert-success alert-danger");
// 					if (result == 0) {
// 						$("#idCheckDiv").addClass("alert-success");
// 						idCheck = true;
// 					} else {
// 						$("#idCheckDiv").addClass("alert-danger");
// 						idCheck = false;
// 					}
// 				});
				
				$.ajax({    type : 'post',           // 타입 (get, post, put 등등)    
					url : '/user/idCheck?id='+id, 
					success : function(result) { // 결과 성공 콜백함수        
						console.log(result);   
						$("#idCheckDiv").removeClass("alert-success alert-danger");
	 					if (result == 0) {
	 						$("#idCheckDiv").addClass("alert-success");
	 						 $("#idCheckDiv").text("사용할 수 있는 아이디 입니다");
	 						idCheck = true;
	 					} else {
	 						$("#idCheckDiv").addClass("alert-danger");
	 						 $("#idCheckDiv").text("사용할 수 없는 아이디 입니다");
	 						idCheck = false;
	 					}
					},error : function(request, status, error) { 
						// 결과 에러 콜백함수        console.log(error)    
						}
					})
		      }
			
			
			
			

		}); //$("#user_id").keyup 이벤트끝

		
		
		
		
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
			 
			
			
			
// 			else if (pw == pw2) {// 4~20 사이 pw2와 같은지 체크
			 
			
// 				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
// 				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
// 				$("#pwCheckDiv, #pw2CheckDiv").text("적당한 비밀번호입니다.");
// 				pwCheck = true;
// 			} else {
// 				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
// 				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
// 				$("#pwCheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
// 				if (pw2.length < 8)
// 					$("#pw2CheckDiv").text("비밀번호확인은 8자 이상이여야합니다.");
// 				else if (pw2.length > 20)
// 					$("#pw2CheckDiv").text("비밀번호 확인은 20자 이내여야합니다.");
// 				else
// 					$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
// 			}
			
			
			

			

		});

		//비밀번호 확인 처리 이벤트
		$("#pw2").keyup(function() {
			pwCheck = false;
			var pw2 = $(this).val();
			var pw = $("#pw").val();

			if (pw2.length < 8) {
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호는 8자 이상이어야 합니다.");
				return;
			}

			// 20자 초과 처리
			else if(pw2.length > 20) {
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호는 20자 이내여야 합니다.");
				return;
			} 
			 // 4~20 사이 pw2와 같은지 체크
			
			else if(pw == pw2) {
				
				$("#pw2CheckDiv, #pwCheckDiv").removeClass("alert-danger");
				$("#pw2CheckDiv, #pwCheckDiv").addClass("alert-success");
				$("#pw2CheckDiv, #pwCheckDiv").text("적당한 비밀번호입니다.");
				pwCheck = true;
			} else {
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
				$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			}

			

		});

		// 비밀번호 이벤트 끝

		
		
		// 핸드폰 번호 유효성 검사
		$("#phone").keyup(function() {
			phoneCheck = false;
			var phone = $(this).val();
			// 공백 문자 처리
			phone = $.trim(phone);
			$("#phone").val(phone);
		
			
			// 11자 미만 처리
			if (phone.length < 11) {
				$("#phoneCheckDiv").removeClass("alert-success");
				$("#phoneCheckDiv").addClass("alert-danger");
				$("#phoneCheckDiv").text("핸드폰번호는 12자 이상 이여야 합니다.");
				return;
			}

			// 14자 초과
			if (phone.length > 14) {
				$("#phoneCheckDiv").removeClass("alert-success");
				$("#phoneCheckDiv").addClass("alert-danger");
				$("#phoneCheckDiv").text("핸드폰번호는 13자 이내 숫자여야 합니다.");
				return;
			}
			
		      if(!phoneJ.test($("#phone").val())){
		        
		        $("#phoneCheckDiv").val("");
		        $("#phoneCheckDiv").text("핸드폰 번호 양식에 맞게 적어주세요");
		        //$("#phoneCheckDiv").focus();
		        
		        return ;
		      }else{
		    	  
		    	  
		    	  
		    	  $.ajax({    
		    		  	type : 'post',           // 타입 (get, post, put 등등)    
						url : '/user/phoneCheck?phone='+phone, 
						success : function(result) { // 결과 성공 콜백함수        
							console.log(result);   
							$("#phoneCheckDiv").removeClass("alert-success alert-danger");
		 					if (result == 0) {
		 						$("#phoneCheckDiv").addClass("alert-success");
		 						 $("#phoneCheckDiv").text("사용할 수 있는 번호입니다");
		 						phoneCheck = true;
		 					} else {
		 						$("#phoneCheckDiv").addClass("alert-danger");
		 						 $("#phoneCheckDiv").text("사용할 수 없는 번호 입니다");
		 						phoneCheck = false;
		 					}
						},error : function(request, status, error) { 
							// 결과 에러 콜백함수       
							console.log(error)    
							}
						})
			      }
				
				
			}); //$("#phone).keyup 이벤트끝
			
			
			
		// 회원가입
		$("#writeForm").submit(function() {
			var name = $('#name').val();
			
			// 핸드폰 중복체크 -
			if(!phoneCheck){
				alert("핸드폰 번호 양식에 맞게 기입하세요");
				$("#phone").focus();
				
				return ;
			}
				
			// 아이디 중복체크 - 사용 가능한 아이디 인지 확인
			if (!idCheck) {
				alert("중복이 되지 않는 적당한 형식의 아이디를 사용하셔야만 합니다.");
				console.log(idCheck+"@@@@@@@@@");
				$("#id").focus();
				//form 전송을 무시시킴
				return ;
			}

			// 비밀번호와 비밀번호 확인
			if (!pwCheck) {
				alert("비밀번호와 비밀번호 확인의 길이가 8~20이여야하고 같아야 합니다.");
				$("#pw").focus();
				// form 전송을 무시시킴->나중에 꼭 주석처리해야만 한다.
				return ;
			}
			
				
				alert(name+"회원님 가입을 환영합니다.");
		});
			
			//인증코드 발송 버튼 클릭
			$("#checkEmailButton").click(function(){
				const email = $("#id").val(); // 회원가입시 입력한 이메일 주소값 가져오기 
				console.log("회원 이메일 확인 : " + email);// console에서 확인 
				const checkInput = $("#checkEmail"); // 인증번호 입력하는 곳 
				
				$.ajax({
					type : "get",
					url : "/user/mailCheck?email="+email,
					success : function(data){
						console.log("data : " + data);
						checkInput.attr("disabled",false);
						code = data; 
						alert("인증번호가 전송되었습니다");
					},
					error : function(){
						alert("인증번호 전송에 실패했습니다.");
					}
				});// mail ajax
			});// checkEmailButton. click 
			
			$("#checkEmail").blur(function(){
				var inputCode = $(this).val();
				var resultMsg = $("#mail_check_msg");
				
				if(inputCode == code){
					resultMsg.html("인증번호가 일치합니다.");
					resultMsg.css("color","green");
					$("#checkEmailButton").attr("disabled",true);
					$("#email").attr("readonly",true);
				}else{
					resultMsg.html("인증번호가 일치하지 않습니다. 다시 입력해 주세요.");
					resultMag.css("color","red");
				}
				
			});//checkEmail.blur
		
	}); // $(function(){})의 끝
	
</script>

<div class="container">
	<h2>회원가입 페이지</h2>
	<!-- action="" 인경우 자기자신의 경로 호출 -->
	<form action="" id="writeForm" method="post">
		<div class="form-group">
			<label for="id">아이디 </label> 
			<input id="id" name="user_id" required="required" class="form-control" type="text">
			<div class="alert alert-danger" id="idCheckDiv">아이디는 4자 이상 입력하셔야합니다.</div>
		</div>
		
		<span class="id_input_box_warn"></span>
		<div class="form-group">
			<button type="button" id="checkEmailButton" class="btn btn-primary">인증코드 발송</button>
		</div>

		<div class="row mt-1">
			<div class="col bi bi-exclamation-square-fill deepblue">인증번호
				발송은 서버 상황에 따라 1분정도 걸릴 수 있어요</div>
		</div>

		<div class="row mt-1">
			<div class="col-lg-5">
				<input class="form-control" id="checkEmail" type="text"
					placeholder="인증번호 6자리를 입력해주세요." aria-label="default input example"
					disabled="disabled">
				<div>
					<span id="mail_check_msg"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="pw">비밀번호</label> 
				<input id="pw" name="user_pw" required="required"  placeholder="비밀번호 입력"
					class="form-control" type="password">
				<div id="pwCheckDiv" class="alert alert-danger">비밀번호는 8자 이상이어야합니다.</div>
			</div>
			<div class="form-group">
				<label for="pw2">비밀번호 확인</label> 
				<input id="pw2" name="user_pw2" required="required"  placeholder="비밀번호 입력"
					class="form-control" type="password">
				<div id="pw2CheckDiv" class="alert alert-danger">비밀번호는 8자 이상이어야합니다.</div>
			</div>
			<div class="form-group">
				<label for="name">이름</label> 
				<input id="name" name="user_name"
					class="form-control" pattern="[가-힣]{2,10}" placeholder="이름 입력"
					required="required">
			</div>
			<div class="form-group">
				<label for="tel">연락처</label> <input id="phone" name="user_phone" placeholder="000-0000-0000" 
				 class="form-control"  required="required">
				<div class="alert alert-danger" id="phoneCheckDiv">휴대폰 번호를 양식에 맞게 적어주세요.</div>
			</div>
		</div>



		<div class="row mt-1">
			<div class="col-lg-5">
				<a type="button" class="btn btn-primary infoModBtn pull-right"
					href="../user/userMain">취소</a>
				<button type="submit" class="btn btn-primary infoModBtn pull-right"
					id="joinButton">회원가입</button>
			</div>
		</div>

	</form>
</div>



<%@include file="../include/footer.jsp"%>