#!/bin/zsh
sqlite3 flights.db <<EOF

WITH popular_routes AS (
SELECT
    origin_airport,
    destination_airport,
    COUNT(*) AS nb_flights
FROM flights
GROUP BY 1,2
),

ranked_routes AS (
SELECT
    origin_airport,
    destination_airport,
    ROW_NUMBER() OVER(PARTITION BY origin_airport ORDER BY nb_flights DESC) AS rank
FROM popular_routes
)

SELECT
    origin_airport,
    destination_airport,
    rank
FROM ranked_routes
WHERE rank <= 3
ORDER BY 1,3;
EOF