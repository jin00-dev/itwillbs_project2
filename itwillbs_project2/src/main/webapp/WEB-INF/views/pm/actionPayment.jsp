<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
</head>
<body>

	<c:set var="user_id" value="test1"/>


	<button onclick="requestPay()">결제하기</button>

	<script type="text/javascript">


    var IMP = window.IMP; 
    IMP.init('imp66880805');

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
                        alert('결제가 완료되었습니다');
                        location.href = '/class/paymentList?user_id=${user_id}';
                    },
                    error: function (error) {
                        console.error(error);
                        alert('결제를 다시 시도해주세요');
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