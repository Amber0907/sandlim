<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 주문 관리 페이지</title>
</head>
<body>
<%@ include file="../css/menu.jsp" %>
<form>
	<h2>결제내역 관련</h2>
	고유 아이디: <input type="text" name="imp_uid" id="imp_uid" placeholder="imp_uid 입력"><br>
	
	상점 거래 아이디: <input type="text" name="merchant_uid" id="merchant_uid" placeholder="merchant_uid 입력"><br>
	
<!-- 	조건문 걸어야함 현재는 목록 안뜸  -->
	<button id="list_module" type="button" class="btn">결제완료목록조회</button>
	
<!-- 	개별적으로 취소버튼은 생기지만 주문 로직 완료해야 취소 연결 가능  -->
	<button id="all_module" type="button" class="btn">모든목록조회</button>
	
<!-- 	인풋창에 직접 입력하여 취소는 가능하지만 자동화 시키는중  -->
<!-- 	<button id="cancel_module" type="button" class="btn">취소하기</button> -->

	<p id="paylist">
	</p>
	</form>
	  <%@include file="../css/footer.jsp"%>
</body>
</html>