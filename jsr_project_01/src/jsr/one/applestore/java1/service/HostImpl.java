package jsr.one.applestore.java1.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Scanner;

import jsr.one.applestore.java1.model.Code;
import jsr.one.applestore.java1.model.GoodsInfo;
import jsr.one.applestore.java1.view.MenuImpl;
import jsr.one.applestore.java1.view.ToolBox;

public class HostImpl implements Host,Code {
	
	// 멤버변수
	private int totalM = 0;//총 승인건
	private int totalR = 0;//총 환불건
	
	private int totalMoney(int money) { // 총 승인건 합산 메서드
		return this.totalM += money;
	}
	
	private int totalRefund(int money) { // 총 환불건 합산 메서드
		return this.totalR += money;
	}
	
	public HashMap<Integer, GoodsInfo> stock = new HashMap<>();
	public HashMap<Integer, GoodsInfo> confirm = new HashMap<>();
	public HashMap<Integer, GoodsInfo> refund = new HashMap<>();
	
	ToolBox tool = new ToolBox();
	Scanner scan = new Scanner(System.in);
	Random random = new Random();
	
	// 싱글톤
	private static HostImpl instance;
	public HostImpl() {}
	public static HostImpl getInstance() {
		if(instance == null) {
			instance = new HostImpl();
		} return instance;
	}
	
	GoodsInfo goods = new GoodsInfo();
	
	// 추상메서드 재정의
	@Override
	public void goodsList() {
		tool.headList("상품목록");
		try {
			for(Map.Entry<Integer, GoodsInfo> info : stock.entrySet()) {
				Integer key = info.getKey();
				GoodsInfo value = info.getValue();
				System.out.println(key + "\t"+ value);
			}
			tool.oneLine();
		} catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
			
		}
		
	}

	@Override
	public void goodsAdd() {
		tool.headAddGoods();
		try {
			System.out.print("제품명 : ");
			String name = MenuImpl.strScan();
			System.out.print("타입 : ");
			String type = MenuImpl.strScan();
			System.out.print("가격 : ");
			int price = MenuImpl.numScan();
			System.out.print("수량 : ");
			int count = MenuImpl.numScan();
			
			int randomkey = random.nextInt(1000)+1000;
			stock.put(randomkey, new GoodsInfo(name,type,price,count));
			
			tool.addSuccess("제품이 등록");
			System.out.println();
			
			goodsList();
			System.out.println();
			
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
			
		}catch(Exception e){
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
		}
		
	}

	@Override
	public void goodsUpdate() {
		tool.headLine("상품수정");
		try {
			System.out.print("수정할 상품번호 : ");
			int key = MenuImpl.numScan();
			System.out.print("수정할 제품명 : ");
			String name = MenuImpl.strScan();
			System.out.print("수정할 타입 : ");
			String type = MenuImpl.strScan();
			System.out.print("수정할 가격 : ");
			int price = MenuImpl.numScan();
			System.out.print("수정할 수량 : ");
			int count = MenuImpl.numScan();
			
			stock.put(key, new GoodsInfo(name,type,price,count));
			tool.addSuccess("제품이 수정");
			System.out.println();
			
			goodsList();
			System.out.println();
			
			System.out.println();
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
		}
	}

	@Override
	public void goodsRemove() {
		tool.headLine("상품삭제");
		try {
			System.out.print("삭제할 상품의 코드를 입력하세요 : ");
			int removeNum = MenuImpl.numScan();
			
			stock.remove(removeNum);
			tool.addSuccess("제품이 삭제");
			System.out.println();
			
			goodsList();
			System.out.println();
			
			System.out.println();
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
			MenuImpl.getInstance().commonMenu(STOCK_MENU);
		}
	}

	@Override
	public void orderList() {
		try {
			tool.headList("승인요청");
			for(Map.Entry<Integer, GoodsInfo> info1 : GuestImpl.getInstance().buy.entrySet()) {
				Integer key = info1.getKey();
				GoodsInfo value = info1.getValue();
				System.out.println(key + "\t"+ value);
			}
			tool.headList("환불요청");
			for(Map.Entry<Integer, GoodsInfo> info2 : GuestImpl.getInstance().request.entrySet()) {
				Integer key = info2.getKey();
				GoodsInfo value = info2.getValue();
				System.out.println(key + "\t"+ value);
			}
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
	    	MenuImpl.getInstance().commonMenu(ORDER_MENU);
	    }
		
	}

	@Override
	public void orderConfirm() {
		tool.headLine("주문승인");
		
		try {
			System.out.print("승인할 주문의 번호를 입력하세요 : ");
			int key = MenuImpl.numScan();
			
			GoodsInfo cf = GuestImpl.getInstance().buy.get(key);
			
			confirm.put(key, cf);
			stock.get(key).minus(cf.getCount());
			GuestImpl.getInstance().buy.remove(key);
			
			// 승인된 결제 합산
			totalMoney((cf.getPrice()*cf.getCount()));
			
			tool.addSuccess("주문이 승인");
			System.out.println();
			
			MenuImpl.getInstance().commonMenu(ORDER_MENU);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	System.out.println();
	    	MenuImpl.getInstance().commonMenu(ORDER_MENU);
	    }
		
		
	}

	@Override
	public void orderCancel() { // 확인해야됨
		
		try {
			System.out.print("취소할 주문의 번호를 입력하세요 : ");
			int key = MenuImpl.numScan();
			
			GoodsInfo cancle = GuestImpl.getInstance().request.get(key);
			
			refund.put(key, cancle);
			stock.get(key).plus(cancle.getCount());
			GuestImpl.getInstance().request.remove(key);
			
			// 환불 결제건 합산
			totalRefund((cancle.getPrice()*cancle.getCount()));

			tool.addSuccess("주문이 취소");
			System.out.println();
			MenuImpl.getInstance().commonMenu(ORDER_MENU);
			
		}catch(Exception e) {
	    	System.out.println("잘못된 입력입니다, 다시 시도해주세요.");
	    	MenuImpl.getInstance().commonMenu(ORDER_MENU);
	    }
		
	}

	@Override
	public void saleTotal() {
		tool.headLine("결산");
		tool.oneLine();
		
		System.out.println("총 승인된 결제건 : "+totalM);
		System.out.println("총 환불된 결제건 : "+totalR);
		
		System.out.println("총 매출액은 "+(totalM-totalR)+"원 입니다.");
		tool.oneLine();
		MenuImpl.getInstance().commonMenu(ORDER_MENU);
	}

}
