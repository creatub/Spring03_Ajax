<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>백엔드 21기 롤링페이퍼</title>
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
	
<script>
var isInputMode = true; // 초기에는 input 모드로 시작

document.getElementById("inputField").addEventListener("click", function(event) {
    if (isInputMode) {
        event.stopPropagation(); // inputField 클릭 시, 부모인 container의 클릭 이벤트가 발생하지 않도록 함
    }
});

document.getElementById("container").addEventListener("click", function() {
    var container = document.getElementById("container");
    var inputField = document.getElementById("inputField");
    
    if (isInputMode) {
        container.style.border = "none";
        inputField.style.border = "1px solid #ccc";
        inputField.focus();
        isInputMode = false; // input 모드에서 버튼 모드로 전환
    } else {
        var inputValue = inputField.value;
        alert("Button clicked with value: " + inputValue);
        container.style.border = "1px solid #ccc";
        inputField.style.border = "none";
        isInputMode = true; // 버튼 모드에서 input 모드로 전환
    }
});
</script>
	
</head>
<body>
	<div class="paper ">
		안녕, 그동안 우리와 함께 공부하느라 고생했어.<br>
		너의 이름을 적어줘!<br><br>
		<div id="container">
    		<input type="text" id="inputField">
		</div>
	</div>
	
	
</body>
</html>

<style>
body{
	font-family: "Helvetica Nene", Helvetica, Arial, sans-serif; 
	background-color: #fff;
	padding:3em;
}
div{
	height:500px;
	width:500px;
 	position: fixed;
    top: 130px;
    left: 35%;
}
/*종이 질감 효과*/
.paper{
	background-color: #fafaff;
	/*hsb 색상값 지정 hue, saturation, brightness*/
	background-image: -webkit-linear-gradient(hsla(0,0%,0%,.0),
		hsla(0,0%,0%,.0)
	);
	/* 그림자 적용 */
	box-shadow: inset 0 0 0 .1em hsla(0,0%,0%,.01),
		inset 0 0 1em hsla(0,0%,0%,.001),
		0 .1em .25em hsla(0,0%,0%,.1);
	/*포지션 상대위치 적용*/
	position: relative;
	display: flex;
    justify-content: center;
    align-items: center;
    /* 내용을 가운데 정렬 */
    text-align: center;
	}
	
/*종이 가상 그림자 공통 스타일 시트 적용*/
.paper:after,
.paper:before{
	bottom: .1em;
	box-shadow: 0 0 .5em .5em hsla(0,0%,0%,.25);
	content:'';
	height: 3em;
	position: absolute;
	width:80%;
	z-index: -1;
}
/*종이 가상 그림자 살짝 뜬 것처럼 방향 수정*/
.paper:after{
	right: 1em;
	-webkit-transform: rotate(3deg);
	-webkit-transform-origin: 100% 100%;
}
.paper:before{
	left: 1em;
	-webkit-transform: rotate(-3deg);
	-webkit-transform-origin: 0% 100%;
}


/*인풋 필드*/
#container {
    display: inline-block;
    position: absolute;
    top: 400px;
    left: 50%;
    transform: translateX(-50%);
}

#inputField {
    border: none;
    padding: 8px 64px;
    background-color: #40e0d0;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
    text-align: center;
    border-radius: 20px; /* 둥근 모서리 설정 */
}

#inputField:focus {
    outline: none;
}

#inputField:hover {
    background-color: #e0e0e0;
}

#inputField::placeholder {
    color: #999;
}

</style>