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
	<h2>내 주변 클래스</h2>
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
						<td id="nowRegion">입력된 주소가 없어요</td>
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
	
	var selectedMarker;

	//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
	function searchAddressToCoordinate(address) {
		getNaverMapCoordinates(address).then(function(result) {
			insertAddress(result.roadAddress, result.x, result.y);
		}).catch(function(error) {
		    console.log(error);
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
		mapList += "	<td id='nowRegion'>" + address + "</td>"
		mapList += "</tr>"

		$('#mapList').empty();
		$('#mapList').append(mapList);
		
		
		map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(longitude, latitude),
			zoom : 12
		});
		
		$('#expList').empty();
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
	async function insertList(addr,map) {
		list = ${list};
		
		for (let i of list) {
			var expList = "";
			if(i.exp_region.substr(0,2) == addr.substr(0, 2)){
				
				var start ={ x: "", y: "" };
				var end ={ x: "", y: "" };
				var nowRegion = $('#nowRegion').text();
				
				try {
					let start = await getNaverMapCoordinates(nowRegion);
	                let end = await getNaverMapCoordinates(i.exp_region);

				    var href= "onclick=location.href='/exp/info?exp_num=" + i.exp_num + "';";
				    var findHref = "https://map.naver.com/p/directions/" + start.x + "," + start.y + "/" + end.x + "," + end.y + "/-/transit?c=13.00,0,0,0,dh";
				    
				    expList += '<div class="container-fluid border" style="min-width: 300px" >';
					expList += '    <div class="row justify-content-center" style="cursor:pointer;" >';
					expList += '        <div class="col-6 m-3" '+href+'>';
					expList += '            <img class="img-fluid" src="https://dummyimage.com/150x150/dee2e6/6c757d.jpg" class="card-img-left" alt="...">';
					expList += '        </div>';
					expList += '        <div class="col-6 m-3" '+href+' >';
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
					expList += '    <div class="col-6 m-3 text-center">';
					expList += '       <a href="'+findHref+'" class="btn btn-outline-info" id="findRoute">길찾기</a>';
					expList += '    </div>';
					expList += '    </div>';
					expList += '</div>';
					
					$('#expList').append(expList);
					
					//마커 만들기
					let marker = new naver.maps.Marker({
						map : map,
						position : new naver.maps.LatLng(end.y, end.x),
						animation: naver.maps.Animation.DROP,
					});
					
					// 정보 창 만들기
					var href= "onclick=location.href='/exp/info?exp_num="+i.exp_num+"';";
					var contentString = 
						'<div class="card" '+href+' style="cursor:pointer;">' +
	                    '   <h3>' + i.exp_name + '</h3>' +
	                    '   <p>' + i.exp_region + '<br />' +
	                    '   </p>' +
	                    '     <a href="'+findHref+'" class="btn btn-outline-info" id="findRoute">길찾기</a>'+
	                    '</div>';
					 
					let infowindow = new naver.maps.InfoWindow({
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
				} catch (error) {
	                console.log(error);
	                // 오류 처리 로직
	            }
				
				
			}//if
		}//for
	}////
	
	//현재위치 ---------------------------------------------------------------
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
			
			//주변 체험 목록작성
			naver.maps.Service.reverseGeocode({
		        location: new naver.maps.LatLng(lat, lng),
		    }, function(status, response) {
		        if (status !== naver.maps.Service.Status.OK) {
		            return alert('Something wrong!');
		        }
	
		        var result = response.result, // 검색 결과의 컨테이너
		        	items = result.items; // 검색 결과의 배열
			
				getNaverMapCoordinates(items[1].address).then(function(result) {
					insertAddress(result.roadAddress, result.x, result.y);
				}).catch(function(error) {
				    console.log(error);
				});
		    });
        }

        function success(location) {
            var currentMyLocation = {
                lat: location.coords.latitude,
                lng: location.coords.longitude
            };
            
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
	// 주소를 좌표로 -----------------------------------------------------
	function getNaverMapCoordinates(address) {
	    return new Promise((resolve, reject) => {
	        naver.maps.Service.geocode({
	            query: address
	        }, function(status, response) {
	            if (status === naver.maps.Service.Status.ERROR) {
	                reject('Something Wrong!');
	                return;
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
	
	            if (response.v2.meta.totalCount === 0) {
	                reject('올바른 주소를 입력해주세요.');
	                return;
	            }
	
	            //var item = response.v2.addresses[0];
	            var result = {
	                x: item.x, 
	                y: item.y, 
	                roadAddress: item.roadAddress, 
	                jibunAddress: item.jibunAddress, 
	                englishAddress: item.englishAddress
	            };
	
	            resolve(result);
	        });
	    });
	}
		


</script>