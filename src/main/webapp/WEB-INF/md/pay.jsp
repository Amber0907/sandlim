<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>

<!-- 
	 혹시 결제 에러나면 위에 header.jsp주석처리해서 테스트 해보세요  
	 관리자 주문 취소와 결제페이지 스크립트가 같아서 외부 스크립트 파일로 빼놨더니 
	 결제 시 에러 발생해서 jsp에 직접 기술해놨어요 
-->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
//결제 관련 함수 시작 
var chk = false;
$(document).ready(function(){
var IMP = window.IMP;
IMP.init('${impKey}');
var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
   
if(!isMobile) {
	//모바일이 아닌 경우 스크립트
	$("#check_module").click(function () {
		IMP.request_pay({
 			pg:'danal_tpay', 
			pay_method: 'card',
			merchant_uid: 'merchant_' + new Date().getTime(),
			name: '주문명:결제테스트',
			amount: $("#amount").val(),
			buyer_email: $("#umail").val() ,
			buyer_name: $("#unm").val() ,
			buyer_tel: $("#utel").val() ,
			buyer_addr: $("#uaddr").val() ,
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
				if(chk==true) orderList();
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
// 			popup : false // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
			}, function (rsp) {
				console.log(rsp);
			
		});
	});
}  
});

//결제완료 서브밋
function orderList(){
	alert('주문내역 처리할 곳. 컨트롤러 호출');
	let fm = document.fm;
	fm.action ="pay";
	fm.method="post";
	fm.submit();
}

</script>

</head>
<body>
<%@ include file="../css/menu.jsp" %>
<form name="fm">
<!-- <div style="position:sticky;top:0;left:0;background-color:#fff;padding-bottom:20px;border-bottom:1px solid #000;"> -->
	<h2>주문 결제 페이지</h2><br>
	<div>
	주문 메뉴 쭈루룩 
	</div>
	이름: <input type="text" name="unm" id="unm" placeholder="이름 입력"><br>
	전화번호: <input type="text" name="utel" id="utel" placeholder="예시: 010-1111-2222"><br>
	이메일: <input type="text" name="umail" id="umail" placeholder="이메일 입력"><br>
	주소: <input type="text" name="uaddr" id="uaddr" placeholder="주소 입력"><br>
	금액: <input type="number" name="amount" id="amount" ><br>	
	<button id="check_module" type="button" class="btn">결제하기</button>
	<br>
</form>
  <%@include file="../css/footer.jsp"%>
</body>
</html>