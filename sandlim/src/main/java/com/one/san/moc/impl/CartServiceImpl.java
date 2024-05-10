package com.one.san.moc.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.one.san.moc.CartService;
import com.one.san.moc.CartVO;

@Service("cartservice")
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAOMybatis cartDAO;

	// 장바구니 담기
	@Override
	public int insertCart(CartVO vo) {
		return cartDAO.insertCart(vo);
	}

	// 장바구니 이동시 리스트 가져오기
	@Override
	public List<CartVO> getCartList(CartVO vo) {
		System.out.println("서비스 임플 안");
		return cartDAO.getCartList(vo);
	}

	@Override
	// 장바구니 테이블에 데이터있는지 확인
	public CartVO CartListCheck(CartVO vo) {
		return cartDAO.CartListCheck(vo);
	}

	// 중복 상품 있을시 업데이트
	@Override
	public int UpdateCart(CartVO vo) {
		System.out.println("서비스 임플 안");
		return cartDAO.UpdateCart(vo);
	}
	
	// 장바구니 메뉴삭제
	@Override
	   public int deleteCart(CartVO vo) {
	      return cartDAO.deleteCart(vo);
	   }

}
