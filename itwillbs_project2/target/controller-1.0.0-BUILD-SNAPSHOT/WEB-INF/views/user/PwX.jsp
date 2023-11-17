<!-- PwX.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Update Result</title>
    <script>
        // alert 창 표시
        function showAlert() {
            alert("일치하는 정보를 찾을 수 없습니다.");
            // alert 창 확인 후 /user/findPassword 페이지로 리다이렉션
            window.location.href = '/user/findPassword';
        }

        // 페이지 로드 시 alert 창 표시 여부 확인
        window.onload = function () {
            var isError = '<%= request.getParameter("error") %>';
            if (isError !== null && isError !== '') {
                showAlert();
            }
        }
    </script>
</head>
<body>
   
</body>
</html>
