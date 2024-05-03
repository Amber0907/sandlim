<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<style>
#searchNav{-webkit-justify-content: flex-end; justify-content: flex-end; }
</style>
<body>
<%@ include file="../css/menu.jsp" %>
<div class="jumbotron">
   <h1>회원목록</h1>      
</div>
<%@ include file="../css/menu.jsp" %>
<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
  <form class="form-inline" action="userList.do" method="post">
    <input class="form-control mr-sm-2" type="text" name="searchKeyword" placeholder="아이디나 이름을 입력하세요.">
    <button class="btn btn-success" type="submit">검색</button>
  </form>
</nav>
<div class="container-fluid">
  <table class="table table-hover">
    <thead class="btn-primary">
      <tr>
        <th>아이디</th>
        <th>비밀번호</th>
        <th>이름</th>
        <th>역할</th>
      </tr>
    </thead>
    <tbody>
<c:forEach items="${userList}" var="user">
	<tr onclick="selUser('${user.id}')" style="cursor:pointer;">
	  <td class="tdCenter">${user.id}</td>
	  <td>${user.name}</td>
	  <td class="tdCenter">${user.name}</td>
	  <td class="tdCenter">${user.role}</td>
	</tr>
</c:forEach>
    </tbody>
  </table><br><br>
</div>

</body>
</html>
