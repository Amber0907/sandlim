<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
/*  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap'); */



 * {
            font-family: 'Noto Sans KR',sans-serif !important;
            box-sizing: border-box;
            font-weight: 500;
     }
footer {
   margin-top:15%;
   position: relative;
   background-color: #fff;
   border-top: 1px solid #000;
}

.foot {
   background-color: #fff;
   position: relative;
   width: 90%;
   padding: 20px;
   flex-direction: column;
   justify-content: flex-start;
}

.footer2 {
   display: flex;
   margin: 10px auto;
   align-items: center;
}

.p3 {
   margin: 0px;
   font-size: 12px;
}

.p2 {
   font-size: 14px;
   font-weight: bolder;
}

.footerimg {
   width: 70px;
   margin: 20px 0px 20px 20px;
   margin-left: 10%;
}
</style>
<body>
   <footer>
      <div class="footer2">
         <img class="footerimg" src="./img/logo.png">
         <div class="foot">
            <p class="p2">산들림 2024년 5월 23일</p>
            <p class="p3">팀장 부팀장 정하영 남태욱</p>
            <p class="p3">팀원 김준성 변유림 성한규 이환석 홍수민</p>
            <p class="p3">이 사이트는 교육용 사이트로 실제 사용하실 수 없습니다.</p>
            <p class="p3">ⓒ 2024 Sandlim Company. All Rights Reserved.</p>
         </div>
      </div>
   </footer>
</body>
</html>