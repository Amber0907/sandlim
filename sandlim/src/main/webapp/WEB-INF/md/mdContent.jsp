<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.js"></script>
<!-- 모달창이라 헤더,풋터 넣으면 안돼요  -->
  <div class="modal-dialog" id="subModal">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel1_2">영양정보 보기</h4>
<!--         <button type="button" id="contentClose" class="close" data-dismiss="modal" aria-label="Close">×</button> -->
        <button type="button" id="contentClose" class="close" onclick="subModalClose()">×</button>
      </div>
      <div class="modal-no"></div>
      <div class="modal-body">
      <div>
			<button type="button" class="sizeContent" onclick="sizeContent('Tall')">Tall</button>
			<button type="button" class="sizeContent" onclick="sizeContent('Grande')">Grande</button>
			<br><br>
			<p id="content_Size"></p>
			<input type="text" id="content_Kcal" class="content" value="" readonly>
			<input type="text" id="content_CarBo" class="content" value="" readonly>
			<input type="text" id="content_Sugar" class="content" value="" readonly>
			<input type="text" id="content_Nat" class="content" value="" readonly>
			<input type="text" id="content_Pro" class="content" value="" readonly>
			<input type="text" id="content_Fat" class="content" value="" readonly>
			<input type="text" id="content_Sfat" class="content" value="" readonly >
			<input type="text" id="content_Cafe" class="content" value="" readonly>
      </div>
      </div>

      <div class="modal-footer">
      </div>
    </div>
  </div>
</body>
