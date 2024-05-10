<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../css/header.jsp"%>
<%-- <c:if test="${userId eq 'admin'}" ><%@ include file="../css/footer.jsp"%></c:if> --%>

<style>
/* #searchNav{-webkit-justify-content: flex-end; justify-content: flex-end; } */
</style>
<body>

   <nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
      <div class="jumbotron">
         <h1>REVIEW</h1>
         <h1>${userId}</h1>
      </div>
   </nav>
   <div class="container-fluid">
      <table class="table table-hover">
         <thead class="btn-primary">
            <tr>
               <th>MENU</th>
               <th>평점</th>
               <th>사진/내용</th>
               <th>작성자</th>
               <th>등록일</th>
            </tr>
         </thead>
         <tbody>
            <%--     var index = ${boardListSize } --%>
            <c:set var="index" value="${fn:length(boardList)}" />
            <c:forEach items="${boardList}" var="board" varStatus="loop">
               <tr onclick="selReview(${board.b_num})" style="cursor: pointer;">
                  <td class="tdCenter">${board.b_status}</td> 
                  <td class="tdCenter">${board.b_rev}</td>
                  <td><img id="imgBoxImg" style="height: 120px; width: 150px;"
                     src="resources/bimg/rimg/${board.b_file }" art="${board.b_file }"
                     <c:if test="${board.b_file eq NULL}">hidden</c:if>>
                     ${board.b_content}</td>
                  <td class="tdCenter">${board.b_nick}</td>
                  <td class="tdCenter">${board.b_date}</td>
               </tr>
               <c:set var="index" value="${index - 1}" />
            </c:forEach>
         </tbody>
      </table>
      <br> <br>
      <div id="footer">
         <button type="button" id="getinsertReview" class="btn btn-primary"
            <c:if test="${userId eq NULL}">hidden</c:if>>리뷰작성</button>
            
      </div>
   </div>
   <%@ include file="../css/footer.jsp"%>
</body>
</html>