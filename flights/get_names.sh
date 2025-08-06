#!/bin/zsh
sqlite3 flights.db <<EOF

DROP TABLE IF EXISTS flights_full_names;

CREATE TABLE flights_full_names AS
    SELECT
        f.origin_airport AS origin_airport,
        apt.airport AS origin_airport_name,
        f.airline AS airline,
        air.airline AS airline_name,
        f.flight_number AS flight_number,
        f.scheduled_departure AS scheduled_departure
    FROM flights f
    LEFT JOIN airports apt
        ON (f.origin_airport = apt.iata_code)
    LEFT JOIN airlines air
        ON (f.airline = air.iata_code);
EOF