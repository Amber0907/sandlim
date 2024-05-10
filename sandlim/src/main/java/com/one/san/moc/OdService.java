package com.one.san.moc;

import java.util.List;

import com.one.san.util.Pagination;

public interface OdService {

	// 주문 취소(결제 취소 후 실행됨) 주문상태 "주문취소" 로 변경
	public void revokeOd(String mid);

	// 주문 상태 변경
	public void updateOd(OdVO vo);

	// 해당 주문건
	public OdVO selectOd(OdVO vo);

	// 주문 검색
	public List<OdVO> odsearch(OdVO vo);

	// 날짜로 검색
	public List<OdVO> ddsearch(OdVO vo);

	// 전체 주문내역 리스트, 검색
	public List<OdVO> getProductListPaging(Pagination pg);

	// 주문내역 갯수
	public int countProductList(Pagination pg);

	// 주문시 od테이블 insert
	public int putOder(OdVO vo);

	// 전자영수증에서 사용할 데이터 가져오기
	public OdVO receipt(OdVO vo);

	// 나의 주문완료 내역
	public List<OdVO> odMyAllList(OdVO vo);

	// 나의 주문진행 내역
	public List<OdVO> odMyList(OdVO vo);

}
