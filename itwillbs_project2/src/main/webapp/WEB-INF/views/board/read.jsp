<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<div class="notice-detail">
    <h3>공지사항</h3>

    
    <h5>${resultVO.enf_title}</h5>

    
    <div>
        <span>작성일: <fmt:formatDate value="${resultVO.enf_regdate}" pattern="yyyy-MM-dd" /></span>
    </div>

   
    <div>
        <p>
            <c:out value="${resultVO.enf_content}" />
        </p>
    </div>

    
    <form id="actionForm" method="POST">
        <input type="hidden" name="enf_notice_num" value="${resultVO.enf_notice_num}">
    </form>

    
    <div>
        <button id="btnList">목록</button>
        
        <%-- <c:if test="${sessionScope.userRole.equals('admin')}"> --%>
            <button id="btnUpdate">수정</button> 
            <button id="btnDelete">삭제</button> 
       <%-- </c:if> --%>
    </div> 
</div>
 
<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        // 목록 버튼 클릭 이벤트
        $('#btnList').click(function() {
            location.href = 'boardListAll';
        });

        // 수정 버튼 클릭 이벤트
        $('#btnUpdate').click(function() {
            location.href = '/board/update?enf_notice_num=${resultVO.enf_notice_num}';
        });

        // 삭제 버튼 클릭 이벤트
        $('#btnDelete').click(function() {
            if (confirm('정말 삭제하시겠습니까?')) {
                // form의 action을 설정하고 서버로 POST 요청을 보냄
                $('#actionForm').attr('action', '/board/remove').submit();
            }
        });
    });
</script> 