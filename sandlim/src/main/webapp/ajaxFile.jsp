<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>

<style>
table {border-collapse:collapse; border: 1px solid #333; width:60%}
th,td {border: 1px solid #333;}
th {background-color: #aaa; color: #fff;}
</style>

<script>
function getBoard1(val){
	let objParams = {seq: val};
	let values = []; //ArrayList 값을 받을 변수를 선언
	$.ajax({
		type : "POST", //form 태그의 method
		url : "reqAjax1.do", //form 태그의 action
		data : objParams, 
		cache : false, 
		success : function(res){
			$("#demo1").hide();
			console.log(res);
			console.log("성공");
			let str = "";
			$.each(res, function(i, o){
				str += "[" + i + "] { " + o.seq + "," + o.title + "," + o.writer + "}<br>";
			});
			$("#demo1_con").html(str);
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}

function getBoard2(val){
	let objParams = {seq: val};
	let values = []; //ArrayList 값을 받을 변수를 선언 
	$.ajax({
		method: "POST", //"POST"
		url : "reqAjax2.do",
		data: objParams, 
		cache : false, 
		success : function(data){
			console.log('data : ', data);
			if(data.code == "OK"){ //controller에서 넘겨준 성공여부 코드
				values = data.boardList; //java에서 정의한 ArrayList명을 적어준다.
				$.each(values, function(index, value){
					console.log(index + " : " + value.title);
					$("#status").append("<tr><td>" + value.seq + "</td><td>"+ value.title +"</td><td>" + value.writer + "</td></tr>");
					
				});
				
				$("#demo2").hide();
				console.log("성공");
			}else {
				console.log("실패");
			}
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}
/*
 참고 사이트 : https://knowledge-warehouse-jun.tistory.com/8
 
 dataType : 서버에서 결과 값으로 반환해주는 데이터를 어떤 자료형으로 받을 것인지 정의.
 생략했을 경우에는 jQuery가 MIME타입들을 보면서 자동으로 결정한다.
 -dataType의 종류-
1. xml  - XML문서
2. html - HTML을 텍스트 데이터로 여기에 script태그가 포함된 경우 처리가 실행됩니다.
3. json - JSON 형식 데이터로 평가하고 JavaScript의 개체로 변환합니다.
4. text - 일반 텍스트

contentType : 서버로 데이터를 보낼때에 어떤 자료형(타입)으로 보낼것인지를 정의.
1. application/json; charset-utf-8 (utf-8로 인코딩 된 json데이터로 전송)
2. application/x-www-form-urlencoded; charset=utf-8 (디폴트 값, utf-8로 인코딩 된 파라미터로 전송)
 
 
 
 */
 function ajaxTest(){
	$.ajax({
		url : "ajaxTest.do", //form태그의 action속성
		type : "post", // form태그의 method 속성
	 contentType : 'application/json; charset=utf-8', //서버로 전송할 데이터의 속성 설정 
// 		form태그의 입력요소로 보내는 파라미터 (name)와 value
//		data : {"id" : "admin", "password" : "1111", "name" : "관리자", "role" : "Admin"},
		data : JSON.stringify({"id" : "admin", "password" : "1111", "name" : "관리자", "role" : "Admin"}),
		cache : false,
		success : function(result){
// 			ajax로 요청한 데이터를 모두 처리하고 난 뒤 정상적으로 모두 완료되면 실행되는 로직 
// 			alert(result.code);
			alert(result);
		}
	});
}
</script>
</head>
<body>
	<h2>ajax Array 받기</h2>
	<div id="demo1">
		<button type="button" onclick="getBoard1(2)">데이터 불러오기</button>
	</div>
	<p id="demo1_con"></p>
	<hr><br><br>
	
	<h2>ajax Object 받기</h2>
	<table id = "status">
	<tr><th>번호</th><th>제목</th><th>작성자</th></tr>
	</table>
	<br><br>
	
	<div id = "demo2">
		<button type="button" onclick="getBoard2(2)">데이터 불러오기</button>
	</div><br><br>
	<hr><br><br>
	
	<button onclick="ajaxTest()">테스트</button>
</body>
</html>