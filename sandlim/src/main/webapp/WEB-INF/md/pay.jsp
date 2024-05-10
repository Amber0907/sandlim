<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제</title>
<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
   $(document).ready(function(){
      let orderNo = '<%= session.getAttribute("oderNo") %>';
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
   });
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
</style>
<body>
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
  <%@include file="../css/footer.jsp"%>
</body>
</html>