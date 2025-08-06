#!/bin/zsh
sqlite3 flights.db <<EOF

WITH raw_count_delay AS (
    SELECT
        airline,
        CASE WHEN departure_delay > 60 * 2 THEN 'big_delay'
             WHEN departure_delay > 60 THEN 'medium_delay'
             WHEN departure_delay > 15 THEN 'small_delay'
             ELSE 'no_delay' END AS delay_category,
        COUNT(*) AS nb_flights
    FROM flights
    WHERE departure_delay IS NOT NULL
    GROUP BY 1,2
)

SELECT
    airline,
    delay_category,
    (1.0 * nb_flights) / (1.0 * SUM(nb_flights) OVER(PARTITION BY airline)) AS perc_category
FROM raw_count_delay;
EOF