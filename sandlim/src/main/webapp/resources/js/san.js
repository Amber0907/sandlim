$(document).ready(function(){ 
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

//결제 취소 
function cancelPayment(merchant_uid){
			let mid = merchant_uid;	
			console.log(mid);
		
		$.ajax({
			url : "paycan",
			data : {"mid": mid},
			method : "POST",
			success : function(val){
				console.log(val);
				if(val==1){
					alert("취소 완료");
				//	$("#all_module_${val.o_no}").trigger("click");
				}
				else alert("취소 실패\n이미 취소되었거나 잘못된 정보입니다.");
			},
			error :  function(request, status){
				alert("취소가 실패하였습니다.");
			}
			
		});
		
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


// 전체 메뉴 클릭 시 실행되는 함수 
function allMd(val){
	location.href = val;
}
//관리자 주문 영수증


//검색에 사용되는 함수 
function search(){
 	let seCon = document.getElementById("sel1").value;
    let seKey = document.getElementById("key1").value;
	let objParams = {searchCondition : seCon ,searchKeyword : seKey };
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
				let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span></span>';
				$("#cardall").append(
                    `
                    <div class="col-lg-3 col-md-6 col-sm-10 mdcard">
                     <div class="card">
                        <img class="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}">
                        <div class="card-body">
                            <h5 class="card-title">${value.m_name}</h5>
                            <p class="card-text">가격 : ${value.m_price} 원</p>
                             ${m_state}
                             <button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button>
                        </div>
                        </div>
                    </div><br>
                    `
  )
			});

		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}
//관리자 날짜로 검색
function oddate(){
	let oddate = document.getElementById("oddate").value;
	let objParams = {o_date : oddate};
	$.ajax({
		tyoe : "POST",
		url : "dateSearch.san",
		data : objParams,
		chche : false, 
		success : function(data){
		   $('#paylist').empty();
            values = data.ddsearch;
            values.forEach(function(od) {
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
                            ${od.o_state === '주문접수중' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('주문접수', '${od.o_no}')">주문접수</button>` : ''}
                            ${od.o_state === '주문진행중' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('제조완료', '${od.o_no}')">제조완료</button>` : ''}
                            ${od.o_state === '제조완료' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('픽업완료', '${od.o_no}')">픽업완료</button>` : ''}
                            ${od.o_state === '픽업완료' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('완료', '${od.o_no}')">완료</button>` : ''}
                        </td>
                        <td><button type='button' class='btn' id="all_module_${od.o_no}" onclick="cancelPayment('${od.o_no}')">취소</button></td>
                    </tr>
                `);
            });
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	
	});
}
//여기서 실험 시작 ------------------------------------------------------------------------------------------------------


//여기서 실험 끝 ------------------------------------------------------------------------------------------------------

//관리자 검색에 사용되는 함수 
function adminsearch(){
 	let seCon = document.getElementById("sel1").value;
    let seKey = document.getElementById("key1").value;
	let objParams = {searchCondition : seCon ,searchKeyword : seKey };
	let values = [];
	$.ajax({
		type : "POST",
		url : "search.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
		
			   $('#admdlist').empty();
               values = data.searchList; 
               
               $.each(values, function(index, value){
               let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span style="color:gray; font-weight:bold;">판매가능</span>';
				 $("#admdlist").append(
                   	 ` 
					   <tr>
					   <td> <img class="mdimg" id="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}" style="width:150px; height: 150px"></td>
					   <td>${value.m_name}</td>
					   <td>${value.m_price} 원</td>
					   <td>${value.m_content}</td>
					   <td>${m_state}</td>
					   <td><button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button></td>
					   <td><button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value= "${value.m_no}">메뉴수정</button></td>
					   </tr>
                    `
  				 );
  			 });

		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}

//상태변경
function modiod(val, val2){
	location.href = "updateOd.san?o_state=" + val + "&o_no=" + val2;
	console.log(val);
	console.log(val2);
}

//관리자 주문 검색에 사용되는 함수
function odsearch() {
    let seCon = document.getElementById("sel2").value;
    let seKey = document.getElementById("key2").value;
    let objParams = { searchCondition: seCon, searchKeyword: seKey };
    let values = [];
    $.ajax({
        type: "POST",
        url: "odsearch.san",
        data: objParams,
        cache: false,
        success: function(data) {
            $('#paylist').empty();
            $('#pagediv').empty();
            values = data.odsearch;
            values.forEach(function(od) {
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
                            ${od.o_state === '주문 확인중' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('주문접수', '${od.o_no}')">주문접수</button>` : ''}
                            ${od.o_state === '주문진행중' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('제조완료', '${od.o_no}')">제조완료</button>` : ''}
                            ${od.o_state === '제조완료' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('픽업완료', '${od.o_no}')">픽업완료</button>` : ''}
                            ${od.o_state === '픽업완료' ? `<button type='button' class='btn modiod-button' id="modiod_${od.o_no}" onclick="modiod('완료', '${od.o_no}')">완료</button>` : ''}
                        </td>
                        <td><button type='button' class='btn' id="all_module_${od.o_no}" onclick="cancelPayment('${od.o_no}')">취소</button></td>
                    </tr>
                `);
            });
        },
        error: function(request, status) {
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
            let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span></span>';
				$("#cardall").append(
				
                    `
                    <div class="col-lg-3 col-md-6 col-sm-10 mdcard"> 
                    <div class="card">
                        <img class="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}">
                        <div class="card-body">
                            <h5 class="card-title">${value.m_name}</h5>
                            <p class="card-text">가격 : ${value.m_price} 원</p>
                            ${m_state}
                           <button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">주문하기</button>
                        </div>
                       </div>
                    </div>`
  );
                   
			});
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}

//관리자 키워드별 메뉴
function adminkind(val){
	let objParams = {m_kind: val};
	let values = [];

	$.ajax({
		type : "POST",
		url : "kind.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
            $('#admdlist').empty();
               values = data.kindList; 
               
                $.each(values, function(index, value){
                let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span style="color:gray; font-weight:bold;">판매가능</span>';
				  $("#admdlist").append(
                   	 ` 
					   <tr>
					   <td> <img class="mdimg" id="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}" style="width:150px; height: 150px"></td>
					   <td>${value.m_name}</td>
					   <td>${value.m_price} 원</td>
					   <td>${value.m_content}</td>
					   <td>${m_state}</td>
					   <td><button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button></td>
					   <td><button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value= "${value.m_no}">메뉴수정</button></td>
					   </tr>
                    `
  				  );
  				}); 
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}
// 품절 메뉴
function soldList(val){
	let objParams = {m_state: val};
	let values = [];

	$.ajax({
		type : "POST",
		url : "sold.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
            $('#admdlist').empty();
               values = data.soldList; 
               
                $.each(values, function(index, value){
                let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span style="color:gray; font-weight:bold;">판매가능</span>';
				  $("#admdlist").append(
                   	 ` 
					   <tr>
					   <td> <img class="mdimg" id="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}" style="width:150px; height: 150px"></td>
					   <td>${value.m_name}</td>
					   <td>${value.m_price} 원</td>
					   <td>${value.m_content}</td>
					   <td>${m_state}</td>
					   <td><button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">상세보기</button></td>
					   <td><button type="button" class="btn modify" id="modify" data-toggle="modal" data-target="#myModal" value= "${value.m_no}">메뉴수정</button></td>
					   </tr>
                    `
  				  );
  				}); 
		},
		error:function(request, status){
			alert("오류가 발생했습니다.");
		}
	});
}
//주문 가능한 메뉴만 보기
function okList(val){
	let objParams = {m_state: val};
	let values = [];

	$.ajax({
		type : "POST",
		url : "sold.san", 
		data : objParams, 
		cache : false, 
		success : function(data){
		
            $('#cardall').empty(); 
            values = data.soldList;
            $.each(values, function(index, value){
            let m_state = value.m_state === "품절" ? '<span style="color:red; font-weight:bold;">SOLD OUT</span>' : '<span></span>';
				$("#cardall").append(
                    `
                    <div class="col-lg-3 col-md-6 col-sm-10 mdcard"> 
                    <div class="card">
                        <img class="mdimg" src="../resources/img/${value.m_img}" alt="${value.m_name}" title="${value.m_name}">
                        <div class="card-body">
                            <h5 class="card-title">${value.m_name}</h5>
                            <p class="card-text">가격 : ${value.m_price} 원</p>
                            ${m_state}
                           <button type="button" id="List" class="btn" onclick="list('${value.m_no}', '${value.m_kind}' )" data-toggle="modal" data-target="#listModal">주문하기</button>
                        </div>
                        </div>
                    </div><br>`
  );
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
   let data = { m_no : no };
     $.ajax({
        url : "getMd.san",
        type : "POST",
        data : data,
      success: function(data){
      
     if(keyword === '에이드' || keyword === '프라페' ){
        $("#getKind").val("");
        $("#getKind").val(keyword);
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
        $("#getPrice_hide").val(data.m_price);
        let m_price = data.m_price;
        m_price = m_price.toLocaleString();
        $("#getPrice").val(m_price + "원");
        $("#totalprice").val(m_price + "원");
        $("#Mdimg").attr("src", "../resources/img/"+data.m_img);
        $("#Mdimg").attr("title", data.m_name);
        $("#Mdimg").attr("alt", data.m_name);
     }else if(keyword === '커피' || keyword === '논커피' || keyword === '티'){
         $("#getKind").val("");
        $("#getKind").val(keyword);
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
        $("#getPrice_hide").val(data.m_price);
        let m_price = data.m_price;
        m_price = m_price.toLocaleString();
        $("#getPrice").val(m_price + "원");
        $("#totalprice").val(m_price + "원");
        $("#Mdimg").attr("src", "../resources/img/"+data.m_img);
        $("#Mdimg").attr("title", data.m_name);
        $("#Mdimg").attr("alt", data.m_name);
     }else if(keyword === '디저트'){
         $("#getKind").val("");
        $("#getKind").val(keyword);
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
        $("#getPrice_hide").val(data.m_price);
        let m_price = data.m_price;
        m_price = m_price.toLocaleString();
        $("#getPrice").val(m_price + "원");
        $("#totalprice").val(m_price + "원");
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
        document.querySelector("#subModal").style.display="block";
      let name = $("#getName").val();
      let val = { m_name : name };
      $.ajax({
         url : "getContent.san",
         type : "POST",
         data : val,
         success: function(data){
            let kind = data.m_kind;
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
      location.href="getCartList.san";
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
function cartInsert(val) {
   let id = val;
   if(id === 'null' || id === "" ){
      alert("로그인 후 이용 가능합니다.");
      location.href="../login.do";
   }else{
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
            if(kind != '디저트'){
            secondVal = {
               c_id : id,
               c_name :  cname,
               c_total : $("#total").val(),
               c_price : price,
               c_option : opt,
               c_size : size,
               c_toprice : totalprice,
               c_img : img.trim(),
            };
            }else if(kind === '디저트'){
            secondVal = {
               c_id : id,
               c_name :  cname,
               c_total : $("#total").val(),
               c_price : price,
               c_option : '-',
               c_size : '-',
               c_toprice : totalprice,
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
            toPrice = toPrice.replace("원", "").replace(",", "");
            toPrice = parseInt(toPrice);
            let totalprice = $("#totalprice").val(); // 상품 총 가격
            totalprice = totalprice.replace("원", "").replace("," , ""); // 상품 총 가격
            totalprice = parseInt(totalprice);
            
            let total_2 = $("#total").val(); 
            total_2 = parseInt(total_2);
            toPrice = toPrice + totalprice;
            total = total + total_2;
            
            toPrice = toPrice.toLocaleString()+"원";
            
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
   }

// Tall 이랑 Grande 설정시 가격 변동
$(document).ready(function(){ 
 var msize = false;
 var msize_2 = false;

// Tall 사이즈랑 Grande 사이즈 변경시 필요한 변수
  
$("input:radio[name=sel]").click(function(){
   if($("input:radio[name=sel]:checked").val()=='Grande'){
         msize_2 = false;
         msize = false;
   }else if($("input:radio[name=sel]:checked").val()=='Tall'){
         msize_2 = true;
         msize = true;
   }
   let price = $("#getPrice_hide").val().replace(",", ""); // 기본 값
   let price_2 = $("#getPrice").val().replace("원","").replace(",", ""); // 사이즈 가격
   price = parseInt(price);
   price_2 = parseInt(price_2);
   if($("input:radio[name=sel]:checked").val()=='Grande' && msize == false && msize_2 == false) { // Grande 일때
      
      price = price * 1.2;
      price = price.toLocaleString();
      $("#total").val(1);
      $("#getPrice").val("");
      $("#totalprice").val("");
      $("#getPrice").val(price+"원");
      $("#totalprice").val(price+"원");
      
      msize = true;
   }else if($("input:radio[name=sel]:checked").val()=='Tall' && msize == true && msize_2 == true){
      price_2 = price_2 / 1.2;
      price_2 = price.toLocaleString();
      $("#total").val(1);
      $("#getPrice").val("");
      $("#totalprice").val("");
      $("#getPrice").val(price_2+"원");
      $("#totalprice").val(price_2+"원");
      
      msize = false;
   }
});
});

function mainModalClose(){
   document.getElementById("Tall").checked = true;
   let hidePrice = $("#getPrice_hide").val();
   hidePrice = parseInt(hidePrice);
   hidePrice = hidePrice.toLocaleString();
   $("#totalprice").val(hidePrice+"원");
   $("#getPrice").val(hidePrice+"원");
}

function toPlus(){
   let total = document.getElementById("total");
   let totalVal = parseInt(total.value);
   if (!isNaN(totalVal) && totalVal < 99) {
      total.value = totalVal + 1;
      
      let originPrice = $("#getPrice").val();
      originPrice = originPrice.replace("원", "").replace(",", "");
      originPrice = parseInt(originPrice); // 기존 가격
      total = $("#total").val();
      total = parseInt(total); // 업데이트 된 갯수
      
      let totalPrice = originPrice * total;
      totalPrice = totalPrice.toLocaleString();
      $("#totalprice").val(totalPrice+"원");
      
   }
}
   function toMiu(){
   let total = document.getElementById("total");
   let totalVal = parseInt(total.value);
   if (!isNaN(totalVal) && totalVal > 1) {
      total.value = totalVal - 1;
      
      let originPrice = $("#getPrice").val();
      originPrice = originPrice.replace("원", "").replace(",", "");;
      originPrice = parseInt(originPrice); // 기존 가격
      total = $("#total").val();
      total = parseInt(total); // 업데이트 된 갯수
      
      let totalPrice = originPrice * total;
      totalPrice = totalPrice.toLocaleString();
      $("#totalprice").val(totalPrice+"원");
   }
}


    
 function outPoint(){
   
   let usePoint = $("#usePoint").val(); 
   let allTotalPrice = $("#allTotalPrice").val();
   let savePoint = $("#savePoint").val();
   usePoint = parseInt(usePoint);
   allTotalPrice = allTotalPrice.replace("원","").replace("," ,"");
   allTotalPrice = parseInt(allTotalPrice);
   
   if(isNaN(usePoint)){
      alert("사용할 포인트를 입력해주세요");
   }
   else if(savePoint >= usePoint){ // 여기서 -나오는것을 바꿔야함
      let payPrice = allTotalPrice - usePoint;    // 총금액에서 포인트 사용 = > 총 결제 금액
      if(payPrice >= 0){
      let payPrice_2 = payPrice.toLocaleString();
      $("#payPrice").val("0");
      $("#payPrice").val(payPrice_2+"원");
      $("#payPrice_2").val(payPrice_2+"원");
      $("#totalPayPrice").val(payPrice_2+"원");
      
     if($("input:radio[name=o_buy]:checked").val()=='배달'){
      let payPrice = $("#payPrice").val();
      payPrice = payPrice.replace("원","").replace("," ,"");
      payPrice = parseInt(payPrice);
      payPrice = payPrice + 3000;
      payPrice = payPrice.toLocaleString();
      $("#totalPayPrice").val(payPrice+"원");
     }
      
      } else if(payPrice < 0){
      alert("포인트 사용 금액은 결제 금액을 초과할 수 없습니다.");
      $("#usePoint").val("0");
      let allTotalPrice_2 = allTotalPrice.toLocaleString();
      $("#payPrice").val(allTotalPrice_2+"원");
      $("#payPrice_2").val(allTotalPrice_2+"원");
      if($("input:radio[name=o_buy]:checked").val()=='배달'){
      let payPrice = $("#payPrice").val();
      payPrice = payPrice.replace("원","").replace(",", "");
      payPrice = parseInt(payPrice);
      
      payPrice = payPrice + 3000;
      let payPrice_3 = payPrice.toLocaleString();
      $("#totalPayPrice").val(payPrice_3+"원");
     }
      }
   }
   else{
      alert("사용가능 포인트를 초과하였습니다.");
      $("#usePoint").val('0');
      let allTotalPrice_3 = allTotalPrice.toLocaleString();
      $("#payPrice").val(allTotalPrice_3+"원");
      $("#payPrice_2").val(allTotalPrice_3+"원");
      $("#totalPayPrice").val(allTotalPrice_3+"원");
      
       if($("input:radio[name=o_buy]:checked").val()=='배달'){
      let payPrice = $("#payPrice").val();
      payPrice = payPrice.replace("원","").replace(",", "");
      payPrice = parseInt(payPrice);
      
      payPrice = payPrice + 3000;
      let payPrice_4 = payPrice.toLocaleString();
      $("#totalPayPrice").val(payPrice_4+"원");
     }
      }
}
 function plus(c_no){
    let total = document.getElementById(c_no);
    let totalVal = parseInt(total.value);
    if (!isNaN(totalVal) && totalVal < 99) {
       total.value = totalVal + 1;
        
      let number = document.getElementById(c_no).value; // 갯수
      total= parseInt(number);
      let number_2 = document.getElementsByName(c_no);
      let number_3 = document.getElementsByClassName(c_no);
      
      for(let i =0 ; i < number_2.length ; i++){
         
         if(number_2[i].name === c_no){
           let totalWitch = number_2[i];
           let totalPrice = number_2[i].value;
           
           for(let j = 0 ; j < number_3.length ; j++){
              if(number_3[j].className === c_no){
                 
              let priceWitch = number_3[j].value;
              let originPrice = number_3[j].value;
              originPrice = originPrice.replace("원","").replace(",","");
              originPrice = parseInt(originPrice);
              
              totalPrice = originPrice * total;
              totalPrice = totalPrice.toLocaleString();
              
              totalWitch.value = totalPrice + "원"; // 총 가격
              
              let number_4 = document.getElementsByClassName("cartMenuPrice");
              let eachTotalPrice = 0;
              for(let k = 0 ; k < number_4.length ; k++){
                 let eachPrice = number_4[k].value;
                 eachPrice = eachPrice.replace("원", "").replace(",","");
                 eachPrice = parseInt(eachPrice);
                 eachTotalPrice += eachPrice;
              }
              let eachTotalPrice_2 = eachTotalPrice.toLocaleString();
              $("#allTotalPrice").val(eachTotalPrice_2+"원"); // 총 금액
              $("#payPrice_2").val(eachTotalPrice_2+"원");
              let usePoint = $("#usePoint").val();
              
              alltotalPrice = eachTotalPrice - usePoint;
              alltotalPrice = alltotalPrice.toLocaleString();
              $("#payPrice").val(alltotalPrice+"원");  // 결제금액
              $("#payPrice_2").val(alltotalPrice+"원");
              $("#totalPayPrice").val(alltotalPrice+"원");
              
              if($("input:radio[name=o_buy]:checked").val()=='배달'){
                 let payPrice_2 = $("#payPrice_2").val();
                 payPrice_2 = payPrice_2.replace("원","").replace(",", "");
                 payPrice_2 = parseInt(payPrice_2);
                 payPrice_2 = payPrice_2 + 3000;
                 payPrice_2 = payPrice_2.toLocaleString();
                 $("#totalPayPrice").val(payPrice_2+"원");
              }
                    
            }
              }
           }
         }
      }
    }
function miu(c_no) {
    
    let inputElement = document.getElementById(c_no);
    let currentValue = parseInt(inputElement.value);
     if (!isNaN(currentValue) && currentValue > 1) {
         inputElement.value = currentValue - 1;
         
       let number = document.getElementById(c_no).value; // 갯수
       total= parseInt(number);
       let number_2 = document.getElementsByName(c_no);
       let number_3 = document.getElementsByClassName(c_no);
       
       for(let i =0 ; i < number_2.length ; i++){
          if(number_2[i].name === c_no){
             let totalWitch = number_2[i];
            let totalPrice = number_2[i].value; // 기존 가격
            for(let j = 0 ; j < number_3.length ; j++){
               if(number_3[j].className === c_no){
                  
               let priceWitch = number_3[j];
               let originPrice = number_3[j].value;
               originPrice = originPrice.replace("원","").replace(",","");
               originPrice = parseInt(originPrice);
               totalPrice = originPrice * total;
               totalPrice = totalPrice.toLocaleString();
               totalWitch.value = totalPrice + "원"; // 총 가격
               let number_4 = document.getElementsByClassName("cartMenuPrice");
               let eachTotalPrice = 0;
               for(let k = 0 ; k < number_4.length ; k++){
                  let eachPrice = number_4[k].value;
                  eachPrice = eachPrice.replace("원", "").replace(",", "");
                  eachPrice = parseInt(eachPrice);
                  eachTotalPrice += eachPrice;
               }
               let eachTotalPrice2= eachTotalPrice.toLocaleString();
               $("#allTotalPrice").val(eachTotalPrice2+"원");
               $("#payPrice_2").val(eachTotalPrice2+"원");
               let usePoint = $("#usePoint").val();
               alltotalPrice = eachTotalPrice - usePoint;
               let alltotalPrice_2 = alltotalPrice.toLocaleString();
               $("#payPrice").val(alltotalPrice_2+"원");
               $("#payPrice_2").val(alltotalPrice_2+"원");
               $("#totalPayPrice").val(alltotalPrice_2+"원");
               
               if(alltotalPrice >= 0){
               if($("input:radio[name=o_buy]:checked").val()=='배달'){
                  let payPrice_2 = $("#payPrice_2").val();
                  payPrice_2 = payPrice_2.replace("원","").replace(",", "");
                  payPrice_2 = parseInt(payPrice_2);
                  payPrice_2 = payPrice_2 + 3000;
                  payPrice_2 = payPrice_2.toLocaleString();
                  $("#totalPayPrice").val(payPrice_2+"원");
               }
               }else {
                  usePoint = parseInt(usePoint);
                  alltotalPrice = parseInt(alltotalPrice);
                  
                  alltotalPrice = usePoint + alltotalPrice ;
                  
                  $("#usePoint").val(alltotalPrice);
                  $("#payPrice").val('0원');
                  $("#payPrice_2").val('0원');
                  $("#totalPayPrice").val('0원');
                  if($("input:radio[name=o_buy]:checked").val()=='배달'){
                     $("#totalPayPrice").val("3,000원");
                    }
               }
               }
            }
          }
       }
     }
 }

// 장바구니에서 메뉴 삭제
function deleteMenu(c_no, c_id){
   let no = c_no;
   let id = c_id;
   let value = {
      c_no : no
   }
   $.ajax({
      url : "../deleteCart.san",
      type : "POST",
      data : value,
      
      success: function(){
         location.href="getCartList.san?c_id="+id;
         
      },error: function(){
         location.href="getCartList.san?c_id="+id;
      }
   });
}


