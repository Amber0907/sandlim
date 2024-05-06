<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../WEB-INF/css/header.jsp"%>

<body>
	<div class="jumbotron">
		<h1>환영합니다.</h1>
	</div>

	<h1>값 체크</h1>
<%-- 	<p>userId: ${sessionScope.userId}</p> --%>
<%-- 	<p>userName: ${sessionScope.userName}</p> --%>
<%-- 	<p>userStatus: ${sessionScope.userStatus}</p> --%>

	<%@ include file="../WEB-INF/css/menu.jsp"%>
	<p id="timeBox"></p>

	<ul class="navbar-nav">
		<li class="nav-item"><a class="nav-link" href="adminPage.san">adminWork페이지</a></li>
		
		<li class="nav-item"><a class="nav-link" href="selectList.san">상품목록</a></li>
		<li class="nav-item"><a class="nav-link" href="pay">결제 테스트 페이지</a></li>
		
<!-- 		관리자 메뉴들은 adminWork 연결해놓긴 했어요  -->
		<li class="nav-item"><a class="nav-link" href="insert.san">관리자 상품등록</a> </li>
		<li class="nav-item"><a class="nav-link" href="adminMd.san">관리자 상품관리</a></li>
		<li class="nav-item"><a class="nav-link" href="adminOd.san">관리자 주문관리(결제취소)</a></li>

	</ul>

	<%@include file="../WEB-INF/css/footer.jsp"%>
</body>
</html>