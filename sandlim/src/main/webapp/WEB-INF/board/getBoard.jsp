<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp"%>
<%
String sts = "";
if (session.getAttribute("userId") == null) {
   sts = "disabled";
}
%>
<style>
#imgBox {
   display: none;
   position: absolute;
   top: 0;
   left: 0;
   height: 100vh !important;
   background-color: rgba(0, 0, 0, 0.5);
   z-index: 9999999;
}

#imgContentBox {
   whidth: 600px;
   max-height: 550px;
   overflow: auto;
   position: absolute;
   top: 30%;
   left: 30%;
   border-radius: 5px;
   z-index: 9999999;
}

#imgBoxTitleBar {
   border-bottom: 1px solid #777;
   border-redius: 5px 5px 0 0;
   background-color: #ddd;
   width: 100%;
   padding: 10px;
   text-align: right;
   font-size: 20px;
   font-weight: bolder;
}

#imgBoxImg {
   width: 100%;
   border-radius: 0 0 5px 5px;
}

#closeX {
   padding: 5px 20px;
   border-radius: 5px;
   border: 1px solid #777;
   background-color: red;
   color: #fff;
}

#closeX:hover {
   background-color: #777;
   cursor: pointer;
}
</style>
<body>
   <div class="jumbotron">
      <h1>글 상세보기</h1>
   </div>
   <div class="container-fluid">
      <%
      if (request.getParameter("error") != null) {
         out.println("<div class='alert alert-danger'>");
         out.println("해당 글은 작성자만이 수정할 수 있습니다.");
         out.println("</div>");
      }
      %>
      <form name="fm" action="updateBoard.do" method="post">
         <input type="hidden" name="b_num" value="${board.b_num}">
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">분류</span>
            </div>
            <select name="b_cat" value="${board.b_cat}" readonly >
               <option value="${board.b_cat}" >${board.b_cat}</option>
               <option value="공지사항" <c:if test="${!(userId eq 'admin')}">hidden</c:if>>[변경]공지사항</option>
               <option value="이벤트" <c:if test="${!(userId eq 'admin')}">hidden</c:if>>[변경]이벤트</option>
            </select>
         </div>


         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">제목</span>
            </div>
            <input type="text" class="form-control innm" name="b_title"
               value="${board.b_title}" <%=sts %>>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">작성자</span>
            </div>
            <input type="text" class="form-control innm" value="${board.b_nick}"
               readonly <%=sts %>>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">내용</span>
            </div>
            <span><img style="width:500px;" src="resources/bimg/${board.b_file }" alt="${board.b_file }">
            <textarea class="form-control innm" rows="10" id="comment"
               name="b_content" <%=sts%>>${board.b_content}</textarea></span>
         </div>

         <div class="input-group mb-3"
            <c:if test="${board.b_file eq NULL}">hidden</c:if>>
            <div class="input-group-prepend">
               <span class="input-group-text">첨부파일</span> <input type="hidden"
                  name="b_file" value="${board.b_file}">
            </div>
            <c:if test="${board.b_file ne NULL }">
               <span style="cursor: pointer;"
                  onclick="downloadFile('${board.b_file}')">[파일다운]
                  ${board.b_file}</span>
               <script>
                  function downloadFile(b_file) {
                     window.location = 'download.do?filename=' + b_file;
                  }
               </script>
            </c:if>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">등록일</span>
            </div>
            <input type="text" class="form-control innm" name="b_date"
               value="${board.b_date}" readonly <%=sts %>>
         </div>
         <div class="input-group mb-3">
            <div class="input-group-prepend">
               <span class="input-group-text">조회수</span>
            </div>
            <input type="text" class="form-control innm" name="cnt"
               value="${board.b_cnt}" readonly <%=sts %>>
         </div>
         <div id="footer">
            <button type="submit" class="btn btn-primary"
               <c:if test="${!(userId eq 'admin')}">hidden</c:if>>글수정</button>
            <button id="insertBoard" type="button" class="btn btn-primary"
               <c:if test="${!(userId eq 'admin')}">hidden</c:if>>글쓰기</button>
            <button id="deleteBoard" type="button" class="btn btn-primary"
               <c:if test="${!(userId eq 'admin')}">hidden</c:if>>글삭제</button>
            <button id="getBoardList" type="button" class="btn btn-primary">글목록</button>
         </div>
      </form>
   </div>
</body>
</html>