package com.one.san.moc.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.one.san.moc.OdVO;
import com.one.san.util.Pagination;

@Repository
public class OdDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 바로 취소
	public void revokeOd(String mid) {
		mybatis.update("OdDAO.revokeOd", mid);
	}

	// 주문 상태 변경
	public void updateOd(OdVO vo) {
		mybatis.update("OdDAO.updateOd", vo);
	}

	// 전체 주문 내역
	public List<OdVO> odAllList(OdVO vo) {
		return mybatis.selectList("OdDAO.odAllList", vo);
	}

	// 해당 주문 내역
	public OdVO selectOd(OdVO vo) {
		return mybatis.selectOne("OdDAO.selectOd", vo);
	}

	// 주문내역 검색
	public List<OdVO> odsearch(OdVO vo) {
		return mybatis.selectList("OdDAO.odsearch", vo);
	}

	// 주문 날짜로 검색
	public List<OdVO> ddsearch(OdVO vo) {
		return mybatis.selectList("OdDAO.ddsearch", vo);
	}

	// 전체 주문내역, 검색
	public List<OdVO> getProductListPaging(Pagination pg) {
		return mybatis.selectList("OdDAO.getProductListPaging", pg);
	}

	// 주문내역 갯수
	public int countProductList(Pagination pg) {
		return mybatis.selectOne("OdDAO.countProductList", pg);
	}

	// 주문시 od테이블 insert
	public int putOder(OdVO vo) {
		return mybatis.insert("OdDAO.putOder", vo);
	}

	// 전자영수증에서 사용할 데이터 가져오기
	public OdVO receipt(OdVO vo) {
		return mybatis.selectOne("OdDAO.receipt", vo);
	}

	// 나의 주문전체 내역
	public List<OdVO> odMyAllList(OdVO vo) {
		return mybatis.selectList("OdDAO.odMyAllList", vo);
	}

	// 나의 주문진행중 내역
	public List<OdVO> odMyList(OdVO vo) {
		return mybatis.selectList("OdDAO.odMyAllList", vo);
	}

}
