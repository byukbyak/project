package jsr.one.applestore.java1.model;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

public interface Code {
	
	// 상수 정의, 숫자는 메뉴 번호
    static final int OPEN_SHOP = 100; 			// 오픈
    
    // ---------------------------------------------------
    
    // 고객 
    static final int GUEST_LOGIN = 110; 		// 고객로그인
    
    
    static final int GUEST_MENU = 120;			// 메뉴목록
    // 고객 - 상품목록
    static final int GOODS_LIST = 130;			// 상품목록
    static final int BUYING_NOW = 131;			// 1. 바로구매
    static final int ADD_CART = 132;			// 2. 장바구니
    
    // 고객 - 장바구니
    static final int CART_LIST = 140;			// 장바구니목록
    static final int CART_BUY = 141;			// 1. 결제
    static final int CART_DEL = 142;			// 2. 삭제
    
    // 고객 - 주문내역
    static final int COMPLETED = 150;			// 구매목록
    static final int REFUND_REQUEST = 151;		// 1. 환불요청
 
    // ---------------------------------------------------
    
    // 관리자
    static final int HOST_LOGIN = 199;  	// 관리자 로그인
    // 관리자 - 메뉴
    static final int HOST_MENU = 220;  		// 관리자메뉴
    static final int STOCK_MENU = 230; 			// 1. 재고관리
    static final int ORDER_MENU = 240; 			// 2. 주문관리
    // 관리자 - 재고관리
    static final int STOCK_LIST = 231; 			// 1. 목록
    static final int STOCK_ADD = 232; 			// 2. 추가
    static final int STOCK_UPDATE = 233; 		// 3. 수정
    static final int STOCK_DEL = 234; 			// 4. 삭제
    
    // 관리자 - 주문관리
    static final int ORDER_LIST = 241; 			// 1. 주문목록
    static final int ORDER_CONFIRM = 242; 		// 2. 결제승인
    static final int ORDER_CANCEL = 243; 		// 3. 결제취소
    
    // 관리자 - 결산
    static final int ORDER_TOTAL = 244; 		// 4. 결산
    
    // ---------------------------------------------------
    
    // 회원가입
    static final int NEW_MEMBER = 310;


}
