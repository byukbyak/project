package jsr.one.applestore.java1.view;

/*  작성자 : 정성령
	작성일 : 21.12.31
	버전 : version_1.5
	소스설명 : 회원 메뉴 구체화
*/

public class ToolBox {
	
	public ToolBox() {}
	
	public void oneLine() {
		System.out.println("------------------------------------------");
	}
	
	public void twoLine() {
		System.out.println("==========================================");
	}
	
	public final void loginSuccess() {
		this.twoLine();
		System.out.println("\t      로그인 되었습니다.");
		this.twoLine();
	}
	
	public final void newMemberSuccess() {
		twoLine();
		System.out.println("\t       회원가입 완료");
		twoLine();
	}
	
	public final void headLine(String headName) {
		System.out.println("              << " + headName + " >>");
	}
	
	public void headList(String listName) {
		System.out.println("================= "+listName+" =================");
		System.out.println("번호\t이름\t타입\t가격\t수량");
		this.twoLine();
	}
	
	public void headAddGoods() {
		System.out.println("================= 제품 등록 =================");
	}
	
	public void addSuccess(String doingWhat) {
		this.twoLine();
		System.out.println("\t   "+doingWhat+" 되었습니다.");
		this.twoLine();
	}
	
	public final void receipt(String timelind, String adName, String headName) {
		System.out.println("              << " + headName + " >>");
	}

}