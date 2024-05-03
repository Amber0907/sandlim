<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp"%>
<body>
	<%@ include file="../css/menu.jsp"%>
	<div class="jumbotron">
		<h1>로그인</h1>
	</div>
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">로그인</h3>
			<%
			if (request.getSession().getAttribute("userError") != null) {
				session.invalidate();
				out.println("<div class='alert alert-danger'>");
				out.println("아이디와 비밀번호를 확인해 주세요");
				out.println("</div>");
			}
			%>
			<form class="form-signin" action="login.do" method="post">
				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> <input
						type="text" class="form-control" placeholder="ID" name="u_id"
						required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" class="form-control" placeholder="Password"
						name="u_pw" required>
				</div>
				<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>
			</form>
		</div>
	</div>

	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<a href="findId">
				<button class="btn-lg btn-primary btn-block" type="button">아이디
					찾기</button>
			</a> <a href="findPw">
				<button class="btn-lg btn-primary btn-block" type="button">비밀번호
					찾기</button>
			</a> <a href="signUp">
				<button class="btn-lg btn-primary btn-block" type="button">회원
					가입</button>
			</a>
		</div>

		<br><br><br>
		
		<div class="container" align="center">
			<div class="col-md-4 col-md-offset-4">
				<button class="btn-lg btn-primary btn-block" type="button">네이버
					로그인</button>
				<button class="btn-lg btn-primary btn-block" type="button">카카오
					로그인</button>
				<button class="btn-lg btn-primary btn-block" type="button">구글
					로그인</button>
				<button class="btn-lg btn-primary btn-block" type="button">페이스북
					로그인</button>
			</div>
		</div>

	</div>
  <%@include file="../css/footer.jsp"%>
</body>
</html>