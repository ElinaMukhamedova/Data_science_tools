#!/bin/zsh
sqlite3 flights.db <<EOF

SELECT
    origin_airport,
    COUNT(*) AS nb_flights
FROM flights
    WHERE scheduled_departure >= '2015-01-01'
        AND scheduled_departure < '2015-04-01'
GROUP BY 1
ORDER BY 2 DESC;

EOF