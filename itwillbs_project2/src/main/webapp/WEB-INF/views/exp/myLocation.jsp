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
						<td>입력된 주소가 없어요</td>
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
// 	var map = new naver.maps.Map('map', {
// 		center : new naver.maps.LatLng(start, end),
// 		zoom : 12
// 	});
	selectMapList();
// 	console.log(start);
// 	console.log(end);
// 	RouteMap(map,start,end);
	
	var selectedMarker;
	
	//현재 위치 가져오기

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
		
		map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(longitude, latitude),
			zoom : 12
		});
		
		insertList(address,map);
		
		var marker = new naver.maps.Marker({
			map : map,
			position : new naver.maps.LatLng(longitude, latitude),
			animation: naver.maps.Animation.DROP,
		});
		
		// 정보 창 만들기
		var contentString = [
		        '<div class="iw_inner">',
		        '   <h3>내 주소</h3>',
		        '</div>'
		    ].join('');
		 
		var infowindow = new naver.maps.InfoWindow({
		    content: contentString
		});
		
		// 마커 클릭 이벤트
		naver.maps.Event.addListener(marker, "click", function(e) {
		    if (infowindow.getMap()) {
		        infowindow.close();
		    } else {
		        infowindow.open(map, marker);
		    }
		    
		 	// 현재 선택된 마커에만 애니메이션 효과 적용
		    if (selectedMarker) {
		        selectedMarker.setAnimation(null); // 이전에 선택된 마커의 애니메이션 제거
		    }

		    selectedMarker = marker;
		    selectedMarker.setAnimation(naver.maps.Animation.BOUNCE);
		});
	}///

	//체험 리스트와 마커
	function insertList(addr,map) {
		list = ${list};
		
		for (let i of list) {
			var expList = "";
			if(i.exp_region.substr(0,2) == addr.substring(0, 2)){
				var href= "onclick=location.href='/exp/info?exp_num="+i.exp_num+"';";
				expList += '<div class="container-fluid border" style="min-width: 300px"'+href+' >';
				expList += '    <div class="row justify-content-center" style="cursor:pointer;" >';
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
				expList += '        <div class="col-6 m-3">';
				expList += '        	<a class="btn">길찾기</a>';
				expList += '    	</div>';
				expList += '    </div>';
				expList += '</div>';
				
				$('#expList').append(expList);

				naver.maps.Service
				.geocode(
						{
							query : i.exp_region
						},
						function(status, response) {
							console.log(response);
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
							
							//마커 만들기
							var marker = new naver.maps.Marker({
								map : map,
								position : new naver.maps.LatLng(item.y, item.x),
								animation: naver.maps.Animation.DROP,
							});
							
							// 정보 창 만들기
							var href= "onclick=location.href='/exp/info?exp_num="+i.exp_num+"';";
							var contentString = '<div class="card" '+href+' style="cursor:pointer;">' +
			                    '   <h3>' + i.exp_name + '</h3>' +
			                    '   <p>' + i.exp_region + '<br />' +
			                    '   </p>' +
			                    '</div>';
							 
							var infowindow = new naver.maps.InfoWindow({
							    content: contentString
							});
							
							// 마커 클릭 이벤트
							naver.maps.Event.addListener(marker, "click", function(e) {
							    if (infowindow.getMap()) {
							        infowindow.close();
							    } else {
							        infowindow.open(map, marker);
							    }

								// 현재 선택된 마커에만 애니메이션 효과 적용
							    if (selectedMarker) {
							        selectedMarker.setAnimation(null); // 이전에 선택된 마커의 애니메이션 제거
							    }

							    selectedMarker = marker;
							    selectedMarker.setAnimation(naver.maps.Animation.BOUNCE);

							});
							
						});
				
				
				
			}//if
		}//for
	}////
	
	//현재위치
	 function initMap(lat, lng) {
            var mapOptions = {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 15
            };

            map = new naver.maps.Map('map', mapOptions);

            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                animation: naver.maps.Animation.DROP
            });
            
            naver.maps.Event.addListener(marker, 'click', function() {
           	  marker.setAnimation(naver.maps.Animation.BOUNCE);
           	});

           	naver.maps.Event.addListener(marker, 'animation_end', function() {
           	  marker.setAnimation(null);  // 애니메이션 제거
           	});
            
         // 정보 창 만들기
			var contentString = [
		        '<div class="iw_inner">',
		        '   <h2>내 주소</h2>',
		        '</div>'
		    ].join('');
			 
			var infowindow = new naver.maps.InfoWindow({
			    content: contentString
			});
			
			// 마커 클릭 이벤트
			naver.maps.Event.addListener(marker, "click", function(e) {
			    if (infowindow.getMap()) {
			        infowindow.close();
			    } else {
			        infowindow.open(map, marker);
			    }
			    
			 	// 현재 선택된 마커에만 애니메이션 효과 적용
			    if (selectedMarker) {
			        selectedMarker.setAnimation(null); // 이전에 선택된 마커의 애니메이션 제거
			    }

			    selectedMarker = marker;
			    selectedMarker.setAnimation(naver.maps.Animation.BOUNCE);
			});
        }

        function success(location) {
            var currentMyLocation = {
                lat: location.coords.latitude,
                lng: location.coords.longitude
            };
            
	          //  var cuAddr = getAddressFromCoordinates(currentMyLocation.lat, currentMyLocation.lng)
			naver.maps.Service.reverseGeocode({
		        location: new naver.maps.LatLng(currentMyLocation.lat, currentMyLocation.lng),
		    }, function(status, response) {
		        if (status !== naver.maps.Service.Status.OK) {
		            return alert('Something wrong!');
		        }
	
		        var result = response.result, // 검색 결과의 컨테이너
		        	items = result.items; // 검색 결과의 배열
		        
	            $('#mapList').empty();
	    		$('#mapList').append(items[1].address);
		    });
	
	            initMap(currentMyLocation.lat, currentMyLocation.lng);
        }

        function error() {
        	map = new naver.maps.Map('map', {
    			center : new naver.maps.LatLng(37.3595704, 127.105399),
    			zoom : 10
    		});
            alert('현재 위치를 가져올 수 없습니다.');
        }

	//지도를 그려주는 함수
	function selectMapList() {
		if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(success, error);
        } else {
            alert('Geolocation이 지원되지 않습니다.');
        }
	}

	// 지도를 이동하게 해주는 함수
	function moveMap(len, lat) {
		var mapOptions = {
			center : new naver.maps.LatLng(len, lat),
			zoom : 15,
			mapTypeControl : true
		};
		map = new naver.maps.Map('map', mapOptions);
		var marker = new naver.maps.Marker({
			position : new naver.maps.LatLng(len, lat),
			map : map
		});
	}
	
	//길찾기 -------------------------------------------------------
	// 출발지와 도착지 좌표를 설정합니다.
// 	var start = new naver.maps.LatLng(37.5666103, 126.9783882); // 출발지 좌표
// 	var end = new naver.maps.LatLng(37.4979502, 127.0276368); // 도착지 좌표
	
	
	
// 	function RouteMap(map, startCoord, endCoord) {
// 		var directionsService = new naver.maps.services.Directions();
// 	    var directionsRenderer = new naver.maps.DirectionsRenderer({
// 	        map: map,
// 	        preserveViewport: true,
// 	        suppressMarkers: true
// 	    });

// 	    // 길찾기 요청
// 	    directionsService.route({
// 	        start: startCoord,
// 	        end: endCoord,
// 	        method: 'DRIVING',  // 자동차 경로 찾기
// 	        callback: function(response, status) {
// 	            if (status === naver.maps.Service.Status.OK) {
// 	                // 길찾기 결과를 지도에 표시
// 	                directionsRenderer.setDirections(response);
// 	            } else {
// 	                // 실패 시 처리
// 	                alert('길찾기에 실패했습니다.');
// 	            }
// 	        }
// 	    });
// 	}
	
	
</script>