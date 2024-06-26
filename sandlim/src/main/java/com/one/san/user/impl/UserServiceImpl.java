package com.one.san.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.one.san.user.UserService;
import com.one.san.user.UserVO;
import com.one.san.util.Pagination;
import com.one.san.util.VerificationCodeGenerator;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private UserDAOMybatis userDAO;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder; // 비밀번호 암호화를 위한 Encoder

	@Override
	   public int insertUser(UserVO vo) {
	      System.out.println("조건문들 다 통과");
	      String encryptedPassword = passwordEncoder.encode(vo.getU_pw()); // 비밀번호 암호화
	      vo.setU_pw(encryptedPassword); // 암호화된 비밀번호로 설정
	      return userDAO.insertUser(vo);
	   }
	
	// 장바구니에서 회원정보 가져오기
    @Override
    public UserVO cartSelectUser(UserVO vo) {
       return userDAO.cartSelectUser(vo);
    }

    // 비밀번호 재설정에 사용했음
 	@Override
 	public int updateUser(UserVO vo) {
 		String password = vo.getU_pw();
 		password = passwordEncoder.encode(password);
 		vo = getUser(vo);
 		vo.setU_pw(password); // 암호화된 비밀번호로 설정
 		int num = userDAO.updateUser(vo);
 		return num;
 	}

	@Override
	public int deleteUser(UserVO vo) {
		int num = userDAO.deleteUser(vo);
		return num;
	}

	// u_no 를 가지고 유저 정보들 가져옴.
	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}

	@Override
	public UserVO selectOne(String selId) {
		return userDAO.selectOne(selId);
	}

	@Override
	public List<UserVO> selectList(Pagination pg) {
		return userDAO.selectList(pg);
	}
	
	@Override
	public int userTotalCnt(Pagination pg) {
		return userDAO.userTotalCnt(pg);
	}

	@Override
	public String sendVerificationEmail(String email) {

		String verCode = VerificationCodeGenerator.generate();

		try {
			// 메시지 생성
			MimeMessage message = mailSender.createMimeMessage();
			message.setSubject("이메일 인증 코드");
			message.setText("당신의 이메일 인증 코드는 " + verCode + "입니다.");
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));

			// 메시지 전송
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return verCode;
	}

	public boolean verifyEmailCode(String inputCode, String emailCode) {
		return emailCode.equals(inputCode);
	}

	@Override
	public String findIdOutput(String name, String email) {
		// findUser에 보내주려고 맵형식으로 만들어줌
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("u_name", name);
		map.put("u_email", email);

		String uId = null;
		uId = userDAO.findUser(map);
		System.out.println("uid 확인하기: "+uId);

		return uId;
	}

	@Override
	public UserVO selectPhno(String selId) {
		return userDAO.selectPhno(selId);
	}
	
	@Override
	public UserVO selectEmail(String selId) {
		return userDAO.selectEmail(selId);
	}

	@Override
	public String sendsms(String phno) {

		String random = VerificationCodeGenerator.generate();
//	      String api_key = "NCS665AHFZ154SIC";
//	      String api_secret = "XN4S35RRONVXBNYLEPFLP0UUPXMMJBPC";
//	      Message coolsms = new Message(api_key, api_secret);
		//
//	      HashMap<String, String> set = new HashMap<String, String>();
		//
//	      String phno2 = phno.replace("-", "");
		//
//	      set.put("to", phno2); // 수신번호
//	      set.put("from", "01051419521"); // 발신번호
//	      set.put("text", "[산들림] 회원가입 인증 번호는 [" + random + "] 입니다."); // 문자내용
//	      set.put("type", "sms"); // 문자 타입
//	      System.out.println(set);

//	      try {
//	         JSONObject result = coolsms.send(set); // 보내기&전송결과받기
//	         System.out.println(result.toString());
//	         
//	      } catch (CoolsmsException e) {
//	         
//	         System.out.println(e.getMessage());
//	         System.out.println(e.getCode());
//	         
//	      }

		return random;/* 비교를 위해 인증 번호를 돌려받아야함 */

	}

	//로그인용
	@Override
	public UserVO getLogin(UserVO vo) {
		UserVO user = userDAO.getUser(vo);
		System.out.println(user);

		if (user != null) {
			boolean isMatch = passwordEncoder.matches(vo.getU_pw(), user.getU_pw());
			if (isMatch) {
				return user;
			}
		}

		return null;
	}

	public int chkSocialLogin(UserVO vo) {
	      UserVO tmp = new UserVO();
	      
	      // 이미 가입된 회원. 카카오 => -1, 네이버 => -2, 일반 => -3
	      if((tmp = selectEmail(vo.getU_email())) != null) {
	         System.out.println("이메일중복");
	         if(tmp.getU_social().equals("카카오회원")) 
	            return -1;
	         else if(tmp.getU_social().equals("네이버회원"))
	            return -2;
	         else 
	            return -3;
	      }else if((tmp = selectPhno(vo.getU_phno())) != null){
	         System.out.println("전화번호중복");
	         System.out.println(tmp.getU_social());
	         if(tmp.getU_social().equals("카카오회원")) 
	            return -1;
	         else if(tmp.getU_social().equals("네이버회원"))
	            return -2;
	         else 
	            return -3;
	      }else if((tmp = getUser(vo)) != null) {
	         System.out.println("아이디중복");
	         if(tmp.getU_social().equals("카카오회원")) 
	            return -1;
	         else if(tmp.getU_social().equals("네이버회원"))
	            return -2;
	         else 
	            return -3;
	      }
	      
	      return 0;
	   }

}
