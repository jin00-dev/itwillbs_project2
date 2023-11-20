<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<!-- Bootstrap CSS 추가 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
	@font-face{font-family:KBO-Dia-Gothic_bold;src:url(https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/KBO-Dia-Gothic_bold.woff) format('woff');font-weight:700;font-style:normal}.card-title a{color:inherit;text-decoration:none}.card-img-top{width:100%;height:200px;object-fit:contain;background-color:#f8f9fa}.eh3{font-family:KBO-Dia-Gothic_bold;margin-top:50px}
.abx{
  height: auto;
  min-height: 100%;
  padding-bottom: 180px;
}
</style>

<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp"%>


<h2 class="text-center mb-4 eh3">이벤트 게시판</h2>

<div class="container abx">
<c:if test="${user_type eq 2}">
 <div class="text-right mb-3">
      <a href="/board/eventInsert" class="btn btn-primary">글쓰기</a>
    </div>
</c:if>

  <div class="row">
  <c:forEach var="item" items="${eventListAll}">
    <c:if test="${item.enf_category == 0}">
      <div class="col-md-4 mb-4">
        <div class="card h-100">
          <a href="/board/eventRead?enf_event_num=${item.enf_event_num}">
            <img class="card-img-top" src="/exp/thumbDownload?fileName=${item.enf_img}&wid=400&hei=200" alt="이벤트 이미지">
          </a>
          <div class="card-body">
            <h5 class="card-title">
              <a href="/board/eventRead?enf_event_num=${item.enf_event_num}">${item.enf_title}</a>
            </h5>
            <p class="card-text">
              <c:choose>
                <c:when test="${item.enf_event_type == 1}">
                  <span class="badge badge-success p-2">이벤트 진행중</span>
                </c:when>
                <c:otherwise>
                  <span class="badge badge-secondary p-2">종료된 이벤트</span>
                </c:otherwise>
              </c:choose>
            </p>
          </div>
        </div>
      </div>
    </c:if>
  </c:forEach>
</div>
</div>

<!-- footer -->
<%@include file="../include/footer.jsp"%>

<!-- Bootstrap JS 추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>