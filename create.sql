-- --------------------------------------------------

CREATE DATABASE IF NOT EXISTS flightsDb;
use flightsDb;
show tables;

-- --------------------------------------------------
-- tabula rasa for src_* tables
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS airlines;

-- --------------------------------------------------
-- DDL src_* Tables
CREATE TABLE IF NOT EXISTS airports
  (
	  IATA_CODE	STRING
	  AIRPORT	STRING
	  CITY		STRING
	  STATE		STRING
	  COUNTRY	STRING
	  LATITUDE	STRING
	  LONGITUDE	STRING
  )
  COMMENT 'airport.csvfrom kaggle.com'
  ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    WITH SERDEPROPERTIES (
   "separatorChar" = ","
)
  STORED AS TEXTFILE
  -- location '/user/bd01/flights_2/airport.csv'
;

CREATE TABLE IF NOT EXISTS airlines
  (
      IATA_CODE STRING
	  AIRLINE	STRING
  )
  COMMENT 'airlines.csvfrom kaggle.com'
  ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    WITH SERDEPROPERTIES (
   "separatorChar" = ","
)
  STORED AS TEXTFILE
  -- location '/user/bd01/flights_2/airlines.csv'
;

CREATE TABLE IF NOT EXISTS flights
  (
		YEAR					STRING
		MONTH					STRING
		DAY						STRING
		DAY_OF_WEEK				STRING
		AIRLINE					STRING
		FLIGHT_NUMBER			STRING
		TAIL_NUMBER				STRING
		ORIGIN_AIRPORT			STRING
		DESTINATION_AIRPORT		STRING
		SCHEDULED_DEPARTURE		STRING
		DEPARTURE_TIME			STRING
		DEPARTURE_DELAY			STRING
		TAXI_OUT				STRING
		WHEELS_OFF				STRING
		SCHEDULED_TIME			STRING
		ELAPSED_TIME			STRING
		AIR_TIME				STRING
		DISTANCE				STRING
		WHEELS_ON				STRING
		TAXI_IN					STRING
		SCHEDULED_ARRIVAL		STRING
		ARRIVAL_TIME			STRING
		ARRIVAL_DELAY			STRING
		DIVERTED				STRING
		CANCELLED				STRING
		CANCELLATION_REASON		STRING
		AIR_SYSTEM_DELAY		STRING
		SECURITY_DELAY			STRING
		AIRLINE_DELAY			STRING
		LATE_AIRCRAFT_DELAY		STRING
		WEATHER_DELAY			STRING
  )
  COMMENT 'flights.csvfrom kaggle.com'
  ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
  WITH SERDEPROPERTIES (
   "separatorChar" = ","
) 
  STORED AS TEXTFILE
  -- location '/user/bd01/flights_2/flights.csv'
;

-- --------------------------------------------------
-- show infos
show tables;

DESCRIBE flights       			;  
DESCRIBE airlines               ;  
DESCRIBE airports               ;  
