package jsr.one.applestore.java1.service;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

public interface Host {
	
	public static final String ID = "host";			// 관리자 고유 ID
	public static final String PASSWORD = "host";	// 관리자 고유 PW
	
	// 관리자 - 재고관리
	public void goodsList();
	public void goodsAdd();
	public void goodsUpdate();
	public void goodsRemove();
	
	// 관리자 - 주문관리
	public void orderList();
	public void orderConfirm();
	public void orderCancel();
	
	// 관리자 - 결산
	public void saleTotal();

}
