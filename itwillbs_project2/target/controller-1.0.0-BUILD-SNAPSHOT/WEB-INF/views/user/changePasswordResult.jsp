<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Password Change Result</title>
    <script>
        // alert 창 표시 함수
        function showAlert() {
            var success = '<%= request.getAttribute("success") %>';
            var error = '<%= request.getAttribute("error") %>';
            
            if (success !== null && success !== '') {
                alert(success);
                // alert 창 확인 후 로그인 페이지
                window.location.href = '/user/login'; 
            } else if (error !== null && error !== '') {
                alert(error);
                // alert 창 확인 후 이전 페이지로 돌아가야하는데 왜 로그인페이지로갈까?
               
                window.history.back();
            }
        }

        //  alert 
        window.onload = function () {
            showAlert();
        }
    </script>
    
</head>
<body>
    
</body>
</html>
