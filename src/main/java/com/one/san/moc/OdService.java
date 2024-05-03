package com.one.san.moc;

public interface OdService {

	//주문 취소(결제 취소 후 실행됨) 주문상태 "주문취소" 로 변경 
	public void revokeOd(String mid);
	
}
