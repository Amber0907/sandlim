package com.one.san.view.controller;

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

import com.one.san.moc.MdVO;
import com.one.san.user.UserService;
import com.one.san.user.UserVO;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	//메인에서 관리자 페이지 이동 
	@RequestMapping("/adminPage.san")
	public String adminPage() {
		return "/admin/adminWork";
	}
	
	// 로그인 GET방식 요청할때
	@RequestMapping(value = { "/login.do", "/longin" }, method = RequestMethod.GET)
	public String login() {
		return "user/login"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}

	// 로그인 POST방식 요청할때.
	// insertUser에서 비밀번호를 암호화해서 db에 저장되어있어서
	// match함수로 암호화된 비밀번호를 비교하는 유효성검사가 UserServiceImpl의 getUser 안에 들어있음.

	@RequestMapping(value = { "/login.do", "/longin" }, method = RequestMethod.POST)
	public String login(UserVO vo, HttpSession session) {

		if (userService.getLogin(vo) != null) {
			session.setAttribute("userId", userService.getUser(vo).getU_id());
			session.setAttribute("userName", userService.getUser(vo).getU_name());
			session.setAttribute("userStatus", userService.getUser(vo).getU_status());
			return "redirect:main.jsp"; // WEB-INF 안 main.jsp로 ..
		} else {
			session.setAttribute("userError", "error");
			return "redirect:WEB-INF/user/login.jsp?result=1";
		}
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

	// 아이디 비번찾기 관련이 있어야하고, sns 눌렀을때
	@RequestMapping(value = { "/insertUser.do" }, method = RequestMethod.POST)
	public String join(UserVO vo) {
		userService.insertUser(vo);
		return "redirect:/main.jsp"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}

	@RequestMapping(value = { "/delUser.do" }, method = RequestMethod.POST)
	public String delUser(UserVO vo, HttpSession session) {
		userService.deleteUser(vo);
		session.invalidate();
		return "user/"; // WEB-INF 안 user폴더
	}

	@RequestMapping(value = { "/selUser.do", "/selUser" }, method = RequestMethod.POST)
	public String selUser(@RequestParam(value = "u_id", defaultValue = "", required = false) String selId,
			Model model) { // vo커맨드
		System.out.println("selId 확인: " + selId);
		model.addAttribute("user", userService.selectOne(selId));
		return "admin/selUser"; // WEB-INF 안 admin 폴더 안에 selUser.jsp
	}

	//경로 이거 맞나요? 아니면 "redirect:WEB-INF/admin/selUser.jsp" + vo.getU_id(); 으로 변경
	@RequestMapping(value = { "/updateUser.do" }, method = RequestMethod.POST)
	public String updateUser(UserVO vo) {
		userService.updateUser(vo);
		return "redirect:admin/selUser/" + vo.getU_id(); // WEB-INF 안 admin 폴더 안에 selUser.jsp
	}

	@RequestMapping(value = { "/userList.do" }, method = RequestMethod.GET)
	public String getUserList(
			@RequestParam(value = "searchKeyword", defaultValue = "", required = false) String keyword, Model model) {
		model.addAttribute("userList", userService.selectList(keyword));
		return "user/userList"; // WEB-INF 안 userList.jsp 파일이 있는 폴더가 user일 경우
	}

	@RequestMapping(value = { "/logout.do" }, method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:main.jsp"; // WEB-INF 안 login.jsp 파일이 있는 폴더가 user일 경우
	}
	
}
