$(document).ready(function(){ 
	$( window ).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth >= 978) {
			$("#subNavMenu").hide();
		}
	});
	
	$("#clMenu").click(function(){
		$("#subNavMenu").toggle();
	});
	
	$("#conWrite").click(function(){
		location.href = "adminInsertFaq.do";
	});
	
	$("#conUpdate").click(function(){
		location.href = "updateBoard.jsp";
	});
	
	$("#conDel").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			let v = document.fm.seq.value;
			location.href = "deleteBoard.do?seq="+v;
		}else{
		}
	});
	
	$("#conList").click(function(){
		location.href = "adminGetFaq.do";
	});
	$("#conList2").click(function(){
		location.href = "getFaq.do";
	});
	$("#conFaqDel").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			let v = document.fm.seq.value;
			location.href = "deleteBoard.do?seq="+v;
		}else{
		}
	});
});


function selTr(val){
	location.href = "getBoard.do?b_num="+val;
}

function selFaq(val){
	location.href = "adminFaqDetail.do?b_num="+val;
}

function selUser(val){
	location.href = "selUser.do?id="+val;
}

function delUser(val1, val2, val3){
	if(val1 == 'admin'){
		alert(val3);
	}else{
		location.href= val2 + "?id=" + val1;
		alert("탈퇴가 완료되었습니다.");
	}
}