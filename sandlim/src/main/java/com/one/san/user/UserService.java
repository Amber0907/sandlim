package com.one.san.user;

import java.util.List;

import com.one.san.util.Pagination;

public interface UserService {

	public int insertUser(UserVO vo);
	public int updateUser(UserVO vo);
	public int deleteUser(UserVO vo);
	
	public UserVO getLogin(UserVO vo);
	public UserVO getUser(UserVO vo);
	public UserVO selectOne(String selId);
	public List<UserVO> selectList(Pagination pg);
	public int userTotalCnt(Pagination pg);
	
	public String sendVerificationEmail(String email);
	public boolean verifyEmailCode(String inputCode, String emailCode);
	public String findIdOutput(String name, String email);
	
	public UserVO selectPhno(String email);
	public UserVO selectEmail(String phno);
	public String sendsms(String phno);
	
	public UserVO cartSelectUser(UserVO vo);
	
	public int chkSocialLogin(UserVO vo);
	
}
