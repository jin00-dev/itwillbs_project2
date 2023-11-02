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

<button onclick="requestPay()">결제하기</button>
<script>
const userCode = "imp14397622";
IMP.init(userCode);

function requestPay() {
  IMP.request_pay({
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid: "test_lmk5h0rr",
    name: "테스트 결제",
    amount: 100,
    buyer_tel: "010-0000-0000"
  });
}
</script>




</body>
</html>