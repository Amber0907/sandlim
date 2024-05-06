<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>

<body>
<%@ include file="../css/menu.jsp" %>  
<div class="jumbotron">
   <h1><c:choose><c:when test="${userId eq 'admin' }">회원상세</c:when><c:otherwise>마이페이지</c:otherwise></c:choose></h1>      
</div>
<div class="container-fluid">

  <form name="fm" action="updateUser.do" method="post" onsubmit="return chk()">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">아이디</span>
      </div>
      <input type="text" class="form-control innm" id="id" name="id" value="${user.id}" readonly>      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">비밀번호</span>
      </div>
      <input type="password" class="form-control innm" name="password" value="${user.password}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">이름</span>
      </div>
      <input type="text" class="form-control innm" name="name" value="${user.name}">      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">역할</span>
      </div>
      <c:choose>
	      <c:when test="${userId ne 'admin' }"><input type="text" class="form-control innm" id="role" name="role" value="${user.role}" readonly></c:when>
		  <c:otherwise>
			<select class="form-control innm" id="role" name="role" required>
				<option disabled>역할 선택</option>
				<option value="User" <c:if test="${user.role eq 'User' }">selected</c:if>>사용자</option>
				<option value="Admin" <c:if test="${user.role eq 'Admin' }">selected</c:if>>관리자</option>
			</select>
		  </c:otherwise>
      </c:choose>
    </div>
    <div id="footer">
	  	<button type="submit" class="btn btn-primary">정보수정</button>
	  	<button type="button" class="btn btn-danger" onclick="delUser('${user.id}', 'delUser.do', '관리자는 회원탈퇴를 하실 수 없습니다.')">회원탈퇴</button>
<c:choose>
	<c:when test="${userId eq 'admin' }">
	  	<button type="button" class="btn btn-primary" onclick="javascript:location.href='userList.do';">회원목록</button>
	</c:when>
	<c:otherwise>
	  	<button type="button" class="btn btn-primary" onclick="javascript:location.href='index.jsp';">취소</button>
	</c:otherwise>
</c:choose>
	</div>
  </form>  
</div>


</body>
</html>
