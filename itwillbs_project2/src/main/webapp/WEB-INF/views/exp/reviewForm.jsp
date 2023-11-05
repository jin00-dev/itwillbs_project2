<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header-->
<%@include file="../include/header.jsp"%>
<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Vue.js 스크립트 불러오기 -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.min.js"></script>

<!-- Section-->
<div class="col-md-8 m-5">
	<div class="card card-primary">
		<div class="card-header">
			<h3 class="card-title">Quick Example</h3>
		</div>
		<form>
			<div class="card-body">
				<label for="exampleInputFile">File input</label>
				<textarea class="form-control mb-2" rows="10" placeholder="후기를 작성해주세요 ..."></textarea>
				<div class="form-group">
					<div class="input-group">
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="exampleInputFile"> <label class="custom-file-label" for="exampleInputFile">Choose file</label>
						</div>
					</div>
				</div>
			</div>
			<div class="card-footer text-end">
				<button type="submit" class="btn btn-primary ">후기작성</button>
			</div>

		</form>
	</div>
</div>
<!-- footer -->
<%@include file="../include/footer.jsp"%>

<style>
</style>
<!-- script  -->
<script type="text/javascript">
	
</script>
