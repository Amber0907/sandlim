<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>

<body>
<div class="jumbotron">
   <h1><c:choose>
   <c:when test="${userStatus eq '관리자' }">회원상세</c:when>
   <c:otherwise>내 정보</c:otherwise></c:choose></h1>      
</div>
<div class="container-fluid">

  <form name="fm" action="updateUserForm.do" method="post" onsubmit="return chk()">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">아이디</span>
      </div>
      <input type="text" class="form-control innm" id="u_id" name="u_id" value="${user.u_id}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">닉네임</span>
      </div>
      <input type="text" class="form-control innm" name="u_nick" value="${user.u_nick}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">이름</span>
      </div>
      <input type="text" class="form-control innm" name="u_name" value="${user.u_name}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">전화번호</span>
      </div>
      <input type="text" class="form-control innm" name="u_phno" value="${user.u_phno}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">현재 주소</span>
      </div>
      <input type="text" class="form-control innm" name="u_addr" value="${user.u_addr}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">생년월일</span>
      </div>
      <input type="text" class="form-control innm" name="u_birth" value="${user.u_birth}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">이메일</span>
      </div>
      <input type="text" class="form-control innm" name="u_email" value="${user.u_email}" readonly>
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">포인트</span>
      </div>
      <input type="text" class="form-control innm" name="u_point" value="${user.u_point}" readonly>      
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">역할</span>
      </div>
      <input type="text" class="form-control innm" id=status name="u_status" value="${user.u_status}" readonly>
    </div>
    <div id="footer">
	  	<button type="submit" class="btn btn-primary">정보수정</button>
<c:choose>
	<c:when test="${userStatus eq '관리자' }">
	  	<button type="button" class="btn btn-primary" onclick="javascript:location.href='userList.do';">회원목록</button>
	</c:when>
	<c:otherwise>
	  	<button type="button" class="btn btn-primary" onclick="javascript:location.href='index.jsp';">돌아가기</button>
	</c:otherwise>
</c:choose>
	</div>
  </form>  
</div>


</body>
</html>
