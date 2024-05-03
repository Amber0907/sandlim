package com.one.san.moc.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.one.san.moc.OdService;

@Service("odservice")
public class OdServiceImpl implements OdService {

	@Autowired
	private OdDAOMybatis odDAO;

	@Override
	public void revokeOd(String mid) {
		odDAO.revokeOd(mid);
	}
}
