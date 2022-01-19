package jsr.one.applestore.java1.model;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

public class GoodsInfo {
	
	// 멤버변수
	private String goodsName;	// 상품명
	private String type;		// 타입
	private int price;			// 가격
	private int count;			// 재고
	private int total;			// 토탈
	
	// 디폴트 생성자
	public GoodsInfo () {}
	
	// 매개변수 생성자 - 입력용
	public GoodsInfo (String goodsName, String type, int price, int count) {
		this.goodsName=goodsName;
		this.type=type;
		this.price=price;
		this.count=count;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}
	public int getTotal() {
		return total;
	}
	
	// 마이너스 { 구매한 수량만큼 전체 재고수량에서 - }
	public void minus(int count) {
		this.count-=count;
	}
	// 플러스 { 구매한 수량만큼 전체 재고수량에서 - }
	public void plus(int count) {
		this.count+=count;
	}
	
	// getter,setter
	public void setGoods() {
		System.out.println("setGoods()");
	}

	public void getGoods() {
		System.out.println("getGoods()");
	}
	
	// setter, getter
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return goodsName+"\t"+type+"\t"+price+"\t"+count;
	}

}
