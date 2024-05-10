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
      
   
   // [ADMIN] NOTICE 등록
   $("#insertBoard").click(function(){
      location.href = "getinsertBoard.do";
   });

   // [ADMIN] NOTICE 삭제
   $("#deleteBoard").click(function(){
      if(confirm("공지사항을 삭제하시겠습니까?") == true){
         let v = document.fm.b_num.value;
      location.href = "deleteBoard.do?b_num="+v;
      }
   });
   
   // NOTICE 목록
   $("#getBoardList").click(function(){
      location.href = "getBoardList.do";
   });
   
   
   
   // REVIEW 등록 불러오기
   $("#getinsertReview").click(function(){
      location.href = "getinsertReview.do";
   });
   
   // REVIEW 목록
   $("#getReview").click(function(){
      location.href = "getReview.do";
   });
   
   // REVIEW 수정
   $("#updateReview").click(function(){
      if(confirm("리뷰를 수정하시겠습니까?") == true){
      location.href = "updateReview.do";
      }
   });
   
   // REVIEW 삭제
   $("#deleteReview").click(function(){
      if(confirm("리뷰를 삭제하시겠습니까?") == true){
      let v = document.fm.b_num.value;
      location.href = "deleteReview.do?b_num="+v;}
   });
   
   
   //faq
   $("#conWrite").click(function(){
      location.href = "adminInsertFaq.do";
   });
   
   $("#conList").click(function(){
      location.href = "adminGetFaq.do";
   });
   $("#conFaqDel").click(function(){
      if(confirm("정말 삭제하시겠습니까?") == true){
         let v = document.fm.num.value;
         //let v = document.getElementById("num").innerText;
         location.href = "deleteFaq.do?b_num="+v;
      }else{
      }
   });
   $("#conList2").click(function(){
      location.href = "getFaq.do";
   });
   
});


function selBoard(val){
   location.href = "getBoard.do?b_num="+val;
}

function selReview(val){
   location.href = "getReviewDetail.do?b_num="+val;
}

function selFaq(val){
   location.href = "adminFaqDetail.do?b_num="+val;
}

