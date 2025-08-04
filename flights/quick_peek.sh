#!/bin/zsh
sqlite3 flights.db <<EOF

.mode column
.headers on

SELECT * FROM flights LIMIT 17;

SELECT * FROM airlines;

SELECT * FROM airports LIMIT 17;
EOF