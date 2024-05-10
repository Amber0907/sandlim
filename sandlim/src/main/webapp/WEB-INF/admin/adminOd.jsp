<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../css/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 주문 관리 페이지</title>
</head>
<script>
function paymo(val) {
    let orderNo = val;
    let value = {
       o_no : orderNo
    }
    $.ajax({
       url : "receipt.san",
       type : "POST",
       data : value,
       success: function(data){
          let o_no = data.o_no;
          o_no = o_no.substring("merchant_".length);
          $("#o_noH2").text(o_no); // 주문번호
          let o_name = data.o_name;
          let o_total = data.o_total;
          let o_num = data.o_num;
          let o_size = data.o_size;
          let o_option = data.o_option;
          let o_eachPrice = data.o_eachprice;
          let o_toprice = data.o_toprice;
          o_toprice = parseInt(o_toprice);
          let o_usePoint = data.o_usepoint; 
          o_usePoint = parseInt(o_usePoint);
          let o_savePoint = data.o_savepoint;
          let totalPayPrice = o_toprice - o_usePoint;
          let o_delivery = data.o_delivery; 
          let o_date = data.o_date;
          o_toprice = o_toprice.toLocaleString(); 
          o_usePoint = o_usePoint.toLocaleString();
          o_delivery = parseInt(o_delivery);
          
          let each_name = o_name.split(',');
          let each_num = o_num.split(','); // 갯수
          let each_size = o_size.split(','); // tall/ grande
          let each_option = o_option.split(','); // hot/ ice
          let each_total = o_total.split('원,'); // 개당 가격
          let each_eachPrice = o_eachPrice.split('원,');
          let table = "";
          
          o_usePoint = o_usePoint.toLocaleString();
          for(let i =0 ; i < each_num.length ; i++){
             
             // 상품이름, 기존가격, 갯수 , 총 가격
             table += "<tr><td>"+each_name[i]+"</td><td class='option_margin'>"+each_option[i]+"</td><td>"+each_size[i]+"</td><td>"+each_eachPrice[i]+"원</td><td>"+each_num[i]+"</td><td>"+each_total[i]+"원</td></tr>"
          }
          if(o_delivery === 3000){
             $("#deliveryblock").css("display", "block");
             $("#delivery").text("+3,000원");
             let o_toprice_2 = o_toprice.replace(",","");
             o_toprice_2 = parseInt(o_toprice_2);
             o_toprice_2 = o_toprice_2 + 3000;
             o_toprice_2 = o_toprice_2.toLocaleString();
             $("#span_totalPayPrice").text(o_toprice_2+"원");
          }else{
             let o_toprice_3 = o_toprice.toLocaleString(); 
             $("#span_totalPayPrice").text(o_toprice_3+"원");
          }
          console.log("o_toprice : " + o_toprice);
          o_savePoint = o_savePoint.toLocaleString();
          $("#table_tbody").append(table);
          $("#span_totalPrice").text(o_toprice+"원");
          $("#span_usePoint").text(o_usePoint+"포인트");
          $("#span_savePoint").text(o_savePoint+"포인트");
          $("#orderDate").text("주문시간: "+o_date);
       },error: function(){
          alert("실패");
       }
    });
 }
 </script>
<style>
#o_receipt{
   width: 100%;
   border:1px solid black;
   margin:0 auto;
   margin-top: 50px;
}   
#img_logo{
   margin-top : 50px;
   width: 200px;
   height: 40px;
}
.p_dash{
   padding: 0 15px;
}
.h3_center, #orderDate{
   text-align: center;
}
td{
 text-align: center;
 font-size: 14px;
}
#table_size{
   width: 490px;
   height: 200px;
}
#receipt_margin{
   margin-top: 20px;
}
.receipt_margin{
   margin-left: 30px;
   margin-top : 15px;
}
.span_receipt_margin{
   margin-left: 290px;
}
#span_totalPayPrice{
   margin-left: 280px;
}
#delivery{
   margin-left: 272px;
}
.small_ad{
   padding-left: 15px;
}
#deliveryblock{
   display:none;
}
#barcode{
   width: 300px;
   height: 100px;
}
#barcode_margin{
   text-align:center;
   margin-bottom : 20px;
}

#mainModal2{
width: 500px!important;
height: 100%;
    }
    
 #mohe2{  
 	display: flex;
/* 	width: 600px!important; */
/* 	background-color:white; */
    flex-direction: column;
    align-items: baseline;
    }
    
  .modal-body{
	max-height: calc(120vh - 200px);
    overflow-y: clip;
    width: 100%;
  }
</style>
<script>
var odMaxPage=0; // 전체 페이지의 수
var odCurrentPage11 = 1; // 현재 페이지
var odPageLimit = 5; // 한 페이지에 표시할 데이터 수
var odListDataAll; // 전체 데이터

//페이지 로드 시 실행될 함수
function getodList() {
	let seCon = document.getElementById("sel2").value;
    let seKey = document.getElementById("key2").value;
	let search = {searchCondition : seCon ,searchKeyword : seKey };
	let values = [];

 $.ajax({
     url: "odSelect.san",
     type: "post",
     data: search,
     cache: false,
     async: false,
     success: function(data) {
//          alert('데이터 로딩 성공');
         odListDataAll = data; // 데이터 저장
         var totalDataCnt = ${oList.length} // 전체 데이터 수
         odMaxPage = Math.ceil(totalDataCnt / odPageLimit); // 전체 페이지 수 계산
         makeBtn(odMaxPage); // 페이지 버튼 생성
         odCurrentPage11Data(odListDataAll, odCurrentPage11); // 현재 페이지 데이터 표시
     },
     error: function() {
         alert('데이터 로딩 실패');
     }
 });
}

function makeBtn(odMaxPage) {
 $("#pagediv .page-num-list").remove();
 $("#pagediv").append("<div class='page-num-list'></div>");
 for (let i = 1; i <= odMaxPage; i++) {
    if(i==1)
     $("#pagediv .page-num-list").append("<button type='button' id='pageBtn1'class='pageBtn'>" + i + "</button>");
    else
     $("#pagediv .page-num-list").append("<button type='button' class='pageBtn'>" + i + "</button>");
 }
}

function odCurrentPage11Data(data, odCurrentPage11) {
 let viewData = data.odList.slice((odCurrentPage11 - 1) * odPageLimit, odCurrentPage11 * odPageLimit);
 $("#paylist").empty(); // 테이블 초기화
 $('#pagediv').empty();
 // 데이터를 테이블에 추가
 viewData.forEach(function(od) {
	  let bbb = '';
      switch (od.o_state) {
          case '취소':
              bbb = '<span style="color: red; font-weight: bold;">주문취소</span>';
              break;
          case '주문진행중':
              bbb = '<span style="color: black; font-weight: bold;">주문진행중</span>';
              break;
          case '완료':
              bbb = '<span style="color: blue; font-weight: bold;">완료</span>';
              break;
          case '픽업완료':
              bbb = '<span style="color: gray; font-weight: bold;">픽업완료</span>';
              break;
          case '제조완료':
              bbb = '<span style="color: green; font-weight: bold;">제조완료</span>';
              break;
          default:
              bbb = '<span style="color: hotpink; font-weight: bold;">주문접수중</span>';
      }
      $("#paylist").append(`
          <tr>
              <td>${od.o_date}</td>
              <td>${od.o_id}</td>
              <td>${od.o_name}</td>
              <td>${od.o_toprice}</td>
              <td>전자영수증 버튼 추가</td>
              <td id="status_${od.o_no}">${bbb}</td>
              <td>
              <c:choose>
              <c:when test="${od.o_state eq '주문 확인중'}">
                  <button type="button" class="btn modiod-button" id="modiod_${od.o_no}" onclick="modiod('주문접수', '${od.o_no}')">주문접수</button>
              </c:when>
              <c:when test="${od.o_state eq '주문진행중'}">
                  <button type="button" class="btn modiod-button" id="modiod_${od.o_no}" onclick="modiod('제조완료', '${od.o_no}')">제조완료</button>
              </c:when>
              <c:when test="${od.o_state eq '제조완료'}">
                  <button type="button" class="btn modiod-button" id="modiod_${od.o_no}" onclick="modiod('픽업완료', '${od.o_no}')">픽업완료</button>
              </c:when>
              <c:when test="${od.o_state eq '픽업완료'}">
                  <button type="button" class="btn modiod-button" id="modiod_${od.o_no}" onclick="modiod('완료', '${od.o_no}')">완료</button>
              </c:when>
          </c:choose>
              </td>
              <td><button type='button' class='btn' id="all_module_${od.o_no}" onclick="cancelPayment('${od.o_no}')">취소</button></td>
          </tr>
      `);
  });
    		 

}

$(document).ready(function() {
   //검색리스트 호출
 // getodList();
 $("#pagediv").on("click", ".pageBtn", function() {
     odCurrentPage11 = parseInt($(this).text());
     odCurrentPage11Data(odListDataAll, odCurrentPage11);
 });

// $(".search-btn").click(getodList); // 검색 버튼 클릭 이벤트 연결
 
});

function prepareUp(element) {
 let od = $(element).data('od');
 up(od.bookNum, od.memberName, od.carName, od.today, od.bookDate, od.returnDate, od.bookStatus);
}

function up(bno, mnm, cnm, tod, bd, ret, bs) {
 $.ajax({
     url: "dashBoardInclude/bookmodify.jsp",
     type: "POST",
     data: {
         bookNum: bno,
         memberName: mnm,
         carName: cnm,
         today: tod,
         bookDate: bd,
         returnDate: ret,
         bookStatus: bs
     },
     success: function(response) {
         $('#content').html(response);
     },
     error: function(xhr, status, error) {
         alert("오류 발생: " + error);
     }
 });
}

function del(bno) {
 var result = confirm("해당 예약을 취소하시겠습니까?");
 if (result) {
     alert(bno + "번 예약이 취소 되었습니다.");
     location.href = "bookDelete.bk?bookNum=" + bno;
 }
}
</script>
<body>

  <form class="form-inline sch" action="odsearch.san" method="post"  onsubmit="return false">
  	<select class="form-control" id="sel2" name="searchCondition" style="display:inline-block!important;margin-right:10px;">
        <c:forEach items="${conditionMap}" var="option">
	        <option value="${option.value}">${option.key}</option>
        </c:forEach>
		<option value="주문자">주문자ID</option>
		<option value="픽업/배달">픽업/배달</option>
		<option value="주문상태">주문상태</option>
    </select>
    <input class="form-control mr-sm-2" type="text" id="key2" name="searchKeyword" placeholder="검색어를 입력하세요.">
<!--     <button class="btn btn-success" type="button" onclick="odsearch()">검색</button> -->
    <button class="btn btn-success search-btn" type="button" onclick="getodList()">검색</button>
<!--     <button class="btn btn-success search-btn" type="button">검색</button> -->
  </form>
  
 	<div class="datediv">
	<input type="date" id="oddate" style="margin:10px;">
    <button class="btn btn-success" type="button" style="height: 30px;" onclick="oddate()">검색</button>
    </div>
    
	<table class="table table-hover" id="odtable">
		<thead>
			<tr>
				<th>주문 일자</th>
				<th>주문자 아이디</th>
				<th>주문 상품</th>
				<th>결제 금액</th>
				<th>상세 보기</th>
				<th>주문 상태</th>
				<th>상태 변경</th>
				<th>취소 버튼</th>
			</tr>
		</thead>

			<tbody id="paylist">
		<c:forEach items="${odList}" var="od">
				<tr>
					<td>${od.o_date}</td>
					<td>${od.o_id}</td>
					<td>${od.o_name}</td>
					<td>${od.o_toprice}</td>
					<td><button id="but__${od.o_no}" type="button" class="btn" data-toggle="modal" data-target="#payModal" onclick="paymo('${od.o_no}')">전자영수증</button></td>
<%-- 					<td><button id="but__${od.o_no}" type="button" class="btn" onclick="paymo('${od.o_no}')">전자영수증</button></td> --%>
					<td id="status_${od.o_no}"><c:choose>
							<c:when test="${od.o_state eq '취소'}">
								<span id="sta_${od.o_no}" style="color: red; font-weight: bold;">주문취소</span>
							</c:when>
							<c:when test="${od.o_state eq '주문진행중'}">
								<span id="sta_${od.o_no}" style="color: black; font-weight: bold;">주문진행중</span>
							</c:when>
							<c:when test="${od.o_state eq '완료'}">
								<span id="sta_${od.o_no}" style="color: blue; font-weight: bold;">완료</span>
							</c:when>
							<c:when test="${od.o_state eq '픽업완료'}">
								<span id="sta_${od.o_no}" style="color: gray; font-weight: bold;">픽업완료</span>
							</c:when>
							<c:when test="${od.o_state eq '제조완료'}">
								<span id="sta_${od.o_no}" style="color: green; font-weight: bold;">제조완료</span>
							</c:when>
							<c:otherwise>
								<span id="sta_${od.o_no}" style="color: hotpink; font-weight: bold;">주문접수중</span>
							</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${od.o_state eq '주문 확인중'}">
								<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('주문접수', '${od.o_no}')">주문접수</button>
							</c:when> 
							<c:when test="${od.o_state eq '주문진행중'}">
								<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('제조완료', '${od.o_no}')">제조완료</button>
							</c:when>
							<c:when test="${od.o_state eq '제조완료'}">
								<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('픽업완료', '${od.o_no}')">픽업완료</button>
							</c:when>
							<c:when test="${od.o_state eq '픽업완료'}">
								<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('완료', '${od.o_no}')">완료</button>
							</c:when>
							<c:otherwise>
								<span></span>
							</c:otherwise>
						</c:choose></td>
					<td>
						<button type='button' class='btn' id="all_module_${od.o_no}" onclick="cancelPayment('${od.o_no}')">취소</button></td>
				</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="modal fade" id="payModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop='static' data-keyboard='false' >
<div class="modal-dialog" id="mainModal2">
    <div class="modal-content">
<div class="modal-body" id="mohe2">
<div id = "o_receipt">
<div style="text-align:center;">
   <img id="img_logo" src ="../resources/img/logo.png" title="logo" alt="logo">
   <h2>전자 영수증</h2>
</div>
   <small class="small_ad">안양123번가</small>
   <br>
   <small class="small_ad">TEL: 031-000-0000</small>
   <br>
   <small class="small_ad" id="address">매장: 경기도 안양시 123번가 산들1동 101호(산들림)</small>
   
   <p class="p_dash">---------------------------------------------------------------------------------</p>
   <h3 class="h3_center">주문 번호</h3>
   <h4 class="h3_center" id="o_noH2"></h4>
   <p class="p_dash">---------------------------------------------------------------------------------</p>
   <table id="table_size">
   <thead>
      <tr><th>메뉴</th><th>Option</th><th>Size</th><th>가격</th><th>수량</th><th>총 가격</th></tr>
   </thead>
   <tbody id="table_tbody">
   </tbody>
   </table>
   <div class="receipt_margin" id="receipt_margin">총금액 <span class="span_receipt_margin" id="span_totalPrice"></span></div>
   <p class="p_dash">---------------------------------------------------------------------------------</p>
   <div class="receipt_margin">포인트 <span class="span_receipt_margin" id="span_usePoint"></span></div>
   <div class="p_dash">---------------------------------------------------------------------------------</div>
   <div id="deliveryblock" class="receipt_margin">배달비용<span id="delivery"></span></div>
   <div class="receipt_margin">결제금액<span id="span_totalPayPrice"></span></div>
   <p class="p_dash">---------------------------------------------------------------------------------</p>
   <div class="receipt_margin">적립금 <span class="span_receipt_margin" id="span_savePoint"></span></div>
   <p class="p_dash">---------------------------------------------------------------------------------</p>
   <p id="orderDate"></p>
   <div id="barcode_margin">
   <img id="barcode" src ="../resources/img/barcode.jpg" title="barcode" alt="barcode">
   </div>
</div>
</div>
</div>
</div>
</div>
	
	<div id="pagediv">
		<nav aria-label="Page navigation example" style="margin: auto;">
			<ul class="pagination justify-content-center">
				<c:if test="${pagination.prev}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">이전</a></li>
				</c:if>
				<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<li class="page-item <c:out value="${pagination.currPageNo == idx ? 'active' : ''}"/> ">
						<button type=button class="pagebtn" onClick="fn_pagination('${idx}', '${pagination.range}')"> ${idx} </button></li>
				</c:forEach>
				<c:if test="${pagination.next}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.currPageNo}', '${pagination.range}', '${pagination.pageSize}')">다음</a></li>
				</c:if>
			</ul>
		</nav>
	</div>

	<div id="paginationData" data-searchType="${pagination.searchType}" data-keyword="${pagination.keyword}"></div>

	<script>
		function fn_prev(currPageNo, range, pageSize) {
			
			var searchType = document.getElementById('paginationData').getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData').getAttribute('data-keyword');
			var currPageNo = (range - 1) * pageSize;
			var range = range - 1;

			var url = "/odAllList.san";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;

		}

		function fn_pagination(currPageNo, range) {
			
			var searchType = document.getElementById('paginationData').getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData').getAttribute('data-keyword');
			var url = "/odAllList.san";

			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;

		}
		function fn_next(currPageNo, range, pageSize) {

			var searchType = document.getElementById('paginationData').getAttribute('data-searchType');
			var keyword = document.getElementById('paginationData').getAttribute('data-keyword');
			var currPageNo = (range * pageSize) + 1;
			var range = parseInt(range) + 1;

			var url = "/odAllList.san";
			url = url + "?currPageNo=" + currPageNo;
			url = url + "&range=" + range;
			url = url + "&searchType=" + searchType;
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		</script>

	<%@include file="../css/footer.jsp"%>
</body>
</html>