-- --------------------------------------------------
use flights;

-- --------------------------------------------------
-- daten verschieben
LOAD DATA INPATH '/user/bd01/flights_2/airlines.csv'   	OVERWRITE INTO TABLE airlines;
LOAD DATA INPATH '/user/bd01/flights_2/airports.csv'   	OVERWRITE INTO TABLE airports;
LOAD DATA INPATH '/user/bd01/flights_2/flights.csv'    	OVERWRITE INTO TABLE flights;


