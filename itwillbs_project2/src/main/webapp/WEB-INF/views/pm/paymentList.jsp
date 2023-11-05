<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<h2> 한 회원이 주문한 모든 클래스 내용 리스트 </h2>
	
	<table>
		<tr>
			<td>사진</td>
			<td>주문번호</td>
			<td>클래스이름</td>
			<td>클래스 옵션:</td>
			
		</tr>
			<c:forEach var="i" items="${list }">
				<tr>
					<td>${i.exp_summary_img }</td>
					<td>${i.order_num }</td>
					<td>${i.exp_name }</td>
					<td>${i.exp_capacity } * ${i.exp_price }</td>
					<td><button class="btn1" onclick="location.href='/class/paymentInfo?user_num=${param.user_num}&order_num=${i.order_num }'">상세내역</button></td>
					<td><button class="btn2" onclick="location.href='/class/paymentInfo'">환불</button><br></td>
					
				</tr>
			</c:forEach>	
	</table>
	

</body>
</html>