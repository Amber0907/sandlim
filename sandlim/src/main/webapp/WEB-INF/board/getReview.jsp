
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../css/header.jsp"%>
<style>
/*  .cardall { */
/*         display: flex; */
/*         flex-wrap: wrap;  */
        
/* } */

.container-fluid {
        display: flex;
        flex-wrap: wrap;
        text-align:center; 
}

 .table {
/*        padding : 30px; */
       margin : 20px;
/*       flex-basis: 33.3%; */
/*       flex-basis: 480PX; */
         display: flex; 
/*          flex-direction: row; */
/*          flex-flow: row wrap;   */
/*         flex-wrap: wrap;  */
/*         justify-content: space-around;  */
/*         border : none; */
        } 
</style>
<body>
	<%@ include file="../css/menu.jsp"%>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<div class="jumbotron">
			<h1>리뷰</h1>
		</div>
	</nav>
	<div class="container-fluid">
		<c:forEach items="${boardList}" var="board" varStatus="loop">
			<table class="table table-hover"
				style="width: 450px; border: 1px solid #272727;">
				<tbody>
					<%--     var index = ${boardListSize } --%>
					<%-- 				<c:set var="index" value="${fn:length(boardList)}" /> --%>
					<tr id="selTr(${board.b_num})">
						<td class="tdCenter">${board.b_nick}</td>
						<td class="tdCenter">${board.b_date}</td>
						<td class="tdCenter">${board.b_rev}/10</td>
					</tr>

					<tr rowspan="2">
						<td colspan="2" rowspan="2" class="tdCenter" style="width:300px;">${board.b_content}</td>
						<%-- 						<td class="tdCenter">${index}</td> --%>
						<td>${board.b_title}</td>
					</tr>
					<tr>
						<td class="tdCenter" ><img id="imgBoxImg"
							style="height: 120px; width: 150px;" src="resources/bimg/rimg/${board.b_file }" art="${board.b_file }"></td>
						<%-- 						<td class="tdCenter">${board.b_cat}</td> --%>
					</tr>
					<c:set var="index" value="${index - 1}" />
				</tbody>
			</table>
		</c:forEach>
		<br> <br>
		<div id="footer">
			<button type="button" id="conWrite2" class="btn btn-primary"
				<c:if test="${userId eq NULL}">disabled</c:if>>리뷰작성</button>
		</div>
	</div>

</body>
</html>