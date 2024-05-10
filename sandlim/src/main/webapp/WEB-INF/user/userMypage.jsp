<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<head>
<style>
*{text-decoration:none;}
a{color: black;}
.wrap {
   width: 700px;
   max-width: 100%;
   margin: 0 auto;
   background-color: white;
   height: auto;
/*    border: 1px solid #ccc; */
   padding: 50px;
   box-sizing: border-box;
   position: relative;
   margin-top:30px;
}
div#wrapIn {
    border-top: 1px solid black;
    height: 250px;
    margin: 0 auto;
    border-bottom: 1px solid black;
    padding-left: 30px;
    padding-top: 20px;
    
}

h3 {
	margin: 0 auto;
    font-size: x-large;
/*     text-align: initial; */
    margin-bottom: 20px;
}

div#wrapIn > a {
    display: block;
    text-decoration: none;
    color: black;
    font-weight: normal;
    font-size: 16px;
    margin-bottom: 30px;
}

@media screen and (max-width: 768px) {
.wrap {
	width: 100%;
}

}
</style>
</head>
<body>
<div class="wrap" id="wrap">
	<h3>${userId}님의 마이페이지</h3>
	
	보유 포인트 :&gt; ${user.u_point}<br>
	
	<div id="wrapIn">
		<a href="selUser.do">&gt; 내 정보 </a>

		<a href="getCartList.san">&gt; 장바구니 </a>

		<a href="구매내역 경로">&gt; 구매내역 </a>
	</div>
</div>


</body>
</html>
