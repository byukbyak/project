package jsr.one.applestore.java1.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import jsr.one.applestore.java1.model.Code;
import jsr.one.applestore.java1.model.GoodsInfo;
import jsr.one.applestore.java1.view.MenuImpl;
import jsr.one.applestore.java1.view.ToolBox;

/*  작성자 : 정성령
  	작성일 : 21.12.31
  	버전 : version_1.5
  	소스설명 : 회원 메뉴 구체화
*/

public class GuestImpl implements Guest,Code {
	
	public HashMap<Integer, GoodsInfo> cart = new HashMap<>();
	public HashMap<Integer, GoodsInfo> buy = new HashMap<>();
	public HashMap<Integer, GoodsInfo> request = new HashMap<>();

	ToolBox tool = new ToolBox();
	Scanner scan = new Scanner(System.in);
	
	// 싱글톤
	private static GuestImpl instance = new GuestImpl();
	private GuestImpl() {}
	public static GuestImpl getInstance() {
		return instance;
	}
	
	public static void main(String[] args) {
		System.out.println(HostImpl.getInstance().goods);
	}
	
	// 추상메서드 재정의
	@Override
	public void guestGoodsList() { // 1.상품목록 , 1)바로구매 2)장바구니추가
		MenuImpl.getInstance().commonMenu(STOCK_LIST);
		try {
			System.out.print("1. 바로구매     2. 장바구니추가     3. 이전메뉴");
		    System.out.print("\n메뉴번호를 입력하세요 : ");
		    int choice = MenuImpl.numScan();
	
		    if(choice<0||choice>3) {
		    	System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
		    	System.out.println();
		    	MenuImpl.getInstance().commonMenu(GOODS_LIST);
		    }else {
				switch(choice) {
				case 1 : 
					System.out.println();
					MenuImpl.getInstance().commonMenu(BUYING_NOW);		// 상품목록
					return;
				case 2 : 
					System.out.println();
					MenuImpl.getInstance().commonMenu(ADD_CART);		// 장바구니목록
					return;	
			    default: 
			    	System.out.println();
			    	System.out.println("로그아웃 되었습니다.");
			    	MenuImpl.getInstance().commonMenu(OPEN_SHOP);
			    	return;
			    }
		    }
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(GOODS_LIST);
		}
		
	}
	
	@Override
	public void nowBuy() { // 1-1)바로구매
		try {
			System.out.print("구매할 상품의 번호를 입력해주세요 : ");
			int key = MenuImpl.numScan();
			System.out.print("구매할 상품의 수량을 입력해주세요 : ");
			int num = MenuImpl.numScan();
			
			// 바로 구매 요청으로 이동
			GoodsInfo gi = HostImpl.getInstance().stock.get(key);
			buy.put(key, new GoodsInfo(gi.getGoodsName(),gi.getType(),gi.getPrice(),num));
	
			tool.addSuccess("구매 승인 요청이 완료");
			System.out.println();
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
	}
	
	@Override
	public void cartAdd() {
		try {
			System.out.print("장바구니에 추가할 상품번호 : ");
			int key = MenuImpl.numScan();
			System.out.print("장바구니에 추가할 수량입력 : ");
			int num = MenuImpl.numScan();
			
			GoodsInfo gi = HostImpl.getInstance().stock.get(key);
			cart.put(key, new GoodsInfo(gi.getGoodsName(),gi.getType(),gi.getPrice(),num));

			tool.addSuccess("장바구니에 추가 완료");
			System.out.println();
			
			MenuImpl.getInstance().commonMenu(GUEST_MENU);			
		}catch(Exception e){
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
	}
	
	@Override
	public void cartList() {
		tool.headList("장바구니 목록");
		try {
			for(Map.Entry<Integer, GoodsInfo> info : cart.entrySet()) {
				Integer key = info.getKey();
				GoodsInfo value = info.getValue();
				System.out.println(key + "\t"+ value);
			}
			tool.oneLine();
			System.out.print("1. 결제     2. 삭제     3.이전메뉴");
			System.out.print("\n메뉴번호를 입력하세요 : ");
			
			int choice = MenuImpl.numScan();
			
			if(choice<0||choice>3) {
				System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
				MenuImpl.getInstance().commonMenu(CART_LIST);
			}else {
				switch(choice) {
				case 1 : 
					System.out.println();
					MenuImpl.getInstance().commonMenu(CART_BUY);			// 결제
					break;
				case 2 : 
					System.out.println();
					MenuImpl.getInstance().commonMenu(CART_DEL);			// 삭제
					break;	
				default: 
					System.out.println();
					MenuImpl.getInstance().commonMenu(GUEST_MENU);
					break;
				}
			}
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
	}

	@Override
	public void cartRemove() {
		tool.headLine("장바구니삭제");
		try {
			System.out.print("삭제할 상품의 코드를 입력하세요 : ");
			
			int removeNum = MenuImpl.numScan();
			cart.remove(removeNum);
			
			tool.addSuccess("제품이 삭제");
			System.out.println();
			MenuImpl.getInstance().commonMenu(CART_LIST);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
	}

	@Override
	public void cartBuy() {
		try {
			System.out.println("장바구니의 모든 목록을 구매하시겠습니까?");
			System.out.print("1. 예          2. 아니오(이전메뉴)");
			System.out.print("\n메뉴번호를 입력하세요 : ");
			
			int choice = MenuImpl.numScan();
			
			if(choice<0||choice>2) {
				System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
				System.out.println();
				MenuImpl.getInstance().commonMenu(CART_LIST);
			}else {
				switch(choice) {
					case 1 : 
						System.out.println();
						buy.putAll(cart);
						tool.addSuccess("구매 승인 요청이 완료");
						MenuImpl.getInstance().commonMenu(GUEST_MENU);
						break;
					default: 
						System.out.println();
						MenuImpl.getInstance().commonMenu(GUEST_MENU);
						break;
					}
			}
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
		
	}
	
	@Override
	public void purchased() {
		tool.headList("구매목록");
		try {
			for(Map.Entry<Integer, GoodsInfo> info : HostImpl.getInstance().confirm.entrySet()) {
				Integer key = info.getKey();
				GoodsInfo value = info.getValue();
				System.out.println(key + "\t"+ value);
			}
			
			System.out.print("1. 환불요청          2. 이전메뉴");
			System.out.print("\n메뉴번호를 입력하세요 : ");
			
			int choice = MenuImpl.numScan();
			
			if(choice<0||choice>2) {
		    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
		    	System.out.println();
				MenuImpl.getInstance().commonMenu(COMPLETED);
			}else {
				switch(choice) {
					case 1 : 
						System.out.println();
						MenuImpl.getInstance().commonMenu(REFUND_REQUEST);
						break;
					default: 
						System.out.println();
						MenuImpl.getInstance().commonMenu(GUEST_MENU);
						break;
					}
			}
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
			MenuImpl.getInstance().commonMenu(GUEST_MENU);
		}
		
	}
	
	@Override
	public void refund() {
		try {
			System.out.print("환불할 상품의 코드를 입력하세요 : ");
			int refundNum = MenuImpl.numScan();
			
			System.out.println(HostImpl.getInstance().confirm.get(refundNum).getGoodsName()+"을(를) 환불 요청하시겠습니까?");
			System.out.print("1. 예          2. 아니오(이전메뉴)");
			System.out.print("\n메뉴번호를 입력하세요 : ");
			
			int choice = MenuImpl.numScan();
				if(choice<0||choice>2) {
					System.out.println("잘못된 입력입니다. 다시 입력해주세요.");
					System.out.println();
					MenuImpl.getInstance().commonMenu(COMPLETED);
				}else {
					switch(choice) {
						case 1 : 
							request.putAll(cart);
							System.out.println();
							tool.addSuccess("제품이 환불 요청");
							MenuImpl.getInstance().commonMenu(COMPLETED);
							break;
						default: 
							System.out.println();
							MenuImpl.getInstance().commonMenu(GUEST_MENU);
							break;
						}
				}
			}catch(Exception e) {
		    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
		    	System.out.println();
				MenuImpl.getInstance().commonMenu(GUEST_MENU);
			}
	}

}
