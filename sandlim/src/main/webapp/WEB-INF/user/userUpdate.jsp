<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>정보수정</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/signup.css">
</head>
<%@ include file="../css/header.jsp"%>
<body>
	<div class="container">
		<h1 class="signup">USERS 정보수정 테스트</h1>
		<form action="userUpdate.do" method="post">

			<label for="u_id">사용자 ID:</label> <input type="text" id="u_id"
				name="u_id" value="${user.u_id}" readonly><br> <label
				for="u_pw">새 비밀번호:</label> <input type="password" id="u_pw"
				name="u_pw" maxlength="30">

			<div id="warningPw1">8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</div>

			<br> <label for="u_pw2">비밀번호 확인:</label> <input type="password"
				id="u_pw2" name="u_pw2" maxlength="30"><br>

			<div id="warningPw2">비밀번호가 일치하지 않습니다.</div>

			<label for="u_nick">닉네임:</label> <input type="text" id="u_nick"
				name="u_nick" required maxlength="30" autocomplete="off"
				value="${user.u_nick}"><br>

			<div id="warningNick">닉네임은 1글자 이상 10글자 미만의 한글, 영문, 숫자로 가능합니다.</div>

			<label for="u_name">사용자 이름:</label> <input type="text" id="u_name"
				name="u_name" value="${user.u_name}" readonly><br> <label
				for="u_phno">사용자 휴대폰 번호:</label> <input type="text" id="u_phno"
				name="u_phno" required maxlength="11" autocomplete="off"
				value="${user.u_phno}"><br>

			<div id="needPhno">전화번호를 입력해주세요.</div>

			<div id="warningSamePhno">이미 등록된 전화번호입니다.</div>

			<div id="warningPhno">
				올바른 번호를 숫자로 입력해주세요.<br>예시) 01012345678
			</div>

			<button type="button" onclick="sendCheck()">인증번호 발송</button>
			<br> <label for="checkPhnoNum">인증번호:</label> <input type="text"
				id="checkPhnoNum" name="checkPhnoNum" autocomplete="off"
				maxlength="6"><br>

			<button type="button" onclick="checkPhno()">인증번호 확인</button>
			<br>

			<div id="timer"></div>
			<div id="checkPhnoOk">인증이 완료되었습니다.</div>
			<div id="warningCheckPhno">인증번호가 일치하지 않습니다.</div>

			<label for="u_phno">현재 주소:</label> <input type="text" id="u_addr2"
				name="u_addr2" autocomplete="off" value="${user.u_addr}" readonly><br>

			<label for="u_addr">새 주소:</label> <input type="text" id="postcode"
				name="postcode" placeholder="우편번호" readonly> <input
				type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="address" placeholder="주소" readonly><br>
			<input type="text" id="detailAddress" maxlength="100"
				autocomplete="off" placeholder="상세주소"><br>

			<div id="warningAddr">우편번호 찾기를 통해, 주소를 입력해주세요.</div>
			<input type="hidden" id="u_addr" name="u_addr"> <label
				for="u_birth">사용자 생년월일:</label> <input type="text" id="u_birth"
				name="u_birth" value="${user.u_birth}" readonly><br> <label
				for="u_email">이메일:</label> <input type="text" id="u_email"
				name="u_email" maxlength="100" autocomplete="off" required
				value="${user.u_email}"><br>

			<div id="warningSameEmail">이미 등록된 이메일입니다.</div>

			<div id="warningEmail">이메일을 올바른 형식으로 작성해주세요.</div>

			<c:choose>
				<c:when test="${userStatus eq '관리자' }">
					<select class="form-control innm" id="u_status" name="u_status"
						required>
						<option disabled>권한 수정</option>
						<option value="일반유저"
							<c:if test="${user.u_status eq '일반유저' }">selected</c:if>>일반유저</option>
						<option value="스태프"
							<c:if test="${user.u_status eq '스태프' }">selected</c:if>>스태프</option>
						<option value="관리자"
							<c:if test="${user.u_status eq '관리자' }">selected</c:if>>관리자</option>
					</select>
				</c:when>
			</c:choose>

			<button type="submit">정보수정</button>

			<div id="warningNoCheckPhno">번호 인증을 진행해주세요.</div>
		</form>
	</div>
	<!-- 	<script src="/resources/js/validate.js"></script> -->
	<script>
		var checkNum;
		var validateSamePhnoCheck;
		var validateSameEmailCheck;
		var checkPhnoResult = false;

		var timeoutId;
		var countdownId;
		var remainingTime;

		function resetRemTime() {
			remainingTime = 180;
		}

		document.getElementById("u_pw").addEventListener("blur",
				validatePassword);

		document.getElementById("u_pw2").addEventListener("blur",
				validatePasswordMatch);

		document.getElementById("u_nick")
				.addEventListener("blur", validateNick);

		document.getElementById("u_phno")
				.addEventListener("blur", validatePhno);

		document.getElementById("u_phno").addEventListener("blur",
				validateSamePhno);

		document.getElementById("u_email").addEventListener("blur",
				validateEmail);

		document.getElementById("u_email").addEventListener("blur",
				validateSameEmail);

		function validatePassword() {
			var userPw = document.getElementById("u_pw").value;
			var pwdPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\^\w]).{8,16}$/;
			hideWarning("warningPw1");

			if (userPw.trim() != "") {

				if (!pwdPattern.test(userPw)) {
					document.getElementById("warningPw1").style.display = "block";
					return false;
				}

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
			var phoneNoPattern = /^01[0-9]{1}[0-9]{3,4}[0-9]{4}$/;
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

		function validateSameEmail() {
			var userEmail = document.getElementById("u_email").value;
			$
					.ajax({
						url : "checkSameEmail.do",
						type : "post",
						data : JSON.stringify({
							u_email : userEmail
						}),
						contentType : 'application/json; charset=utf-8',
						cache : false,
						success : function(data) {
							if (data) {
								hideWarning("warningSameEmail");
								validateSameEmailCheck = true;
							} else {
								hideWarning("warningSameEmail");
								document.getElementById("warningSameEmail").style.display = "block";
								validateSameEmailCheck = false;
							}
						},
						error : function() {
							alert('error');
						}
					});

		}

		function sendCheck() {
			// 이전 요청이 있다면 취소
			if (timeoutId)
				clearTimeout(timeoutId);
			if (countdownId)
				clearInterval(countdownId);

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

				document.getElementById("checkPhnoNum").readOnly = true;

				checkPhnoResult = true;
			} else {
				document.getElementById("warningCheckPhno").style.display = "block";
				checkPhnoResult = false;
			}

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

		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.userSelectedType === 'R' ? data.roadAddress
							: data.jibunAddress;
					var detailAddress = document
							.getElementById("detailAddress").value;
					var fullAddress = data.zonecode + ' ' + addr;

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

		function validateAddr() {
			var postcode = document.getElementById('postcode').value;
			var address = document.getElementById('address').value;
			var detailAddress = document.getElementById('detailAddress').value;
			var fullAddress = postcode + address;
			
			if (detailAddress) {
				fullAddress += ', ' + detailAddress;
			}
			
			
			document.getElementById("u_addr").value = fullAddress;
			
			hideWarning("warningAddr");
			
			if (postcode === "" || address === "") {
				document.getElementById("warningAddr").style.display = "block";
				fullAddress = document.getElementById('u_addr2').value;
			}

			return true;
		}

		function hideWarning(warningId) {
			document.getElementById(warningId).style.display = "none";
		}

		document.querySelector("form").onsubmit = function(e) {

			validatePassword();
			if (!validatePassword()) {
				console.log('비밀번호 형식 문제');
				e.preventDefault();
			}

			validatePasswordMatch();
			if (!validatePasswordMatch()) {
				console.log('비밀번호 확인 문제');
				e.preventDefault();
			}

			validatePhno();
			if (!validatePhno()) {
				console.log('번호 문제');
				e.preventDefault();
			}

			validateSamePhno();
			if (!validateSamePhnoCheck) {
				console.log('번호 중복 문제');
				document.getElementById("warningSamePhno").style.display = "block";
				e.preventDefault();
			}

			if (!checkPhnoResult) {
				console.log('번호인증문제');
				document.getElementById("warningNoCheckPhno").style.display = "block";
				e.preventDefault();
			}

			validateAddr();
			if (!validateAddr()) {
				console.log('주소 문제');
				e.preventDefault();
			}

			validateEmail();
			if (!validateEmail()) {
				console.log('이메일 문제');
				e.preventDefault();
			}

			validateSameEmail();
			if (!validateSameEmailCheck) {
				console.log('이메일 중복 문제');
				document.getElementById("warningSameEmail").style.display = "block";
				e.preventDefault();
			}

			console.log('변경성공');
			e.preventDefault();
		};
	</script>
</body>
</html>