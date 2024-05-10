$(document).ready(function() {
	//사이드 메뉴 height조정
	let idxhdHeight = $(".idxhd").height(); //헤더 높이
	let idxbodyHeight = $(".idxbody").height(); //사이즈 높이
	
	let ftHeight = $("footer").height();
	let bodyHeight = $("body").height();
	
	
	let useHeight = idxhdHeight + idxbodyHeight; //가용 height값
	
	if(useHeight > bodyHeight){
		$(".wrap").height(idxbodyHeight);
// 		$("footer").css({"position": "absolute", "bottom" : "0px", "width":"100%", "z-index": 1000}); 
	}
	$(".idxbody").height($("body").height()-50);
	//$(".idxbody").height($("body").height()-65.59);
	
	console.log('idxheader: '+idxhdHeight);
	console.log('idxbody: '+idxbodyHeight);
	console.log('footer: '+ftHeight);
	console.log('useHeight: '+useHeight);
	console.log('body 전: '+bodyHeight);
	console.log('body 후: '+  $("body").height());
});