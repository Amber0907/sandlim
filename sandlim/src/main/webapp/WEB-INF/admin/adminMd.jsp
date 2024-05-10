<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<title>관리자 상품 관리 페이지</title>
<body>
  <form class="form-inline sch" action="adminMd.san" method="post">
  	<select class="form-control" id="sel1" name="searchCondition" style="display:inline-block!important;margin-right:10px;">
        <c:forEach items="${conditionMap}" var="option">
	        <option value="${option.value}">${option.key}</option>
        </c:forEach>
		<option value="이름">이름</option>
		<option value="이상가격">이상 가격</option>
		<option value="이하가격">이하 가격</option>
    </select>
    <input class="form-control mr-sm-2" type="text" id="key1" name="searchKeyword" placeholder="검색어를 입력하세요.">
    <button class="btn btn-success" type="button" onclick="adminsearch()">검색</button>
  </form>
  
  <div class= "menubut">
	<button type="button" class="but1 but1start" onclick="allMd('adminMd.san')" value ="전체 메뉴">전체 메뉴</button>
	<button type="button" class="but1" onclick="adminkind('커피')" value ="커피">커피</button>
	<button type="button" class="but1" onclick="adminkind('논커피')" value ="논커피">논커피</button>
	<button type="button" class="but1" onclick="adminkind('티')" value ="티">티</button>
	<button type="button" class="but1" onclick="adminkind('에이드')" value ="에이드">에이드</button>
	<button type="button" class="but1" onclick="adminkind('프라페')" value ="프라페">프라페</button>
	<button type="button" class="but1" onclick="adminkind('디저트')" value ="디저트">디저트</button>
	<button type="button" class="but1" onclick="soldList('품절')" value ="품절">품절</button>
	</div>
	
<div>	
<div class="container">
  <table class="table table-hover">
    <thead>
      <tr>
        <th>상품 사진</th>
        <th>상품 이름</th>
        <th>상품 가격</th>
        <th>상품 설명</th>
        <th>판매 상태</th>
        <th>상세 보기</th>
        <th>수정 하기</th>
      </tr>
    </thead>
    <tbody id="admdlist">
    <c:forEach items="${mdList}" var="md">
      <tr>
   <td> <img class="mdimg" id="mdimg" src="${pageContext.request.contextPath }/resources/img/${md.m_img}" alt="${md.m_name}" title="${md.m_name}" style="width:150px; height: 150px"></td>
        <td>${md.m_name}</td>
        <td>${md.m_price} 원</td>
        <td>${md.m_content}</td>
        <td>  <c:choose>
		   	<c:when test = "${md.m_state eq '품절'}" >
		   		<span style= "color:red; font-weight:bold;">품절</span>
		   	</c:when>
		   		<c:otherwise>
		   		<span style="color:gray; font-weight:bold;">판매가능</span>
		   		</c:otherwise>
		   	</c:choose></td>
        <td><button type="button" id="List" class="btn" onclick="list('${md.m_no}', '${md.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button></td>
        <td><button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value= "${md.m_no}">메뉴수정</button></td>
      </tr>
      </c:forEach>
      </tbody>
  </table>
</div>
</div>

<div class="modal fade" id="listModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<%@ include file="../md/getMd.jsp" %>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<%@ include file="updateMd.jsp" %>
</div>


<button type="button" id="mdinsert" class="btn btn-primary" style="margin:10px 40px;float: right">상품 등록</button>
  	  <%@include file="../css/footer.jsp"%>
</body>
</html>
