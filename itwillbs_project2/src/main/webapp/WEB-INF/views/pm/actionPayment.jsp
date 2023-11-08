<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
</head>
<body>

	<button onclick="requestPay()">결제하기</button>

	<script type="text/javascript">


    var IMP = window.IMP; 
    IMP.init('imp14397622');

    var today = new Date();
    var hours = today.getHours(); 
    var minutes = today.getMinutes();
    var seconds = today.getSeconds();
    var milliseconds = today.getMilliseconds();
    var makeMerchantUid = hours +  minutes + seconds + milliseconds;

    function requestPay() {
        IMP.request_pay({
            pg : 'html5_inicis',
            pay_method : 'card',
            merchant_uid: "IMP"+makeMerchantUid, 
            name : 'test1',
           amount : 100,
           buyer_email : "ddd@fff.vom",
           custom_data : "2023-11-10",
           buyer_name : "ddd",
           buyer_tel : "000-111-111"
        }, function (rsp) { // callback
            if (rsp.success) {
                console.log(rsp);
                $.ajax({
                    type: 'POST',
                    url: '/class/payment',
                    data: rsp,
                    success: function (response) {
                        console.log(response);
                    },
                    error: function (error) {
                        console.error(error);
                    }
                });
            } else {
                console.log(rsp);
                alert(rsp.error_msg);
            }
        });
}
</script>




</body>
</html>