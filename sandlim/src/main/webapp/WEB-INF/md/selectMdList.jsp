<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<title>손님 메뉴 리스트 페이지</title>
<body>
<%@ include file="../css/menu.jsp" %>
<div class="jumbotron">
   <h1>메뉴</h1>      
</div>
<%-- <%@ include file="../../menu.jsp" %> --%>
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
    <button class="btn btn-success" type="button" onclick="search()">검색</button>
  </form>
  
  <div class= "menubut">
	<button type="button" class="but1 but1start" onclick="allMd('selectList.san')" value ="전체 메뉴">전체 메뉴</button>
	<button type="button" class="but1" onclick="selectkind('커피')" value ="커피">커피</button>
	<button type="button" class="but1" onclick="selectkind('논커피')" value ="논커피">논커피</button>
	<button type="button" class="but1" onclick="selectkind('티')" value ="티">티</button>
	<button type="button" class="but1" onclick="selectkind('에이드')" value ="에이드">에이드</button>
	<button type="button" class="but1" onclick="selectkind('프라페')" value ="프라페">프라페</button>
	<button type="button" class="but1" onclick="selectkind('디저트')" value ="디저트">디저트</button>
	</div>
	
<div class="cardall" id="cardall">
<div class="card1">
<c:forEach items="${mdList}" var="md">
  <div class="card">
    <img class="mdimg" id="mdimg" src="${pageContext.request.contextPath }/resources/img/${md.m_img}" alt="${md.m_name}" title="${md.m_name}" style="width:100%; height: 350px">
    <div class="card-body">
      <h4 class="card-title" id="card_h4">${md.m_name}</h4>
      <p class="card-text">가격 : ${md.m_price} 원</p>
      <p class="card-text">${md.m_content}</p>
     <div id="soldout" style="display:none">${md.m_state}</div>
      <button type="button" id="List" class="btn" onclick="list('${md.m_no}', '${md.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button>
    </div>
  </div>
  </c:forEach>
  <br>
  </div>
 </div>
 
<div class="modal fade" id="listModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<%@ include file="getMd.jsp" %>
</div>
  <%@include file="../css/footer.jsp"%>
</body>
</html>
