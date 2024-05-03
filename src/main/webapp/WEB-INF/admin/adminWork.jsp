<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../css/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산들림</title>
<style>
/* body { */
/*     font-family: Arial, sans-serif; */
/*     display: flex; /* body의 직접 자식 요소들을 플렉스 아이템으로 만듭니다. */ */
/* } */

#menu {
    width: 200px; /* 메뉴의 너비를 고정합니다. */
    position: fixed; /* 메뉴를 고정 위치에 둡니다. */
    height: 100%; /* 메뉴의 높이를 브라우저 창의 높이와 같게 합니다. */
    overflow: auto; /* 메뉴가 너무 길어질 경우 스크롤을 허용합니다. */
}

.tab-link {
    background-color: #ddd;
    display: block; /* 각 링크를 세로로 나열 */
    padding: 10px 15px;
    cursor: pointer;
    text-decoration: none; /* 기본 링크 스타일 제거 */
    color: black; /* 링크 텍스트 색상 지정 */
}

.tab-link:hover {
    background-color: #ccc;
}

#content {
    padding: 50px;
    border: 1px solid #ddd;
    margin-left: 220px; /* 왼쪽 메뉴와의 간격 조정 */
    flex-grow: 1; /* 오른쪽의 남는 공간을 모두 차지하도록 설정합니다. */
}
</style>
</head>
<script>
$(document).ready(function() {
	/* $.ajax({
		url : "adminWork.do",
		type : "GET",
		success : function(data) {
			$("#content").html(data);
		},
		error : function() {
			$("#content").html("Error loading page.");
		}
	}); */

    $(".tab-link").click(function() {
        const tabId = $(this).attr("id");
        let url = "";
        
        switch(tabId) {
            case "userdiv": url = "userList.do"; break;
            case "mddiv": url = "adminMd.san"; break;
            case "oddiv": url = "adminOd.san"; break;
            case "boarddiv": url = "getBoardList.do"; break;
            case "faqdiv": url = "adminGetFaq.do"; break;
            case "ridiv": url = "insertFaqTable.do"; break;
        }
        
        console.log("url : " + url);
        
        $.ajax({
            url : url,
            type : "GET",
            success : function(data) {
                $("#content").html(data);
            },
            error : function() {
                $("#content").html("Error loading page.");
            }
        });

    });
});
</script>
<body>
<%@ include file="../css/menu.jsp" %>
	<h1>산들림 관리자 페이지 테스트 (header)</h1>
	<div id="menu">
		<c:set var="id" value="${sessionScope.userStatus }" />
		<c:choose>
		    <c:when test="${id eq 'A' }">
		        <div id="userdiv" class="tab-link">회원관리</div>
		    </c:when>
		    <c:otherwise>
		        <div id="userdiv" class="tab-link" style="color: gray;">회원관리</div>
		    </c:otherwise>
		</c:choose>
	    <div id="mddiv" class="tab-link">메뉴관리</div>
	    <div id="oddiv" class="tab-link">주문관리</div>
	    <div id="boarddiv" class="tab-link">공지사항관리</div>
	    <div id="faqdiv" class="tab-link">FAQ관리</div>
	    <div id="ridiv" class="tab-link">리뷰관리</div>
	</div>
	
	<div id="content" style="padding: 50px;"></div>
	<%@include file="../css/footer.jsp"%>
</body>
</html>
