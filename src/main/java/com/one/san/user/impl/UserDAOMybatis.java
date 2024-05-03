package com.one.san.user.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.one.san.user.UserVO;

@Repository
public class UserDAOMybatis {
	@Autowired
	private SqlSessionTemplate mybatis;

	public int insertUser(UserVO vo) {
		return mybatis.insert("UserDAO.insertUser", vo);
	}

	public int updateUser(UserVO vo) {
		return mybatis.update("UserDAO.updateUser", vo);
	}

	public int deleteUser(UserVO vo) {
		return mybatis.delete("UserDAO.deleteUser", vo);
	}

	public UserVO getUser(UserVO vo) {
		return mybatis.selectOne("UserDAO.getUser",vo);
	}

	public UserVO selectOne(String selId) {
		return mybatis.selectOne("UserDAO.selectOne", selId);
	}

	public List<UserVO> selectList(String keyword) {
		return mybatis.selectList("UserDAO.selectList", keyword);
	}
	
	public String findUser(Map<String, Object> user) {
		return mybatis.selectOne("UserDAO.findUser", user);
	}
	
	public UserVO selectPhno(String selId) {
	      return mybatis.selectOne("UserDAO.selectPhno", selId);
	
	}
}
