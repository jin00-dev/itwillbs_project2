<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>

var IMP = window.IMP; 
IMP.init("imp66880805"); 

function requestPay() {
    IMP.request_pay({
        pg : 'html5_inicis',
        pay_method : 'card',
        merchant_uid: "${tsetVO.order_num}", 
        name : '${testVO.exp_name}',
        amount : '${testVO.exp_price}',
        buyer_email : '${testVO.user_id}',
        buyer_name : '${testVO.user_id}',
        buyer_tel : '${testVO.user_phone}',
        buyer_postcode : '123-456'
    }, function (rsp) { // callback
    	IMP.request_pay({ /** 요청 객체를 추가해주세요 */ },
    			  function (rsp) {
    			    if (rsp.success) {
    			      // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
    			      // jQuery로 HTTP 요청
    			      jQuery.ajax({
    			        url: "{서버의 결제 정보를 받는 가맹점 endpoint}", 
    			        method: "POST",
    			        headers: { "Content-Type": "application/json" },
    			        data: {
    			          imp_uid: rsp.imp_uid,            // 결제 고유번호
    			          merchant_uid: rsp.merchant_uid   // 주문번호
    			        }
    			      }).done(function (data) {
    			        // 가맹점 서버 결제 API 성공시 로직
    			      })
    			    } else {
    			      alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
    			    }
    			  });
    });
}

</script>

<button onclick="requestPay()">결제하기</button>


</body>
</html>