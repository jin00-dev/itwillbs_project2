<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../include/header.jsp"%>
<style>
  /* footer 고정  */
  .abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}	
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<h1>userUpdate.jsp</h1>
	<script type="text/javascript">

	$(document).ready(function() {
		
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		var phoneCheck = false;
		
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


// 회원 정보 수정 
// 		$("#updateForm").submit(function() {
// 			var name = $('#name').val();
// 			// 이름 정규식
// 			var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
			
// 			// 이름 유효성 검사
// 			if($("#name").val() == null || $("#name").val() == ""){
// 				alert("닉네임을 입력해주세요");
// 				("#name").focus();
				
// 				return false;
// 				}
			
			
// 			// 핸드폰 중복체크 -
// 			if(!phoneCheck){
// 				alert("핸드폰 번호 양식에 맞게 기입하세요");
// 				$("#phone").focus();
				
// 				return false;
// 			}
			
	}); // $(function(){})의 끝

		  let openWin;

	        function openChild() {
	            // window.name = "부모창 이름"; 
	            window.name = "parentForm";
	            
	            // window.open("open할 window", "자식창 이름", "팝업창 옵션");
	            openWin = window.open("child", "childForm", "width=570, height=350, resizable = no, scrollbars = no");    
	        }

	        function setChildText(){
	            openWin.document.getElementById("cInput").value = document.getElementById("pInput").value;
	            // 전달하고자 하는 값
	        }
	
	</script>
    <!-- 로그인 정보가 없으면 로그인 페이지로 이동 -->
    <c:if test="${empty user_id}">
       <c:redirect url="/user/login" />
    </c:if>
    
    <!-- 회원수정 완료시 팝업에 비밀번호입력 -->
    <c:if test="${param.msg == '0' }">
	<script>
	window.onload = function() {
        alert("비밀번호가 틀렸습니다! 다시 확인해주세요!")
    };
	</script>
</c:if>		
    
    <!-- <input type="button" value="로그아웃" onclick=" location.href='/user/logout'; ">
    <hr> 상단에 로그아웃 버튼 있음 -->
   <div class="container mt-5 abx">
	<div class="row">
          <div class="card">
              <!-- 회원정보 확인 -->
            <div class="card-body pt-3">
               <h4>${vo.user_name }님의 마이페이지 입니다. </h4>
              <ul class="nav nav-tabs nav-tabs-bordered" role="tablist">
				
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" data-bs-toggle="tab" onclick= "location.href='/user/update';" aria-selected="true" role="tab">회원 정보 조회 및 수정</button>
                </li>
                <li class="nav-item" role="presentation">
		           <button class="nav-link" data-bs-toggle="tab" onclick= "location.href='/class/paymentList';" aria-selected="false" role="tab" tabindex="-1">클래스 예약 관리</button>
		        </li>
				<c:if test="${user_type eq 1 }">
					<li class="nav-item" role="presentation">
		                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password" aria-selected="false" role="tab" tabindex="-1">사업자 클래스 관리</button>
		            </li>
				</c:if>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" data-bs-toggle="tab" onclick= "location.href='/qna/qnaListAll';" aria-selected="false" role="tab" tabindex="-1">1:1문의</button>
                </li>
              </ul>
              
             <!-- 회원정보 수정 -->
                <div class="tab-pane fade profile-edit pt-3" >

                  <form action="" method="post">
                  
                  	<div class="row mb-3">
                      <label for="user_id" class="col-md-4 col-lg-3 col-form-label">아이디 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_id" type="text" class="form-control" id="user_id" value="${vo.user_id }" readonly>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label for="user_name" class="col-md-4 col-lg-3 col-form-label">이름 : </label>
                      <div class="col-md-8 col-lg-9">
                        <input name="user_name" type="text" class="form-control" id="user_name" value="${vo.user_name } ">
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
                        <input name="user_pw" type="password" class="form-control" id="user_pw" placeholder="비밀번호를 입력 해 주세요.">
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary" id="userUpdate">정보수정하기</button>
                      <button type="button" class="btn btn-primary">회원탈퇴</button>
                    </div>

						<a type="button" class="btn btn-default pull-left"
							href="../user/userInfo">취소</a> <input type="button"
							id=userUpdate value=" 자식창 열기 " onclick="openChild()"> <br> <input
							type="hidden" id="pInput" name="user_pw"> <input type="submit"
							value="정보 수정하기">
					</form>
                </div>
                <!-- 회원정보 수정 -->
               </div>
            </div>
		</div>
					<!-- End Change Password Form -->	
						
              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
        </div>
       
   
    
    
<!--     <h3><a href="/user/info">회원정보 조회</a></h3> -->
   
<!--     <hr><hr> -->
    
<!--     <h3><a href="/user/update">회원정보 수정</a></h3> -->
<!--     <hr><hr> -->
    
<!--     <h3><a href="/user/delete">회원정보 삭제</a></h3> -->
                                  
<%--     <c:if test="${!empty id && id eq 'admin'}"> --%>
<%--     <c:if test="${!empty user_id && user_id.equals('admin1')}"> --%>
<!--        관리자(admin)일때 확인가능한 메뉴  admin 페이지 새로 만듦   -->
<!--        <hr><hr> -->
<!--        <h3><a href="/user/list">회원정보 목록</a></h3> -->
<%--     </c:if> --%>
<%@include file="../include/footer.jsp"%>    
    
