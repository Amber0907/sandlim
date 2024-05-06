<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 페이지</title>
</head>
<body>
	<%@ include file="../css/menu.jsp"%>
	<h1>장바구니</h1>
	<h2>주문 메뉴</h2>
	<form action="payOd.san" method="post">
		<c:forEach items="${cartList}" var="cartMenu">

			<div>
				<input type="checkbox" name="choice">
				<button type="button">x</button>
				<br> <img
					src="${pageContext.request.contextPath }/resources/img/${cartMenu.c_img}"
					alt="${cartMenu}" title="${cartMenu}"
					style="width: 100px; height: 100px">
			</div>
		</c:forEach>

		<button type="submit">주문하기</button>
	</form>
</body>
<%@include file="../css/footer.jsp"%>
</html>