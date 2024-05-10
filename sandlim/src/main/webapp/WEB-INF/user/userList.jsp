<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../css/header.jsp"%>
<style>
#searchNav {
	-webkit-justify-content: flex-end;
	justify-content: flex-end;
}
</style>
<body>
	<div class="jumbotron">
		<h1>회원목록</h1>
	</div>
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="userList.do" method="post">
			<select name="searchType" class="form-control mr-sm-2">
				<option value="u_id">아이디</option>
				<option value="u_name">이름</option>
				<option value="u_nick">닉네임</option>
				<option value="u_phno">전화번호</option>
				<option value="u_addr">주소</option>
				<option value="u_birth">생년월일</option>
				<option value="u_email">이메일</option>
				<option value="u_status">회원상태</option>
			</select> <input class="form-control mr-sm-2" type="text" name="keyword" autocomplete="off"
				placeholder="검색어를 입력하세요.">
			<button class="btn btn-success" type="submit">검색</button>
		</form>
	</nav>
	<div class="container-fluid">
		<table class="table table-hover">
			<thead class="btn-primary">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>역할</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userList}" var="user">
					<tr onclick="selUser('${user.u_id}')" style="cursor: pointer;">
						<td class="tdCenter">${user.u_id}</td>
						<td>${user.u_name}</td>
						<td class="tdCenter">${user.u_status}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br> <br>
	</div>

	<div>
		<nav aria-label="Page navigation example" style="margin: auto;">
			<ul class="pagination justify-content-center">
				<c:if test="${pagination.prev}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_prev('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">이전</a></li>
				</c:if>
				<c:forEach begin="${pagination.startPage}"
					end="${pagination.endPage}" var="idx">
					<li
						class="page-item <c:out value="${pagination.currPageNo == idx ? 'active' : ''}"/> "><a
						class="page-link" href="#"
						onClick="fn_pagination('${idx}', '${pagination.range}')">
							${idx} </a></li>
				</c:forEach>
				<c:if test="${pagination.next}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_next('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">다음</a></li>
				</c:if>
			</ul>
		</nav>
	</div>

	<div id="paginationData" data-searchType="${pagination.searchType}"
		data-keyword="${pagination.keyword}"></div>

	<script>
		//이전 버튼
		function fn_prev(currPageNo, range, pageSize) {

			var searchType = document.getElementById('paginationData')
					.getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData')
					.getAttribute('data-keyword');
			var currPageNo = (range - 1) * pageSize;
			var range = range - 1;

			var url = "/userList.do";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;

		}

		//페이지 번호 클릭

		function fn_pagination(currPageNo, range) {

			var searchType = document.getElementById('paginationData')
					.getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData')
					.getAttribute('data-keyword');
			var url = "/userList.do";

			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;

		}
		//다음 버튼 이벤트
		function fn_next(currPageNo, range, pageSize) {

			var searchType = document.getElementById('paginationData')
					.getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData')
					.getAttribute('data-keyword');
			var currPageNo = (range * pageSize) + 1;
			var range = parseInt(range) + 1;

			var url = "/userList.do";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		

		function selUser(val){
			location.href = "selUser.do?u_id="+val;
		}

	</script>

</body>
</html>
