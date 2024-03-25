<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세페이지-상품평</title>
<!-- ----------------------------------------- -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- -------------------------------------------- -->
<style>
#reviewList {
	width: 100%;
}

#reviewList li {
	list-style: none;
	float: left;
}

#reviewList li:nth-child(3n+1) {
	width: 30%;
}

#reviewList li:nth-child(3n+2) {
	width: 70%;
}

#reviewList li:nth-child(3n) {
	clear: both; /*float 속성 해제*/
}
</style>
</head>
<body>
	<div class="container py-4 text-center">
		<h1>${msg }</h1>
		<br>
		<button class="btn btn-outline-primary" data-target="#reviewModal"
			data-toggle="modal">상품평 쓰기</button>
		<a href="#reviewModal" data-toggle="modal">상품평 쓰기</a>
		<!--  ============================================ -->
		<!-- The Modal -->
		<div class="modal" id="reviewModal">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">

					<!-- Modal Header ------------------------------------------------>
					<div class="modal-header">
						<h4 class="modal-title">상품 Review</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -------------------------------------------------->
					<div class="modal-body">
						<div class="row">
							<!-- 리뷰쓰기 xl,lg,md(desktop), sm(table) xs(mobile) -->
							<div class="col-md-6 col-sm-12 col-xs-12">
								<!--글쓰기 폼 --------------------------- -->
								<form name="rf" id="rf" method="post"
									enctype="multipart/form-data">
									<!-- hidden data ================== -->
									<input type="hidden" name="userid" id="userid" value="admin">
									<input type="hidden" name="pnum" id="pnum"
										value="${param.pnum}"> <input type="text" name="no"
										id="no" value="0">
									<!-- 글수정시 사용 -->
									<table class="table table-responsive">
										<tr>
											<th colspan="4" class="text-center">
												<h3>::상품 후기::</h3>
											</th>
										</tr>
										<tr>
											<th>평가점수</th>
											<td><input type="radio" name="score" id="score1"
												value="1">1점 <input type="radio" name="score"
												id="score2" value="2">2점 <input type="radio"
												name="score" id="score3" value="3">3점 <input
												type="radio" name="score" id="score4" value="4">4점 <input
												type="radio" name="score" id="score5" value="5">5점</td>

											<th>작성자</th>
											<td id="writer"></td>
										</tr>
										<tr>
											<th>제목</th>
											<td colspan="3"><input type="text" name="title"
												id="title" placeholder="Title" class="form-control">
											</td>
										</tr>
										<tr>
											<th>상품평</th>
											<td colspan="3"><textarea name="content" id="content"
													rows="2" class="form-control"></textarea></td>
										</tr>
										<tr>
											<th>이미지업로드</th>
											<!-- input name을 mfilename으로 ==> 컨트롤러에서 @RequestParam("mfilename") MultipartFile mf으로 받아야 함 -->
											<td colspan="2"><input type="file" name="mfilename"
												id="filename" accept="image/*" class="form-control">
											</td>
											<td><a type="button" class="btn btn-success" id="btn1"
												onclick="send()">글쓰기</a></td>
										</tr>
									</table>
									<div id="prodImg">
										<!-- 업로드한 상품 이미지 -->
									</div>
								</form>

							</div>
							<!-- .col -->
							<!-- 리뷰목록 -->
							<div class="col-md-6 col-sm-12 col-xs-12">
								<ul id="reviewList">
									<!-- <li>
									<img src="resources/" class="img img-thumbnail">
									</li>
									<li>
										<span class="text-danger">★★★★★</span><br>
										<span>[title]</span><br>
										상품평 - 좋습니다
									</li>
									<li></li> -->

									<!-- li row end(한 행에 li 3개씩) -->
								</ul>
							</div>
							<!-- .col -->
						</div>
						<!-- .row -->
					</div>

					<!-- Modal footer ------------------------------------------------>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>

		<!--  ============================================ -->
	</div>
	<!-- .container end -->
</body>
<script>
$(function() {
	getReviewAll('${param.pnum}');//특정상품의 리뷰 게시글 목록 가져오기
})//$()end--------

function send(){
	let isChk=$('input[name="score"]').is(":checked");
	//alert(isChk)
	if(!isChk){
		alert('평가점수를 체크하세요');
		return;
	}
	if(!$('#title').val()){
		alert('제목을 입력하세요');
		$('#title').focus();
		return;
	}
	//ajax로 처리하지 않을 때
	/*$('#rf').prop('action','reviews')
			.prop('method','post')
			.submit();*/
	let btnTxt=$('#btn1').text();
	//alert(btnTxt);
	//[1] 파일을 업로드 하지 않을 경우. input값들을 파라미터 문자열로 만들어서 전송해야 함 title=aaa&content=bbb&score=5
	let paramData=$('#rf').serialize();
	//alert(paramData);
	
	//[2] 파일을 업로드할 경우 ==> FormData객체를 이용
	let form=$('#rf')[0]//form 객체
	//alert(form)
	let formData = new FormData(form);//파일 업로드 시는 FormData를 전송한다
	//formData.append("name","Sam"); // key,value
	
	
	if(btnTxt=='글쓰기'){			
		//writeReview(paramData);//파일업로드 하지 않을 경우
		writeReviewAndFile(formData);//파일 업로드를 할 경우 FormData를 넘기자
	}else if(btnTxt=='글수정'){
		updateReviewAndFile(formData);
	}				
}//send()-------------

//POST /reviews
function writeReviewAndFile(formData){
	$.ajax({
		type: 'post',
		url: 'reviews',
		data: formData, //==> FormData를 전달
		dataType:'json',
		contentType:false, // false를 주면 "multipart/form-data"로 전송된다
		processData: false, // 일반적으로 서버에 전달하는 데이터는 query string 형태, false를 주면 query sting을 사용 안함
		cache: false,
		success:function(res){
			if(res.result=='ok'){
				//글목록 가져오기
				getReviewAll(res.pnum);
			}else{
				alert('리뷰 등록 실패')
			}
		},
		error:function(err){
			alert('err: '+err.status)			
		}
	})
}//---------
//PUT  /reviews  ==>수정처리 (파일 업로드 안할때)
//POST /reviews (파일업로드할때는 POST로 하자)
function updateReviewAndFile(formData){
	/* let file = $('#filename')[0].value;
	formData.append("filename", file);
	alert(file)*/
	formData.append("mode","edit"); // mode값이 edit이면 수정 처리 ==> 컨트롤러에서, 비어있으면 등록 처리
	$.ajax({
		type:'post',
		url:'reviews',
		data:formData,
		dataType:'json',
		contentType:false,
		processData:false,
		cache:false
	})
	.done((res)=>{
		//alert(JSON.stringify(res));
		if(res.result=='ok'){
			getReviewAll(res.pnum);
		}else{
			alert('수정 실패');
		}
	})
	.fail((err)=>{
		alert('err: '+err.status)
	})
}//---------------

function writeReview(paramData){
	$.ajax({
		type:'post',
		url:'reviews',
		data:paramData, //파라미터 데이터
		dataType:'json',//응답유형
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res))
			if(res.result=='ok'){
				//글목록 가져오기
				getReviewAll(res.pnum);
			}else{
				alert('리뷰 등록 실패')
			}
		},
		error:function(err){
			alert('err: '+err.status)	
		}
	})				
}//writeReview()--------------------------
//GET /reviews => 리뷰 목록 가져오기
function getReviewAll(pnum){
	//alert(pnum)
	$.ajax({
		type:'get',
		url:'reviews?pnum='+pnum,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res))
			showList(res);
		},
		error:function(err){
			alert("err: "+err.status)
		}
	})
}//getReviewAll()----------------

function showList(res){//res==>배열
	let str="";
	$(res).each(function(i, obj){
		console.log('obj.wdate: '+obj.wdate);//long timestamp
		
		let d = new Date(obj.wdate);//작성일
		
		let yy=d.getFullYear();
		let mm=d.getMonth()+1//Jan:0, Feb:1, ... Dec:11
		let dd=d.getDate();
		let dateStr=yy+"-"+mm+"-"+dd;
		
		if(obj.filename==null){
			str+=`<li><img src="resources/images/noimage1.PNG" class="img img-thumbnail"></li>`;
		}else{
			str+=`<li><img src="resources/images/\${obj.filename}" class="img img-thumbnail"></li>`;
			
		}//else
		str+=`<li><span class="text-danger">`;
			for(var i =0;i<obj.score;i++){
				str+=`★`;
			}//for----
		str+=`</span>[\${dateStr}]<br>
		<span>\${obj.title}</span><br>
		<span>\${obj.userid}</span><br>
		<p>\${obj.content}</p>
		`;
		//글쓴이와 로그인한 사람이 일치하다면 수정,삭제 링크
		if(obj.userid=='admin'){
            str+=`<button class="btn btn-info" onclick="edit('\${obj.no}')">수정</button>
            <button class="btn btn-danger" onclick="remove('\${obj.no}')">삭제</button>
            `;
        }
    str+=`</li>
    <li></li>`;
    
    $('#reviewList').html(str);
	})//each()
}//showList()-----------------
//DELETE reviews/10 ==> 경로 접근 방식으로 글번호(no)를 넘긴다
function remove(no){
	$.ajax({
		type:'delete',
		url:'reviews/'+no,
		dataType: 'json',
		cache:false
	})
	.done(function(res){
		if(res.result=='ok'){
			getReviewAll(${param.pnum});
		}else{
			alert('실패')
		}
	})
	.fail(function(err){
		alert('err: '+err.status)
	})
	
}//remove()-----------
//GET /reviews/10==>특정 게시글 가져오기
function edit(no){
	$.ajax({
		type:'get',
		url:'reviews/'+no,
		dataType:'json',
		cache:false
	})
	.done((res)=>{
		//alert(JSON.stringify(res))
		$('#score'+res.score).prop('checked',true);
			//스코아 점수 체크
		$('#writer').html(res.userid);
			
		$('#title').val(res.title);
		$('#userid').val(res.userid);
		$('#pnum').val(res.pnum);
		$('#no').val(res.no);
		$('#content').val(res.content);
		if(res.filename!=null){
			let str=`<img src="resources/images/\${res.filename}" class="img-fluid">`;
			$("#prodImg").html(str);
		}
		
		
		$('#btn1').text("글수정");
		
	})
	.fail((err)=>{
		alert('err: '+err.status)
	})
}//edit()--------------------


</script>

</html>