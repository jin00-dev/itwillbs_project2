

//window.addEventListner("DOMContentLoaded", function(){
//	$("#joinIdInput").keyup(function (){
//		var value= ${event.target}.val();
//		var num = value.search(/[0-9]/g);
//		var eng = value.search(/[a-z]/ig);
//		
//		if(value.length < 5 || value.length > 10){
//			$("#alertId").css({
//				"color" : "red",
//				"font-size" : "10px"
//			});
//			$("#alertId").text("! 아아디는 5자리이상 10자리 이하여야합니다.")
//		} else if(value.replace(/\s| /gi, "").length == 0){
//			$("#alertId").css({
//				"color" : "red",
//				"font-size" : "10px"
//		});
//			$("#alertId").text("! 아이디에 공백은 사용할 수 없습니다.")
//		} else if(num<0 || eng <0){
//			$("#alertId").css({
//				"color": "red",
//				"font-size":"10px"
//			});
//			$("#alertId").text("! 아이디는 영어+숫자로 이루어져야 합니다.")
//		} else {
//			$.ajax({
//				type : "post",
//				url : "./isExistId",
//				data : {
//					user_id: $("#joinIdInput").val()
//				},
//				dataType : "json",
//				success : function(data){
//					if (data.result == "fail") {
//						$("#alertId").css({
//							"color" : "red"
//						});
//						$("#alertId").text("! 이미 사용중인 아이디입니다.")
//					} else {
//						$("#alertId").css({
//							"color" : "black"
//						});
//						$("#alertId").text("@ 사용가능한 아이디 입니다.")
//					}
//				}
//			});
//		}
//	});
	
//	$("#changePassword").keyup(function () {
//		var value= ${event.target}.val();
//		
//		var num = value.search(/[0-9]/g);
//		var eng = value.search(/[a-z]/ig);
//		var spe = value.search(/['~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
//		
//		if (value.length  < 8 || value.length >30){
//			$("#alertPassword").css({
//				"color":"red",
//				"font-size":"10px"
//			});
//			$("#alertPassword").text("! 비밀번호는 8자리 이상 30자리 이하여야합니다.")
//		} else if(value.replace(/\s| /gi, "").length == 0){
//			$("#alertPassword").css({
//				"color" : "red",
//				"font-size" : "10px"
//		});
//			$("#alertPassword").text("! 비밀번호에 공백은 사용할 수 없습니다.")
//		} else if(num<0 || eng <0 || spe<0){
//			$("#alertPassword").css({
//				"color": "red",
//				"font-size":"10px"
//			});
//			$("#alertPassword").text("! 비밀번호는 영어+숫자+특수문자로 이루어져야 합니다.")	
//		} else {
//			$("#alertPassword").css({
//				"color" : "black",
//				"font-size":"10px"
//			});
//			$("#alertId").text("@ 사용가능한  비밀번호입니다.");
//		}
//	});
//	
//	$("#confirmPassword").keyup(function () {
//		var value= ${"#confirmPassword"}.val();
//		
//		
//		if (value != $("#confirmPassword").val()){
//			$("#alertPassword2").css({
//				"color":"red",
//				"font-size":"12px"
//			});
//			$("#alertPassword2").text("! 비밀번호가 일치하지 않습니다.")
//			return;
//		}
//		;
//		$("#alertPassword2").css({
//			"color" : "black",
//			"font-size":"10px"
//		});
//		$("#alertPassword2").text("@ 비밀번호가 일치합니다.");
//	});
//	
//	$("#userPhone").keyup(function () {
//		var value = $(event.target).val();
//		var phone = $("#userPhone").val();
//		var regex = new RegExp("^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$");
//		if(value.length < 13 || value.length > 13){
//			$("#alertPhone").css({
//				"color":"red",
//				"font-size":"10px"
//			});
//			$("#alertPhone").text(" ! 휴대폰번호는 하이픈포함 13글자여야 합니다.");
//		} else if (!regex.test(phone)){
//			$("#alertPhone").css({
//				"color" : "red",
//				"font-size" : "10px"
//			});
//			$("#alertPhone").text("! 휴대폰번호 정규식에 맞게끔 작성해주세요");
//		} else {
//			$.ajax({
//				type : "post",
//				url : "./isExistPhone",
//				data : {
//					user_phone : $("#userPhone").val()
//				},
//				dataType : "json",
//				success : function (data){
//					if(data.result == "fail"){
//						$("#alertPhone").css({
//							"color":"red",
//							"font-size":"10px"
//						});
//					$("#alertPhone").text("! 이미 사용중인 휴대폰 번호 입니다.");
//			}else {
//				$("#alertPhone").css({
//					"color" : "black",
//					"font-size" : "10px"
//				});
//				$("#alertPhone").text("@ 사용가능한 휴대폰번호입니다.")
//				}
//			}
//		});
//	}
//});
//	
//	$("#userEmail").keyup(function (){
//		var value= ${event.target}.val();
//		var email = ${"#userEmail"}.val();
//		var regex = new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z]*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
//		if(!regex.test(email)){
//			$("#alertEmail").css({
//				"color":"red",
//				"font-size":"10px"
//			});
//			$("#alertEmail").text("! 이메일의 정규식에 맞게끔 작성 부탁드립니다. abc@gmail.com");
//		}else{
//			$.ajax({
//				type: "post",
//				url: "./isExistEmail",
//				data:{
//					user_email : email
//				},
//				dataType: "json",
//				success : function(data){
//					if(data.result == "fail"){
//						$("#alertEmail").css({
//							"color":"red",
//							"font-size":"10px"
//						});
//						$("alertEmail").text(" ! 이메일이 이미 사용중입니다.")
//					}else{
//						$("#alertEmail").css({
//							"color" : "black",
//							"font-size":"10px"
//					});
//						$("#alertEmail").text(" @ 사용 가능한 이메일주소입니다.")
//						$("#checkEmailButton").attr("disabled",false);
//					}
//				}
//				
//			});
//		}
//	});
//	
//	var code="";
//	$("#checkEmailButton").click(function(){
//		$.ajax({
//			type : "post",
//			url : "./checkEmail",
//			data : {
//				user_email : $("#userEmail").val()
//			},
//			dataType : "json",
//			success : function(data){
//				if(data.result == "error"){
//					alert("서버와 통신중 에러가 발생했습니다.");
//					$("#alertCertified").css({
//						"color":"red",
//						"font-size":"10px"
//					});
//					code = data.code;
//					$("#checkEmail").attr("disabled",false);
//					$("#checkEmailButton").attr("disabled",true);
//				}
//			}
//			
//		});
//	});
//	
//	$("#checkEmail").keyup(function(){
//		if($("#checkEmail").val().length != 6){
//			$("#alertCertified").text("!  인증번호가 일치하지 않습니다. 다시 확인해주시기 바랍니다.")
//			$("#alertCertified").css({
//				"color":"red",
//				"font-size":"10px"
//			});
//		}else if ($("#checkEmail").val() == code){
//			$("#alertCertified").text("@ 메일인증이 완료되었습니다.")
//			$("#alertCertified").css({
//				"color":"green",
//				"font-size":"10px"
//			});
//			$("#checkEmail").attr("disabled",true);
//			$("#joinButton").attr("disabled",false);
//			$("#userEmail").attr("disabled",false);
//			$("#updateInfo").attr("disabled",false);
//		}
//	});
//	
//	$("#joinButton").click(function(){
//		if($("#alertId").text() != " 사용 가능한 아이디입니다."){
//			alert("아이디 중복 확인을 해주세요.");
//			return;
//		}
//		if($("#alertPhone").text() != " 사용 가능한 휴대폰입니다."){
//			alert("휴대폰번호 중복확인 해주세요");
//			return;
//		}
//		if($("#alertCertified").text() != " 메일 인증이 완료되었습니다."){
//			alert("메일 인증을 해주세요");
//			return;
//		}
//		
//		$("#insertForm").submit();
//		
//		alert("회원가입이 완료 되었습니다.");
//	});
//				});
//		
//		
//	