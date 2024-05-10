package com.one.san.moc.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.one.san.moc.MdVO;

@Repository
public class MdDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public int insertMd(MdVO vo) {
		return mybatis.insert("MdDAO.insertMd", vo);
	}

	public void updateMd(MdVO vo) {
		mybatis.update("MdDAO.updateMd", vo);
	}
	
	public void deleteMd(MdVO vo) {
		mybatis.delete("MdDAO.updateStateMd", vo);
	}

	public MdVO upgetMd(int mNo) {
		return mybatis.selectOne("MdDAO.getMd", mNo);
	}

	public List<MdVO> selectkind(MdVO vo) {
		return mybatis.selectList("MdDAO.selectkind", vo);
	}
	
	public List<MdVO> soldList(MdVO vo) {
		return mybatis.selectList("MdDAO.soldList", vo);
	}

	public List<MdVO> searchList(MdVO vo) {
		return mybatis.selectList("MdDAO.searchList", vo);
	}

	public List<MdVO> selectList(MdVO vo) {
		return mybatis.selectList("MdDAO.selectList", vo);
	}

	public MdVO getMd(MdVO vo) {
		return mybatis.selectOne("MdDAO.getMd", vo);
	}

	public MdVO getContent(MdVO vo) {
		return mybatis.selectOne("MdDAO.getContent", vo);
	}

}
