package jsr.one.applestore.java1.service;

public interface Guest {
	
	// 회원가입 후 가입한 정보로 로그인한다.
	// 테스트용도
	public static final String ID = "guest";
	public static final String PASSWORD = "guest";
	
	// 고객 - 회원메뉴
	public void guestGoodsList();		// 1. 상품목록
	public void cartList();			// 2. 장바구니목록
	public void purchased();		// 3. 구매목록
	
	// 고객 - 장바구니
	public void cartAdd();
	public void cartRemove();
	public void cartBuy();
	
	// 고객 - 바로구매
	public void nowBuy();
	
	// 고객 - 환불
	public void refund();

}
