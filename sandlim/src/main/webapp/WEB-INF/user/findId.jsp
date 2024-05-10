<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>아이디찾기 테스트 페이지입니다</h1>

	<div>
	    <label for="u_name">사용자 이름:</label>
        <input type="text" id="u_name" name="u_name" required>
    </div>

    <div>
	  	<form onsubmit="event.preventDefault(); requestEmailVerification();">
	    <label for="u_email">사용자 이메일:</label>
	    <input type="email" id="u_email" name="u_email" required>
	    <button type="submit">이메일 인증</button>
	  </form>
	</div>
    
	<div>
	    <label for="verification_code">인증 코드:</label>
	    <input type="text" id="verification_code" name="verification_code">
	    <button onclick="verifyCode()">인증 확인</button>
		<div id="timer"></div>
	</div>
	
	<button onclick="requestUserId()">아이디 주세요!!</button>
	
	<div id="userIdDisplay"></div>
	<br><br><br>
	<button onclick="window.location.href='main.jsp'">메인으로</button>
	

</body>

<script>
	var verCode = null;
	var timeoutId;
	var countdownId;
	var remainingTime;
	var chkEmail = false;
	
	
	function resetRemTime(){
		remainingTime = 300;
	}
	
	function requestEmailVerification() {
		// 이전 요청이 있다면 취소
	    if(timeoutId) clearTimeout(timeoutId);
	    if(countdownId) clearInterval(countdownId);
		
	    var email = document.getElementById('u_email').value;
		
	    // 서버에 이메일 인증 코드 요청
	    $.ajax({
	        url : "EmailVerification.do",
	        type : "post",
	        data : JSON.stringify({u_email : email}),
	        contentType : 'application/json; charset=utf-8',
	        cache : false,
	        success : function(data) {
	            alert('인증 코드를 발송했습니다. 이메일을 확인해주세요.');
	            resetRemTime();
	            verCode = data;
	            document.getElementById('timer').textContent = "5:00";
	            // 인증 코드 요청이 성공했을 때 시간제한 설정
	            startTimer();
	        },
	        error : function() {
	            alert('인증 코드 발송에 실패했습니다.');
	        }
	    });
	}
	
	function verifyCode() {
	    if (!verCode) {
	        alert('인증 코드를 먼저 요청해주세요.');
	        return;
	    }
	
	    var code = verCode;
	    var userCode = document.getElementById('verification_code').value;
	
	    // 서버에 이메일 인증 요청
	    $.ajax({
	        url : "verifyCode.do",
	        type : "post",
	        data : JSON.stringify({ emailCode : code, inputCode :  userCode}),
	        contentType : 'application/json; charset=utf-8',
	        success : function(data) {
	            if(data) {
	                alert('인증에 성공했습니다.');
	                clearTimeout(timeoutId); // 시간제한 해제
	                clearInterval(countdownId); // 타이머 해제
	                document.getElementById('timer').textContent = "";
	                chkEmail = true;
	            } else {
	                alert('입력하신 인증 코드가 일치하지 않습니다.');
	            }
	        },
	        error : function(xhr, status, error) {
	            alert('인증에 실패했습니다: ' + error);
	        }
	    });
	}

    
    function startTimer() {
        // 인증 코드가 만료되면 실행될 콜백 함수
        var onTimeout = function() {
            verCode = null;
            alert('인증 시간이 만료되었습니다.');
        };

        // 인증 코드 요청 후 5분 후에 onTimeout 실행
        timeoutId = setTimeout(onTimeout, 5 * 60 * 1000);

        // 매 초마다 타이머 업데이트
        countdownId = setInterval(function() {
        	remainingTime--;
            var minutes = Math.floor(remainingTime / 60);
            var seconds = remainingTime % 60;
            document.getElementById('timer').textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            if (remainingTime <= 0) {
                clearInterval(countdownId);
                resetRemTime();
            }
        }, 1000);
    }
    
    
    // 유저아이디 반환
    function requestUserId() {
    	
    	if(chkEmail){
	        var userName = document.getElementById('u_name').value;
	        var userEmail = document.getElementById('u_email').value;
	        // 서버에 아이디 요청
	        $.ajax({
	            url : "FindIdOutput.do",
	            type : "post",
	            data : JSON.stringify({u_name : userName, u_email : userEmail}),
	            contentType : 'application/json; charset=utf-8',
	            cache : false,
	            success : function(data) {
	            	console.log("userName: "+userName);  // userName 값 확인
	            	console.log("data: "+data);
	            	if(userName == "" || data == ""){
	            		alert('이름을 확인해주세요');
	            	}else{
	            		document.getElementById('userIdDisplay').textContent = '아이디는 ' + data + ' 입니다.';
	            	}
	            },
	            error : function() {
	                alert('아이디 찾기에 실패했습니다.');
	            }
	        });
    	}else {
    		alert('이메일 인증을 먼저 진행해주세요');
    	}
    	
    }
</script>

</html>