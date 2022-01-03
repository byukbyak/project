package jsr.one.applestore.java1.view;

import java.util.HashMap;
import java.util.Scanner;

import jsr.one.applestore.java1.model.Code;
import jsr.one.applestore.java1.service.GuestImpl;
import jsr.one.applestore.java1.service.Host;
import jsr.one.applestore.java1.service.HostImpl;

public class MenuImpl implements Menu, Code {

	public static HashMap<String, String> member = new HashMap<String, String>();
	
	// 싱글톤 적용
	private static MenuImpl instance = new MenuImpl();
	private MenuImpl() {}
	public static MenuImpl getInstance() {
		return instance;
	}

	Scanner scan = new Scanner(System.in);
	
	public static Scanner scan() { //스캔 준비
	      Scanner keyboard = new Scanner(System.in);
	      return keyboard;
	   }
	   
	   public static int numScan() { // 숫자스캔
	      return scan().nextInt();
	   }
	   
	   public static String strScan() { // 문자스캔
	      return scan().nextLine();
	   }
	
	// 싱글톤 메뉴 호출
	public ToolBox tool = new ToolBox();
	public GuestImpl guest = GuestImpl.getInstance();
	public HostImpl host = HostImpl.getInstance();
	
	
	@Override
	public void openShop() {
		
		System.out.println("---------------- Apple Shop ----------------");
	    System.out.print("1. 고객      2. 관리자      3.회원가입      4.종료");
	    System.out.print("\n메뉴번호를 입력하세요 : ");
	    int choice = numScan();
	    int breakpoint = 0;
	    
		try {  
	    	if(choice<0||choice>5) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	commonMenu(OPEN_SHOP);
		    }else {
			    while(breakpoint == 0) {
					switch(choice){
					case 1 : 
						System.out.println();
						commonMenu(GUEST_LOGIN);		// 고객로그인
						break;
					case 2 : 
						System.out.println();
						commonMenu(HOST_LOGIN);		// 관리자 로그인
						break;	
					case 3 : 
						System.out.println();
						commonMenu(NEW_MEMBER); 		// 회원가입
						break;
					case 4: 
						System.out.println();
						System.out.println("프로그램을 종료합니다.");
						breakpoint=1;
				    	return;
					}
			    }
		    }
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	commonMenu(OPEN_SHOP);
	    }
	}

	@Override
	public void guestLogin() {
		tool.headLine("고객 로그인");
	    System.out.print("ID : ");
	    String inID = strScan();
		    if(!member.containsKey(inID)) {
		    	System.out.println("ID가 유효하지 않습니다.");
		    	System.out.println();
		    	commonMenu(OPEN_SHOP);
		    }else {
		    System.out.print("PW : ");
		    String inPW = strScan();
		    	if(!member.containsValue(inPW)) {
		    		System.out.println("PW가 유효하지 않습니다.");
		    		System.out.println();
		    		commonMenu(OPEN_SHOP);
		    	}else {
		    		tool.loginSuccess();
		    		guestMenu();
		    	}
	    }
		    
	}
	@Override
	public void createID() {
		System.out.println();
		tool.headLine("회원가입");
		System.out.print("사용할 ID를 입력하세요 : ");
		String newID = strScan();
		System.out.print("사용할 PASSWORD를 입력하세요 : ");
		String newPW = strScan();
		
		member.put(newID, newPW);
		tool.newMemberSuccess();
		
		System.out.println();
		commonMenu(OPEN_SHOP);
	}
	
	@Override
	public void guestMenu() {
		tool.headLine("회원 메뉴");
	    System.out.print("1. 상품목록     2. 장바구니목록     3.구매목록     4.로그아웃");
	    System.out.print("\n메뉴번호를 입력하세요 : ");
	    int choice = numScan();
	    try {
		    if(choice<0||choice>4) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	commonMenu(GUEST_MENU);
		    }else {
				switch(choice) {
					case 1 : 
						System.out.println();
						commonMenu(GOODS_LIST);			// 상품목록
						return;
					case 2 : 
						System.out.println();
						commonMenu(CART_LIST);		// 장바구니목록
						return;	
					case 3 : 
						System.out.println();
						commonMenu(COMPLETED); 	// 구매목록
						return;
				    default: 
				    		System.out.println("로그아웃 되었습니다.");
				    		System.out.println();
				    		commonMenu(OPEN_SHOP);
				    	return;
				    }
				}
		    }catch(Exception e) {
		    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
		    	System.out.println();
		    	commonMenu(OPEN_SHOP);
		    }
	}


	@Override
	public void hostLogin() {
		tool.headLine("관리자 로그인");
	    System.out.print("ID : ");
	    String inID = strScan();
	    try {
		    if(!inID.equals(Host.ID)) {
		    	System.out.println("ID가 유효하지 않습니다.");
		    	System.out.println();
		    	commonMenu(OPEN_SHOP);
		    }else {
			    System.out.print("PW : ");
			    String inPW = strScan();
			    	if(!inPW.equals(Host.PASSWORD)) {
			    		System.out.println();
			    		System.out.println("PW가 유효하지 않습니다.");
			    		commonMenu(OPEN_SHOP);
			    	}else {
			    		tool.loginSuccess();
			    		System.out.println();
			    		hostMenu();
			    	}
		    }
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	commonMenu(OPEN_SHOP);
	    }

	}

	@Override
	public void hostMenu() {
		tool.headLine("관리자 메뉴");
	    System.out.print("1. 재고관리     2. 주문관리     3.로그아웃");
	    System.out.print("\n메뉴번호를 입력하세요 : ");
	    int choice = numScan();
	    try {
		    if(choice<0||choice>3) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	commonMenu(HOST_MENU);
		    }else {
				switch(choice) {
					case 1 : 
						System.out.println();
						hostStockMenu();		// 재고관리
						return;
					case 2 : 
						System.out.println();
						hostOrderMenu();		// 주문관리
						return;	
					default: 
						System.out.println("로그아웃 되었습니다.");
						System.out.println();
			    		commonMenu(OPEN_SHOP);
				    	return;
			    }
		    }
	    }catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
	    	commonMenu(HOST_MENU);
	    }
		
	}

	@Override
	public void hostStockMenu() {
		tool.headLine("재고관리");
	    System.out.print("1. 추가     2. 수정     3. 삭제     4. 이전메뉴");
	    System.out.print("\n메뉴번호를 입력하세요 : ");
	    int choice = numScan();
	    try {
		    if(choice<0||choice>4) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	commonMenu(STOCK_MENU);
		    }else {
				switch(choice) {
				case 1 : 
					System.out.println();
					commonMenu(STOCK_ADD);			// 추가
					return;
				case 2 : 
					System.out.println();
					commonMenu(STOCK_UPDATE);		// 수정
					return;	
				case 3 : 
					System.out.println();
					commonMenu(STOCK_DEL); 			// 삭제
					return;
			    default: 
			    	System.out.println();
			    	commonMenu(HOST_MENU);
			    	return;
			    }
			}
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	commonMenu(STOCK_MENU);
	    }
		
	}
	
	@Override
	public void hostOrderMenu() {
		tool.headLine("주문관리");
		HostImpl.getInstance().orderList();
		tool.oneLine();
	    System.out.print("1. 주문승인     2. 주문취소     3. 결산     4. 이전메뉴");
	    System.out.print("\n메뉴번호를 입력하세요 : ");
	    int choice = numScan();
	    try {
		    if(choice<0||choice>4) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	MenuImpl.getInstance().commonMenu(ORDER_MENU);
		    }else {
				switch(choice) {
				case 1 : 
					System.out.println();
					commonMenu(ORDER_CONFIRM);		// 추가
					return;
				case 2 : 
					System.out.println();
					commonMenu(ORDER_CANCEL);		// 수정
					return;	
				case 3 : 
					System.out.println();
					commonMenu(ORDER_TOTAL); 		// 구매목록
					return;
			    default: 
			    	System.out.println();
			    	commonMenu(HOST_MENU);
			    	return;
			    }
		    }
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
	    	commonMenu(STOCK_MENU);
	    }
	}
	
	@Override
	public void commonMenu(int menuNo) {
		switch(menuNo) {
		case OPEN_SHOP : openShop(); break;				// 오픈
		
		// < 고객 >
		case GUEST_LOGIN : guestLogin(); break;			// 고객로그인 - 메뉴노출
		
		case GUEST_MENU : guestMenu(); break;			// 1. 고객메뉴
		case GOODS_LIST : guest.guestGoodsList(); break; 	// 상품목록 및 선택화면
		case BUYING_NOW : guest.nowBuy();break; 			// 1) 바로구매
		case ADD_CART : guest.cartAdd(); break; 			// 2) 장바구니추가
		
		case CART_LIST : guest.cartList(); break; 		// 2. 장바구니목록
		case CART_BUY : guest.cartBuy(); break;				// 1) 결제
		case CART_DEL : guest.cartRemove(); break; 			// 2) 삭제
			
		case COMPLETED : guest.purchased(); break;		// 3. 구매목록
		case REFUND_REQUEST : guest.refund(); break; 		// 1) 환불요청
		
		// < 관리자 >
		case HOST_LOGIN : hostLogin(); break; 			// 관리자 로그인 - 메뉴선택
		case HOST_MENU : hostMenu(); break; 			// 관리자메뉴
		
		case STOCK_MENU : hostStockMenu(); break; 		// 1. 재고관리 - 1) 목록
		case STOCK_LIST : host.goodsList(); break; 		// 1. 재고관리 - 1) 목록
		case STOCK_ADD : host.goodsAdd(); break; 			// 2) 추가
		case STOCK_UPDATE : host.goodsUpdate(); break; 		// 3) 수정
		case STOCK_DEL : host.goodsRemove(); break; 		// 4) 삭제
		
		case ORDER_MENU : hostOrderMenu(); break;		// 2. 주문관리 - 1) 주문목록
		case ORDER_LIST : host.orderList(); break;		// 2. 주문관리 - 1) 주문목록
		case ORDER_CONFIRM : host.orderConfirm(); break;	// 2) 결제승인
		case ORDER_CANCEL : host.orderCancel(); break;		// 3) 결제취소
		case ORDER_TOTAL : host.saleTotal(); break;			// 4) 결산
		
		case NEW_MEMBER : createID(); break;			// 회원가입
		
		}
	}

}
