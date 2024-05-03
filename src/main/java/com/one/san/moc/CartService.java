package com.one.san.moc;

import java.util.List;

public interface CartService {
	
	   // 장바구니 담기
	   public int insertCart(CartVO vo);
	   
	   // 장바구니 리스트 가져오기(장바구니 이동시)
	   public List<CartVO> getCartList(CartVO vo);
	   
	   // 동일한 상품이 있는지 확인
	   public CartVO CartListCheck(CartVO vo);
	      
	   // 장바구니 담기 클릭시 동일 옵션/사이즈/메뉴이름 있을 시 수량 및 가격 업그레이드 
	   public int UpdateCart(CartVO vo);

}
