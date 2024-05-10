<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "com.one.view.controller.UserController" %>
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>
<!-- 모달창이라 헤더,풋터,등 넣으면 안돼요  -->
<script>
$(document).ready(function(){ 
   document.querySelector("#other_menu").style.display="none";
   document.querySelector("#order").style.display="none";
});
</script>
<style>
#cart_in{
text-align: center;

}
#cart_insert{
       width: 150px;
        height: 40px;
        background-color: #272727;
        color: #f9f5f2;
        font-family: border;
       margin-top: 30px;
      }
#cart_insert:hover{
        background-color : #f9f5f2;
      color : #272727;
       font-family: bold;
}
.cartmove:hover{
        background-color : #f9f5f2;
      color : #272727;
       font-family: bold;
}
.cartmove{
       width: 150px;
        height: 40px;
        background-color: #272727;
        color: #f9f5f2;
        font-family: border;
       margin-top: 30px;
}
#cart_move, #contentbtn{
   text-align: center;
}
#order{
   margin-left: 15px;
}
#other_menu{
   margin-right: 15px;
}
#getName{
   font-size: 25px;
   font-weight: bold;
}
#getPrice{
   font-size: 25px;
   font-weight: bold;
}
#getKind{
   display:none;
}
#getContent{
   margin-top: 5px; 
}
#selectSize{
   padding: 5px 0px;
   text-align: center;
}
#HOT, #ICE{
   appearance: none;
}
#selectSize input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
    height: 38px;
    width: 170px;
    border: 1px solid #333;
    line-height: 24px;
    font-size: 18px;
    text-align: center;
    font-weight:bold;
}
#label_HOT, #label_ICE{
   font-size : 20px;
   vertical-align: middle;
}
#selectSize input[type=radio]+label{
    background-color: #fff;
    color: #333;
}
#selectSize input[type=radio]:checked+label{
    background-color: #f9f5f2;
    color: #272727;
}

#selectOption{
   padding: 5px 0px;
   text-align: center;
}
#Tall, #Grande{
   appearance: none;
}
#selectOption input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
    height: 38px;
    width: 170px;
    border: 1px solid #333;
    line-height: 24px;
    font-size: 18px;
    text-align: center;
    font-weight:bold;
}
#label_Tall, #label_Grande{
   font-size : 20px;
}
#selectOption input[type=radio]+label{
    background-color: #fff;
    color: #333;
}
#selectOption input[type=radio]:checked+label{
    background-color: #f9f5f2;
    color: #272727;
}

#contentList{
   background-color: white;
   width: 350px;
   border-radius: 50px;
}
#total{
   width: 25px;
}
#contentbtn{
   margin-bottom: 15px;
}
#totalprice{
   text-align: right;
}
#d_totalprice{
   margin-left: 3px;
}
</style>

<%
   String id = (String) session.getAttribute("userId");
%>
<body>
  <div class="modal-dialog" id="mainModal">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel1">메뉴 상세</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="mainModalClose()">×</button>
      </div>
      <div class="modal-no"></div>
        <form name="frm">
      <div class="modal-body">
      <div>
            <img id="Mdimg" style="width: 100%;">
            <input type="text" class="in_hidden" value="" id="getKind">
            <input type="text" class="in_hidden" id="getName" name="getName" value="" readonly>
            <input type="text" id="getPrice_hide" value="" style="display:none;">
            <p id="getContent"></p>
            <input type="text" class="in_hidden" id="getPrice" name="getPrice" value="" readonly>
         <div id="selectSize">
            <input type="radio" id="HOT" name="opt" value="HOT" checked><label for="HOT" id="label_HOT">HOT</label> 
            <input type="radio" id="ICE" name="opt" value="ICE"><label for="ICE" id="label_ICE">ICE</label>
            </div>
            <div id="selectOption">
            <input type="radio" id="Tall" name="sel" value="Tall" checked><label for="Tall" id="label_Tall">Tall</label>
            <input type="radio" id="Grande" name="sel" value="Grande"><label for="Grande" id="label_Grande">Grande</label>
            </div> 
            <div id="contentbtn">
            <button type="button" id="contentList" onclick="content()" data-toggle="modal" data-target="#mdContent">영양정보 보기</button>
            </div>
            <div>
            <div id="d_totalprice">
            <button type="button" onclick="toMiu()">-</button>
            <input type="text" size="2" class="in_hidden" name="c_total" value="1" id="total" readonly>
            <button type="button" onclick="toPlus()">+</button>
            <input id="totalprice" size="23" class="in_hidden" value="" readonly>
            </div>
            </div>
            <div id="cart_in">
            <button type="button" id="cart_insert" onclick="cartInsert('<%= id%>')">장바구니 담기</button>
            </div>
            <div id="cart_move">
            <button type="button" class="cartmove" id="other_menu" onclick="othermenu()">다른 메뉴 더보기</button>
            <button type="button" class="cartmove" id="order" onclick="cartMove()">장바구니 이동</button>
            </div></div></div>
      <div class="modal-footer"></div></form></div></div>
<div class="modal fade" id="mdContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  data-backdrop='static' data-keyboard='false'>
<%@ include file='mdContent.jsp' %>
</div>
</body>