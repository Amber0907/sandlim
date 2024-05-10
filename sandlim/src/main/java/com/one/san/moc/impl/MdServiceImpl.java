package com.one.san.moc.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.one.san.moc.MdService;
import com.one.san.moc.MdVO;

@Service("mdservice")
public class MdServiceImpl implements MdService {

	@Autowired
	private MdDAOMybatis mdDAO;

	// 메뉴 등록
	@Override
	public int insertMd(MdVO md) {
		System.out.println(md);
		return mdDAO.insertMd(md);
	}

	// 메뉴 수정
	@Override
	public void updateMd(MdVO vo) {
		mdDAO.updateMd(vo);
	}

	// 메뉴 삭제
	@Override
	public void deleteMd(MdVO vo) {
		mdDAO.deleteMd(vo);
	}

	//메뉴 한 줄 가져오기 
	@Override
	public MdVO upgetMd(int mNo) {
		return mdDAO.upgetMd(mNo);
	}

	// 키워드 메뉴
	@Override
	public List<MdVO> selectkind(MdVO vo) {
		return mdDAO.selectkind(vo);
	}
	
	// 품절 메뉴
	@Override
	public List<MdVO> soldList(MdVO vo) {
		return mdDAO.soldList(vo);
	}

	// 메뉴 검색
	@Override
	public List<MdVO> searchList(MdVO vo) {
		return mdDAO.searchList(vo);
	}

	// 전체 메뉴 조회
	@Override
	public List<MdVO> selectList(MdVO vo) {
		return mdDAO.selectList(vo);
	}

	// 메뉴 상세정보 가져오기
	@Override
	public MdVO getMd(MdVO vo) {
		return mdDAO.getMd(vo);
	}

	// 메뉴 영양정보 가져오기
	@Override
	public MdVO getContent(MdVO vo) {
		return mdDAO.getContent(vo);
	}

}
