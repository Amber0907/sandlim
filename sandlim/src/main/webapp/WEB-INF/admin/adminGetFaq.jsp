<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="adminIndex.jsp" %>
<style>
#searchNav{-webkit-justify-content: flex-end; justify-content: flex-end; }
.bcl{padding: 0px 0px 100px 200px;}
</style>
<script>
window.onload = function(){
	//사이드 메뉴 height조정
	$(".idxbody").height($("body").height()-65.59);
	console.log('window.innerHeight(100vh)값: ', window.innerHeight );
};
</script>
<body>
<div class="bcl">
<div class="jumbotron">
   <h1>어드민 FAQ 리스트</h1>      
</div>
<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
  <form class="form-inline" action="adminGetFaq.do" method="post">
     <select class="form-control" id="sel1" name="searchCondition" style="display:inline-block!important;margin-right:10px;">
        <c:forEach items="${conditionMap}" var="option">
           <option value="${option.value}">${option.key}</option>
        </c:forEach>
    </select>
    <input class="form-control mr-sm-2" type="text" name="searchKeyword" placeholder="검색어를 입력하세요.">
    <button class="btn btn-success" type="submit">검색</button>
  </form>
</nav>
<div class="container-fluid">
  <table class="table table-hover">
    <thead class="btn-primary">
      <tr>
        <th>번호</th>
        <th>카테고리</th>
        <th>제목</th>
        <th>등록일</th>
        <th>공개상태</th>
      </tr>
    </thead>
    <tbody>
   <c:set var="index" value="${fn:length(faq)}" />
<c:forEach items="${faq}" var="board" varStatus="loop">
<%-- <c:forEach items="${boardList}" var="board" varStatus="loop"> --%>
   <tr onclick="selFaq(${board.b_num})" style="cursor:pointer;">
     <td class="tdCenter">${board.rnum}</td>     
     <td class="tdCenter">${board.b_cat}</td>     
     <td>${board.b_title}</td>
     <td class="tdCenter">${board.b_date}</td>
     <td class="tdCenter">${board.b_status}</a></td>
   </tr>
    <c:set var="index" value="${index - 1}" />
</c:forEach>
    </tbody>
  </table><br><br>
  
<!--   페이지네이션 추가 -->
  <div>
		<nav aria-label="Page navigation example" style="margin: auto;">
			<ul class="pagination justify-content-center">
				<c:if test="${pagination.prev}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_prev('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">이전</a></li>
				</c:if>
				<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
					<li	class="page-item <c:out value="${pagination.currPageNo == idx ? 'active' : ''}"/> ">
					<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}')">	${idx} </a></li>
				</c:forEach>
				<c:if test="${pagination.next}">
					<li class="page-item"><a class="page-link" href="#"
						onClick="fn_next('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">다음</a></li>
				</c:if>
			</ul>
		</nav>
</div>

	<div id="paginationData" data-searchType="${pagination.searchType}"	data-keyword="${pagination.keyword}"></div>
	<script>
		//이전 버튼
		function fn_prev(currPageNo, range, pageSize) {

			var searchType = document.getElementById('paginationData').getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData').getAttribute('data-keyword');
			var currPageNo = (range - 1) * pageSize;
			var range = range - 1;

			var url = "/adminGetFaq.do";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;
		}

		//페이지 번호 클릭

		function fn_pagination(currPageNo, range) {
			var searchType = document.getElementById('paginationData').getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData').getAttribute('data-keyword');
			var url = "/adminGetFaq.do";

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

			var url = "/adminGetFaq.do";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		

		function selUser(val){
			location.href = "adminGetFaq.do?u_id="+val;
		}

	</script>
<!-- 	페이지네이션 추가 끝 -->

  <div id="footer">
     <button type="button" id="conWrite" class="btn btn-primary">새글쓰기</button>
  </div>
</div>
</div>

</body>
<%@ include file="../css/footer.jsp"%>
</html>