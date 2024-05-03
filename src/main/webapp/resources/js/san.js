
$(document).ready(function(){ 
	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
	});
// 관리자 : 메뉴 추가	
	$("#mdinsert").click(function(){
		location.href = "insert.san";
	});

//관리자 : 메뉴 삭제	
	$("#mddelete").click(function(){
		let delNo = document.getElementById("no_input").value;
			if(confirm("메뉴를 삭제하시겠습니까?")){
				location.href = "deleteMd.san?m_no="+delNo;
		}else {
				location.href = "adminMd.san";
		}
		});
	
//관리자 : 메뉴 추가 페이지에서 메뉴 목록 불러오기 
	$("#mdList").click(function(){
		location.href = "adminMd.san";
	});

// 장바구니 토탈 가격 	
	$("#total").on("change", function() {

         let cnt = $("#total").val();
         let price = $("#getPrice").val();
         console.log("cnt "  + cnt);
         console.log("price " + price);
         price = price.replace("원", "");
         console.log("price " + price);
         
         price = price * cnt;

         $("#totalprice").val(price + "원");
      });
});  

//결제 관련 함수 시작 
// $(document).on("click", ".cancel_button", function () {
// 	let merchant_uid =   document.getElementById("merchant_uid").value; 
// 	$.ajax({
// 		url : "paycan",
// 		data : {"mid": merchant_uid,
// 				"uid" : imp_uid	
// 		},
// 		method : "POST",
// 		success : function(val){
// 			console.log(val);
// 			if(val==1){
// 				alert("취소 완료");
// 				$("#all_module").trigger("click");
// 			}
// 			else alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
// 		},
// 		error :  function(request, status){
// 			alert("취소가 실패하였습니다.");
// 		}
// 	});
// });

$(document).on("click", ".cancel_button", function () {
    var imp_uid = $(this).data("imp_uid"); // 데이터 속성에서 imp_uid 읽어오기
    cancelPayment(imp_uid); // 취소 함수 호출
});
//결제 취소 
function cancelPayment(imp_uid){
				console.log(imp_uid);
		$.ajax({
			url : "paycan",
			data : {"uid": imp_uid},
			method : "POST",
			success : function(val){
				console.log(val);
				if(val==1){
					alert("취소 완료");
					$("#all_module").trigger("click");
				}
				
				else alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
			},
			error :  function(request, status){
				alert("취소가 실패하였습니다.");
			}
			
		});
	}
	
//결제 연동
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

// 성공 결제 리스트 
$("#list_module").click(function(){
	$.ajax({
		url : "payamount",
		data : {"mid": $("#merchant_uid").val()},
		method : "GET",
//			contentType : 'application/json; charset=UTF-8',
		success : function(val){
			console.log(val);
			$("#paylist").empty();
			if(val.msg!=null){
				$("#paylist").append(val.msg);
			}else{
				$("#paylist").append("고유ID: "+val.imp_uid);
				$("#paylist").append("<br>상점 거래ID: "+val.merchant_uid);
				$("#paylist").append("<br>주문상품: "+val.name);
				$("#paylist").append("<br>주문자: "+val.buyer_name);
				$("#paylist").append("<br>결제금액: "+val.amount);
			}
		},
		error :  function(request, status){
			alert("목록 가져오기를 할 수 없습니다.");
		}
	});
});

//모든 결제 내역
$("#all_module").click(function(){
	$.ajax({
		url : "paylist",
		method : "GET",
//			contentType : 'application/json; charset=UTF-8',
		success : function(val){
			console.log(val);
			$("#paylist").empty();
			$.each(val, function(i, v){
// 				let cancelButton = "<button type='button' class='cancel_button' data-imp_uid='${v.imp_uid}' data-merchant_uid='${v.merchant_uid}'>취소</button>";
// 				let cancelButton = "<button type='button' class='cancel_button' data-imp_uid='" + v.imp_uid + "'>취소</button>";
// 				let cancelButton = "<button type='button' class='cancel_button' onclick="cancelPayment(v.imp_uid)">취소</button>";
// 				let cancelButton = "<button type='button' id='merchant_uid' class='cancel_button' value=v.imp_uid>취소</button>";
				$("#paylist").append("고유ID: "+v.imp_uid);
				$("#paylist").append("<br>상점 거래ID: "+v.merchant_uid);
				$("#paylist").append(
				`<button type='button' class='cancel_button' data-imp_uid='${v.imp_uid}' data-merchant_uid='${v.merchant_uid}'>취소</button>`		
// 				`<button type="button" class="cancel_button" onclick="cancelPayment(${imp_uid})">취소</button>`		
				);
				if(v.cancel_amount != 0 ) $("#paylist").append("<br><span style=\"color:red;font-weight:bold;\">주문취소</span>");
				else if(v.failed_at != 0 ) $("#paylist").append("<br><span style=\"color:pink;font-weight:bold;\">결제오류</span>");
				else $("#paylist").append("<br><span style=\"color:blue;font-weight:bold;\">결제완료</span>");
				$("#paylist").append("<br>주문상품: "+v.name);
				$("#paylist").append("<br>주문자: "+v.buyer_name);
				$("#paylist").append("<br>결제금액: "+v.amount+"<hr><br>");
			});
			 // 취소 버튼 클릭 이벤트 처리
//         	$(".cancel_button").click(function(){
//            	 	let imp_uid = $(this).data("imp_uid");
//             	cancelPayment(imp_uid);
//         });
			
		},
		error :  function(request, status){
			alert("목록 가져오기를 할 수 없습니다.");
		}
	});
});     

});

//결제완료 서브밋
function orderList(){
	alert('주문내역 처리할 곳. 컨트롤러 호출');
	let fm = document.fm;
	fm.action ="pay";
	fm.method="post";
	fm.submit();
}


// 관리자 : 수정하기 클릭 시 그 메뉴에 해당하는 정보 끌고오는 함수 
$(document).on("click", ".modify", function () {
    var m_no = $(this).val();
    let val = { m_no : m_no };
  	 $.ajax({
       url: "upgetMd.san", 
       type: "GET", 
       data: val, 
       success: function(response) { 

              $("#no_input").val(response.m_no);
              $("#img_input").attr("src", "../resources/img/"+ response.m_img);
              $("#img_input").attr("title", response.m_name);
              $("#img_input").attr("alt", response.m_name);
              $("#img2_input").val(response.m_img);
              $("#name_input").val(response.m_name);
              $("#price_input").val(response.m_price);
              $("#content_input").val(response.m_content);
              $("#keyword_input").val(response.m_kind);
              $("#sugar_input").val(response.m_sugar);
              $("#cal_input").val(response.m_kcal);
              $("#sfat_input").val(response.m_sfat);
              $("#na_input").val(response.m_nat);
              $("#protin_input").val(response.m_pro);
              $("#cof_input").val(response.m_cafe);
              $("#carbo_input").val(response.m_carbo);
              $("#fat_input").val(response.m_fat);
              $("#best_input").val(response.m_sel);
              $("#state_input").val(response.m_state);
         
       },
       error: function(xhr, status, error) { 
           console.error("Ajax 요청 실패:", status, error);
       }
   });
   });
   
//관리자 : 이미지 수정 관련 
function newimg(event) {
        var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          img.setAttribute("title", "이미지 준비");
          img.setAttribute("alt", "이미지 준비");
          document.querySelector("div#image_container").appendChild(img);
          
          document.getElementById("image_container").style.display = "block";
          document.getElementById("imgchange").style.display = "block";
        };

        reader.readAsDataURL(event.target.files[0]);
      }
 //관리자 : 이미지 수정 업로드 후 취소 했을 때 실행되는 함수  
 function delimg() {
    document.getElementById("img1_input").value = ""; 
    document.getElementById("img1_input").src = ""; 
//  document.querySelector("#image_container > img").remove();
    document.querySelector("#image_container").replaceChildren();
    document.getElementById("image_container").style.display = "none"; 
    document.getElementById("imgchange").style.display = "none";
}

// 전체 메뉴 클릭 시 실행되는 함수 //회원, 관리자에 따라 나누기 
function allMd(val){
	location.href = val;
}

//검색에 사용되는 함수 
function search(){
 	let seCon = document.getElementById("sel1").value;
    let seKey = document.getElementById("key1").value;
	let objParams = {searchCondition : seCon ,searchKeyword : seKey };
	console.log(seCon, seKey);
	let values = [];
	$.ajax({
		type : "POST",
		url : "search.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
		
            $('#cardall').empty(); 
			values = data.searchList;
			$.each(values, function(index, value){
				
				$("#cardall").append(
                    `
                     <div class="card">
                        <img class="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}" style="width:100%; height: 350px">
                        <div class="card-body">
                            <h4 class="card-title">${value.m_name}</h4>
                            <p class="card-text">가격 : ${value.m_price} 원</p>
                            <p class="card-text">${value.m_content}</p>
                            <button type="button" class="btn" onclick="">상세보기</button>
                            <button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value="${value.m_no}">메뉴수정</button>
                        </div>
                    </div><br>`
  )
			});
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}

//키워드 별로 메뉴 리스트 가져오는 함수 
function selectkind(val){
	let objParams = {m_kind: val};
	let values = [];
	$.ajax({
		type : "POST",
		url : "kind.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
		
            $('#cardall').empty(); 
			values = data.kindList;
			$.each(values, function(index, value){
				
				$("#cardall").append(
                    ` <div class="card">
                        <img class="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}" style="width:100%; height: 350px">
                        <div class="card-body">
                            <h4 class="card-title">${value.m_name}</h4>
                            <p class="card-text">가격 : ${value.m_price} 원</p>
                            <p class="card-text">${value.m_content}</p>
                            <button type="button" class="btn" onclick="">상세보기</button>
                            <button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value="${value.m_no}">메뉴수정</button>
                        </div>
                    </div><br>`
  )
			});

		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}

//메뉴 상세보기 클릭 시 옵션 보여지게 
function list(val, val_2){
   let no = val;
   let keyword = val_2;
   console.log("keyword" + keyword);
   let data = { m_no : no };
   console.log("data : " + no);
     $.ajax({
        url : "getMd.san",
        type : "POST",
        data : data,
      success: function(data){
      
     if(keyword === '에이드' || keyword === '프라페' ){
        $("#label_HOT").hide();
        $("#HOT").hide();
        $("#ICE").show();
        $("#label_ICE").show();
        $("#Tall").show();
        $("#label_Tall").show();
        $("#Grande").show();
        $("#label_Grande").show();
        $("#ICE").prop("checked", true);
         let content = data.m_content;
         $("#total").val(1);
        $("#getName").val(data.m_name);
        $("#getContent").html(content);
        $("#getPrice").val(data.m_price + "원");
        $("#totalprice").val(data.m_price + "원");
        $("#Mdimg").attr("src", "../resources/img/"+data.m_img);
        $("#Mdimg").attr("title", data.m_name);
        $("#Mdimg").attr("alt", data.m_name);
     }else if(keyword === '커피' || keyword === '논커피' || keyword === '티'){
        $("#label_HOT").show();
        $("#HOT").show();
        $("#label_ICE").show();
        $("#ICE").show();
        $("#Tall").show();
        $("#label_Tall").show();
        $("#Grande").show();
        $("#label_Grande").show();
        let content = data.m_content;
         $("#total").val(1);
        $("#getName").val(data.m_name);
        $("#getContent").html(content);
        $("#getPrice").val(data.m_price + "원");
        $("#totalprice").val(data.m_price + "원");
        $("#Mdimg").attr("src", "../resources/img/"+data.m_img);
        $("#Mdimg").attr("title", data.m_name);
        $("#Mdimg").attr("alt", data.m_name);
     }else if(keyword === '디저트'){
        $("#label_HOT").hide();
        $("#HOT").hide();
        $("#label_ICE").hide();
        $("#ICE").hide();
        $("#label_Tall").hide();
        $("#Tall").hide();
        $("#label_Grande").hide();
        $("#Grande").hide();
        let content = data.m_content;
         $("#total").val(1);
        $("#getName").val(data.m_name);
        $("#getContent").html(content);
        $("#getPrice").val(data.m_price + "원");
        $("#totalprice").val(data.m_price + "원");
        $("#Mdimg").attr("src", "../resources/img/"+data.m_img);
        $("#Mdimg").attr("title", data.m_name);
        $("#Mdimg").attr("alt", data.m_name);
     }
     },
     error: function(){
        alert("아작스 실패");
     }
  });
}

// 상품 담은 후 다른메뉴 보기 이동 =>  onclick="othermenu()"
   function othermenu(){
      location.href="../selectList.san";
   }
   
// 영양정보 가져오기(모달 사용) 기본은 Tall 사이즈로 => onclick="content()"
   function content(){ /*  아작스 써서 데이터 넣기 mdContent.jsp에 */
      let name = $("#getName").val();
      let val = { m_name : name };
      $.ajax({
         url : "getContent.san",
         type : "POST",
         data : val,
         success: function(data){
            let kind = data.m_kind;
            console.log("content 안 kind :" + kind);
            if(kind != '디저트'){
            $("#content_Size").empty();
            $(".content").val("");
            $(".sizeContent").show();
            $("#content_Size").text("366ml");
            $("#content_Kcal").val("칼로리:"+data.m_kcal+"Kcal");            
            $("#content_CarBo").val("탄수화물:"+data.m_carbo+"g");            
            $("#content_Sugar").val("당류:"+data.m_sugar+"g");            
            $("#content_Nat").val("나트륨:"+data.m_nat+"mg");            
            $("#content_Pro").val("단백질:"+data.m_pro+"g");            
            $("#content_Fat").val("지방:"+data.m_fat+"g");            
            $("#content_Sfat").val("포화지방:"+data.m_sfat+"g");            
            $("#content_Cafe").val("카페인:"+data.m_cafe+"mg");
            }else if(kind === '디저트'){
               $("#content_Size").empty();
               $("#content_Size").text("디저트");
               $(".sizeContent").hide();
               $(".content").val("");
               $("#content_Kcal").val("칼로리:"+data.m_kcal+"Kcal");            
               $("#content_CarBo").val("탄수화물:"+data.m_carbo+"g");            
               $("#content_Sugar").val("당류:"+data.m_sugar+"g");            
               $("#content_Nat").val("나트륨:"+data.m_nat+"mg");            
               $("#content_Pro").val("단백질:"+data.m_pro+"g");            
               $("#content_Fat").val("지방:"+data.m_fat+"g");            
               $("#content_Sfat").val("포화지방:"+data.m_sfat+"g");   
            }
         },
         error: function(){
            alert("아작스 실패")
         }
      });
   }
   
// 장바구니 이동
   function cartMove(){
      let id = 'sung';
      location.href="getCartList.san?c_id="+id;
   }
      
//영양정보 안에 사이즈 클릭시 사이즈에 관한 영양정보
   function sizeContent(menuSize){
      let size = menuSize;
      let name = $("#getName").val();
      let val = { m_name : name };
      $.ajax({
         url : "getContent.san",
         type : "POST",
         data : val,
         success: function(data){
            let kind = data.m_kind;
            console.log("kind 사이즈 : " + kind);
            if(size === "Tall" && kind != '디저트'){
               $("#content_Size").empty();
               $(".content").val("");
               $(".sizeContent").show();
               $("#content_Size").text("366ml");
               $("#content_Kcal").val("칼로리:"+data.m_kcal+"Kcal");            
               $("#content_CarBo").val("탄수화물:"+data.m_carbo+"g");            
               $("#content_Sugar").val("당류:"+data.m_sugar+"g");            
               $("#content_Nat").val("나트륨:"+data.m_nat+"mg");            
               $("#content_Pro").val("단백질:"+data.m_pro+"g");            
               $("#content_Fat").val("지방:"+data.m_fat+"g");            
               $("#content_Sfat").val("포화지방:"+data.m_sfat+"g");            
               $("#content_Cafe").val("카페인:"+data.m_cafe+"mg");   
            }else if(size === "Grande" && kind != '디저트'){
               $("#content_Size").empty();
               $(".content").val("");
               $(".sizeContent").show();
               $("#content_Size").text("512ml");
               $("#content_Kcal").val("칼로리:"+(data.m_kcal*1.3).toFixed(1).replace(".0","")+"Kcal");            
               $("#content_CarBo").val("탄수화물:"+(data.m_carbo*1.25).toFixed(1).replace(".0","")+"g");            
               $("#content_Sugar").val("당류:"+(data.m_sugar*1.29).toFixed(1).replace(".0","")+"g");            
               $("#content_Nat").val("나트륨:"+(data.m_nat*1.27).toFixed(1).replace(".0","")+"mg");            
               $("#content_Pro").val("단백질:"+(data.m_pro*1.36).toFixed(1).replace(".0","")+"g");            
               $("#content_Fat").val("지방:"+(data.m_fat*1.28).toFixed(1).replace(".0","")+"g");            
               $("#content_Sfat").val("포화지방:"+(data.m_sfat*1.31).toFixed(1).replace(".0","")+"g");            
               $("#content_Cafe").val("카페인:"+(data.m_cafe*1.38).toFixed(1).replace(".0","")+"mg");   
               
            }else if(kind === '디저트'){
               $("#content_Size").empty();
               $("#content_Size").text("디저트");
               $(".sizeContent").hide();
               $(".content").val("");
               $("#content_Kcal").val("칼로리:"+(data.m_kcal*1.3).toFixed(1).replace(".0","")+"Kcal");            
               $("#content_CarBo").val("탄수화물:"+(data.m_carbo*1.25).toFixed(1).replace(".0","")+"g");            
               $("#content_Sugar").val("당류:"+(data.m_sugar*1.29).toFixed(1).replace(".0","")+"g");            
               $("#content_Nat").val("나트륨:"+(data.m_nat*1.27).toFixed(1).replace(".0","")+"mg");            
               $("#content_Pro").val("단백질:"+(data.m_pro*1.36).toFixed(1).replace(".0","")+"g");            
               $("#content_Fat").val("지방:"+(data.m_fat*1.28).toFixed(1).replace(".0","")+"g");            
               $("#content_Sfat").val("포화지방:"+(data.m_sfat*1.31).toFixed(1).replace(".0","")+"g");
               $("#content_Cafe").val("");
            }
         }, error: function(){
            alert("아작스 실패");
         }
      });
   }
//상세보기에서 영양정보(서브모달) 닫는 함수 
function subModalClose(){
   document.querySelector("#subModal").style.display="none";
   document.getElementsByClassName("modal-backdrop")[1].remove();
}

//   상품 담기 =>  onclick="cartInsert()"
function cartInsert() {
   let id = 'sung'; // session으로 값 받기
   let cname = $("#getName").val();
   let opt =  $("input:radio[name=opt]:checked").val();
   let size = $("input:radio[name=sel]:checked").val();
   let kind = $("#getKind").val();
   let firstVal;
   if(kind != '디저트'){
   firstVal = {
         c_id : id,
         c_name : cname,
         c_option : opt,
         c_size : size,
   };
   }else if(kind === '디저트'){
      firstVal = {
      c_id : id,
      c_name : cname,
      c_option : '-',
      c_size : '-',
      };
   }
   $.ajax({
      url : "ListCheck.san",
      type : "POST",
      data : firstVal,
      success: function(data){
         if(data.c_name == null && data.c_option == null && data.c_id == null && data.c_size == null){
            let secondVal;
            let img = document.getElementById('Mdimg').getAttribute('src');
            img = img.split('/');
            img = img[img.length -1];
            let totalprice = $("#totalprice").val();
            let price = $("#getPrice").val();
            totalprice = totalprice.replace("원", "");
            price = price.replace("원", "");
            console.log("totalprice : " + totalprice);
            
            if(kind != '디저트'){
            secondVal = {
               c_id : id,
               c_name :  cname,
               c_total : $("#total").val(),
               c_price : price.trim(),
               c_option : opt,
               c_size : size,
               c_toprice : totalprice.trim(),
               c_img : img.trim(),
            };
            }else if(kind === '디저트'){
            secondVal = {
               c_id : id,
               c_name :  cname,
               c_total : $("#total").val(),
               c_price : price.trim(),
               c_option : '-',
               c_size : '-',
               c_toprice : totalprice.trim(),
               c_img : img.trim(),
            };
            }
            $.ajax({
               url : "insertCart.san",
               type : "POST",
               data : secondVal,
               success : function(res) {
                  alert("장바구니 등록");
                  $("#other_menu").show();
                  $("#order").show();
               },
               error : function(xhr, error) {
                  alert("장바구니담기 실패");
               }
            });
         } // null 확인 중괄호
         
         
         else{
            let thirdVal;
            let total = data.c_total; // 상품갯수 가져옴
            let toPrice = data.c_toprice; // 토탈 가격
            let totalprice = $("#totalprice").val(); // 상품 총 가격
            totalprice = totalprice.replace("원", ""); // 상품 총 가격
            totalprice = parseInt(totalprice, 10);
            
            let total_2 = $("#total").val();
            total_2 = parseInt(total_2, 10);
            toPrice = toPrice + totalprice;
            total = total + total_2;
            
            console.log("id :" + id);
            console.log("cname :" + cname);
            console.log("toPrice :" + toPrice);
            console.log("total :" + total);
            console.log("opt :" + opt);
            console.log("size :" + size);
            
            if(kind != '디저트'){
            thirdVal = {
               c_id : id,
               c_name :  cname,
               c_total : total,
               c_toprice : toPrice,
               c_option : opt,
               c_size : size,
            };
            }else if(kind === '디저트'){
            thirdVal = {
               c_id : id,
               c_name :  cname,
               c_total : total,
               c_toprice : toPrice,
               c_option : '-',
               c_size : '-',
            };
            }
            $.ajax({
               url : "UpdateCart.san",
               type : "POST",
               data : thirdVal,
               success : function(res) {
                  alert("장바구니 업데이트 완료");
                  $("#other_menu").show();
                  $("#order").show();
               },
               error : function(xhr, error) {
                  alert("장바구니담기 실패");
               }
            });
         }
      },error: function(){
         alert("아작스 실패");
      }
   });
}

// Tall 이랑 Grande 설정시 가격 변동
$(document).ready(function(){ 
// Tall 사이즈랑 Grande 사이즈 변경시 필요한 변수

   let msize = false;
$("input:radio[name=sel]").click(function(){
   
   console.log("msize "+ msize);
   let price = $("#getPrice").val().replace("원", "");
   price = parseInt(price, 10);
   console.log("price : " + price);
   if($("input:radio[name=sel]:checked").val()=='Grande' && msize == false) { // Grande 일때
      
      price = price * 1.2;
      console.log(" if문 price" + price);
//       $("#total").val("");
      $("#total").val(1);
      $("#getPrice").val("");
      $("#totalprice").val("");
      $("#getPrice").val(price+"원");
      $("#totalprice").val(price+"원");
      
      msize = true;
   }else if($("input:radio[name=sel]:checked").val()=='Tall' && msize == true){
      price = price / 1.2;
      $("#total").val(1);
      $("#getPrice").val("");
      $("#totalprice").val("");
      $("#getPrice").val(price+"원");
      $("#totalprice").val(price+"원");
      
      msize = false;
   }
});
});


