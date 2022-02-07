/**
 * 	new > other > javascript > javascript file
	3-3. 자바스크립트 이벤트 추가 : 햄버거버튼을 클릭하면 아래쪽으로 메뉴가 나오도록 main.js에서 추가
	navbar_toggleBtn(햄버거 버튼)을 클릭했을때 menu와 icon의 클래스에 active가 없다면 
 */

const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.global_menu');
const icons = document.querySelector('.global_icons');

/* addEventListener API를 통해 클릭이 될때마다 지정한 함수 호출 */
toggleBtn.addEventListener('click', () => { 
	alert('test');
	menu.classList.toggle('active');
	icons.classList.toggle('active');
});