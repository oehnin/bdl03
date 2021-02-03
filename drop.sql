-- --------------------------------------------------
-- 2019-03, Bruno Grossniklaus, https://github.com/it-gro

use openaq_org_api;

-- --------------------------------------------------
-- drop all
DROP TABLE IF EXISTS openaq_org_api.stg_latest_location;
DROP TABLE IF EXISTS openaq_org_api.stg_latest_measurements;
DROP VIEW IF EXISTS openaq_org_api.stg_latest;

DROP VIEW IF EXISTS openaq_org_api.src_cities;
DROP VIEW IF EXISTS openaq_org_api.src_latest_location;
DROP VIEW IF EXISTS openaq_org_api.src_latest_measurements;
DROP VIEW IF EXISTS openaq_org_api.src_latest;

DROP TABLE IF EXISTS openaq_org_api.src_cities_json;
DROP TABLE IF EXISTS openaq_org_api.src_latest_location_json;
DROP TABLE IF EXISTS openaq_org_api.src_latest_measurements_json;

-- daten - und tschüss (=> drops nur für Test-Systeme geeignet)
DROP TABLE IF EXISTS openaq_org_api.measurements;
DROP TABLE IF EXISTS openaq_org_api.hwm_location_parameter;

show tables;

DROP DATABASE IF EXISTS openaq_org_api;
