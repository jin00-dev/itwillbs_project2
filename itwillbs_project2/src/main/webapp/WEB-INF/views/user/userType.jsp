<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
$(function () {
	//이벤트 처리
	//회원정보보기 아이디클릭
	$(".user_id").click(function () {
		// alert ("회원보기")
		//데이터 수집- 아이디
		let user_id = $(this).text();
		//alert(id);
		location = "view.do=" + user_id + "&${pageObject.pageQuery}";
		
	});
	let clickCnt = 2;
	let oldDate = "";
	let changeData = "";
	
	// 회원상태 처리
	$(".status").click(function (){
		let val = $(this).val();
		if(clickCnt == 2){
			clickCnt==1; //한번누르면
			oldDate = val; //옛날데이터
		} else {
			clickCnt == 2; //두번누르면
			changeData = val;  //바꿀데이터
			if(oldData != changeData ){
				let user_id = $(this).closest(".dataRow").find(".user_id").text();
				if(confirm(user_id + "님의 상태를 " + changeData + "(으)로 바꾸시겠습니까?")){
					//alert("데이터 바꾸기 진행");
					$.ajax({
						url : "/ajax/changeStatus.do?user_id=" + user_id + "&status" + changData,
								success :function (result){
									console.log("success.result = " + result);
									alert(result);
								},
								error : function (xhr, status, error){
									console.log("error.xhr= " + xhr);
									console.log("error.status= " + status);
									console.log("error.error= " + error);
									alert("회원상태 변경 중 오류발생")
								}
					});
				
				
				}else{
					//원래 데이터로 복귀 세팅
					$(this).val(oldData);
				}
			}
	}
		console.log("회원상태클릭 :(" +clickCnt+"): " +val);
		console.log("원래데이터= "+oldDate +", 바꿀데이터 = " +changeData );
		
		
	});
	
	// 회원등급변경
	$(".grade").click(function (){
		let val = $(this).val();
		if(clickCnt == 2){
			clickCnt==1; //한번누르면
			oldDate = val; //옛날데이터
		} else {
			clickCnt == 2; //두번누르면
			changeData = val;  //바꿀데이터
			if(oldData != changeData ){
				let user_id = $(this).closest(".dataRow").find(".user_id").text();
				if(confirm(user_id + "님의 등급을 " + ((changeData == 1)?"일반회원으로":"사업자로") + " 바꾸시겠습니까?")){
					 alert("데이터 바꾸기 진행");
				 	$.ajax({
						url : "/ajax/changeGrade.do?user_id=" + user_id + "&gradeNo" + changData,
								success :function (result){
									console.log("success.result = " + result);
									alert(result);
								},
								error : function (xhr, status, error){
									console.log("error.xhr= " + xhr);
									console.log("error.status= " + status);
									console.log("error.error= " + error);
									alert("회원등급 변경 중 오류발생")
								}
					});
				
				
				}else{
					//원래 데이터로 복귀 세팅
					$(this).val(oldData);
				}
			}
	}
		console.log("회원상태클릭 :(" +clickCnt+"): " +val);
		console.log("원래데이터= "+oldDate +", 바꿀데이터 = " +changeData );
		
		
	});
	
});


</script>


</body>
</html>