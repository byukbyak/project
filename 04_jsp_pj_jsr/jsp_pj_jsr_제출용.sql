-------------------------------------------------------------------------------------
                            /* 전체 테이블 조회 */
SELECT OWNER, TABLE_NAME FROM ALL_TABLES WHERE OWNER LIKE '%JSP_PJ_JSR%';
-------------------------------------------------------------------------------------
                             /* 전체 외래키 확인 */
SELECT uc.constraint_name, uc.table_name, ucc.column_name, uc.constraint_type, uc.r_constraint_name
FROM user_constraints uc, user_cons_columns ucc
WHERE uc.constraint_name = ucc.constraint_name;
-------------------------------------------------------------------------------------
                            /* 시퀀스 모음 */
-- 1. 관리자 번호 시퀀스
DROP SEQUENCE admin_no_seq;
CREATE SEQUENCE admin_no_seq
MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCYCLE;
-- 2. 상품 재고번호를 자동으로 생성하는 시퀀스
DROP SEQUENCE product_code_seq;
CREATE SEQUENCE product_code_seq
MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCYCLE;
-- 3. 주문 번호를 자동으로 생성하는 시퀀스 생성
DROP SEQUENCE order_no_seq;
CREATE SEQUENCE order_no_seq
MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 NOCYCLE;
-------------------------------------------------------------------------------------
                            /* SELECT TABLE */
SELECT * FROM admin_tbl; -- 1. 관리자 정보
SELECT * FROM customer_tbl; -- 2. 회원 정보
SELECT * FROM product_tbl; -- 3. 상품 정보
SELECT * FROM notice_tbl ORDER BY notice_no DESC; -- 4. 공지사항
SELECT * FROM cart_tbl; -- 5. 장바구니
SELECT * FROM v_cart; -- 5-1. 장바구니 뷰
SELECT * FROM order_tbl ORDER BY order_no; -- 6. 주문 정보
SELECT * FROM v_order; -- 6-1. 주문정보 뷰
SELECT * FROM v_refund; -- 6-2. 환불정보 뷰
-------------------------------------------------------------------------------------
                             /* CREATE TABLE */
/* ------------------------ 1. 관리자 정보 테이블 ------------------------ */
DROP TABLE admin_tbl CASCADE constraints;
CREATE TABLE admin_tbl (
    admin_no NUMBER CONSTRAINT admin_no_pk PRIMARY KEY,
    admin_id VARCHAR2(20) CONSTRAINT admin_id_unn NOT NULL UNIQUE,
    admin_pw VARCHAR2(20) CONSTRAINT admin_pw_nn NOT NULL,
    admin_nick VARCHAR2(20) CONSTRAINT admin_nick_unn NOT NULL UNIQUE
);
/* ------------------------ 2. 회원 정보 테이블 ------------------------ */
DROP TABLE customer_tbl CASCADE constraints;
CREATE TABLE customer_tbl (
    id          VARCHAR2(20)    PRIMARY KEY,
    password    VARCHAR2(20)    NOT NULL,
    name        VARCHAR2(20)    NOT NULL,
    nickname    VARCHAR2(20)    NOT NULL UNIQUE,
    birthday    DATE            NOT NULL,
    address     VARCHAR2(100)   NOT NULL,
    hp          VARCHAR2(13)    NOT NULL,
    email       VARCHAR2(50)    NOT NULL UNIQUE,
    indate      DATE            DEFAULT sysdate,
    grade       VARCHAR2(30)    DEFAULT '일반',
    show        CHAR(1)         DEFAULT 'y' -- 탈퇴시 update customer_tbl set show = 'n';
);
/* ------------------------ 3. 상품 정보 테이블 ------------------------ */
DROP TABLE product_tbl CASCADE constraints;
CREATE TABLE product_tbl (
    p_code      NUMBER          PRIMARY KEY,                           -- 재고번호,시퀀스
    p_brand     VARCHAR2(20)    NOT NULL,                           -- 브랜드명
    p_category  VARCHAR2(20)    NOT NULL,                           -- 제품 카테고리
    p_name      CLOB            NOT NULL,                           -- 제품명
    p_content   VARCHAR2(100),                                      -- 제품설명
    p_img       CLOB,                                               -- 이미지명
    p_price     NUMBER          NOT NULL,                           -- 판매가격
    p_qty       NUMBER          NOT NULL,                           -- 재고수량
    p_option    VARCHAR2(20)    DEFAULT '선택안함',                   -- 상품옵션 (각각다름)
    indate      DATE            DEFAULT sysdate,                    -- 등록일,자동생성
    outdate     DATE            DEFAULT sysdate+(INTERVAL '1' YEAR),-- 판매기한,자동생성
    status      VARCHAR2(15)    DEFAULT '준비중'                     -- 판매상태(준비중,판매중,판매중지,판매완료,예약중)
);
/* ------------------------ 4. 공지사항 게시판 ------------------------ */
DROP TABLE notice_tbl CASCADE constraints;
CREATE TABLE notice_tbl (
    notice_no NUMBER PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    content CLOB,
    writer VARCHAR(20) NOT NULL CONSTRAINT notice_writer_fk
    REFERENCES admin_tbl(admin_nick) ON DELETE CASCADE,
    readCnt NUMBER DEFAULT 0,
    indate DATE DEFAULT sysdate,
    show CHAR(1) DEFAULT 'y'
);
/* ------------------------ 8. 장바구니 테이블 ------------------------ */
DROP TABLE cart_tbl CASCADE constraints ;
CREATE TABLE cart_tbl (
    cart_no NUMBER CONSTRAINT cart_no_pk Primary key,
    p_code NUMBER NOT NULL CONSTRAINT cart_p_code_fk
    REFERENCES product_tbl(p_code) ON DELETE CASCADE,
    id VARCHAR2(20) NOT NULL CONSTRAINT cart_id_fk
    REFERENCES customer_tbl(id) ON DELETE CASCADE,
    c_qty NUMBER NOT NULL
);
/* 장바구니 뷰 */
CREATE OR REPLACE VIEW v_cart AS
SELECT c.cart_no as c_num,
       c.id as id,
       c.p_code as p_code,
       p.p_name as p_name,
       p.p_brand as p_brand,
       p.p_category as p_category,
       p.p_img as p_img,
       p.p_price as p_price,
       m.nickname as nickname,
       c.c_qty as c_qty,
       (p.p_price*c.c_qty) as c_total
FROM customer_tbl m,
    product_tbl p,
    cart_tbl c
WHERE c.p_code = p.p_code
AND m.id = c.id;
/* ------------------------ 9. 주문정보 테이블 ------------------------ */
DROP TABLE order_tbl CASCADE constraints ;
CREATE TABLE order_tbl (
    order_no NUMBER CONSTRAINT order_no_pk Primary key,
    p_code NUMBER NOT NULL CONSTRAINT order_p_code_fk
    REFERENCES product_tbl(p_code) ON DELETE CASCADE,
    p_price NUMBER NOT NULL,
    id VARCHAR2(20) NOT NULL CONSTRAINT order_id_fk
    REFERENCES customer_tbl(id) ON DELETE CASCADE,
    o_qty NUMBER NOT NULL,
    o_total NUMBER NOT NULL,
    o_status VARCHAR2(30) DEFAULT '구매요청',
    order_day DATE DEFAULT sysdate,
    r_qty NUMBER,
    refund_day DATE 
);
-- 전체 주문정보 뷰 - 마이페이지 / 관리자 주문 정보 확인
CREATE OR REPLACE VIEW v_order AS
SELECT o.order_no as order_no,
       o.id as id,
       o.p_code as p_code,
       p.p_name as p_name,
       p.p_brand as p_brand,
       p.p_category as p_category,
       p.p_img as p_img,
       p.p_price as p_price,
       m.nickname as nickname,
       o.o_qty as o_qty,
       o.o_total as o_total,
       o.o_status as o_status,
       o.order_day as order_day,
       o.r_qty as r_qty,
       o.refund_day as refund_day
FROM customer_tbl m,
    product_tbl p,
    order_tbl o
WHERE o.p_code = p.p_code
AND m.id = o.id;
-- 환불정보 뷰 - 마이페이지 / 관리자 주문 정보 확인
CREATE OR REPLACE VIEW v_refund AS
SELECT o.order_no as refund_no,
       o.id as id,
       o.p_code as p_code,
       p.p_name as p_name,
       p.p_brand as p_brand,
       p.p_category as p_category,
       p.p_img as p_img,
       p.p_price as p_price,
       m.nickname as nickname,
       o.o_qty as o_qty,
       (p.p_price*o.o_qty) as o_total,
       o.o_status as o_status,
       o.order_day as order_day,
       o.refund_day as refund_day
FROM customer_tbl m,
    product_tbl p,
    order_tbl o
WHERE o.p_code = p.p_code
AND m.id = o.id
AND o.o_status LIKE '환불'||'%';


























