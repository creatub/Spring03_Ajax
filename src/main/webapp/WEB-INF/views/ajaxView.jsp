<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxView</title>
<!-- ----------------------------------------------------- -->
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
	$(function(){// document들이 다 올라오면 이 function 실행하라
		$('#btn1').on('click',function(){//click 이벤트가 발생하면 function이 처리할거라는 Handler
			$.ajax({
				type:'get',//요청 method
				url:'ajaxText?phone=1111-1234',//요청 url
				dataType:'text',//응답유형
				cache:false, // 캐시 사용 안함 => 자꾸 캐시를 부르려고 해서 개발하는 중에는 cache 없는 게 나음
				success:function(data){ // 변수는 아무거나 해도 됨
					//alert(data);
					//$('#result').text(data);
					$('#result').html(data);
				},
				error:function(err){
					alert('error:' +err.status);
					console.log("error: "+err.responseText);//에러 메시지
				}
			})
		})//#btn1 end-----------------
		$('#btn2').click(function(){
			$.ajax({
				type:'get',
				url:'ajaxXml?phone=2222-1234',
				dataType:'xml',
				cache:false,
				success:function(data){
					//alert(data)
					let no=$(data).find("no").text();
					let name=$(data).find("name").text();
					let addr=$(data).find("addr").text();
					let phone=$(data).find("phone").text();
					
					let str= `
						<h3>\${no}</h3>
						<h3>\${name}</h3>
						<h3>\${addr}</h3>
						<h3>\${phone}</h3>
					`;
					$('#result').html(str).addClass('alert alert-danger');//bootstrap의 class를 추가함
				},
				error:function(err){
					alert(err.status)
				}
			})
		})//#btn2 end-------
		$('#btn3').click(function(){
			$.ajax({
				type:'post',
				url:'ajaxJson',
				data:'phone=3333-1234&addr=인천',//post방식일 때 파라미터로 전달할 데이터
				dataType:'json',
				cache:false,
				success:function(data){
					//alert(JSON.stringify(data))
					let no = data.no;
					let name = data.name;
					let addr = data.addr;
					let phone = data.phone;
					
					let str= `
						<h3>\${no}</h3>
						<h3>\${name}</h3>
						<h3>\${addr}</h3>
						<h3>\${phone}</h3>
					`;
					$('#result').html(str).addClass('alert alert-primary');
				},
				error:function(err){
					alert(err.status)
				}
			})	
		})//#btn3 end-------
		$('#btn4').click(function(){
			$.ajax({
				type:'post',
				url:'ajaxJsonList',
				data:{phone:'5555',addr:'수원'},//json형태의 데이터 전달
				dataType:'json',
				cache:false
			})
			.done(function(data){//success
				//alert(JSON.stringify(data));
				//응답데이터가 배열일 경우==>반복문
				//jquery 함수: $(배열).each(function(i,item){})
				let str='<ul class="list-group">';
				$(data).each(function(i,item){
					console.log(i+": "+JSON.stringify(item));
					str+=`
						<li class="list-group-item">
						\${item.no},\${item.name},\${item.addr},\${item.phone}
						</li>
					`;
				})
				str+="</ul>";
				$('#result').html(str);
			})
			.fail(function(err){//error
				alert('error: '+err.status);
			})
		})//#btn4 end-------
	})//$() end

</script>


</head>
<body>
	<div class="container py-5">
		<h1>JSON/XML/TEXT등의 데이터를 받아보자</h1>
		<h2>JSON이란? - JavaScript Object Notation</h2>
		<h3>자바스크립트 객체 형태로 데이터를 표현하는 방식</h3>
		<h3>JSON객체에는 문자열, 숫자, 배열, boolean, null값만 들어갈 수 있다</h3>
		
		<hr color="blue">
		<button class="btn btn-info" id="btn1">Text데이터 받는 경우</button>
		<button class="btn btn-warning" id="btn2">Xml데이터 받는 경우</button>
		<button class="btn btn-success" id="btn3">JSON데이터 받는 경우(객체)</button>
		<br><br>
		<button class="btn btn-primary" id="btn4">JSON데이터 받는 경우(배열)</button>
		<button class="btn btn-secondary" id="btn5">Naver OpenAPI에서 도서정보 받아오기</button>
		<hr color="red">
		<div id="result" class="my-4">
		
		</div>
	</div>

</body>
</html>