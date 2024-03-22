<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>날씨가 좋을지도</title>
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
    <h3>날씨가 좋을지도?</h3><br>
    <div id="map" style="width:100%;height:500px;"></div>
    <br>
      <h3>Weather Web</h3>
      <p>Please click on the region you want to check the weather for</p>
    </div>
    <div id="result" class="my-4">
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
    zoom: 14
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
			//console.log(x);
			let str = `
				<img src="resources/\${x.daily[0].weather[0].main}.png" style="width:100px"><br><br>
				<h4>weather : \${x.daily[0].weather[0].main}</h4>
                <h4>wind Speed : \${x.daily[0].wind_speed.toFixed(1)}m/s</h4>
                <h4>max-temp : \${(x.daily[0].temp.max-273.15).toFixed(1)}°C</h4>
                <h4>min-temp : \${(x.daily[0].temp.min-273.15).toFixed(1)}°C</h4>
                <br><br>
			`;
			$('#result').html(str);
			if((x.daily[0].temp.max-273.15)>27){
				str="더운 날씨  <img src='resources/Hot.png' style='width:50px'>";
			}else if((x.daily[0].temp.max-273.15)>10){
				str="보통 날씨  <img src='resources/Cold.png' style='width:50px'>";
			}else{
				str="추운 날씨  <img src='resources/Cold.png' style='width:50px'>";
			}
			console.log((x.daily[0].temp.max-273.15));
			$('#result').append(str);
		}
	})
});



</script>
</body>
</html>

<style>
@import url("https://fonts.googleapis.com/css2?family=Asap&display=swap");
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
html,
body {
  overscroll-behavior-x: none;
  overscroll-behavior-y: none;
}
body {
  font-family: "Asap", sans-serif;
  position: relative;
  width: 100vw;
  min-height: 100vh;
  text-align: center;
  overflow-x: hidden;
  background: linear-gradient(
    to bottom,
    oklch(80% 0.2 220deg),
    oklch(80% 0.1 220deg),
    oklch(80% 0.1 320deg),
    oklch(80% 0.2 350deg)
  );
  color: white;
  font-size: clamp(12px, 5vw, 30px);
}
#cloud div::before,
#cloud div::after {
  content: "";
  display: block;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-image: url(https://raw.githubusercontent.com/happy358/misc/main/image/cloud_X.png);
  background-repeat: repeat-x;
  animation: cloud var(--duration) linear infinite forwards var(--direction);

  --posX: right;
  --duration: 15s;
  --direction: normal; /* normal or reverse */
  --lowHeight: 20vh;
  --highHeight: 100vh;
  --layerNum: 4;
  --index: 0;
  --opacity: 0.7;
  --moveX: 300px;
  animation-delay: calc(
    (var(--duration) / var(--layerNum)) * var(--index) * -1
  );
  opacity: 0;
}
#cloud div::before {
  --index: 0;
}
#cloud div::after {
  --index: 2;
  transform: scale3d(-1, 1, 1);
}
#cloud div#cloud_layer2::before,
#cloud div#cloud_layer2::after {
  background-image: url(https://raw.githubusercontent.com/happy358/misc/main/image/cloud.png);
}
#cloud div#cloud_layer2::before {
  --index: 3;
}
#cloud div#cloud_layer2::after {
  --index: 1;
}
#sun div {
  content: "";
  display: block;
  position: fixed;
  bottom: 0;
  left: 38vw;
  width: 100vw;
  height: 100vh;
  --sunPos: 50vw -35vmin;
  transform-origin: var(--sunPos);
  animation: sun 3.5s linear infinite alternate;

  -webkit-mask-image: radial-gradient(
    circle at var(--sunPos),
    white 0%,
    transparent 80%
  );
  mask-image: radial-gradient(
    circle at var(--sunPos),
    white 0%,
    transparent 80%
  );
}
#sun #sun_layer1 {
  background: conic-gradient(
    from 135deg at var(--sunPos),
    transparent 10.5%,
    rgba(255, 255, 255, 0.15) 11%,
    transparent 11.5%,
    transparent,
    transparent 15%,
    oklch(80% 0.1 0deg/0.1) 16%,
    transparent 17%,
    transparent,
    transparent 18%,
    rgba(255, 255, 255, 0.1) 19%,
    transparent 20%,
    transparent
  );
}
#sun #sun_layer2 {
  animation-delay: -1s;
  animation-duration: 7s;
  background: conic-gradient(
    from 140deg at var(--sunPos),
    transparent 10%,
    rgba(255, 255, 255, 0.1) 11%,
    transparent 12%,
    transparent,
    transparent 15.5%,
    rgba(255, 255, 255, 0.1) 16%,
    transparent 16.5%,
    transparent,
    transparent 17%,
    oklch(90% 0.1 50deg/0.1) 18%,
    transparent 19%,
    transparent
  );
}
#sun #sun_layer3 {
  animation-delay: -2s;
  animation-duration: 6.5s;
  background: conic-gradient(
    from 145deg at var(--sunPos),
    transparent 10%,
    oklch(90% 0.1 200deg/0.1) 11%,
    transparent 12%,
    transparent,
    transparent 14%,
    rgba(255, 255, 255, 0.1) 15%,
    transparent 16%,
    transparent,
    transparent 17%,
    rgba(255, 255, 255, 0.1) 18%,
    transparent 19%,
    transparent
  );
}
main {
  position: relative;
  mix-blend-mode: overlay;
}
section {
  position: relative;
  width: 100vw;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.arrow {
  width: auto;
  height: auto;
  position: absolute;
  bottom: 1rem;
  text-align: center;
}
.arrow .dot {
  --dotSize: 0.45rem;
  --dotColor: black;
  background: var(--dotColor);
  border-radius: 50%;
  width: var(--dotSize);
  height: var(--dotSize);
  margin: calc(var(--dotSize) * 0.5) 0;
  animation: arrow 2s infinite linear;
}
@keyframes arrow {
  0% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
  80% {
    opacity: 0;
  }
  100% {
    opacity: 0;
  }
}
.arrow div:nth-of-type(1) {
  animation-delay: -0.8s;
}
.arrow div:nth-of-type(2) {
  animation-delay: -0.4s;
}
.arrow div:nth-of-type(3) {
  animation-delay: 0s;
}
.arrow div:nth-of-type(4) {
  animation-delay: 0s;

  width: calc(var(--dotSize) * 3);
  height: calc(var(--dotSize) * 3);
  margin: calc(var(--dotSize) * -1.5) 0 0 calc(var(--dotSize) * -1);
  background: transparent;
  border-radius: 0;
  border: calc(var(--dotSize) * 0.45) solid;
  border-color: transparent transparent var(--dotColor) var(--dotColor);
  transform: rotate(-45deg);
}
@keyframes cloud {
  0% {
    opacity: 0;
    background-position: var(--posX) var(--moveX) bottom
      calc(-1 * var(--lowHeight));
    background-size: calc(1 * var(--lowHeight)) var(--lowHeight);
  }
  5% {
    opacity: var(--opacity);
  }
  80% {
    opacity: var(--opacity);
  }
  100% {
    opacity: 0;
    background-position: var(--posX) bottom;
    background-size: calc(3 * var(--highHeight)) var(--highHeight);
  }
}
@keyframes sun {
  to {
    transform: skew(-15deg);
  }
}
#result{
	margin-left: 1.5em;
}
</style>