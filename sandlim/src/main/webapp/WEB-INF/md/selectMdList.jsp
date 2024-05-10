<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<title>손님 메뉴 리스트 페이지</title>

<style>


@media screen and (max-width: 400px) {
 .bod{
	padding: 0 30px!important;;
	}
 .menubut{
 display: none;}
 
 .dropdown{
 display: block;
 }
 
 .cardall{
 	margin: 10px;
 }
 .mdimg{
 	width:100%;
 	height: 350px;
 }
 .card{
 	height: 450px;
 }
 .btn-primary {
    color: #fff;
    background-color: #272727;
    width: 310px;
	font-family: bold;
	border: none;
}
.btn-primary:not(:disabled):not(.disabled).active,.btn-primary.dropdown-toggle:hover, .btn-primary.focus, .btn-primary:focus, .btn-primary:not(:disabled):not(.disabled):active, .show>.btn-primary.dropdown-toggle,.btn-primary.focus, .btn-primary:focus,.dropdown-item:focus{
  		background-color : #f9f5f2;
		color : #272727;
	    font-family: bold;
}
.form-inline {
    display: block;
}
 
 }

</style>
<body>
<div class="bod">
  <form class="form-inline sch" action="selectList.san" method="post">
  	<select class="form-control" id="sel1" name="searchCondition" style="display:inline-block!important;margin-right:10px;">
        <c:forEach items="${conditionMap}" var="option">
	        <option value="${option.value}">${option.key}</option>
        </c:forEach>
		<option value="이름">이름</option>
		<option value="이상가격">이상 가격</option>
		<option value="이하가격">이하 가격</option>
    </select>
    <input class="form-control mr-sm-2" type="text" id="key1" name="searchKeyword" placeholder="검색어를 입력하세요.">
    <button class="btn btn-success" id="seabt" type="button" onclick="search()">검색</button>
  </form>
  
  <div class= "menubut">
	<button type="button" class="but1 but1start" onclick="allMd('selectList.san')" value ="전체 메뉴">전체 메뉴</button>
	<button type="button" class="but1" onclick="selectkind('커피')" value ="커피">커피</button>
	<button type="button" class="but1" onclick="selectkind('논커피')" value ="논커피">논커피</button>
	<button type="button" class="but1" onclick="selectkind('티')" value ="티">티</button>
	<button type="button" class="but1" onclick="selectkind('에이드')" value ="에이드">에이드</button>
	<button type="button" class="but1" onclick="selectkind('프라페')" value ="프라페">프라페</button>
	<button type="button" class="but1" onclick="selectkind('디저트')" value ="디저트">디저트</button>
	<button type="button" class="but1" onclick="okList('판매가능')" value ="판매가능">품절제외</button>
	</div>

  <div class="dropdown">
    <button type="button" class="btn-primary dropdown-toggle" data-toggle="dropdown">
      메뉴
    </button>
    <div class="dropdown-menu">
  	<button type="button" class="dropdown-item but1start" onclick="allMd('selectList.san')" value ="전체 메뉴" >전체 메뉴</button>
	<button type="button" class="dropdown-item" onclick="okList('판매가능')" value ="판매가능">품절제외</button>
	<button type="button" class="dropdown-item" onclick="selectkind('커피')" value ="커피">커피</button>
	<button type="button" class="dropdown-item" onclick="selectkind('논커피')" value ="논커피">논커피</button>
	<button type="button" class="dropdown-item" onclick="selectkind('티')" value ="티">티</button>
	<button type="button" class="dropdown-item" onclick="selectkind('에이드')" value ="에이드">에이드</button>
	<button type="button" class="dropdown-item" onclick="selectkind('프라페')" value ="프라페">프라페</button>
	<button type="button" class="dropdown-item" onclick="selectkind('디저트')" value ="디저트">디저트</button>
    </div>
  </div>

	
<div class="cardall" id="cardall">
<div class="card1">
<c:forEach items="${mdList}" var="md">
<div class="col-lg-3 col-md-6 col-sm-10 mdcard">
  <div class="card">
    <img class="mdimg" id="mdimg" src="${pageContext.request.contextPath }/resources/img/${md.m_img}" alt="${md.m_name}" title="${md.m_name}">
    <div class="card-body">
      <h5 class="card-title" id="card_h4">${md.m_name}</h5>
      <p class="card-text">가격 : ${md.m_price} 원</p>
<%--       <p class="card-text"><small>${md.m_content}</small></p> --%>
      <c:choose>
		   	<c:when test = "${md.m_state eq '품절'}" >
		   		<span style= "color:red; font-weight:bold;">SOLD OUT</span>
		   	</c:when>
		   		<c:otherwise>
		   		<span></span>
		   		</c:otherwise>
		   	</c:choose>
      <button type="button" id="List" class="btn" onclick="list('${md.m_no}', '${md.m_kind}' )" data-toggle="modal" data-target="#listModal">주문하기</button>
    </div>
    </div>
  </div>
  </c:forEach>
  <br>
  </div>
 </div>
 
<div class="modal fade" id="listModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop='static' data-keyboard='false' >
<%@ include file="getMd.jsp" %>
</div>
  </div>
  <%@include file="../css/footer.jsp"%>
</body>
</html>
