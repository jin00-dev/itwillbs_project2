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

<section class="py-5">
	<div class="col-md-8 mx-auto p-5 border">
		<!-- 검색 -->
		<div class="d-flex justify-content-center m-3">
			<input class="form-control me-2" id="address" type="text" placeholder="검색할 주소"> <input class="btn btn-outline-success" id="submit" type="button" value="주소검색">
		</div>
		<div class="m-3 text-center">
			<table class="table">
				<thead>
					<tr>
						<th>주소</th>
					</tr>
				</thead>
				<tbody id="mapList">
					<tr>
						<td>입력된 값이 없어요</td>
					</tr>
				</tbody>
			</table>
			<!-- 지도 -->
			<div id="map" style="width: 100%; height: 400px;"></div>
			<!-- 체험리스트 -->
			<div id="expList"></div>

		</div>

	</div>
</section>




<!-- footer -->
<%@include file="../include/footer.jsp"%>
<!-- script  -->
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=efx8eq0ugv&submodules=geocoder"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
	//네이버 지도 api ---------------------------------------------------------
	selectMapList();
	
	//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
	function searchAddressToCoordinate(address) {
		naver.maps.Service
				.geocode(
						{
							query : address
						},
						function(status, response) {
							if (status === naver.maps.Service.Status.ERROR) {
								return alert('Something Wrong!');
							}
							if (response.v2.meta.totalCount === 0) {
								return alert('올바른 주소를 입력해주세요.');
							}
							var htmlAddresses = [], item = response.v2.addresses[0], point = new naver.maps.Point(
									item.x, item.y);
							if (item.roadAddress) {
								htmlAddresses.push('[도로명 주소] '
										+ item.roadAddress);
							}
							if (item.jibunAddress) {
								htmlAddresses.push('[지번 주소] '
										+ item.jibunAddress);
							}
							if (item.englishAddress) {
								htmlAddresses.push('[영문명 주소] '
										+ item.englishAddress);
							}

							insertAddress(item.roadAddress, item.x, item.y);

						});
	}
	// 주소 검색의 이벤트
	$('#address').on('keydown', function(e) {
		var keyCode = e.which;
		if (keyCode === 13) { // Enter Key
			searchAddressToCoordinate($('#address').val());
		}
	});
	$('#submit').on('click', function(e) {
		e.preventDefault();
		searchAddressToCoordinate($('#address').val());

	});
	naver.maps.Event.once(map, 'init_stylemap');

	//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
	function insertAddress(address, latitude, longitude) {
		var mapList = "";
		mapList += "<tr>"
		mapList += "	<td>" + address + "</td>"
		mapList += "</tr>"

		$('#mapList').empty();
		$('#mapList').append(mapList);
		
		$('#expList').empty();
		insertList(address.substring(0, 2));
		
		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(longitude, latitude),
			zoom : 14
		});
		var marker = new naver.maps.Marker({
			map : map,
			position : new naver.maps.LatLng(longitude, latitude),
		});
	}

	//체험 리스트
	function insertList(addr) {
		list = ${list};
		
		for (var i of list) {
			var expList = "";
			if(i.exp_region.substr(0,2) == addr){
				expList += '<div class="container-fluid border" style="min-width: 300px">';
				expList += '    <div class="row justify-content-center">';
				expList += '        <div class="col-6 m-3">';
				expList += '            <img class="img-fluid" src="https://dummyimage.com/150x150/dee2e6/6c757d.jpg" class="card-img-left" alt="...">';
				expList += '        </div>';
				expList += '        <div class="col-6 m-3">';
				expList += '            <div class="p-3 text-center">';
				expList += '                <span class="bg-secondary text-dark d-inline mx-1 my-1" style="width: 65px;">'
						+ i.exp_region.substring(0, 2) + '</span>';
				expList += '                <span class="bg-secondary text-dark d-inline mx-1 my-1" style="width: 65px;">'
						+ i.exp_category + '</span>';
				expList += '                <h4 class="mx-1 my-1">' + i.exp_name
						+ '</h4>';
				expList += '                <span>가격 : ' + i.exp_price + '원</span>';
				expList += '            </div>';
				expList += '        </div>';
				expList += '    </div>';
				expList += '</div>';
				
				$('#expList').append(expList);
			}
		}
	}

	//지도를 그려주는 함수
	function selectMapList() {

		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(37.3595704, 127.105399),
			zoom : 10
		});
	}

	// 지도를 이동하게 해주는 함수
	function moveMap(len, lat) {
		var mapOptions = {
			center : new naver.maps.LatLng(len, lat),
			zoom : 15,
			mapTypeControl : true
		};
		var map = new naver.maps.Map('map', mapOptions);
		var marker = new naver.maps.Marker({
			position : new naver.maps.LatLng(len, lat),
			map : map
		});
	}
	
	
</script>