<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.overText {
width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

</style>
<body>
		
	<form>
		<input type="date">
	</form>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>주문날짜</th>
				<th>주문상품</th>
				<th>결제금액</th> 
				<th>상세보기</th> 
				<th>주문상태</th>
			</tr>
		</thead>
		<tbody>
	<c:forEach items="${odMyAllList }" var="odm">
		<c:choose>
		<c:when test="${odm.o_state == '완료'}">
			<tr>
				<td>${odm.o_date}</td>
				<td class="overText">${odm.o_name}</td>
				<td>${odm.o_toprice}</td>
				<td><button type="button" onclick="lookRecipt('${odm.o_no}')">전자영수증 보기</button></td>
				<td>${odm.o_state}</td>
			</tr>	
		</c:when>
		</c:choose>	
	</c:forEach>
		</tbody>
	</table>
</body>
</html>