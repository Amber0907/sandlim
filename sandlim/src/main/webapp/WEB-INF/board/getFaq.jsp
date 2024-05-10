<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../css/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<link rel="stylesheet"	href="${pageContext.request.contextPath }/resources/css/test.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<title>Insert title here</title>
<style>
/* Note: Try to remove the following lines to see the effect of CSS positioning */
.affix {
	top: 0;
	width: 100%;
	z-index: 9999 !important;
}

.affix+.container-fluid {
	padding-top: 70px;
}

#tabbtn1, #tabbtn2, #tabbtn3, #tabbtn4 {
	display: none;
	color: #f00;
}

.container{
	padding-top: 80px;
}
.panel-header{
	padding: 7px;
}
.btndiv{
	
}
</style>
<script>
	
</script>
</head>
<body>

	<div class="container">
		<h2>자주 묻는 문의</h2>
		<div class=btndiv>
		<button class="tabbtn1" onclick="tab('tabbtn1')">메뉴</button>
		<button class="tabbtn2" onclick="tab('tabbtn2')">회원</button>
		<button class="tabbtn3" onclick="tab('tabbtn3')">배달</button>
		<button class="tabbtn4" onclick="tab('tabbtn4')">포인트</button>
		</div>
		<br>
		<script>
			$(document).ready(function() {
				// 첫 번째 버튼을 선택하고 해당하는 패널을 보여줍니다.
				tab('tabbtn1');
			});

			function tab(a) {
				$(".panel").hide();
				$("." + a).show();
			}
		</script>

		<div id="accordion">
			<c:forEach items="${faq}" var="board">
				<c:if test="${board.b_cat eq '메뉴'}">
					<div class="panel panel-default tabbtn1">
						<div class="panel-header">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i }">
								${board.b_title} </a>
						</div>
						<div id="collapse${i }" class="panel-collapse collapse">
							<div class="panel-body">${board.b_content}</div>
						</div>
					</div>
					<c:set var="i" value="${i+1 }" />
				</c:if>

				<c:if test="${board.b_cat eq '회원'}">
					<div class="panel panel-default tabbtn2">
						<div class="panel-header">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i }">
								${board.b_title} </a>
						</div>
						<div id="collapse${i }" class="panel-collapse collapse">
							<div class="panel-body">${board.b_content}</div>
						</div>
					</div>
					<c:set var="i" value="${i+1 }" />
				</c:if>

				<c:if test="${board.b_cat eq '배달'}">
					<div class="panel panel-default tabbtn3">
						<div class="panel-header">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i }">
								${board.b_title} </a>
						</div>
						<div id="collapse${i }" class="panel-collapse collapse">
							<div class="panel-body">${board.b_content}</div>
						</div>
					</div>
					<c:set var="i" value="${i+1 }" />
				</c:if>
				
				<c:if test="${board.b_cat eq '포인트'}">
					<div class="panel panel-default tabbtn4">
						<div class="panel-header">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i }">
								${board.b_title} </a>
						</div>
						<div id="collapse${i }" class="panel-collapse collapse">
							<div class="panel-body">${board.b_content}</div>
						</div>
					</div>
					<c:set var="i" value="${i+1 }" />
				</c:if>
			</c:forEach>


		</div>
</body>
</html>