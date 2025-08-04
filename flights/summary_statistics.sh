#!/bin/zsh
sqlite3 flights.db <<EOF

.mode column
.headers on

SELECT
    COUNT(DISTINCT tail_number) AS nb_distinct_aircrafts,
    COUNT(flight_number) AS nb_flights,
    AVG(departure_delay) AS avg_departure_delay,
    MAX(departure_delay) AS max_departure_delay,
    MIN(departure_delay) AS min_departure_delay
FROM flights;
EOF