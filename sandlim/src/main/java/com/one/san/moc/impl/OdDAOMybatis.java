package com.one.san.moc.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OdDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	public void revokeOd(String mid) {
		mybatis.update("MdDAO.revokeOd", mid);
	}
}
