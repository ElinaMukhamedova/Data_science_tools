#!/bin/zsh
sqlite3 flights.db <<EOF

DROP TABLE IF EXISTS flights_raw;
DROP TABLE IF EXISTS flights;


.mode csv
.import flights.csv flights_raw


CREATE TABLE flights (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        origin_airport TEXT,
        destination_airport TEXT,
        airline AIRLINE,
        flight_number INTEGER,
        tail_number TEXT,
        scheduled_departure TEXT,
        departure_delay REAL
    );

INSERT INTO flights (origin_airport, destination_airport, airline, flight_number, tail_number, scheduled_departure, departure_delay)
    SELECT
        ORIGIN_AIRPORT,
        DESTINATION_AIRPORT,
        AIRLINE,
        CAST(FLIGHT_NUMBER AS INTEGER),
        TAIL_NUMBER,
        printf('%4d-%02d-%02d %02d-%02d-00', CAST(YEAR AS INTEGER), CAST(MONTH AS INTEGER), CAST(DAY AS INTEGER), CAST(SCHEDULED_DEPARTURE AS INTEGER) / 100, CAST(SCHEDULED_DEPARTURE AS INTEGER) % 100),
        CAST(DEPARTURE_DELAY AS REAL)
    FROM flights_raw;


DROP TABLE IF EXISTS airlines;

.mode csv
.import airlines.csv airlines


DROP TABLE IF EXISTS airports;

.mode csv
.import airports.csv airports_raw


CREATE TABLE airports (
        iata_code TEXT,
        airport TEXT
    );

INSERT INTO airports
    SELECT
        IATA_CODE,
        AIRPORT
    FROM airports_raw
EOF