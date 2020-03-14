Rem********************************************************************
Rem*     システムＩＤ  ：WJA
Rem*     システム名称  ：譲渡益税
Rem*     ＩＤ          ：wjajdm0121001.sql
Rem*     名称          ：国内株式預り明細(翌日)外部テーブル作成処理
Rem*     改訂履歴
Rem*     年月日     区分  案件番号   内容
Rem*     ---------- ----  ---------  ---------------------------
Rem*     20170113   新規  Y45188-001 GT-EOSL(性能対応)
Rem*     20180227   修正  Y45729-011 NISAサービス拡張
Rem*
Rem*     'Copyright (C) 2017 by Nomura Research Institute,Ltd.
Rem*     'All rights reserved.
Rem********************************************************************
set verify off
set termout on
set trimspool on
set linesize 2000
set pagesize 0
set head off
set feedback off
set num24
set colsep ""

define  ERR_CD         = 8     -- エラーコードの定義
define  TAISYO_TBL     = &1    -- 取引明細データ外部表
define  IN_FILE        = &2    -- 取引明細データファイル
define  BAD_FILE       = &3    -- 不良ファイル
define  DISCARD_FILE   = &4    -- プロセスログファイル
define  LOG_FILE       = &5    -- ログファイル


whenever sqlerror exit &ERR_CD rollback
whenever oserror  exit &ERR_CD rollback

prompt wjajdm0121001.sql 国内株式預り明細(翌日)外部テーブル作成

DECLARE
    cnt PLS_INTEGER;

BEGIN
    SELECT COUNT(1) INTO cnt FROM USER_TABLES WHERE TABLE_NAME = '&TAISYO_TBL';
    IF cnt != 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE &TAISYO_TBL';
    END IF;
END;
/

CREATE TABLE &TAISYO_TBL (
        CREATE_TIMESTAMP               NUMBER(16),
        UPDATE_TIMESTAMP               NUMBER(16),
        UPDATE_PROGRAM                 CHAR(08),
        UPDATE_PC_ADDRESS              CHAR(15),
        UPDATE_STAFF_CD                CHAR(08),
        REC_SEQ_NO                     NUMBER(15),
        REC_DELETE_ID                  CHAR(01),
        USER_CD                        NUMBER(04),
        OFFICE_CD                      CHAR(04),
        ACCOUNT_NO                     NUMBER(11),
        SEC_DOM_FGN_ID                 CHAR(01),
        SEC_ID                         CHAR(02),
        SEC_CD                         CHAR(14),
        SEC_PROPER_CD                  CHAR(05),
        SEC_SPARE_CD                   CHAR(02),
        SEC_SERIAL_CD                  CHAR(05),
        SEC_SUPPORT_CD                 CHAR(02),
        BRAND_CD                       CHAR(06),
        DEPOSIT_CD                     CHAR(03),
        PRINC_AGENT                    CHAR(01),
        MANAGE_PLACE                   CHAR(02),
        LOCATION_ID                    CHAR(02),
        LOCATION_CD1                   CHAR(04),
        LOCATION_CD2                   CHAR(07),
        LOCATION_CD3                   CHAR(02),
        DEPOSIT_NO_INIT                NUMBER(10),
        DEPOSIT_NO_LAST                NUMBER(10),
        QUANTITY                       NUMBER(12),
        BUY_COST_PRICE                 NUMBER(14),
        BUY_COST_PRICE_ID              CHAR(01),
        SELL_COST_PRICE                NUMBER(14),
        BUY_TRADE_DATE                 CHAR(08),
        CUST_DEP_DATE                  CHAR(08),
        TAX_RECKON_DATE                CHAR(08),
        DEP_EFFE_DATE                  CHAR(08),
        SELL_TRADE_DATE                CHAR(08),
        DEP_INEF_DATE                  CHAR(08),
        DEP_ROUTE_INIT                 CHAR(01),
        DEP_ROUTE_LAST                 CHAR(01),
        DEP_DETAIL_ID                  CHAR(02),
        WITHD_DETAIL_ID                CHAR(02),
        BUY_MARKET                     CHAR(03),
        BUY_TRADE                      CHAR(03),
        WITHD_REASON                   CHAR(01),
        SELL_MARKET                    CHAR(03),
        INPUT_DATE                     CHAR(08),
        OUTPUT_DATE                    CHAR(08),
        JASDEC_DEP_DATE                CHAR(08),
        JASDEC_COL_DATE                CHAR(08),
        LOCATION_CHA_DATE              CHAR(08),
        LOCATION_CHA_ID                CHAR(02),
        SELL_FORBID_ID                 CHAR(02),
        WITHD_FORBID_ID                CHAR(02),
        NON_MARKET_ID                  CHAR(02),
        UNCLAIMED_ID                   CHAR(01),
        STK_QUANTITY_ID                CHAR(01),
        SEC_CHANGE_ID                  CHAR(01),
        SEC_UNION_ID                   CHAR(01),
        COLLATERAL_ID                  CHAR(01),
        SHAREHOLDER_ID                 CHAR(01),
        UN_SPECIFY_ID                  CHAR(01),
        WITHD_PRIORITY                 NUMBER(03),
        COL_ACCOUNT_NO                 NUMBER(11),
        NISA_ACQUISITION_YEAR          CHAR(04)
)
ORGANIZATION EXTERNAL (
   TYPE ORACLE_LOADER
   DEFAULT DIRECTORY LCG_RECV_DIR
   ACCESS PARAMETERS (
       RECORDS FIXED 420
       STRING SIZES ARE IN BYTES
       BADFILE LCG_LOG_DIR :'&BAD_FILE'
       DISCARDFILE LCG_LOG_DIR :'&DISCARD_FILE'
       LOGFILE LCG_LOG_DIR :'&LOG_FILE'
       FIELDS NOTRIM (
        CREATE_TIMESTAMP               POSITION(0001:0016) CHAR,
        UPDATE_TIMESTAMP               POSITION(0017:0032) CHAR,
        UPDATE_PROGRAM                 POSITION(0033:0040) CHAR,
        UPDATE_PC_ADDRESS              POSITION(0041:0055) CHAR,
        UPDATE_STAFF_CD                POSITION(0056:0063) CHAR,
        REC_SEQ_NO                     POSITION(0064:0078) CHAR,
        REC_DELETE_ID                  POSITION(0079:0079) CHAR,
        USER_CD                        POSITION(0080:0083) CHAR,
        OFFICE_CD                      POSITION(0084:0087) CHAR,
        ACCOUNT_NO                     POSITION(0088:0098) CHAR,
        SEC_DOM_FGN_ID                 POSITION(0099:0099) CHAR,
        SEC_ID                         POSITION(0100:0101) CHAR,
        SEC_CD                         POSITION(0102:0115) CHAR,
        SEC_PROPER_CD                  POSITION(0116:0120) CHAR,
        SEC_SPARE_CD                   POSITION(0121:0122) CHAR,
        SEC_SERIAL_CD                  POSITION(0123:0127) CHAR,
        SEC_SUPPORT_CD                 POSITION(0128:0129) CHAR,
        BRAND_CD                       POSITION(0130:0135) CHAR,
        DEPOSIT_CD                     POSITION(0136:0138) CHAR,
        PRINC_AGENT                    POSITION(0139:0139) CHAR,
        MANAGE_PLACE                   POSITION(0140:0141) CHAR,
        LOCATION_ID                    POSITION(0142:0143) CHAR,
        LOCATION_CD1                   POSITION(0144:0147) CHAR,
        LOCATION_CD2                   POSITION(0148:0154) CHAR,
        LOCATION_CD3                   POSITION(0155:0156) CHAR,
        DEPOSIT_NO_INIT                POSITION(0157:0166) CHAR,
        DEPOSIT_NO_LAST                POSITION(0167:0176) CHAR,
        QUANTITY                       POSITION(0177:0188) CHAR,
        BUY_COST_PRICE                 POSITION(0189:0202) CHAR,
        BUY_COST_PRICE_ID              POSITION(0203:0203) CHAR,
        SELL_COST_PRICE                POSITION(0204:0217) CHAR,
        BUY_TRADE_DATE                 POSITION(0218:0225) CHAR,
        CUST_DEP_DATE                  POSITION(0226:0233) CHAR,
        TAX_RECKON_DATE                POSITION(0234:0241) CHAR,
        DEP_EFFE_DATE                  POSITION(0242:0249) CHAR,
        SELL_TRADE_DATE                POSITION(0250:0257) CHAR,
        DEP_INEF_DATE                  POSITION(0258:0265) CHAR,
        DEP_ROUTE_INIT                 POSITION(0266:0266) CHAR,
        DEP_ROUTE_LAST                 POSITION(0267:0267) CHAR,
        DEP_DETAIL_ID                  POSITION(0268:0269) CHAR,
        WITHD_DETAIL_ID                POSITION(0270:0271) CHAR,
        BUY_MARKET                     POSITION(0272:0274) CHAR,
        BUY_TRADE                      POSITION(0275:0277) CHAR,
        WITHD_REASON                   POSITION(0278:0278) CHAR,
        SELL_MARKET                    POSITION(0279:0281) CHAR,
        INPUT_DATE                     POSITION(0282:0289) CHAR,
        OUTPUT_DATE                    POSITION(0290:0297) CHAR,
        JASDEC_DEP_DATE                POSITION(0298:0305) CHAR,
        JASDEC_COL_DATE                POSITION(0306:0313) CHAR,
        LOCATION_CHA_DATE              POSITION(0314:0321) CHAR,
        LOCATION_CHA_ID                POSITION(0322:0323) CHAR,
        SELL_FORBID_ID                 POSITION(0324:0325) CHAR,
        WITHD_FORBID_ID                POSITION(0326:0327) CHAR,
        NON_MARKET_ID                  POSITION(0328:0329) CHAR,
        UNCLAIMED_ID                   POSITION(0330:0330) CHAR,
        STK_QUANTITY_ID                POSITION(0331:0331) CHAR,
        SEC_CHANGE_ID                  POSITION(0332:0332) CHAR,
        SEC_UNION_ID                   POSITION(0333:0333) CHAR,
        COLLATERAL_ID                  POSITION(0334:0334) CHAR,
        SHAREHOLDER_ID                 POSITION(0335:0335) CHAR,
        UN_SPECIFY_ID                  POSITION(0336:0336) CHAR,
        WITHD_PRIORITY                 POSITION(0337:0339) CHAR,
        COL_ACCOUNT_NO                 POSITION(0340:0350) CHAR,
        NISA_ACQUISITION_YEAR          POSITION(0351:0354) CHAR
        )
   ) LOCATION ('&IN_FILE')
)
/

exit
