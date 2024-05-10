<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--   <link rel="stylesheet" href="/resources/css/terms.css"> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
	width: 300px;
	max-width: 80%;
	margin: 20px auto;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-top: 350px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.inner-con {
	margin: 0 auto;
}

h3 {
	text-align: center;
}

div>button {
	width: 85px;
	padding: 3px;
	margin-top: 10px;
	display: block;
	margin: 0 auto;
	border: none;
	background-color: #f9f5f2;
	color: #272727;
}

div>button:hover {
	border: none;
	background-color: #272727;
	color: #f9f5f2;
}

.form>div {
	display: flex;
	justify-content: space-between;
	padding-bottom: 13px;
}

.alert {
	color: red;
	font-size: 80%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="inner-con">
			<h3>SANDLIM 관리자페이지</h3>

			<form class="form" action="adminLogin.do" method="post">
				<div>
					<label for="inputUserName">아이디</label>&nbsp; <input type="text"
						placeholder="ID" name="u_id" required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword">비밀번호</label>&nbsp; <input
						type="password" placeholder="Password" name="u_pw" required>
				</div>
				<div>
					<button type="submit">로그인</button>
				</div>
			</form>
		</div>
		<%
		if (request.getSession().getAttribute("userError") != null) {
			session.invalidate();
			out.println("<div class='alert alert-danger'>");
			out.println("아이디와 비밀번호를 확인해 주세요");
			out.println("</div>");
		}
		%>
	</div>

</body>
</html>