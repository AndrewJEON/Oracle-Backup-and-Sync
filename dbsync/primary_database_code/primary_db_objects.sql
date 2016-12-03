--
-- dbsync logging in primary
--
-- $Id: //Infrastructure/GitHub/Database/backup_and_sync/dbsync/primary_database_code/primary_db_objects.sql#3 $
--

CREATE SEQUENCE DBAMGR.DBSYNC_STANDBY_HIST_SEQ
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
/

CREATE SEQUENCE DBAMGR.DBSYNC_STANDBY_SEQ
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
/

CREATE TABLE DBAMGR.DBSYNC_STANDBY
(
  STANDBY_ID                   INTEGER,
  STANDBY_SERVER               VARCHAR2(100 BYTE),
  STANDBY_SID                  VARCHAR2(30 BYTE),
  LAST_FULL_REFRESH_START      DATE,
  LAST_FULL_REFRESH_END        DATE,
  LAST_FULL_REFRESH_STATUS     VARCHAR2(30 BYTE),
  LAST_FULL_REFRESH_LOG        CLOB,
  LAST_ROLLFORWARD_START       DATE,
  LAST_ROLLFORWARD_END         DATE,
  LAST_ROLLFORWARD_STATUS      VARCHAR2(30 BYTE),
  LAST_ROLLFORWARD_LOG         CLOB,
  STANDBY_APPLIED_REDOLOG_SEQ  INTEGER,
  STANDBY_APPLIED_UNTIL_SCN    NUMBER,
  STANDBY_APPLIED_UNTIL_DATE   DATE,
  PRIMARY_CURRENT_REDOLOG_SEQ  INTEGER
)
LOB (LAST_FULL_REFRESH_LOG) STORE AS (
  TABLESPACE  TBSDATA
  CACHE
)
LOB (LAST_ROLLFORWARD_LOG) STORE AS (
  TABLESPACE  TBSDATA
  CACHE
)
TABLESPACE TBSDATA
/

CREATE TABLE DBAMGR.DBSYNC_STANDBY_HIST
(
  HIST_ID                      INTEGER,
  STANDBY_ID                   INTEGER,
  ACTION                       VARCHAR2(30 BYTE),
  LOGFILE                      CLOB,
  LOGFILE_NAME                 VARCHAR2(300 BYTE),
  STATUS                       VARCHAR2(30 BYTE),
  STANDBY_APPLIED_REDOLOG_SEQ  INTEGER,
  STANDBY_APPLIED_UNTIL_SCN    NUMBER,
  STANDBY_APPLIED_UNTIL_DATE   DATE,
  PRIMARY_CURRENT_REDOLOG_SEQ  INTEGER,
  PRIMARY_CURRENT_SCN          INTEGER,
  PRIMARY_CURRENT_DATE         DATE,
  APPLY_START                  DATE,
  APPLY_END                    DATE
)
LOB (LOGFILE) STORE AS (
  TABLESPACE  TBSDATA
  ENABLE      STORAGE IN ROW
  CHUNK       8192
  RETENTION
  CACHE
)
TABLESPACE TBSDATA
/
