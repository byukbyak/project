package jsr.one.applestore.java1.service;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

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
