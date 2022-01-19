package jsr.one.applestore.java1.view;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

public interface Menu {
	
	public void openShop();				// 샵오픈
	public void commonMenu(int menuNo);	// 모든메뉴
	public void guestMenu();			// 게스트 메뉴
	public void guestLogin();			// 로그인메뉴
	public void createID();				// 회원가입
	public void hostLogin();			// 관리자 로그인
	public void hostMenu();				// 관리자 메뉴
	public void hostStockMenu();		// 관리자 재고관리 메뉴
	public void hostOrderMenu();		// 관리자 주문관리 메뉴

}
