<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="" method="get">
		체험번호: <br>
		체험이름 : ${testVO.exp_name }<br>
		예매 상태 : <br>
		장소 : ${testVO.user_place_name }<br>
		주소 : ${testVO.exp_region }<br>
		사업자연락처 : ${testVO.user_phone }<br>
		옵션 : ${testVO.exp_capacity }<br>
		예매번호 : ${testVO.exp_num }<br>
		이용자 : ${testVO.user_name }<br>
		결제금액 : ${testVO.exp_price }<br>
		결제수단 : ${testVO.payment_method }<br>
		결제일시 : ${testVO.payment_date }<br>
		환불기간 : 티켓 유효기간 결제 후 7일 전까지 신청 가능
	</form>
	
	
	

</body>
</html>