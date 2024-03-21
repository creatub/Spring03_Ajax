<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
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
	<!-- 
		https://www.hankyung.com/feed/it  ===> 자바스크립트 보안 정책에 의해 같은 도메인이 아니면 네트워크 통신을 할 수 없다
		==> SOP(Same Origin Policy)  
		https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.hankyung.com%2Ffeed%2Fit
		==> CORS(Cross Origin Resource Sharing): 서버에서 허락한 교차 출처는 통신 가능함
		api.rss2json.com ==> 신문사에서 사이트의 접근을 허락함 ==> 우리는 이 사이트를 이용해서 통신
		이런 사이트를 Proxy Server라고 함
	-->
	<script>
	$(function(){
		$('a[href="newRss1"]').click(function(e){ // 속성 선택할 때 []를 쓴다
			e.preventDefault();//기본 동작을 막는다.(a 태그의 경우 href 지정된 url이동하려함 ==> 이를 막는다)
			//alert('a')
			$.ajax({
				url:'https://www.hankyung.com/feed/it',
				type:'get',
				dataType:'xml',
				cache:false
			})
			.done((data)=>{ // 화살표 함수
				alert(data)
			})
			.fail((err)=>{
				alert('err: '+err.status)
			})
		})//-------------
		
		$('a[href="newRss2"]').click(function(e){
			e.preventDefault();//기본 동작을 막는다.(a 태그의 경우 href 지정된 url이동하려함 ==> 이를 막는다)
			//alert('a')
			$.ajax({
				url:'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.hankyung.com%2Ffeed%2Fit',
				type:'get',
				dataType:'json',
				cache:false
			})
			.done((data)=>{ // 화살표 함수
				//alert(data);
				console.log(JSON.stringify(data));
				let feed_title=data.feed.title;
				let feed_link=data.feed.link;
				let feed_image=data.feed.image;
				let str=`
					<h2>\${feed_title}</h2><br>
					<a href="\${feed_link}" target="_blank"><img src="\${feed_image}"></a>
					<br>
				`;
				$('#result').html(str);
				
				//오늘의 뉴스 10개를 목록 태그를 이용해서 출력
				//title pubDate link
				//내가 짜다 만 코드 ㅎㅎ
				/* let items = data.items;
				str+=`
					<ul>
						<c:forEach var="i" items="\${items}">
							<li>\${i.title}</li>
							<li>\${i.pubDate}</li>
							<li>\${i.link}</li>
						</c:forEach>
					</ul>
				`; */
				//강사님 코드
				let arr = data.items;
				str="<ul class='list-group'>";
				$(arr).each((i, item)=>{
					let title=item.title;
					let pubDate=item.pubDate;
					let link=item.link;
					let image=item.thumbnail;
					str +=` 	
						<li class="list-group-item">
						<a href="\${link}">\${title}
						</a><span>[\${pubDate}]</span></li>
					`;
					//<img src="\${image}" class="img-fluid" style="width:100px">
					
				})//.each()
				str+="</ul>";
				$('#result').append(str);// 뒤에 덧붙이기 prepend()==>앞에 덧붙이기
			})//done()
			.fail((err)=>{
				alert('err: '+err.status)
			})//fail()
		})//$.ajax()----------------------
		
		//rss news를 db에 저장하기---------------
		$('a[href="newRss3"]').click(()=>{
			let url='https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.hankyung.com%2Ffeed%2Fit';
			$.ajax({
				type:'get',
				url:url,
				dataType:'json',
				cache:false
			})
			.done(function(data){
				//alert(data);
				$(data.items).each(function(i,item){
					let title=item.title;
					let link=item.link;
					let pubDate=item.pubDate.split(" ")[0];
					//ajax요청 다시 보내기
					$.ajax({
						type:'post',
						url:'news_dbCreate',
						async:false, // =>false를 주면 동기적 방식으로 요청을 보낸다.(순서를 지켜서)
						data:{
							title:title,
							link:link,
							pubDate:pubDate
						},
						success:function(res){
							//성공:'ok',실패:'fail'
							console.log(res.result);
						}
					})
				})//each()---
				
			})
			.fail(function(err){
				alert('err: '+err.status)
			})
			return false; // href로 이동하지 않음
		})//------------
		
		//
		
	})//$()------------------
	</script>
</head>
<body style="padding:2em">
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<hr>
<a href="ajaxView"><h3>Spring Ajax 기본</h3></a>
<a href="reviewForm"><h3>상품평 글쓰기(Restful)</h3></a>
<a href="newRss1"><h3>오늘의 뉴스1(SOP 제약)</h3></a>
<a href="newRss2"><h3>오늘의 뉴스2(Proxy사용)</h3></a>
<a href="newRss3"><h3>오늘의 뉴스3(json으로 받아온 뒤 DB에 저장)</h3></a>
<a href="weather"><h3>오늘의 날씨</h3></a>
<div id="result" class="my-4">
		
</div>
</body>
</html>
