package com.one.san.moc;

import java.util.List;

public interface MdService {

	//메뉴등록
	public int insertMd(MdVO md);
		
	//메뉴수정
	public void updateMd(MdVO vo);
	
	//메뉴삭제
	public void deleteMd(MdVO vo);
	
	//메뉴상세조회
	public MdVO getMd(MdVO vo);
	
	//메뉴수정데이터 받아오는 
	public MdVO upgetMd(int mNo);
	
	//키워드 별 메뉴 조회
	public List<MdVO> selectkind(MdVO vo);
	
	//검색 별
	public List<MdVO> searchList(MdVO vo);
	
	//메뉴 조회, 검색
	public List<MdVO> selectList(MdVO vo);

	// 상품 상세정보 가져오기
	public MdVO getContent(MdVO vo);
}
