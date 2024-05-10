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
<body>
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
	<c:forEach items="${odMyList}" var="oml">
		<c:choose>
		<c:when test="${oml.o_state != '완료'}">
			<tr>
				<td>${oml.o_date}</td>
				<td>${oml.o_name}</td>
				<td>${oml.o_toprice}</td>
				<td><button type="button" onclick="lookRecipt('${oml.o_no}')">전자영수증 보기</button></td>
				<td>${oml.o_state}</td>
			</tr>
		</c:when>
		</c:choose>
	</c:forEach>
		</tbody>
	</table>
</body>
</html>