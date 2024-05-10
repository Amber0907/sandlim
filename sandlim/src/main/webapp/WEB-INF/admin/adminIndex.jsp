<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/test.css">
  <script src="${pageContext.request.contextPath }/resources/js/san.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/test.js"></script>
<title>Insert title here</title>
<style>
.idxbody {
	width: 200px;
	padding-left: 20px;
	float: left;
	display: flex;
	background-color: #272727;
	color: #f9f5f2;
	/* height:100vh; */
	font-size: 15px;
}

ul {
	list-style: none;
	padding: 0
}

.idxhd {
	display: flex;
	background-color: #272727;
	color: #f9f5f2;
	align-items: center;
	padding: 8px;
}

.move {
	padding-left: 100px;
	background-color: #272727;
	color: #f9f5f2;
}

.info {
	background-color: #272727;
	color: #f9f5f2;
	display:flex;
	margin-left:auto;
}

li {
	margin-top: 15px;
}

a {
	text-decoration: none;
	color: #f9f5f2;
}

h3 {
	margin: 8px 0;
}
</style>
</head>
<body>
<div class="idxhd">
	<h3 style="color:#f9c25c">관리자센터</h3>
	<div class="move">
	<a>산들림 홈페이지로 이동></a>&nbsp;&nbsp;
	
	</div>
	<div class="info">
	<a>${userName} 님</a>&nbsp;&nbsp;
	<a href="adminLogout.do">로그아웃</a>
	</div>
</div>
<div class="idxbody">
	<div>
	<ul>
	<li><br><br><br></li>
	<li><a href="adminWork.do">관리자 메뉴얼</a></li>
	<li><br></li>
	<li class="menu">회원관리></li>
	<li><a href="userList.do">- 회원관리</a></li>
	<li><a href="userList.do">- 회원검색</a></li>
	<li class="menu">상품검색></li>
	<li><a href="adminMd.san">- 상품조회/수정</a></li>
	<li><a href="adminMd.san">- 상품등록</a></li>
	<li class="menu">주문관리></li>
	<li><a href="adminOd.san">- 주문관리</a></li>
	<li><a href="adminOd.san">- 배송관리</a></li>
	<li class="menu">FAQ/리뷰/공지관리></li>
	<li><a href="getBoardList.do">- 공지관리</a></li>
	<li><a href="adminGetFaq.do">- FAQ관리</a></li>
	<li><a href="adminGetReview.do">- 리뷰관리</a></li>
	<li class="menu">통계></li>
	<li><a>-결제건수</a></li>
	<li><a>-결제금액</a></li>
	</ul>
	</div>
</div>
</body>
</html>