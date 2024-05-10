<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
if (session.getAttribute("userId") == null) {
   response.sendRedirect("login.jsp");
} else {
%>
<%@ include file="../css/header.jsp"%>
<body>
   <div class="jumbotron">
      <h1>REVIEQ 등록</h1>
   </div>
   <div class="container-fluid">
      <form action="insertReview.do" method="post"
         enctype="multipart/form-data">
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">MENU</span>
            </div>
            <input type="text" class="form-control innm" name="b_title"
               value="${board.b_status}" readonly>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">작성자</span>
            </div>
            <input type="text" class="form-control innm" name="b_nick"
               value="<%=session.getAttribute("userName").toString()%>" readonly>
         </div>

         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">평점</span>
            </div>
            <input type="number" class="form-control" name="b_rev"
               placeholder="평점 최소 1점, 최대 10점" min="1" max="10" required>
         </div>


         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">내용</span>
            </div>
            <textarea class="form-control" rows="10" id="comment"
               name="b_content" placeholder="글자수제한 30자이내"></textarea>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">파일선택</span>
            </div>
            <input type="file" class="form-control innm" name="uploadB_file">
         </div>

         <div id="footer">
            <button id="insertReview" type="submit" class="btn btn-primary">리뷰등록</button>
            <button id="getReview" type="button" class="btn btn-primary">리뷰목록</button>
         </div>
      </form>
   </div>


</body>
<%
}
%>
</html>