--------------------------------------------------------
--  파일이 생성됨 - 일요일-5월-22-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View V_CART
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "JSP_PJ_JSR"."V_CART" ("C_NUM", "ID", "P_CODE", "P_NAME", "P_BRAND", "P_CATEGORY", "P_IMG", "P_PRICE", "NICKNAME", "C_QTY", "C_TOTAL") AS 
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
AND m.id = c.id
;
--------------------------------------------------------
--  DDL for View V_ORDER
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "JSP_PJ_JSR"."V_ORDER" ("ORDER_NO", "ID", "P_CODE", "P_NAME", "P_BRAND", "P_CATEGORY", "P_IMG", "P_PRICE", "NICKNAME", "O_QTY", "O_TOTAL", "O_STATUS", "ORDER_DAY", "R_QTY", "REFUND_DAY") AS 
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
AND m.id = o.id
;
--------------------------------------------------------
--  DDL for View V_SALES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "JSP_PJ_JSR"."V_SALES" ("P_CATEGORY", "ORDER_TOTAL_SALES", "REFUND_TOTAL_SALES") AS 
  SELECT NVL(p.p_category, 'all') as p_category,
       SUM(o.o_total) as order_total_sales,
       SUM(o.r_total) as refund_total_sales
  FROM product_tbl p,
       order_tbl o
 WHERE o.p_code = p.p_code
   AND o.o_total NOT IN (SELECT o_total FROM order_tbl WHERE o_status LIKE '%요청' AND o_status LIKE '주문취소')
 GROUP BY ROLLUP (p_category)
;
REM INSERTING into JSP_PJ_JSR.V_CART
SET DEFINE OFF;
REM INSERTING into JSP_PJ_JSR.V_ORDER
SET DEFINE OFF;
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (85,'kml',12,'DISBUNNYSTAR','SMART TOK',15000,'지연군',0,0,'환불승인',to_date('22/04/07','RR/MM/DD'),10,to_date('22/04/07','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (60,'kml',12,'DISBUNNYSTAR','SMART TOK',15000,'지연군',5,75000,'구매확정',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (31,'kml',12,'DISBUNNYSTAR','SMART TOK',15000,'지연군',10,40000,'주문취소',to_date('22/03/28','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (21,'kml',10,'DISBUNNYSTAR','ETC.',13000,'지연군',1,8900,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (19,'test',10,'DISBUNNYSTAR','ETC.',13000,'test123',1,8900,'환불취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (13,'test',10,'DISBUNNYSTAR','ETC.',13000,'test123',1,8900,'환불취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (10,'test',10,'DISBUNNYSTAR','ETC.',13000,'test123',1,8900,'주문취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (9,'kml',10,'DISBUNNYSTAR','ETC.',13000,'지연군',1,8900,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (27,'kml',10,'DISBUNNYSTAR','ETC.',13000,'지연군',6,53400,'구매확정',to_date('22/03/28','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (101,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',6,90000,'구매요청',to_date('22/05/22','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (26,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',1,0,'구매거절',to_date('22/03/28','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (25,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',1,13000,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (24,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',1,13000,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (8,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',1,13000,'환불취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (88,'kml',11,'DISBUNNYSTAR','ETC.',15000,'지연군',0,0,'환불승인',to_date('22/04/07','RR/MM/DD'),50,to_date('22/04/07','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (84,'kml',13,'DISBUNNYSTAR','SMART TOK',15000,'지연군',0,0,'환불승인',to_date('22/04/07','RR/MM/DD'),1,to_date('22/04/07','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (83,'kml',13,'DISBUNNYSTAR','SMART TOK',15000,'지연군',1,15000,'구매확정',to_date('22/04/06','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (81,'kml',13,'DISBUNNYSTAR','SMART TOK',15000,'지연군',1,15000,'환불취소',to_date('22/04/06','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (92,'kml',14,'earpearp','SMART TOK',15000,'지연군',20,300000,'구매확정',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (59,'kml',14,'earpearp','SMART TOK',15000,'지연군',6,90000,'구매확정',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (82,'kml',14,'earpearp','SMART TOK',15000,'지연군',0,0,'환불승인',to_date('22/04/06','RR/MM/DD'),5,to_date('22/04/07','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (95,'kml',15,'KITTYBUNNYPONY','ETC.',50000,'지연군',1,0,'구매거절',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (91,'kml',15,'KITTYBUNNYPONY','ETC.',50000,'지연군',5,250000,'환불취소',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (89,'kml',15,'KITTYBUNNYPONY','ETC.',50000,'지연군',30,1500000,'구매확정',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (90,'kml',16,'KITTYBUNNYPONY','ETC.',50000,'지연군',0,0,'환불승인',to_date('22/04/07','RR/MM/DD'),5,to_date('22/04/07','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (63,'kml',17,'earpearp','STICKER',4000,'지연군',10,40000,'환불취소',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (96,'kml',18,'earpearp','STICKER',3000,'지연군',50,150000,'구매승인',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (65,'kml',18,'earpearp','STICKER',3000,'지연군',30,90000,'주문취소',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (102,'kml',19,'earpearp','STICKER',4000,'지연군',5,20000,'구매요청',to_date('22/05/22','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (87,'kml',19,'earpearp','STICKER',4000,'지연군',50,200000,'구매요청',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (86,'kml',19,'earpearp','STICKER',4000,'지연군',1,4000,'주문취소',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (64,'kml',19,'earpearp','STICKER',4000,'지연군',20,80000,'주문취소',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (62,'kml',19,'earpearp','STICKER',4000,'지연군',20,80000,'환불취소',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (93,'kml',20,'earpearp','STICKER',4000,'지연군',50,200000,'주문취소',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (94,'kml',21,'earpearp','STICKER',3000,'지연군',50,150000,'구매승인',to_date('22/04/07','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (61,'kml',21,'earpearp','STICKER',3000,'지연군',10,30000,'구매확정',to_date('22/04/05','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (16,'test',2,'earpearp','ETC.',33900,'test123',1,49000,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (29,'kml',3,'earpearp','ETC.',30900,'지연군',6,0,'구매거절',to_date('22/03/28','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (28,'kml',3,'earpearp','ETC.',30900,'지연군',0,0,'환불승인',to_date('22/03/28','RR/MM/DD'),1,to_date('22/04/05','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (6,'kml',4,'earpearp','ETC.',24900,'지연군',1,14800,'주문취소',to_date('22/03/24','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (3,'kml',4,'earpearp','ETC.',24900,'지연군',0,0,'환불승인',to_date('22/03/24','RR/MM/DD'),1,to_date('22/03/24','RR/MM/DD'));
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (18,'test',5,'DISBUNNYSTAR','PHONE ACC.',13900,'test123',4,35600,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (15,'test',6,'earpearp','PHONE ACC.',14900,'test123',4,35600,'주문취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (5,'kml',6,'earpearp','PHONE ACC.',14900,'지연군',1,13000,'주문취소',to_date('22/03/24','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (2,'kml',6,'earpearp','PHONE ACC.',14900,'지연군',1,13000,'환불요청',to_date('22/03/24','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (17,'test',7,'earpearp','PHONE ACC.',15900,'test123',4,39600,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (12,'test',7,'earpearp','PHONE ACC.',15900,'test123',1,9900,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (1,'kml',7,'earpearp','PHONE ACC.',15900,'지연군',1,13000,'구매요청',to_date('22/03/24','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (4,'kml',7,'earpearp','PHONE ACC.',15900,'지연군',1,13000,'환불취소',to_date('22/03/24','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (23,'kml',8,'earpearp','PHONE ACC.',14900,'지연군',1,8900,'환불거절',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (14,'test',8,'earpearp','PHONE ACC.',14900,'test123',1,8900,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (22,'kml',9,'earpearp','PHONE ACC.',14900,'지연군',1,9900,'구매확정',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (20,'test',9,'earpearp','PHONE ACC.',14900,'test123',1,9900,'주문취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (11,'test',9,'earpearp','PHONE ACC.',14900,'test123',1,9900,'환불취소',to_date('22/03/27','RR/MM/DD'),null,null);
Insert into JSP_PJ_JSR.V_ORDER (ORDER_NO,ID,P_CODE,P_BRAND,P_CATEGORY,P_PRICE,NICKNAME,O_QTY,O_TOTAL,O_STATUS,ORDER_DAY,R_QTY,REFUND_DAY) values (30,'kml',9,'earpearp','PHONE ACC.',14900,'지연군',4,39600,'구매확정',to_date('22/03/28','RR/MM/DD'),null,null);
REM INSERTING into JSP_PJ_JSR.V_SALES
SET DEFINE OFF;
Insert into JSP_PJ_JSR.V_SALES (P_CATEGORY,ORDER_TOTAL_SALES,REFUND_TOTAL_SALES) values ('ETC.',2387500,1088700);
Insert into JSP_PJ_JSR.V_SALES (P_CATEGORY,ORDER_TOTAL_SALES,REFUND_TOTAL_SALES) values ('PHONE ACC.',655200,75500);
Insert into JSP_PJ_JSR.V_SALES (P_CATEGORY,ORDER_TOTAL_SALES,REFUND_TOTAL_SALES) values ('SMART TOK',535000,240000);
Insert into JSP_PJ_JSR.V_SALES (P_CATEGORY,ORDER_TOTAL_SALES,REFUND_TOTAL_SALES) values ('STICKER',1044000,null);
Insert into JSP_PJ_JSR.V_SALES (P_CATEGORY,ORDER_TOTAL_SALES,REFUND_TOTAL_SALES) values ('all',4621700,1404200);
