<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>이용약관</title>
	<link rel="stylesheet" href="/resources/css/terms.css">
</head>
<body>
    <div class="container">
     <h2>회원가입 약관동의</h2>
     <form id="termsForm" action="/signUp" method="get">
        <div class="terms-section">
            <input type="checkbox" id="allAgree" name="allAgree">
            <label for="allAgree" class="txt">전체동의</label>
        </div>
         <div class="terms-section">
             <input type="checkbox" id="agree1" name="agree1" required>
             <label for="agree1" class="txt">홈페이지 이용약관 동의 (필수)</label>
             <div class="terms-text">
                 <p class="tit">산들림은 고객님을 보호합니다.</p>
                 <p class="t1">본 약관은 산들림의 홈페이지 서비스 이용과 관련하여 필요한 사항을 규정합니다.</p>
                 <p class="pri_tit" id="quick_01">제1장 총칙</p>
                 <p class="sub_tit" id="quick_01_01">제 1 조 목적</p>
                 <ol class="mb40">
                     <li>산들림을 운영하는 주식회사 산들림(이하 '회사'라고 합니다)에서 운영하는 홈페이지 (http://localhost:8090/, 이하 “홈페이지”라고 합니다)는 아래와
                         같은 약관에 동의하는 이용자들에게 제공되는 인터넷서비스로, 본 약관은 이용자와 회사 사이에 본 홈페이지 이용에 관한 권리 및 의무를 규정하는 것을 목적으로 합니다.
                     </li>
                     <li>홈페이지의 모든 자료는 Sandlim Corporation 및 자회사, 계열사 혹은 Sandlim Corporation에 의해 자격을 취득한 기타 이해 관계자에 의한
                         저작권, 등록의장, 등록상표 또는 기타 지적소유권으로 보호되고 있습니다.</li>
                     <li>본 홈페이지에 포함된 자료는 이용자에게 정보 제공을 위한 목적으로만 제공됩니다. 이용자는 본 홈페이지의 내용에 대하여 어떤 방법으로도 배포, 출판, 전송, 변경,
                         전시, 모방작품의 창조 혹은 개발할 수 없습니다. 이용자는 회사의 권한을 보호하여야 하고, 본 홈페이지의 자료를 허가 없이 유용할 수 없습니다. 허가 없이 본
                         홈페이지의 내용을 유용하는 경우에 회사와 Sandlim Corporation은 이용자에게
                         법적, 재정적으로 가능한 기타 추가적인 배상을 청구할 수 있습니다.</li>
                     <li>이용자가 제출하는 자료의 내용에 대한 책임은 전적으로 이용자에게 있습니다. 이용자가 제출하는 자료에 불법, 중상모략, 비난 혹은 비도덕적인 내용이 포함되어서는
                         안됩니다. 이용자는 본 홈페이지에 저작권, 등록상표권, 사생활권 혹은 기타 사적 권리 혹은 소유권을 포함하는 제3자의 권리를 침해하는 어떤 자료도 게시하여서는
                         안됩니다.</li>
                     <li>이용자의 개인정보 보호 및 보안, 개인정보에 대한 수집, 이용 및 저장과 관련한 관행 및 정책에 대하여는 회사의 개인정보 처리방침에 의합니다. 개인정보 처리방침은
                         홈페이지에 별도 게시하고 있습니다.</li>
                 </ol>
                 <p class="sub_tit" id="quick_01_02">제 2 조 용어의 정의</p>
                 <ol class="mb40">
                     <li>본 약관에서 사용하는 용어는 다음과 같이 정의합니다.</li>
                     <li>“이용자”란 홈페이지에 접속하여 홈페이지를 이용하는 회원 및 비회원을 말합니다.</li>
                     <li>"회원”이란 홈페이지에 접속하여 본 약관에 따라 회사 인터넷 회원으로 가입하여 홈페이지가 제공하는 서비스를 받는 자를 말하고, “비회원”이란 회원이 아닌 자를
                         말합니다.</li>
                     <li>“산들림 모바일 애플리케이션”이란 회사가 모바일 및 휴대용 기기 등을 통하여 제공하는 앱을 말합니다.</li>
                     <li>'모바일 오더 서비스'란 회사가 스타벅스 모바일 애플리케이션을 통해 회원이 주문할 매장을 선택하여 주문 가능 메뉴를 확인하고 다양한 결제수단으로 주문 및 예약할 수
                         있는 전자상거래 서비스를 말합니다.</li>
                     <li>“모바일오더”란 회원이 사이렌 오더 서비스를 통하여 회사의 다양한 메뉴를 매장별 실시간 주문 가능 수량을 확인하여 선결제한 후, 나의 위치정보(GPS, 고주파 등
                         이용)를 기반으로 2km 내 매장에 주문을 전송을 하는 것을 말합니다.</li>
                 </ol>
             </div>
         </div>
         <div class="terms-section">
             <input type="checkbox" id="agree2" name="agree2" required>
             <label for="agree2" class="txt">개인정보 수집 및 이용동의 (필수)</label>
             <div class="terms-text">
                 <p class="mb15">
                     본인은 산들림을 운영하는 주식회사 산들림(이하 '회사'라 합니다)가 제공하는 회원 서비스(이하 ‘서비스’라 합니다)를 이용하기 위해, 다음과 같이 ‘회사’가 본인의
                     개인정보를 수집/이용하는 것에 동의합니다.
                 </p>
                 <p class="mb15 fontBold underLine">※ 귀하께서는 개인정보 수집·이용에 대한 동의를 거부하실 수 있으나, 동의를 거부하실 경우 회원가입, 서비스 이용
                     등을 하실 수 없습니다.</p>
                 <ul class="pri_con mb40">
                     <li>
                         <span class="fontBold">1. 개인정보 항목·목적·보유기간</span>
                         <table class="vod_tb_ag mb20 mt10">
                             <caption class="hid">
                                 수집하는 개인정보에 대한 항목, 목적, 보유기간 안내 테이블
                             </caption>
                             <colgroup>
                                 <col width="">
                                 <col width="80%">
                             </colgroup>
                             <thead>
                                 <tr>
                                     <th scope="col">구분</th>
                                     <th scope="col">필수</th>
                                 </tr>
                             </thead>
                             <tbody>
                                 <tr>
                                     <th scope="row"><span class="fontBold">항목</span></th>
                                     <td class="taLeft">성명, 생년월일, 아이디, 비밀번호, 휴대전화번호, E-Mail</td>
                                 </tr>
                                 <tr>
                                     <th scope="row"><span class="fontBold">목적</span></th>
                                     <td> - 회원가입, 본인확인<br>
                                         - 서비스 제공 및 개선<br>
                                         * 상품(제품), 서비스 결제, 환불, 배송<br>
                                         * 개인 맞춤형 서비스 및 혜택 제공<br>
                                         - 회원관리, 부정이용 방지<br>
                                         - 서비스 관련 이벤트 및 행사정보 안내<br>
                                         (별도 마케팅정보 수신 동의 회원에 한함) </td>
                                 </tr>
                                 <tr>
                                     <th scope="row"><span class="fontBold">보유 및 <br>
                                             이용기간</span></th>
                                     <td class="pointFont"><span class="underLine">회원 탈퇴 시 즉시 파기(단, 반복 재가입 등의 방법을 이용한
                                             서비스 부정이용 방지를 위해 이름, ID, DI, 성별, 생년은 탈퇴 후 30일 보관) 또는 관계법령에 의한 별도
                                             보존기간</span> (2. 관계법령에 의한 개인정보 보존기간참고)</td>
                                 </tr>
                             </tbody>
                         </table>
                     </li>
                     <li>
                         <span class="fontBold">2. 관계법령에 의한 개인정보 보존기간</span>
                         <ul>
                             <li class="pointFont">- 서비스이용기록, 접속로그, 접속IP정보 (통신비밀보호법 : 3개월)</li>
                             <li class="pointFont">- 표시/광고에 관한 기록 (전자상거래법 : 6개월)</li>
                             <li class="pointFont">- 계약 또는 청약철회 등에 관한 기록 (전자상거래법 : 5년)</li>
                             <li class="pointFont">- 대금결제 및 재화 등의 공급에 관한 기록 (전자상거래법 : 5년)</li>
                             <li class="pointFont">- 소비자의 불만 또는 분쟁처리에 관한 기록 (전자상거래법 : 3년)</li>
                         </ul>
                     </li>
                 </ul>
             </div>
         </div>
         <div class="terms-section">
             <input type="checkbox" id="agree3" name="agree3">
             <label for="agree3" class="txt">광고성 정보 수신동의 (선택)</label>
             <div class="terms-text">
                 <div id="popWrap">

                     <div id="container">
                         <div class="privacy_cont">
                             <table class="vod_tb_ag mb20 mt10">
                                 <colgroup>
                                     <col width="">
                                     <col width="70%">
                                 </colgroup>
                                 <tbody>
                                     <tr>
                                         <th scope="row" style="border-top: 1px solid #ddd"><span
                                                 class="fontBold">목적</span></th>
                                         <td class="taLeft" style="border-top: 1px solid #ddd">마케팅 정보 활용(상품정보 및 행사 정보
                                             안내 등)</td>
                                     </tr>
                                     <tr>
                                         <th scope="row"><span class="fontBold">항목</span></th>
                                         <td>휴대전화번호, 이메일<br></td>
                                     </tr>
                                     <tr>
                                         <th scope="row"><span class="fontBold">보유 및 이용 기간</span></th>
                                         <td style="font-size: 17px;"><span class="underLine"><span
                                                     class="pointFont">회원 탈퇴시까지</span> </span></td>
                                     </tr>
                                 </tbody>
                             </table>
                             <p class="t1">※ 귀하께서는 동의를 거부하실 수 있으나, 동의를 거부 하실 경우 마케팅 정보를 받으실 수 없습니다.</p>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
 <button type="submit" id="submitButton" disabled>제출</button>
 </form>
 </div>
<script src="/resources/js/terms.js"></script>
</body>
</html>