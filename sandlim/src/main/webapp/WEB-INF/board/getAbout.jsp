<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../css/header.jsp" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>산들림</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif; /* 선택한 폰트 패밀리 */
            color: #333;
            background-color: #f7f7f7; /* 선택한 배경색 */
        }

        h1, h2, h3 {
            margin: 0;
        }

        .container {
            width: 70%;
            margin: auto;
            padding: 20px;
            background-color: #fff; /* 선택한 배경색 */
            border-bottom: 1px solid black;
/*             border-radius: 10px; /* 선택한 테두리 모서리 둥글게 */ */
/*             box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 선택한 그림자 효과 */ */
            margin-top: 20px; /* 선택한 상단 여백 */
            overflow: hidden; /* 선택한 컨테이너 내용이 넘칠 경우 가리기 */
        }

        p {
            line-height: 1.6;
        }

        .services {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }

        .service {
            width: 30%;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .service h3 {
            margin-top: 0;
        }

        .about {
            padding: 20px;
            margin-top: 30px;
        }

        .ba {
            background-color: #fff;
            position: relative;
            z-index: 20;
            margin-top: 20px; /* 선택한 상단 여백 */
            border-radius: 10px; /* 선택한 테두리 모서리 둥글게 */
            padding: 20px; /* 선택한 내용 안쪽 여백 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 선택한 그림자 효과 */
            overflow: hidden; /* 선택한 컨테이너 내용이 넘칠 경우 가리기 */
        }

        .ba p {
            margin: 0; /* 선택한 문단 위아래 여백 제거 */
        }

        .root_daum_roughmap {
            margin-top: 20px; /* 선택한 상단 여백 */
        }
        
        
        .roughmap_maker_label {
          left: 46px !important;
      }
      
      .p1 {
         display: flex;
         margin-top: 20px;
      }
      
      .divh2 {
         margin: 20px;
      }
      

    </style>
</head>
<body>
<%@ include file="../css/menu.jsp" %>  
<div class="ba">
<!-- <video src="../resources/img/about.mp4" controls autoplay muted loop></video> -->
    <div class="container">
        <h3>ABOUT 산들림</h3>
    </div>
    <div class="container">
        <h3>“커피 이상의 특별한 경험을 소개합니다.”</h3>
        <div class="about">
<p>세계인들의 생활 속에 스며들어 전 세계의 커피 문화를 선도하고 있는 산들림이 일상을 풍요롭게 하는 제3의 공간으로서</p>
<p>국내에서도 지역사회 속에서 고객 과 함께하며 새로운 커피문화를 정착시키고 있습니다.</p>
        </div>
    </div>
    <div class="container">
       <div>
          <h3>오시는 길</h3>
       </div>
       <div class="p1">
       <div id="daumRoughmapContainer1712547335268" class="root_daum_roughmap root_daum_roughmap_landing">
       </div>
          <div class="divh2">
             <h4>주소</h4>
             <p>경기도 안양시 만안구 안양로314번길 10 광창빌딩 3층</p><br>
             <h4>교통편</h4>
             <p>지하철 : 안양역 1번 출구 도보 10분거리</p>
             <p>버스 : 안양1번가 하차 09220 | 안양역 방면</p> 
             <p>마을버스 2번</p>
             <p>마을버스 9번</p><br>
             <h4>전화</h4>
             <p>031-0000-0000</p>
          </div>
       </div>
   </div>

    <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

    <script charset="UTF-8">
        new daum.roughmap.Lander({
            "timestamp" : "1712547335268",
            "key" : "2itqn",
            "mapWidth" : "640",
            "mapHeight" : "360"
        }).render();
    </script>

    <jsp:include page="../css/footer.jsp"></jsp:include>
    
    <script>
    window.onload = function(){
       document.getElementsByClassName("roughmap_lebel_text")[0].innerText = "산들림";
    };
    </script>
</div>
</body>
</html>