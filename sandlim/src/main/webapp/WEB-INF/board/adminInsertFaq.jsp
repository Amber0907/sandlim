<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>
<body>
<div class="jumbotron">
   <h1>어드민 Faq등록</h1>      
</div>
<%@ include file="../css/menu.jsp" %>  
<div class="container-fluid">
  <form action="insertFaq.do" method="post" enctype="multipart/form-data">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">카테고리</span>
      </div>
      <select name="b_cat" id="b_cat">
      	<option value="메뉴">메뉴</option>
      	<option value="회원">회원</option>   
      	<option value="배달">배달</option>
      	<option value="포인트">포인트</option>
      </select>
      	
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">제목</span>
      </div>
      <input type="text" class="form-control" name="b_title" placeholder="제목을 입력하세요." required>      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">작성자</span>
      </div>
      <input type="text" class="form-control innm" name="b_nick" value="관리자" readonly>      
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text">내용</span>
      </div>
      <textarea class="form-control" rows="10" id="comment" name="b_content"></textarea>      
    </div>  
    <div id="footer">
        <button id="conComplete" type="submit" class="btn btn-primary">등록하기</button>
        <button id="conList" type="button" class="btn btn-primary">목록으로</button>
    </div>
  </form>  
</div>

</body>

</html>