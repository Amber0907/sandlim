<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>USERS 테이블 데이터 삽입 테스트</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
#warningId, #warningPw1, #warningPw2, #warningBirth, #warningNick,
	#warningPhno, #warningEmail, #warningAddr, #warningSameId,
	#warningSamePhno, #warningCheckPhno, #warningNoCheckPhno, #warningName,
	#needPhno {
	display: none;
	color: #f00;
}

#checkPhnoOk {
	display: none;
	color: #0f0;
}
</style>
</head>
<body>
<%@ include file="../css/menu.jsp" %>
	<h1>USERS 테이블 회원가입 테스트</h1>
	<form action="insertUser.do" method="post">
		<!--       <label for="u_no">사용자 번호:</label> <input type="text" id="u_no" name="u_no" required><br> -->

		<label for="u_id">사용자 ID:</label> <input type="text" id="u_id"
			name="u_id" required><br>

		<div id="warningId">아이디는 5글자 이상, 20글자 미만의 영문자 또는 숫자만 가능합니다.</div>

		<div id="warningSameId">해당 아이디는 이미 존재합니다.</div>

		<label for="u_pw">사용자 비밀번호:</label> <input type="password" id="u_pw"
			name="u_pw" required><br> <label for="u_pw2">비밀번호
			확인:</label> <input type="password" id="u_pw2" name="u_pw2" required><br>

		<div id="warningPw1">8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</div>
		<div id="warningPw2">비밀번호가 일치하지 않습니다.</div>

		<label for="u_nick">사용자 닉네임:</label> <input type="text" id="u_nick"
			name="u_nick" required><br>
		<div id="warningNick">닉네임은 1글자 이상 10글자 미만의 한글, 영문, 숫자로 가능합니다.</div>

		<label for="u_name">사용자 이름:</label> <input type="text" id="u_name"
			name="u_name" required><br>

		<div id="warningName">올바른 이름을 입력해주세요.</div>

		<label for="u_phno">사용자 휴대폰 번호:</label> <input type="text" id="u_phno"
			name="u_phno" required placeholder="010-1234-5678"><br>

		<div id="needPhno">전화번호를 입력해주세요.</div>

		<div id="warningSamePhno">이미 등록된 전화번호입니다.</div>

		<div id="warningPhno">올바른 형식인지 확인해주세요.</div>


		<button type="button" onclick="sendCheck()">인증번호 발송</button>
		<br> <label for="checkPhnoNum">인증번호:</label> <input type="text"
			id="checkPhnoNum" name="checkPhnoNum"><br>

		<button type="button" onclick="checkPhno()">인증번호 확인</button>
		<br>

		<div id="timer"></div>
		<div id="checkPhnoOk">인증이 완료되었습니다.</div>
		<div id="warningCheckPhno">인증번호가 같지 않습니다.</div>

		<label for="u_addr">사용자 주소:</label> <input type="text" id="postcode"
			name="postcode" placeholder="우편번호" required readonly> <input
			type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="address" placeholder="주소" required readonly><br>
		<input type="text" id="detailAddress" placeholder="상세주소"><br>
		<div id="warningAddr">주소를 입력해주세요.</div>
		<input type="hidden" id="u_addr" name="u_addr"> <label
			for="u_birth">사용자 생년월일:</label> <input type="text" id="u_birth"
			name="u_birth" required placeholder="0000-00-00"><br>
		<div id="warningBirth">0000-00-00 형식으로 작성해주세요.</div>
		
		<input type="hidden" id="u_point" name="u_point" value="0">
		<input type="hidden" id="u_status" name="u_status" value="U">

		<label for="u_email">사용자 이메일:</label> <input type="text" id="u_email"
			name="u_email" required><br>
		<div id="warningEmail">이메일을 올바른 형식으로 작성해주세요.</div>
		<button type="submit">테스트</button>
		<div id="warningNoCheckPhno">번호 인증을 진행해주세요.</div>
	</form>

	<script>
		var checkNum;
		var validateSameIdCheck;
		var validateSamePhnoCheck;
		var checkPhnoResult = false;

		var timeoutId;
		var countdownId;
		var remainingTime;

		function resetRemTime() {
			remainingTime = 180;
		}

		document.getElementById("u_id").addEventListener("blur", validateId);

		document.getElementById("u_id")
				.addEventListener("blur", validateSameId);

		document.getElementById("u_pw").addEventListener("blur",
				validatePassword);

		document.getElementById("u_pw2").addEventListener("blur",
				validatePasswordMatch);

		document.getElementById("u_nick")
				.addEventListener("blur", validateNick);

		document.getElementById("u_name")
				.addEventListener("blur", validateName);

		document.getElementById("u_phno")
				.addEventListener("blur", validatePhno);
		document.getElementById("u_phno").addEventListener("blur",
				validateSamePhno);
		document.getElementById("u_birth").addEventListener("blur",
				validateBirth);
		document.getElementById("u_email").addEventListener("blur",
				validateEmail);

		function validateId() {
			var userId = document.getElementById("u_id").value;
			var idPattern = /^[a-z0-9_-]{5,20}$/;
			hideWarning("warningId");
			if (!idPattern.test(userId)) {
				document.getElementById("warningId").style.display = "block";
				return false;
			}
			return true;
		}

		function validateName() {
			var userName = document.getElementById("u_name").value;
			var namePattern = /^[a-zA-Z가-힣\s'-]{1,50}$/;
			hideWarning("warningName");
			if (!namePattern.test(userName)) {
				document.getElementById("warningName").style.display = "block";
				return false;
			}
			return true;
		}

		function validateSameId() {
			var userId = document.getElementById("u_id").value;
				$.ajax({
						url : "checkSameId.do",
						type : "post",
						data : JSON.stringify({
							u_id : userId
						}),
						contentType : 'application/json; charset=utf-8',
						cache : false,
						success : function(data) {
							if (data) {
								hideWarning("warningSameId");
								validateSameIdCheck = true;
							} else {
								hideWarning("warningSameId");
								document.getElementById("warningSameId").style.display = "block";
								validateSameIdCheck = false;
							}
						},
						error : function() {
							alert('error');
						}
					});
		}

		function validatePassword() {
			var userPw = document.getElementById("u_pw").value;
			var pwdPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\^\w]).{8,16}$/;
			hideWarning("warningPw1");
			if (!pwdPattern.test(userPw)) {
				document.getElementById("warningPw1").style.display = "block";
				return false;
			}
			return true;
		}

		function validatePasswordMatch() {
			var pw = document.getElementById("u_pw").value;
			var pw2 = document.getElementById("u_pw2").value;
			hideWarning("warningPw2");
			if (pw !== pw2) {
				document.getElementById("warningPw2").style.display = "block";
				return false;
			}
			return true;
		}

		function validateNick() {
			var userNick = document.getElementById("u_nick").value;
			var nickPattern = /^[가-힣a-zA-Z0-9_]{1,10}$/;
			hideWarning("warningNick");
			if (!nickPattern.test(userNick)) {
				document.getElementById("warningNick").style.display = "block";
				return false;
			}
			return true;
		}

		function validatePhno() {
			var userPhno = document.getElementById("u_phno").value;
			var phoneNoPattern = /^01[0-9]{1}-[0-9]{3,4}-[0-9]{4}$/;
			hideWarning("warningPhno");
			hideWarning("needPhno");
			if (!phoneNoPattern.test(userPhno)) {
				document.getElementById("warningPhno").style.display = "block";
				return false;
			}
			return true;
		}

		function validateSamePhno() {
			var userPhno = document.getElementById("u_phno").value;
			$
					.ajax({
						url : "checkSamePhno.do",
						type : "post",
						data : JSON.stringify({
							u_phno : userPhno
						}),
						contentType : 'application/json; charset=utf-8',
						cache : false,
						success : function(data) {
							if (data) {
								hideWarning("warningSamePhno");

								validateSamePhnoCheck = true;
							} else {
								hideWarning("warningSamePhno");
								document.getElementById("warningSamePhno").style.display = "block";
								validateSamePhnoCheck = false;
							}
						},
						error : function() {
							alert('error');
						}
					});

		}

		function sendCheck() {
			// 이전 요청이 있다면 취소
			if(timeoutId) clearTimeout(timeoutId);
		    if(countdownId) clearInterval(countdownId);
		    
			var userPhno = document.getElementById("u_phno").value;

			if (validateSamePhnoCheck && validatePhno()) {

				hideWarning("needPhno");

				$.ajax({
					url : "checkRealPhno.do",
					type : "post",
					data : JSON.stringify({
						u_phno : userPhno
					}),
					contentType : 'application/json; charset=utf-8',
					cache : false,
					success : function(data) {

						hideWarning("warningNoCheckPhno");

						checkNum = data;
						
						resetRemTime();
						document.getElementById('timer').textContent = "3:00";
						// 인증 코드 요청이 성공했을 때 시간제한 설정
						startTimer();

					},
					error : function() {
						alert('error');
					}
				});

			} else {

				document.getElementById("needPhno").style.display = "block";

			}

		}

		function startTimer() {
			// 인증 코드가 만료되면 실행될 콜백 함수
			var onTimeout = function() {
				checkNum = null;
				alert('인증 시간이 만료되었습니다.');
			};

			// 인증 코드 요청 후 5분 후에 onTimeout 실행
			timeoutId = setTimeout(onTimeout, 3 * 60 * 1000);

			// 매 초마다 타이머 업데이트
			countdownId = setInterval(function() {
				remainingTime--;
				var minutes = Math.floor(remainingTime / 60);
				var seconds = remainingTime % 60;
				document.getElementById('timer').textContent = minutes + ':'
						+ (seconds < 10 ? '0' : '') + seconds;
				if (remainingTime <= 0) {
					clearInterval(countdownId);
				}
			}, 1000);
		}

		function checkPhno() {

			var checkNum1 = document.getElementById("checkPhnoNum").value;

			console.log(checkNum);
			console.log(checkNum1);

			if (checkNum === checkNum1) {
				hideWarning("warningCheckPhno");
				hideWarning("warningNoCheckPhno");
				document.getElementById("checkPhnoOk").style.display = "block";

				clearTimeout(timeoutId); // 시간제한 해제
				clearInterval(countdownId); // 타이머 해제
				document.getElementById('timer').textContent = "";

				document
						.querySelector("button[type='button'][onclick='checkPhno()']").disabled = true;

				document
						.querySelector("button[type='button'][onclick='sendCheck()']").disabled = true;

				checkPhnoResult = true;
			} else {
				document.getElementById("warningCheckPhno").style.display = "block";
				checkPhnoResult = false;
			}

		}

		function validateBirth() {
			var userBirth = document.getElementById("u_birth").value;
			var birthPattern = /^\d{4}-\d{2}-\d{2}$/;
			hideWarning("warningBirth");
			if (!birthPattern.test(userBirth)) {
				document.getElementById("warningBirth").style.display = "block";
				return false;
			}
			return true;
		}

		function validateEmail() {
			var userEmail = document.getElementById("u_email").value;
			var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			hideWarning("warningEmail");
			if (!emailPattern.test(userEmail)) {
				document.getElementById("warningEmail").style.display = "block";
				return false;
			}
			return true;
		}

		function validateAddr() {
			var postcode = document.getElementById('postcode').value;
			var address = document.getElementById('address').value;
			var detailAddress = document.getElementById('detailAddress').value;
			hideWarning("warningAddr");
			if (postcode === "" || address === "") {
				document.getElementById("warningAddr").style.display = "block";
				return false;
			}
			return true;
		}

		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.userSelectedType === 'R' ? data.roadAddress
							: data.jibunAddress;
					var fullAddress = data.zonecode + ' ' + addr;
					var detailAddress = document
							.getElementById("detailAddress").value;
					if (detailAddress) {
						fullAddress += ', ' + detailAddress;
					}
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("address").value = addr;
					document.getElementById("u_addr").value = fullAddress;
					hideWarning("warningAddr");
				}
			}).open();
		}

		function hideWarning(warningId) {
			document.getElementById(warningId).style.display = "none";
		}

		document.querySelector("form").onsubmit = function(e) {

			if (!validateId() || !validateName() || !validateSameIdCheck
					|| !validatePassword() || !validatePasswordMatch()
					|| !validateNick() || !validatePhno()
					|| !validateSamePhnoCheck || !validateBirth()
					|| !validateEmail() || !validateAddr() || !checkPhnoResult) {

				if (!checkPhnoResult) {
					document.getElementById("warningNoCheckPhno").style.display = "block";
				}

				console.log('가입실패');

				e.preventDefault();
			}

			console.log('가입성공');
		};
	</script>
</body>
</html>