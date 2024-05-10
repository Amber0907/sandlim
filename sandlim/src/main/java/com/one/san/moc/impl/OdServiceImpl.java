package com.one.san.moc.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.one.san.moc.OdService;
import com.one.san.moc.OdVO;
import com.one.san.util.Pagination;

@Service("odservice")
public class OdServiceImpl implements OdService {

	@Autowired
	private OdDAOMybatis odDAO;

	@Override
	public void revokeOd(String mid) {
		odDAO.revokeOd(mid);
	}

	@Override
	public void updateOd(OdVO vo) {
		odDAO.updateOd(vo);
	}

	@Override
	public OdVO selectOd(OdVO vo) {
		return odDAO.selectOd(vo);

	}

	@Override
	public List<OdVO> odsearch(OdVO vo) {
		return odDAO.odsearch(vo);
	}

	@Override
	public List<OdVO> ddsearch(OdVO vo) {
		return odDAO.ddsearch(vo);
	}

	@Override
	public List<OdVO> getProductListPaging(Pagination pg) {
		return odDAO.getProductListPaging(pg);
	}

	@Override
	public int countProductList(Pagination pg) {
		return odDAO.countProductList(pg);
	}

	@Override
	public int putOder(OdVO vo) {
		return odDAO.putOder(vo);
	}

	@Override
	public OdVO receipt(OdVO vo) {
		return odDAO.receipt(vo);
	}

	@Override
	public List<OdVO> odMyAllList(OdVO vo) {
		return odDAO.odMyAllList(vo);
	}

	@Override
	public List<OdVO> odMyList(OdVO vo) {
		return odDAO.odMyList(vo);
	}

}
