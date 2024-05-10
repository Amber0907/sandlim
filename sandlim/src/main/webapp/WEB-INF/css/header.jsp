<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>

#name {
color : #c79c79;
font-weight: bold;
text-decoration: underline;
text-decoration-color: #c79c79;
}
.navbar-nav.nav-right {
    margin: 0;
}
.navbar-nav li.nav-item {
flex-grow: 1;
}
</style>
<meta charset="UTF-8">
<title>산들림 홈페이지</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/test.css">
  <script src="${pageContext.request.contextPath }/resources/js/san.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/test.js"></script>
  <link href="${pageContext.request.contextPath }/resources/css/test.css" media="screen and (min-width: 400px) and (max-width: 1000px)" rel="stylesheet">
 
</head>

<!-- <nav id="stNav" class="navbar navbar-expand-sm justify-content-center"> -->
<nav id="stNav" class="navbar navbar-expand-sm" style=" justify-content: center; align-items: center;">
<%-- <a href="main.jsp"><img class="nvlog" id="nvlog" src="${pageContext.request.contextPath }/resources/img/logo.png" alt="sandlim" title="sandlim" style="margin-left:280px;height:40px;"></a> --%>
<a href="main.jsp" style="flex-grow: 1;" ><img class="nvlog" id="nvlog" src="${pageContext.request.contextPath }/resources/img/logo.png" alt="sandlim" title="sandlim" style="height:40px;"></a>
  <ul class="navbar-nav" style="flex-grow: 1;">
    <li class="nav-item">
<!--     <li class="nav-item" style="margin-left:110px"> -->
      <a class="nav-link" href="getAbout.do">ABOUT</a>
    </li>    
    <li class="nav-item">
      <a class="nav-link" href="selectList.san">MENU</a>
    </li>    
    <li class="nav-item">
      <a class="nav-link" href="getReview.do">REVIEW</a>
    </li>    
    <li class="nav-item">
      <a class="nav-link" href="getFaq.do">FAQ</a>
    </li>    
    <li class="nav-item">
      <a class="nav-link" href="getBoardList.do">NEWS</a>
    </li>    
  </ul>
 <c:choose>
 	<c:when test='${userId ne NULL}' >
 		<ul class="navbar-nav nav-right">    
<!--  		<ul class="navbar-nav nav-right" style="margin-right:300px;">     -->
		    <li class="nav-item" ><a class="nav-link" href="selUser.do"><span id="name">${userName}</span></a></li>
		    <small style="margin-top:11px;"> 님</small>
		   		<li class="nav-item">
		   		   <a class="nav-link" href="getCartList.san">Cart</a>
		   		</li>
<!-- 		   		<li class="nav-item"> -->
<!-- 		   		   <a class="nav-link" href="selUser.do">MyPage</a> -->
<!-- 		   		</li> -->
		    <li class="nav-item">
		      <a class="nav-link" href="logout.do"><small>logOut</small></a>
		    </li>
		  </ul>
 	</c:when>
 	<c:otherwise>
 		<ul class="navbar-nav nav-right" style="flex-grow: 1;">    
<!-- 		   <li class="nav-item" style="margin-right:300px;"> -->
		   <li class="nav-item" >
		     <a class="nav-link" href="login.do"><small>Sign In</small></a>
		   </li>
		 </ul>
 	</c:otherwise>
 </c:choose>
</nav>

	<nav id="subNav" class="navbar navbar-expand-sm">
	  <a class="navbar-brand" href="main.jsp"><img class="nvlog" id="nvlog" src="${pageContext.request.contextPath }/resources/img/logo.png" alt="sandlim" title="sandlim" style=" width: 120px; height:30px;"></a>
	  <ul class="navbar-nav nav-right">  
	    <li id="clMenu" class="nav-item">
	  <a class="nav-link" href="selUser.do"><img src="${pageContext.request.contextPath }/resources/img/free-icon-font-user-3917711.png" alt="회원" title="회원" style="width: 32px; height:32px;"></a>  
	    </li>
	    <li id="clMenu" class="nav-item">
	  <img src="${pageContext.request.contextPath }/resources/img/free-icon-font-menu-burger-3917762.png" alt="메뉴" title="메뉴" style="width: 32px; height:32px;">
	    </li>
	  </ul>
	</nav>
	
<!-- <div id="subNav" class="navbar navbar-expand-sm bg-light fixed-top"> -->
<!-- <div id="subNav"> -->
<!--   <ul > -->
<!--     <li > -->
<!-- <!--       <a class="nav-link" href="#"><i class="bi bi-house"></i></a> --> 
<!--       <a href="#"><i class="fas fa-home"></i></a> -->
<!--     </li> -->
<!--     <li > -->
<!--       <a  href="#"><i class="bi bi-person"></i></a> -->
<!--     </li> -->
<!--     <li > -->
<!--       <a  href="#"> <i class="fas fa-bars"></i></a> -->
<!--     </li> -->
<!--   </ul> -->
<!-- </div> -->
<!-- 	풀화면 일 때 보여지는 네비메뉴  -->
<!-- 	<div id="subNavMenu" style="top:55.82px;" class="container-fluid bg-primary navbar-dark fixed-top"> -->
<!-- 	  <ul class="navbar-nav nav-right">   -->
<%-- 		<c:choose> --%>
<%-- 		 	<c:when test='${userId ne NULL}' > --%>
	    
<%-- 	       	<c:choose> --%>
<%-- 		   	<c:when test = "${userStatus eq 'A'}"> --%>
<!-- 		   		<li class = "nav-item"> -->
<!-- 		   		   <a class="nav-link" href="adminPage.san">관리자페이지</a> -->
<!-- 		   		</li> -->
<%-- 		   	</c:when> --%>
<%-- 		   	<c:when test = "${userStatus eq 'S'}"> --%>
<!-- 		   		<li class = "nav-item"> -->
<!-- 		   		   <a class="nav-link" href="adminPage.san">관리자페이지</a> -->
<!-- 		   		</li> -->
<%-- 		   	</c:when> --%>
		   	
<%-- 		   		<c:otherwise> --%>
<!-- 		   		<li class="nav-item"> -->
<!-- 		   		   <a class="nav-link" href="getCartList.san">장바구니</a> -->
<!-- 		   		</li> -->
<!-- 		   		<li class="nav-item"> -->
<%-- 		   		   <a class="nav-link" href="selUser.do?id=${userId}">나의정보</a> --%>
<!-- 		   		</li> -->
<%-- 		   		</c:otherwise> --%>
<%-- 		   	</c:choose> --%>
	   
<!-- 	    <li class="nav-item"> -->
<!-- 	      <a class="nav-link" href="logout.do">로그아웃</a> -->
<!-- 	    </li> -->
<%-- 		 	</c:when> --%>
<%-- 		 	<c:otherwise> --%>
<!-- 	   	<li class="nav-item"> -->
<!-- 	     <a class="nav-link" href="login.do">로그인</a> -->
<!-- 	   	</li> -->
<%-- 		 	</c:otherwise> --%>
<%-- 		</c:choose>  --%>
<!-- 	  </ul> -->
<!-- 	</div> -->
<br><br>