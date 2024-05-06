<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../css/header.jsp"%>
<style>
/* #searchNav{-webkit-justify-content: flex-end; justify-content: flex-end; } */
</style>
<body>
   <%@ include file="../css/menu.jsp"%>
   <nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
      <div class="jumbotron">
         <h1>공지 사항</h1>
      </div>
      <form class="form-inline" action="getBoardList.do" method="post">
         <select class="form-control" id="sel1" name="searchCondition"
            style="display: inline-block !important; margin-right: 10px;">
            <c:forEach items="${conditionMap}" var="option">
               <option value="${option.value}">${option.key}</option>
            </c:forEach>
            <%--       <option value="${conditionMap['제목']}">제목</option> --%>
            <%--       <option value="${conditionMap['내용']}">내용</option> --%>
         </select> <input class="form-control mr-sm-2" type="text" name="searchKeyword"
            placeholder="검색어를 입력하세요.">
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
               <th>작성자</th>
               <th>등록일</th>
               <th>조회수</th>
            </tr>
         </thead>
         <tbody>
            <c:set var="index" value="${fn:length(boardList)}" />
            <c:forEach items="${boardList}" var="board" varStatus="loop">
               <tr onclick="selTr(${board.b_num})" style="cursor: pointer;">
                  <td class="tdCenter">${index}</td>
                  <td class="tdCenter">${board.b_cat}</td>
                  <td>${board.b_title}</td>
                  <td class="tdCenter">${board.b_nick}</td>
                  <td class="tdCenter">${board.b_date}</td>
                  <td class="tdCenter">${board.b_cnt}</td>
                  <script>console.log(${board.b_num});</script>
               </tr>
               <c:set var="index" value="${index - 1}" />
            </c:forEach>
         </tbody>
      </table>
      <br>
      <br>
      <div id="footer">
         <button type="button" id="conWrite" class="btn btn-primary"
<%--             <c:if test="${userId eq NULL}">disabled</c:if>>글쓰기</button> --%>
            <c:if test="${!(userId eq 'admin')}">hidden</c:if>>글쓰기</button>
      </div>
   </div>

</body>
</html>