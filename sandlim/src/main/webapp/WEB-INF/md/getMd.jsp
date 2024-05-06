<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>
<style>
   input{border:none; }
</style>

<!-- 모달창이라 헤더,풋터,등 넣으면 안돼요  -->
<body>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel1">메뉴 상세</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
      </div>
      <div class="modal-no"></div>
        <form name="frm">
      <div class="modal-body">
      <div>
            <img id="Mdimg" style="width: 100%; height: 450px">
            <input type="text" value="" id="getKind" style="display:none;">
            <input type="text" id="getName" name="getName" value="" readonly>
            <p id="getContent"></p>
            <input type="text" id="getPrice" name="getPrice" value="" readonly>
<!--             <button type="button" id="contentList" onclick="content()" data-toggle="modal" data-target="#mdContent">영양정보 보기</button> -->
         <br>
            <label for="HOT" id="label_HOT">HOT
            <input type="radio" id="HOT" name="opt" value="HOT" checked>
            </label> 
            <label for="ICE" id="label_ICE">ICE
            <input type="radio" id="ICE" name="opt" value="ICE">
            </label> 
            <br>
            <label for="Tall" id="label_Tall">Tall
            <input type="radio" id="Tall" name="sel" value="Tall" checked>
            </label>
            <label for="Grande" id="label_Grande">Grande 
            <input type="radio" id="Grande" name="sel" value="Grande">
            </label>
            <br>
            <button type="button" id="contentList" onclick="content()" data-toggle="modal" data-target="#mdContent">영양정보 보기</button>
            <br>
            <label for="total"> 수량
            <input type="number" name="c_total" value="1" id="total" min="1" max="99">
            </label> 
            <input id="totalprice" value="" readonly>
            <br>
            <button type="button" id="cart_insert" onclick="cartInsert()">장바구니에 담기</button>
            <br>
            <button type="button" id="other_menu" onclick="othermenu()">다른 메뉴 더보기</button>
            <button type="button" id="order" onclick="cartMove()">장바구니 이동</button>

      </div>
      </div>

      <div class="modal-footer">
<!--         <button type="button" class="btn btn-primary" style="background-color:lightgreen; border:none; color:#fff" onclick="cartInsert()" id="cart_insert" >담기</button> -->
<!--         <button type="button" class="btn btn-default" style="background-color:lightgreen; border:none; color:#fff" data-dismiss="modal">취소</button> -->
      </div>
</form>
    </div>
  </div>
<div class="modal fade" id="mdContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<%@ include file='mdContent.jsp' %>
</div>

</body>