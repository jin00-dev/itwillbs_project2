<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>리뷰 신고 폼</h1>
    <form action="/submitReport" method="post">
        <!-- 리뷰를 신고할 사용자의 user_num -->
        <input type="hidden" name="reportedUserId" value="리뷰를 작성한 사용자의 user_num">

        <!-- 신고자의 user_num (로그인한 사용자의 user_num) -->
        <input type="hidden" name="reportingUserId" value="로그인한 사용자의 user_num">

        <!-- 신고 내용 입력 -->
        <label for="reportContent">신고 내용:</label>
        <textarea name="report_content" id="reportContent" rows="4" cols="50"></textarea>

        <!-- 제출 버튼 -->
        <input type="submit" value="리뷰 신고">
    </form>
</body>
</html>