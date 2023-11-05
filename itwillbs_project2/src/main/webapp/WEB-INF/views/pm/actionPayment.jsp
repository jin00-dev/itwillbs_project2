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

function iamport(){

//     var flag = $("#flag").val();
//     var principalId = $("#principalId").val();
//     var name = $("#name").val();
//     var phone = $("#phone").val();
//     var email = $("#email").val();
//     var postcode = $("#postcode").val();
//     var address = $("#address").val() + " " + $("#detailAddress").val();

//     var productName;
//     var productId = $("#productId").val();
//     var detailName = $("#productName").val();
//     var cartName = $("#cartName").val();
//     var amount = $("#amount").val();
//     var price = $("#total-price").text();


    //가맹점 식별코드
    IMP.init("imp66880805");
    IMP.request_pay({
        pg : 'html5_inicis',
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점 고유 주문 번호
        name : productName, // 결제 이름
        amount : price, //price
        buyer_tel : phone, // 전화번호
    }, function(res) {

        // 결제검증
        $.ajax({
            type : "POST",
            url : "/verifyIamport/" + res.imp_uid
        }).done(function(data) {

            if(res.paid_amount == data.response.amount){
                alert("결제 및 결제검증완료");

                //결제 성공 시 비즈니스 로직

            } else {
                alert("결제 실패");
            }
        });
    });
}
</script>




</body>
</html>