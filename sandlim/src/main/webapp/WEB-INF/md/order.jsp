<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>
<!-- 주문 내역에서 전자영수증 모달 아직 사용 안함 모달창 직접 기술되어있음   -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>

</script>
<style>
#o_receipt{
   width: 500px;
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
/* td{ */
/* text-align: center; */
/* } */

/* #mainModal2{ */
/* width: 500px!important; */
/*     } */
 #mohe2{  display: flex;
width: 600px!important;
background-color:white;
/*     padding: 1rem 1rem; */
/*     border-bottom: 1px solid #dee2e6; */
/*     border-top-left-radius: calc(.3rem - 1px); */
/*     border-top-right-radius: calc(.3rem - 1px); */
    flex-direction: column;
    align-items: baseline;
    }
</style>
<body> 
<div class="modal-dialog" id="mainModal2">
    <div class="modal-content">
      <div class="modal-header" id="mohe2">
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
   </div>
<!--    헤더디브 -->
  <div class="modal-body">
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
</body>
</html>