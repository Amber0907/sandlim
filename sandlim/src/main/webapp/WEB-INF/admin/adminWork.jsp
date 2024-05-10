<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="adminIndex.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산들림</title>
</head>
<script>
$(document).ready(function() {
	//사이드 메뉴 height조정
	let idxhdHeight = $(".idxhd").height(); //헤더 높이
	let idxbodyHeight = $(".idxbody").height(); //사이즈 돞이
	
	let ftHeight = $("footer").height();
	let bodyHeight = $("body").height();
	
	
	let useHeight = idxhdHeight + idxbodyHeight; //가용 height값
	
	if(useHeight > bodyHeight){
		$(".wrap").height(idxbodyHeight);
// 		$("footer").css({"position": "absolute", "bottom" : "0px", "width":"100%", "z-index": 1000}); 
	}
	$(".idxbody").height($("body").height()-65.59);
	
	console.log('idxheader: '+idxhdHeight);
	console.log('idxbody: '+idxbodyHeight);
	console.log('footer: '+ftHeight);
	console.log('useHeight: '+useHeight);
	console.log('body 전: '+bodyHeight);
	console.log('body 후: '+  $("body").height());
	
	//footer 조정
	
	
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
            case "oddiv": url = "odAllList.san"; break;
            case "boarddiv": url = "getBoardList.do"; break;
            case "faqdiv": url = "adminGetFaq.do"; break;
            case "ridiv": url = "insertFaqTable.do"; break;
        }
        
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
<style>
#wrap{
min-height: 100%;
position:relative;
}
</style>
<body>

<div class="wrap">
<div class="nene2">
<div id="navmenu">
  <ul class="nav flex-column">
	<li class="nav-item">
      <div id="userdiv" class="tab-link nav-link" >회원관리</div>
    </li>
    <li class="nav-item">
      <div id="mddiv" class="tab-link nav-link">메뉴관리</div>
    </li>
    <li class="nav-item">
      <div id="oddiv" class="tab-link nav-link">주문관리</div>
    </li>
    <li class="nav-item">
      <div id="boarddiv" class="tab-link nav-link">공지사항관리</div>
    </li>
    <li class="nav-item">
      <div id="faqdiv" class="tab-link nav-link">FAQ관리</div>
    </li>
    <li class="nav-item">
      <div id="ridiv" class="tab-link nav-link">리뷰관리</div>
    </li>
  </ul>
</div>
</div>
	<div id="content" ></div>
	</div>
	<%@include file="../css/footer.jsp"%>
</body>
</html>
