#!/bin/zsh
sqlite3 flights.db <<EOF

DROP TABLE IF EXISTS change;

CREATE TABLE change AS

WITH agg_flights AS (
    SELECT
        origin_airport,
        STRFTIME('%m', scheduled_departure) AS month,
        COUNT(*) AS nb_flights
    FROM flights
    GROUP BY 1,2
),

change_flights AS (
    SELECT
        origin_airport,
        month,
        nb_flights,
        LAG(nb_flights, 1)
            OVER(PARTITION BY origin_airport
                 ORDER BY month ASC) AS nb_flights_before
    FROM agg_flights
)

SELECT
    origin_airport,
    month,
    nb_flights,
    nb_flights_before,
    ROUND((1.0 * (nb_flights - nb_flights_before)) / (1.0 * nb_flights_before), 2) AS perc_change
FROM change_flights;
EOF