<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<title>장바구니 페이지</title>
<script>
var chk = false;
$(document).ready(function(){
    $.ajax({
         url : "pay",
         type : "POST",
         success: function(data){
            let init = data.impKey;
            IMP.init(init);
         },error: function(){
            alert("아작스 실패");
         }
      });
var IMP = window.IMP;
// IMP.init('${impKey}');
var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
   
if(!isMobile) {
   //모바일이 아닌 경우 스크립트
   $("#check_module").click(function () {
      
         let o_toprice = $("#totalPayPrice").val();
         o_toprice =o_toprice.replace("원","").replace(",","");
      
         let o_address = $("#o_address").val();
         let o_id = $("#order_id").val();
         let o_phone = $("#o_phone").val();
         let o_email = $("#order_email").val();
         console.log("o_email : " + o_email);
      IMP.request_pay({
          pg:'danal_tpay', 
         pay_method: 'card',
         merchant_uid: 'merchant_' + new Date().getTime(),
         name: '주문명:결제테스트',
         amount: o_toprice,
         buyer_email: o_email,
         buyer_name:  o_id,
         buyer_tel: o_phone ,
         buyer_addr: o_address ,
         buyer_postcode: '123-456',
         }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
               var msg = '결제가 완료되었습니다.';
               msg += '\n고유ID : ' + rsp.imp_uid;
               msg += '\n상점 거래ID : ' + rsp.merchant_uid;
               msg += '\n결제 금액 : ' + rsp.paid_amount;
               msg += '\n카드 승인번호 : ' + rsp.apply_num;
               
               
               $("#imp_uid").val(rsp.imp_uid);
               $("#merchant_uid").val(rsp.merchant_uid);
               chk = true;
            } else {
               var msg = '결제에 실패하였습니다.';
               msg += '\n에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            if(chk==true) {
             orderList();
            }
      });
   });
    
} else {
   //모바일인 경우 스크립트
   $("#check_module").click(function () {
      IMP.request_pay({
          pg: 'danal_tpay',
         // pg: 'A010002002', 
         pay_method: 'card',
         merchant_uid: 'merchant_' + new Date().getTime(),
         name: '주문명:결제테스트',
         amount: $("#amount").val(),
         buyer_email: $("#umail").val() ,
         buyer_name: $("#unm").val() ,
         buyer_tel: $("#utel").val() ,
         buyer_addr: $("#uaddr").val() ,
         buyer_postcode: '123-456',
         m_redirect_url: 'http://localhost:8090/payments/complete',
//          popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
         }, function (rsp) {
            console.log(rsp);
         
      });
   });
}  
});
//결제완료 서브밋
function orderList(){
   alert('주문내역 처리할 곳. 컨트롤러 호출');
   
   let merchant_uid = $("#merchant_uid").val();
   let o_toprice = $("#allTotalPrice").val();
   o_toprice =o_toprice.replace("원","").replace(",","");
   
   let o_buy = $('input[name=o_buy]:checked').val();
    let o_way = '카드결제';
    let o_address = $("#o_address").val();
    let o_id = $("#order_id").val();
    let o_usepoint = $("#usePoint").val();
    o_usepoint = parseInt(o_usepoint);
    let o_savepoint = "";
    let o_name = "";
    let o_num = "";
    let o_total = "";
    let name = document.getElementsByName("cartMenuName");
    let o_delivery = "";
    let o_phone = $("#o_phone").val();
    let o_size ="";
    let o_option ="";
    let o_eachprice = "";
    if(o_usepoint <= 0 ){
       o_toprice = parseInt(o_toprice);
       o_savepoint = o_toprice * 0.1;
    }else if(o_usepoint >= 1){
       o_savepoint = 0;
    }
    if($("input:radio[name=o_buy]:checked").val()=='배달') {
             o_delivery = "3000";
      }else if($("input:radio[name=o_buy]:checked").val()=='픽업'){
             o_delivery = "0";
      }
    for (let i = 0; i < name.length; i++) {
        let oName = name[i].value;
        o_name += oName;
        if (i !== name.length - 1) {
            o_name += ", ";
        }
    }
    let num = document.getElementsByName("o_num");
    for(let i=0 ; i< num.length; i++){
       let oNum = num[i].value;
       o_num += oNum;
       if(i !== num.length -1){
          o_num += ", ";
       }
    }
    let price = document.getElementsByClassName("cartMenuPrice"); 
    for(let i=0; i< price.length; i++){
       let oPrice = price[i].value;
       o_total += oPrice;
       if(true){
          o_total += ", ";
       }
    }
    let option = document.getElementsByName("cartOption");
    for(let i =0; i<option.length; i++){
          let oOption = option[i].value;
          o_option += oOption;
           if(i !== num.length -1){
              o_option += ", ";
           }
        }
    let size = document.getElementsByName("cartSize");
    for(let i =0; i<size.length; i++){
          let oSize = size[i].value;
          o_size += oSize;
           if(i !== num.length -1){
              o_size += ", ";
           }
        }
    let eachPrice = document.getElementsByName("eachPrice");
    for(let i =0; i<eachPrice.length; i++){
          let oEachPrice = eachPrice[i].value;
          o_eachprice += oEachPrice;
           if(true){
              o_eachprice += ", ";
           }
        }
   let orderVal =  {   
      o_no : merchant_uid,
      o_id : o_id,
      o_name : o_name,
      o_num : o_num,
      o_total : o_total,
      o_toprice : o_toprice,
      o_way : o_way,
      o_usepoint : o_usepoint,
      o_savepoint : o_savepoint,
      o_buy : o_buy,
      o_address : o_address,
      o_phone : o_phone,
      o_delivery: o_delivery,
      o_option : o_option,
      o_size : o_size,
      o_eachprice : o_eachprice,
   }
   $.ajax({
      url : "putOder.san",
      type : "POST",
      data : orderVal,
      success: function(){
         location.href="../payList.san";         
      },error: function(){
         
      }
   });
}
$(function(){
   <% String userId = (String) session.getAttribute("userId");%>
   let userId = '<%= userId%>';
   let buyWay = false;
   let value = {
         u_id : userId
   }
   $.ajax({
      url : 'cartSelectUser.san',
      type : "POST",
      data : value,
   success: function(data){
      $("#savePoint").val(data.u_point);
      $("#o_address").val(data.u_addr);
      $("#o_phone").val(data.u_phno);
      $("#order_email").val(data.u_email);
      $("#order_nick").val(data.u_nick);
      let totalPrice_2 = 0;
      let cartMenuPrice = document.getElementsByClassName("cartMenuPrice");
      for(let i = 0 ; i < cartMenuPrice.length; i++){
         let total = cartMenuPrice[i].value;
          total = total.replace("원","").replace("," , "");
         total = parseInt(total);
           if (!isNaN(total)) {
              totalPrice_2  += total;
             }
      }
      totalPrice_2 = totalPrice_2.toLocaleString();
      $("#allTotalPrice").val(totalPrice_2+"원");
      $("#payPrice").val(totalPrice_2+"원");
      $("#totalPayPrice").val(totalPrice_2+"원");
      $("#payPrice_2").val(totalPrice_2+"원");
      },error: function(){
         alert("아작스 실패");
      }
});
   
   $("input:radio[name=o_buy]").click(function(){
      
      if($("input:radio[name=o_buy]:checked").val()=='배달' && buyWay == false) {
         $("#plusPrice").val("+3,000원");
         
         let payPrice = $("#payPrice").val();
         payPrice = payPrice.replace("원","").replace("," , "");
         payPrice = parseInt(payPrice);
         
         let totalPayPrice = 3000 + payPrice;
         
         totalPayPrice = totalPayPrice.toLocaleString();
         $("#totalPayPrice").val(totalPayPrice+"원");
         
         buyWay = true;
      }else if($("input:radio[name=o_buy]:checked").val()=='픽업' && buyWay == true){
         
         let totalPayPrice = $("#totalPayPrice").val();
         totalPayPrice = totalPayPrice.replace("원","").replace(",","");
         totalPayPrice = parseInt(totalPayPrice);
         totalPayPrice = totalPayPrice - 3000;
         
         totalPayPrice = totalPayPrice.toLocaleString();
         $("#totalPayPrice").val(totalPayPrice+"원");
         $("#plusPrice").val("+0");
         buyWay = false;
      }
      });
});
</script>
</head>
 <style>
    .in_hidden{outline:none;}
    #x_button{
       margin-left: 250px;
    }
 </style>
<body>
<div style="margin:0 auto; width:650px; border:1px solid black; ">   
<h1>장바구니</h1>
     
<h2>주문 메뉴</h2><hr>
<form>
 <c:forEach items="${cartList}" var="cartMenu">
       <div>
          <input type="text" name="cartMenuName" class="in_hidden" value="${cartMenu.c_name}">
          <button type="button" onclick="deleteMenu('${cartMenu.c_no}', '<%= userId%>')" id="x_button">x</button><br>
          <img src="${pageContext.request.contextPath }/resources/img/${cartMenu.c_img}"
                  alt="${cartMenu.c_img}" title="${cartMenu.c_img}"
                  style="width: 100px; height: 100px">
         <input type="text" class="in_hidden" name="cartOption" size="1" width="5px;"value="${cartMenu.c_option}" readonly>/
         <input type="text" class="in_hidden" name="cartSize" size="1" value="${cartMenu.c_size}" readonly>
         <button type="button"  onclick="miu('${cartMenu.c_no}')">-</button>
         <input type="text" name="o_num" class="in_hidden" id="${cartMenu.c_no}" size="1" width="8px" value="${cartMenu.c_total}"  readonly>
         <input type="text" name="eachPrice" class="${cartMenu.c_no}" value='${cartMenu.c_price}' style="display:none;" readonly>
         <button type="button" onclick="plus('${cartMenu.c_no}')">+</button>
         <input type="text" size="10" name="${cartMenu.c_no}" class="cartMenuPrice" value="${cartMenu.c_toprice}" readonly>
       </div><hr>
</c:forEach>
<div>
         총 가격:<input type="text" class="in_hidden" id="allTotalPrice" name="allTotalPrice" value="" readonly><br>
         사용가능 포인트: <input type="number" id="savePoint" name="savePoint" value="" readonly><br>
         포인트 사용: <input type="text" name="o_usepoint" id="usePoint" value="0">
         <button type="button" onclick="outPoint()">적용하기</button><br>
         결제 금액:<input type="text" class="in_hidden" id="payPrice" value="" readonly>
</div><hr>
<div>
         주소 : <input type="text" name="o_address" id="o_address" class="in_hidden" value="" size="50"><br><hr>
         연락처 : <input type="text" name="o_phone" id="o_phone" value="">
         <div>배달방법</div>
         픽업<input type="radio" name="o_buy" value="픽업" checked>
         배달<input type="radio" name="o_buy" value="배달">
         <br>
            
         결제 금액:<input type="text" class="in_hidden" id="payPrice_2" value="" readonly><br>
         추가 금액 : <input type="text" class="in_hidden" id="plusPrice" value="+0" size="7"><br>
         총 결제금액 : <input type="text" class="in_hidden" id="totalPayPrice" value="" readonly>
         <hr>
         <br>
         닉네임:<input type="text" id="order_nick" value="" readonly>
         <input type="text" id="order_id" value="<%= userId%>" style="display:none;">
         <input type="text" id="order_email" value="" style="display:none;">
         
         <input type="text" id="merchant_uid" value="" style="display:none;">
</div>
</form>
         <button id="check_module" type="button" class="btn">결제하기</button>

</div>  
<%@include file="../css/footer.jsp"%>
</html>