#!/bin/zsh
sqlite3 flights.db <<EOF

DROP TABLE IF EXISTS fraction_delayed_flights;

CREATE TABLE fraction_delayed_flights AS
    SELECT
        origin_airport,
        STRFTIME('%m', scheduled_departure) AS month,
        AVG(CASE WHEN departure_delay > 15 THEN 1 ELSE 0 END) AS perc_delayed
    FROM flights
        WHERE departure_delay IS NOT NULL
    GROUP BY 1,2;
EOF