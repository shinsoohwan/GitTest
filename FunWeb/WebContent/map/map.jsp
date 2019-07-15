<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마커 생성하기</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">찾아오는 길</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 내용 -->
		<article>
		<h1>찾아오는 길</h1>
			<div id="map" style="width: 100%; height: 350px;"></div>

			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7ff9f3dbe760beaa68468cb8c17f93d0"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(35.237118, 129.077210), // 지도의 중심좌표
					level : 3 // 지도의 확대 레벨
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
				// 마커가 표시될 위치입니다 
				var markerPosition = new kakao.maps.LatLng(35.237118, 129.077210);

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					position : markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);

				// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
				// marker.setMap(null);
			</script>
			<div>
			
				<h4>버스</h4>
				<div>
		 			해운대, 송정, 기장 : 100, 100-1, 144, 183<br>
 					서창, 범어사, 구서동 : 29, 49, 51, 80, 131, 301, 1002<br>
 					김해, 구포, 덕천동 : 121, 130<br>
 					서면(롯데호텔) : 77<br>
 				</div>
				<h4>지하철</h4>
				<div>
 					부산 지하철 1호선 부산대역에서 하차 후 3번 출구 앞 셔틀버스 이용 또는 도보로 10분 정도 소요<br>
 				</div>
			</div>
			
			
			
		</article>
		<!-- 내용 -->
		<!-- 본문 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>