package com.one.view.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.one.san.user.NaverProfile;
import com.one.san.user.UserService;
import com.one.san.user.UserVO;
import com.one.san.util.KakaoApi;
import com.one.san.util.NaverApi;
import com.one.san.util.Pagination;
import com.one.san.util.VerificationCodeGenerator;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private KakaoApi kakaoApi;

	@Autowired
	private NaverApi naverApi;

	// 메인에서 관리자 페이지 이동
	@RequestMapping("/adminPage.san")
	public String adminPage() {
		return "admin/adminWork";
	}

	// 로그인 GET방식 요청할때
	@RequestMapping(value = { "/login.do", "/longin" }, method = RequestMethod.GET)
	public String login(Model model) {
		model.addAttribute("kakaoApiKey", kakaoApi.getKakaoApiKey());
		model.addAttribute("kakaoRedirectUri", kakaoApi.getKakaoRedirectUri());
		model.addAttribute("naverApiKey", naverApi.getNaverApiKey());
		model.addAttribute("naverRedirectUri", naverApi.getNaverRedirectUri());
		model.addAttribute("naverClientSecret", naverApi.getNaverClientSecret());

		model.addAttribute("state", "STATE_STRING");
		return "user/login"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}

	// 장바구니에서 회원정보를 가져오기 위해 사용
	@RequestMapping("/cartSelectUser.san")
	public ResponseEntity<UserVO> cartSelectUser(UserVO vo) {
		UserVO uv = userService.cartSelectUser(vo);
		if (uv != null) {
			return new ResponseEntity<>(uv, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	// 로그인 POST방식 요청할때.
	// insertUser에서 비밀번호를 암호화해서 db에 저장되어있어서
	// match함수로 암호화된 비밀번호를 비교하는 유효성검사가 UserServiceImpl의 getUser 안에 들어있음.

	@RequestMapping(value = { "/login.do", "/login" }, method = RequestMethod.POST)
	public String login(UserVO vo, Model model, HttpSession session) {

		if (userService.getLogin(vo) != null) {
			session.setAttribute("userId", userService.getUser(vo).getU_id());
			session.setAttribute("userName", userService.getUser(vo).getU_name());
			session.setAttribute("userStatus", userService.getUser(vo).getU_status());
			session.setAttribute("loginChk", "normal");
			return "redirect:main.jsp"; // View Resolver를 통해 main.jsp로 매핑
		} else {
			session.setAttribute("userError", "error");
			return "user/login"; // View Resolver를 통해 user/login.jsp로 매핑
		}
	}

	@RequestMapping("/login/oauth2/code/kakao")
	public String kakaoLogin(@RequestParam String code, HttpSession session, Model model) {
		// 1. 인가 코드 받기 (@RequestParam String code)

		// 2. 토큰 받기
		String accessToken = kakaoApi.getAccessToken(code);
		kakaoApi.setAccessToken(accessToken);

		// 3. 사용자 정보 받기
		Map<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);

		// 맵으로 된 값들 변수로 담아주는 과정 (카카오에서 보내준 값 그대로)
		String id = (String) userInfo.get("id"); // 유저 id. 중복체크필요(insert할때)
		String email = (String) userInfo.get("email");
		String name = (String) userInfo.get("name");
		String phone_number = (String) userInfo.get("phone_number");
		String birthyear = (String) userInfo.get("birthyear");
		String birthday = (String) userInfo.get("birthday");

		// 전화번호, 생년월일 db에 맞게 변환
		String phoneNumber = phone_number;
		String prefix = phoneNumber.substring(0, phoneNumber.indexOf(' ') + 1);
		if (prefix.equals("+82 ")) {
			phoneNumber = phoneNumber.replace(prefix, "0").replace("-", "").trim();
		}
		String birth = birthyear + birthday;

		// 카카오 로그인으로 가져온 유저정보 vo에 담아주기, 닉네임은 처리할예정
		UserVO vo = new UserVO();
		vo.setU_id(id);
		vo.setU_pw(VerificationCodeGenerator.generate());
		vo.setU_name(name);
		vo.setU_phno(phoneNumber);
		vo.setU_birth(birth);
		vo.setU_email(email);
		vo.setU_social("카카오회원");

		model.addAttribute("user", vo);

		return "/user/signUpKakao";

	}

	@RequestMapping("/login/oauth2/code/naver")
	public String naverLogin(@RequestParam(name = "code") String code, @RequestParam(name = "state") String state,
			HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<>();
		// 1. 인가 코드 받기 -> @RequestParam String code

		// 2. 접근 토큰 발급 요청
		String accessToken = naverApi.getAccessToken(code, state);
		session.setAttribute("accessToken", accessToken);

		// 3. 사용자 정보 받기
		NaverProfile userInfo = naverApi.getUserInfo(accessToken);

		// 맵으로 된 값들 변수로 담아주는 과정 (네이버에서 보내준 값 그대로)
		String id = userInfo.getId();
		String email = "tempData@naver.com";
		String nickname = userInfo.getNickname();
		String phone_number = userInfo.getMobile(); // 010-0000-0000 형식
		String birthyear = userInfo.getBirthyear();
		String birthday = userInfo.getBirthday();

		// 전화번호, 생년월일 db에 맞게 변환
		String phoneNumber = phone_number.replace("-", "").trim();
		String birth = birthyear + birthday.replace("-", "").trim();

		// 카카오 로그인으로 가져온 유저정보 vo에 담아주기, 닉네임은 처리할예정
		UserVO vo = new UserVO();
		vo.setU_id(id);
		vo.setU_pw(VerificationCodeGenerator.generate());
		vo.setU_phno(phoneNumber);
		vo.setU_birth(birth);
		vo.setU_social("네이버회원");

		model.addAttribute("user", vo);
		return "/user/signUpNaver";

	}

	// 아이디 중복체크 로직
	@RequestMapping(value = { "checkSameId.do" }, method = RequestMethod.POST)
	public ResponseEntity<Boolean> checkSameId(@RequestBody UserVO user) {

		boolean result = true;
		if (userService.selectOne(user.getU_id()) != null)
			result = false;

		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	// 전화번호 중복체크 로직
	@RequestMapping(value = { "checkSamePhno.do" }, method = RequestMethod.POST)
	public ResponseEntity<Boolean> checkSamePhno(@RequestBody UserVO user) {

		boolean result = true;
		if (userService.selectPhno(user.getU_phno()) != null)
			result = false;

		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	// 이메일 중복체크 로직
	@RequestMapping(value = { "checkSameEmail.do" }, method = RequestMethod.POST)
	public ResponseEntity<Boolean> checkSameEmail(@RequestBody UserVO user) {

		boolean result = true;
		if (userService.selectEmail(user.getU_email()) != null)
			result = false;

		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	// 전화번호 인증 문자 발송 로직
	@RequestMapping(value = { "checkRealPhno.do" }, method = RequestMethod.POST)
	public ResponseEntity<String> checkRealPhno(@RequestBody UserVO user) {

		String result = "";

		result = userService.sendsms(user.getU_phno());

		System.out.println(result);

		return new ResponseEntity<>(result, HttpStatus.OK);

	}

	// 이메일 인증메일 전송. SMTP 서버는 google계정으로 되어있음.
	@RequestMapping(value = { "EmailVerification.do" }, method = RequestMethod.POST)
	public ResponseEntity<String> emailSend(@RequestBody UserVO user) {
		String verCode = null;

		// 이메일 인증 코드 발송
		verCode = userService.sendVerificationEmail(user.getU_email());

		return new ResponseEntity<>(verCode, HttpStatus.OK);
	}

	// 이메일 인증메일의 코드와 사용자 인증코드가 동일한지 체크
	@RequestMapping(value = { "verifyCode.do" }, method = RequestMethod.POST)
	public ResponseEntity<Boolean> emailCodeVerify(@RequestBody Map<String, String> payload) {

		String inputCode = payload.get("inputCode");
		String emailCode = payload.get("emailCode");

		boolean chk = userService.verifyEmailCode(inputCode, emailCode);

		return new ResponseEntity<>(chk, HttpStatus.OK);
	}

	// 비밀번호 찾기
	@RequestMapping(value = { "FindIdOutput.do", "FindPwOutput.do" }, method = RequestMethod.POST)
	public ResponseEntity<String> findIdOutput(@RequestBody Map<String, String> payload) {

		String name = payload.get("u_name");
		String email = payload.get("u_email");

		System.out.println("u_name: " + name);
		System.out.println("u_email: " + email);

		String uId = userService.findIdOutput(name, email);
		System.out.println("uid: " + uId);

		return new ResponseEntity<>(uId, HttpStatus.OK);
	}

	// 비밀번호 재설정
	@RequestMapping(value = { "resetPw.do" }, method = RequestMethod.POST)
	public String resetPw(@RequestParam("u_id") String id, @RequestParam("u_pw") String pw) {

		int result = 0;

		System.out.println("u_id: " + id);
		System.out.println("u_pw: " + pw);

		UserVO uvo = new UserVO();
		uvo.setU_id(id);
		uvo.setU_pw(pw);

		result = userService.updateUser(uvo);

		return "redirect:/main.jsp";

	}

	// 아이디찾기 화면으로 가기(단순 페이지이동)
	@RequestMapping(value = { "/findId.do", "/findId" }, method = RequestMethod.GET)
	public String findId() {
		return "user/findId"; // WEB-INF 안 user폴더 findId.jsp
	}

	// 비밀번호찾기 화면으로 가기(단순 페이지이동)
	@RequestMapping(value = { "/findPw.do", "/findPw" }, method = RequestMethod.GET)
	public String findPw() {
		return "user/findPw"; // WEB-INF 안 user폴더 findPw.jsp
	}

	// 비밀번호찾기 재설정 화면으로 가기(단순 페이지이동)
	@RequestMapping(value = "/findPwReset.do", method = RequestMethod.GET)
	public String findPwReset(@RequestParam("u_id") String uId, Model model) {
		model.addAttribute("u_id", uId);
		return "user/findPwReset";
	}

	// 회원가입 페이지로 가기(단순 페이지이동)
	@RequestMapping(value = { "/signUp.do", "/signUp" }, method = RequestMethod.GET)
	public String signUp() {
		return "user/signUp"; // WEB-INF 안 user폴더 signUp.jsp
	}

	@RequestMapping(value = { "/userMypage.do", "/userMypage" }, method = RequestMethod.GET)
	public String userMypage(Model model, HttpSession session) {

		String selId = (String) session.getAttribute("userId");

		model.addAttribute("user", userService.selectOne(selId));

		return "user/userMypage"; // WEB-INF 안 user폴더 signUp.jsp
	}

	// 아이디 비번찾기 관련이 있어야하고, sns 눌렀을때
	@RequestMapping(value = { "/insertUser.do" }, method = RequestMethod.POST)
	public String join(UserVO vo, HttpSession session) {

		if (vo.getU_social() == null || vo.getU_social().isEmpty()) {
			vo.setU_social("일반회원");
		}

		// 이미 가입된 회원인지 체크
		if (userService.selectEmail(vo.getU_email()) != null || userService.selectPhno(vo.getU_email()) != null) {
			// 닉네임 입력받을 페이지 가서 vo안에 넣어준거 반환받은거 밑에 vo에 넣어줘야함
			String chkMessage = "";
			int chk = 0;
			chk = userService.chkSocialLogin(vo);

			// 이미 가입된 회원. 카카오 => -1, 네이버 => -2, 일반 => -3
			switch (chk) {
			case -1:
				chkMessage = "가입된 카카오 소셜 계정이 있습니다.";
				break;
			case -2:
				chkMessage = "가입된 네이버 소셜 계정이 있습니다.";
				break;
			case -3:
				chkMessage = "가입된 산들림 회원 계정이 있습니다.";
				break;
			}
			chkMessage = URLEncoder.encode(chkMessage);
			return "redirect:/main.jsp?chkMessage=" + chkMessage;

		} else {
			userService.insertUser(vo);
		}

		session.setAttribute("userId", userService.getUser(vo).getU_id());
		session.setAttribute("userName", userService.getUser(vo).getU_name());
		session.setAttribute("userStatus", userService.getUser(vo).getU_status());

		if (vo.getU_social().equals("네이버회원")) {
			session.setAttribute("loginChk", "naver");
		} else if (vo.getU_social().equals("카카오회원")) {
			session.setAttribute("loginChk", "kakao");
		}

		return "redirect:/main.jsp"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}

	@RequestMapping(value = { "/delUser.do" }, method = RequestMethod.POST)
	public String delUser(UserVO vo, HttpSession session) {
		userService.deleteUser(vo);
		session.invalidate();
		return "user/"; // WEB-INF 안 user폴더
	}

	@RequestMapping(value = { "/selUser.do", "/selUser" })
	public String selUser(@RequestParam(value = "u_id", defaultValue = "", required = false) String selId,
			HttpSession session, Model model) { // vo커맨드

		if (selId.equals("")) {
			selId = (String) session.getAttribute("userId");
		}

		model.addAttribute("user", userService.selectOne(selId));

		return "user/selUser"; // WEB-INF 안 admin 폴더 안에 selUser.jsp
	}

	@RequestMapping(value = { "/updateUserForm.do" }, method = RequestMethod.POST)
	public String updateUserForm(@RequestParam(value = "u_id", defaultValue = "", required = false) String selId,
			HttpSession session, Model model) {

		System.out.println("selId 확인: " + selId);

		model.addAttribute("user", userService.selectOne(selId));

		return "user/userUpdate";
	}

	@RequestMapping(value = { "/updateUser.do" }, method = RequestMethod.POST)
	public String updateUser(UserVO vo) {
		userService.updateUser(vo);
		return "redirect:admin/selUser/" + vo.getU_id(); // WEB-INF 안 admin 폴더 안에 selUser.jsp
	}

	@RequestMapping(value = { "/userList.do" })
	public String getUserList(
			@RequestParam(value = "searchType", defaultValue = "", required = false) String searchType,
			@RequestParam(value = "keyword", defaultValue = "", required = false) String keyword,
			@RequestParam(value = "currPageNo", required = false, defaultValue = "1") int currPageNo,
			@RequestParam(value = "range", required = false, defaultValue = "1") int range, Model model) {

		Pagination pg = new Pagination();
		pg.setSearchType(searchType);
		pg.setKeyword(keyword);
		pg.setCurrPageNo(currPageNo);
		pg.setRange(range);

		int totalCnt = userService.userTotalCnt(pg);

		pg.pageInfo(currPageNo, range, totalCnt);

		model.addAttribute("pagination", pg);
		model.addAttribute("userList", userService.selectList(pg));
		return "user/userList"; // WEB-INF 안 userList.jsp 파일이 있는 폴더가 user일 경우
	}

	@RequestMapping(value = { "/logout.do" }, method = RequestMethod.GET)
	public String logout(HttpSession session, Model model) throws IOException {

		session.invalidate();

		return "redirect:main.jsp";
	}

	@RequestMapping(value = { "/kakaoLogout.do" }, method = RequestMethod.GET)
	public String kakaoLogout(HttpSession session, Model model) throws IOException {

		kakaoApi.unlink();
		session.invalidate();

		return "redirect:main.jsp";
	}

	@RequestMapping(value = { "/naverLogout.do" }, method = RequestMethod.GET)
	public String naverLogout(HttpSession session, Model model) throws IOException {

		String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=" + naverApi.getNaverApiKey()
				+ "&client_secret=" + naverApi.getNaverClientSecret() + "&access_token="
				+ session.getAttribute("accessToken") + "&service_provider=NAVER";

		naverApi.requestToServer(apiUrl, null);
		naverApi.naverLogout(model);
		session.invalidate();

		return "redirect:main.jsp";
	}

	// 이용약관 페이지
	@RequestMapping(value = { "/terms.do", "/terms" }, method = RequestMethod.GET)
	public String terms() {
		return "user/terms";
	}

	// 어드민 페이지 로그인
	@RequestMapping(value = { "/adminLogin.do" }, method = RequestMethod.POST)
	public String adminLogin(UserVO vo, Model model, HttpSession session) {

		if (userService.getLogin(vo) != null) {
			session.setAttribute("userId", userService.getUser(vo).getU_id());
			session.setAttribute("userName", userService.getUser(vo).getU_name());
			session.setAttribute("userStatus", userService.getUser(vo).getU_status());
			session.setAttribute("loginChk", "normal");

			if (session.getAttribute("userStatus").equals("관리자")) {
				return "redirect:adminWork.do";
			}
			if (session.getAttribute("userStatus").equals("스태프")) {
				return "redirect:adminWork.do";
			}

			return "redirect:adminWork.do";
		} else {
			session.setAttribute("userError", "error");
			return "redirect:adminLogin.jsp"; // View Resolver를 통해 user/login.jsp로 매핑
		}
	}

	@RequestMapping(value = { "/adminLogout.do" }, method = RequestMethod.GET)
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "redirect:adminLogin.jsp"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}

}
