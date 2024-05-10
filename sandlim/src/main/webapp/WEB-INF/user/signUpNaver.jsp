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
	<h2>필수 입력정보을 입력해주세요.</h2>
	<form action="/insertUser.do" method="post">
	
		<input type="hidden" name="u_id" value="${user.u_id}">
		<input type="hidden" name="u_pw" value="${user.u_pw}">
		<input type="hidden" name="u_phno" value="${user.u_phno}">
		<input type="hidden" name="u_birth" value="${user.u_birth}">
		<input type="hidden" name="u_social" value="${user.u_social}">
	
		<label for="u_nick">사용자 닉네임:</label> <input type="text" id="u_nick" name="u_nick" required maxlength="30" autocomplete="off"><br>
		<div id="warningNick">닉네임은 1글자 이상 10글자 미만의 한글, 영문, 숫자로 가능합니다.</div>
		
		<label for="u_name">사용자 이름:</label> <input type="text" id="u_name" name="u_name" required maxlength="30" autocomplete="off"><br>
		<div id="warningName">올바른 이름을 입력해주세요.</div>
		
		<label for="u_email">사용자 이메일:</label> <input type="text" id="u_email" name="u_email" maxlength="100" autocomplete="off" required><br>
		<div id="warningSameEmail">이미 등록된 이메일입니다.</div>
		<div id="warningEmail">이메일을 올바른 형식으로 작성해주세요.</div>
		
		<button type="submit">회원가입</button>
	</form>
	
</body>
<script>
var validateSameEmailCheck;

document.getElementById("u_nick").addEventListener("blur", validateNick);
document.getElementById("u_name").addEventListener("blur", validateName);
document.getElementById("u_email").addEventListener("blur",validateEmail);
document.getElementById("u_email").addEventListener("blur",validateSameEmail);

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


function validateSameEmail() {
	var userEmail = document.getElementById("u_email").value;
	$.ajax({
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

document.querySelector("form").onsubmit = function(e) {
	validateNick();
	if (!validateNick()) {
		console.log('닉네임 문제');
		e.preventDefault();
	}
	
	validateName();
	if (!validateName()) {
		console.log('이름 문제');
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
};

</script>
		

</html>

