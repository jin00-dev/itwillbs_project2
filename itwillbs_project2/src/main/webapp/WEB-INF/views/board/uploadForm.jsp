<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/WEB-INF/views/include/header.jsp"%>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
.dropdown-select {
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none; /
	padding-right: 1.5rem;
	background-image:
		url('data:image/svg+xml;charset=US-ASCII,<svg width="12" height="12" xmlns="http://www.w3.org/2000/svg"><path d="M4 4l4 4 4-4" stroke="%236c757d" stroke-width="2" fill="none" stroke-linecap="round"/></svg>');
	background-repeat: no-repeat;
	background-position: right 0.7rem center;
	background-size: 12px 12px;
}
/* 선택 상태에서의 배경색 변경 효과 제거 */
.dropdown-select:active, .dropdown-select:focus {
	background-color: transparent;
	border-color: #ced4da;
	box-shadow: none;
}

.container-xxl, .container-xl, .container-lg, .container-md, .container-sm, .container {
    max-width: 800px;
}

</style>


<div class="container">
	<div class="card mb-3">
	<div class="card-body">
	  <div class="pt-4 pb-2">
	<h2>클래스 등록</h2>
	<form action="/board/fileUpload" method="post"
		enctype="multipart/form-data">

		<div class="form-group">
			<label for="exp_phone">사업자 연락처</label> <input type="text"
				class="form-control" id="exp_phone" name="exp_phone"
				placeholder="010-1234-5678" oninput="formatPhoneNumber(this);"
				maxlength="13" required>
		</div>

		<div class="form-group">
			<label for="exp_place">클래스 장소 이름</label> <input type="text"
				class="form-control" id="exp_place" name="exp_place"
				placeholder="가게명" required>
		</div>

		<div class="form-group">
			<label for="exp_name">클래스 이름</label> <input type="text"
				class="form-control" id="exp_name" name="exp_name"
				placeholder="클래스명" required>
		</div>

		<div class="form-group">
			<label for="exp_start_date">시작 날짜</label> <input type="date"
				class="form-control" id="exp_start_date" name="exp_start_date"
				required>
		</div>

		<div class="form-group">
			<label for="exp_end_date">종료 날짜</label> <input type="date"
				class="form-control" id="exp_end_date" name="exp_end_date" required>
		</div>

		<div class="form-group">
			<label for="exp_price">클래스 가격</label>
			<div class="input-group">
				<input type="text" class="form-control" id="exp_price"
					name="exp_price" oninput="formatCurrency(this);" required>
				<div class="input-group-append">
					<span class="input-group-text">원</span>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label for="exp_region">클래스 지역</label> <input type="text"
				class="form-control" id="exp_region" name="exp_region">
		</div>

		<div class="form-group">
			<label for="exp_category">클래스 분류</label> <select
				class="form-control dropdown-select" id="exp_category"
				name="exp_category">
				<option value="공예">공예</option>
				<option value="쿠킹">쿠킹</option>
				<option value="뷰티">뷰티</option>
				<option value="운동">운동</option>
			</select>
		</div>
		<div class="form-group">
			<label for="exp_inout">실내외 여부</label> <select
				class="form-control dropdown-select" id="exp_inout"
				name="exp_inout">
				<option value="0">실내</option>
				<option value="1">실외</option>
			</select>
		</div>

		<div class="form-group">
			<label for="exp_capacity">클래스 인원</label> <input type="number"
				class="form-control" id="exp_capacity" name="exp_capacity" min="1"
				required>
		</div>

		<div class="form-group">
			<label for="exp_summary_img">요약 사진</label> <input type="file"
				class="form-control-file" id="exp_summary_img"
				name="exp_summary_img">
		</div>

		<div class="form-group">
			<label for="exp_detail_img">상세 사진</label> <input type="file"
				class="form-control-file" id="exp_detail_img" name="exp_detail_img"
				multiple>
		</div>
		<div class="d-grid gap-2 mt-3">
		<button type="submit" id="btn" class="btn btn-primary">등록</button>
		</div>
	</form>
</div>
</div>
</div>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- <script>
	function formatPhoneNumber(input) {
		let numbers = input.value.replace(/\D/g, '');
		numbers = numbers.substring(0, 11);

		let formattedNumber = '';

		if (numbers.length > 3 && numbers.length <= 7) {
			formattedNumber = numbers.substr(0, 3) + '-' + numbers.substr(3);
		} else if (numbers.length > 7) {
			formattedNumber = numbers.substr(0, 3) + '-' + numbers.substr(3, 4)
					+ '-' + numbers.substr(7);
		} else {
			formattedNumber = numbers;
		}

		input.value = formattedNumber;
	}
	function formatCurrency(input) {
		var num = input.value.replace(/[^\d,]/g, '');
		num = num.replace(/,/g, '');

		if (num.length > 0) {
			num = parseInt(num).toLocaleString();
		}

		input.value = num;
	}
</script> -->

<%@include file="../include/footer.jsp"%>

