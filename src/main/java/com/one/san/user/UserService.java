package com.one.san.user;

import java.util.List;

public interface UserService {

	public int insertUser(UserVO vo);
	public int updateUser(UserVO vo);
	public int deleteUser(UserVO vo);
	
	public UserVO getLogin(UserVO vo);
	public UserVO getUser(UserVO vo);
	public UserVO selectOne(String selId);
	public List<UserVO> selectList(String keyword);
	
	public String sendVerificationEmail(String email);
	public boolean verifyEmailCode(String inputCode, String emailCode);
	public String findIdOutput(String name, String email);
	
	public UserVO selectPhno(String selId);
	public String sendsms(String phno);
	
}
