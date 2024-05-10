<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#warningPw1, #warningPw2 {
    display: none;
    color: #f00;
}
</style>

</head>
<body>
	<h1>비밀번호 재설정 페이지입니다</h1>
		u_id의 값: ${u_id}
	<div>
		<form action="resetPw.do" id="resetPasswordForm" method="post">
			<label for="u_pw">새 비밀번호:</label> <input type="password" id="u_pw" name="u_pw" required> 
			<label for="u_pw2">비밀번호 확인:</label> <input type="password" id="u_pw2" name="u_pw2" required>
			<input type="hidden" id="u_id" name="u_id" value="${u_id}">
			<button type="submit">비밀번호 변경</button>
		</form>
	</div>
	<div id="warningPw1">8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해주세요.</div>
	<div id="warningPw2">비밀번호가 일치하지 않습니다.</div>
	
</body>
<script>

	document.getElementById("u_pw").addEventListener("blur", validatePassword);
	document.getElementById("u_pw2").addEventListener("blur", validatePasswordMatch);
	
	var form = document.getElementById('resetPasswordForm');
	form.addEventListener('submit', function(event) {
	    if (!validatePassword() || !validatePasswordMatch()) {
	        event.preventDefault();
	    }
	});

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
	
	function hideWarning(warningId) {
		document.getElementById(warningId).style.display = "none";
	}
</script>
</html>