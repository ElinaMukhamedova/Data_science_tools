#!/bin/zsh
sqlite3 flights.db <<EOF

.mode column
.headers on
SELECT * FROM flights LIMIT 17;
EOF


sqlite3 airlines.db <<EOF

.mode column
.headers on
SELECT * FROM airlines;
EOF


sqlite3 airports.db <<EOF

.mode column
.headers on
SELECT * FROM airports;
EOF