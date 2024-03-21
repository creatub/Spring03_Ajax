<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=r0nh0ibqvm"></script>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
	<!-- jQuery library -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<!-- Popper JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<!-- Latest compiled JavaScript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<!----------------------------------------------------------->
</head>

<body>
<div id='cloud'>
  <div id='cloud_layer1'></div>
  <div id='cloud_layer2'></div>
</div>
<div id='sun'>
  <div id='sun_layer1'></div>
  <div id='sun_layer2'></div>
  <div id='sun_layer3'></div>
</div>
<main>
  <section>
    <div>
    <div id="map" style="width:100%;height:500px;"></div>
      <h1>Weather Web</h1>
      <p>Please click on the region you want to check the weather for</p>
    </div>
    <div id="result">
    </div>
    <div class="arrow">
      <div class="dot"></div>
      <div class="dot"></div>
      <div class="dot"></div>
      <div class="dot"></div>
    </div>
  </section>
  <section>
  </section>
</main>


<script>
var position = new naver.maps.LatLng(37.5258975, 126.9284261);

var map = new naver.maps.Map('map', {
    center: position,
    zoom: 15
});

var marker = new naver.maps.Marker({
    position: position,
    map: map
});

naver.maps.Event.addListener(map, 'click', function(e) {
    marker.setPosition(e.coord);
    console.log(e.latlng.y);
    
	$.ajax({
		url:'https://api.openweathermap.org/data/2.8/onecall?lat='+e.latlng.y+'&lon='+e.latlng.x+'&exclude=current&appid=661dfa60fc6da38e5e4d4b8c90c61dac',
		dataType:'json',
		cache:false,
		success: function(x){
			console.log(x);
			let str = `
				<h4>weather : \${x.daily[0].weather[0].main}</h4>
                <h4>wind Speed : \${x.daily[0].wind_speed}</h4>
                <h4>max-temp : \${x.daily[0].temp.max-273.15}°C</h4>
                <h4>min-temp : \${x.daily[0].temp.min-273.15}°C</h4>
			`;
			$('#result').html(str);
		}
	})
});



</script>
</body>
</html>

