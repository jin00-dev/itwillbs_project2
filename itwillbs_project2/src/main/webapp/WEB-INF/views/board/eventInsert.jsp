<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%>

<form method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td><label for="eventImage">이벤트 이미지:</label></td>
            <td><input type="file" id="eventImage" name="file"></td>
        </tr>
        <tr>
            <td><label for="eventStatus">진행 상태:</label></td>
            <td>
                <select id="eventStatus" name="enf_event_type">
                    <option value="1">이벤트 진행중</option>
                    <option value="0">종료된 이벤트</option>
                </select>
            </td>
        </tr>
        <tr> 
            <td><label for="eventTitle">제목:</label></td>
            <td><input type="text" id="eventTitle" name="enf_title"></td>
        </tr>
        <tr>
            <td><label for="eventContent">내용:</label></td>
            <td><textarea id="eventContent" name="enf_content" rows="4" cols="50"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;"><input type="submit" value="작성하기"></td>
        </tr>
    </table>
</form>

<!-- footer -->
<%@include file="/WEB-INF/views/include/footer.jsp"%>

