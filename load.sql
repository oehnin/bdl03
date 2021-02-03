-- --------------------------------------------------
-- 2019-03, Bruno Grossniklaus, https://github.com/it-gro

-- --------------------------------------------------
--
use openaq_org_api;

-- --------------------------------------------------
-- zeige input files
-- beeline
-- dfs -ls /user/bd01/load/ ;
-- hive
-- !hdfs dfs -ls /user/bd01/load/ ;


-- --------------------------------------------------
-- daten verschieben
LOAD DATA INPATH '/user/bd01/load/cities.json'              OVERWRITE INTO TABLE src_cities_json;
LOAD DATA INPATH '/user/bd01/load/latest.location.json'     OVERWRITE INTO TABLE src_latest_location_json;
LOAD DATA INPATH '/user/bd01/load/latest.measurements.json' OVERWRITE INTO TABLE src_latest_measurements_json;

-- hive:    local on client
-- beeline: "local" on server
-- LOAD DATA LOCAL INPATH '/home/bd01/load/cities.ch.json' OVERWRITE INTO TABLE src_cities_json;

-- --------------------------------------------------
-- input files nun weg
# !sh hdfs dfs -ls /user/bd01/load/
# ! hdfs dfs -ls /user/bd01/load/
# dfs -ls /user/bd01/load/


-- --------------------------------------------------
-- temporär materialisieren
--
-- CREATE TEMPORARY TABLE stg_tmp_latest_location AS
--   SELECT *
--   FROM src_latest_location
-- ;
--
-- CREATE TEMPORARY TABLE stg_tmp_latest_measurements AS
--   SELECT *
--   FROM src_latest_measurements
-- ;

-- --------------------------------------------------
-- materialisieren ohne tmp tabellen
DROP TABLE IF EXISTS stg_latest_location;
CREATE TABLE stg_latest_location AS
  SELECT *
  FROM src_latest_location
;

DROP TABLE IF EXISTS stg_latest_measurements;
CREATE TABLE stg_latest_measurements AS
  SELECT *
  FROM src_latest_measurements
;


-- --------------------------------------------------
--

DROP VIEW IF EXISTS stg_latest;
CREATE VIEW IF NOT EXISTS stg_latest AS
  SELECT
      CONCAT(l.location, '.', m.parameter) AS location_parameter
    , l.location
    , l.city
    , l.country
    , l.distance
    , l.latitude
    , l.longitude
    , m.parameter
    , m.value
    , m.lastUpdated
    , m.unit
    , m.sourceName
    , m.averagingPeriodValue
    , m.averagingPeriodUnit
    FROM stg_latest_location l
         JOIN stg_latest_measurements m ON (l.location = m.location)
;

INSERT INTO TABLE measurements
  SELECT
      location_parameter
    , location
    , city
    , country
    , distance
    , latitude
    , longitude
    , parameter
    , value
    , lastUpdated
    , unit
    , sourceName
    , averagingPeriodValue
    , averagingPeriodUnit
  FROM stg_latest l
  WHERE location_parameter NOT IN (SELECT hwm.location_parameter
                                     FROM hwm_location_parameter hwm
                                     WHERE l.location_parameter = hwm.location_parameter
                                  )
;



-- SELECT COUNT(*)
--   FROM stg_latest l
--   WHERE location_parameter NOT IN (SELECT  hwm.location_parameter
--                                      FROM hwm_location_parameter hwm
--                                      WHERE l.location_parameter = hwm.location_parameter
--                                   )
-- ;
--
-- SELECT COUNT(*)
--   FROM stg_latest l
--   LEFT OUTER JOIN hwm_location_parameter hwm ON (l.location_parameter = hwm.location_parameter)
--   WHERE hwm.location_parameter IS NULL
-- ;

-- INSERT INTO TABLE measurements
--   SELECT
--       l.location_parameter
--     , location
--     , city
--     , country
--     , distance
--     , latitude
--     , longitude
--     , parameter
--     , value
--     , l.lastUpdated
--     , unit
--     , sourceName
--     , averagingPeriodValue
--     , averagingPeriodUnit
--   FROM stg_latest l
--        JOIN hwm_location_parameter hwm  ON (l.location_parameter = hwm.location_parameter)
--   WHERE l.lastUpdated > hwm.lastUpdated
-- ;


-- DELETE
--   FROM hwm_location_parameter
--   WHERE location_parameter IN ( SELECT CONCAT(location, '.', parameter) AS location_parameter
--                                   FROM stg_latest_measurements
--                                   GROUP BY location, parameter
--                               )
-- ;


-- beeline
!set showheader false
!set outputformat tsv2

SELECT CURRENT_TIMESTAMP AS current_time, COUNT(*) AS cnt_hwm_location_parameter FROM hwm_location_parameter;

INSERT INTO TABLE hwm_location_parameter
  SELECT
       CONCAT(location, '.', parameter) AS location_parameter
     , MAX(lastUpdated)                 AS lastUpdated
  FROM stg_latest_measurements
  GROUP BY location, parameter
;

CREATE TEMPORARY TABLE tmp_hwm_location_parameter AS
  SELECT
       location_parameter
     , MAX(lastUpdated)                 AS lastUpdated
  FROM hwm_location_parameter
  GROUP BY location_parameter
;

INSERT OVERWRITE TABLE hwm_location_parameter
  SELECT *
  FROM tmp_hwm_location_parameter
;

SELECT CURRENT_TIMESTAMP AS current_time, COUNT(*) AS cnt_hwm_location_parameter FROM hwm_location_parameter;
