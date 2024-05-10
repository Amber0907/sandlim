<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/resources/css/signup.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>사이트에서 사용할 닉네임을 입력해주세요.</h2>
	<form action="/insertUser.do" method="post">
		<input type="hidden" name="u_id" value="${user.u_id}">
		<input type="hidden" name="u_pw" value="${user.u_pw}">
		<input type="hidden" name="u_name" value="${user.u_name}">
		<input type="hidden" name="u_phno" value="${user.u_phno}">
		<input type="hidden" name="u_birth" value="${user.u_birth}">
		<input type="hidden" name="u_email" value="${user.u_email}">
		<input type="hidden" name="u_social" value="${user.u_social}">
	
		<label for="u_nick">사용자 닉네임:</label> <input type="text" id="u_nick" name="u_nick" required maxlength="30" autocomplete="off"><br>
		<div id="warningNick">닉네임은 1글자 이상 10글자 미만의 한글, 영문, 숫자로 가능합니다.</div>
		
		<button type="submit">회원가입</button>
	</form>
</body>
<script>
document.getElementById("u_nick").addEventListener("blur", validateNick);

function hideWarning(warningId) {
	document.getElementById(warningId).style.display = "none";
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

document.querySelector("form").onsubmit = function(e) {
	validateNick();
	if (!validateNick()) {
		console.log('닉네임 문제');
		e.preventDefault();
	}
};

</script>
</html>