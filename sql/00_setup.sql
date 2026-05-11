-- Setup: Create and load the bank marketing table in PostgreSQL
-- Run this once before executing any analysis queries.

DROP TABLE IF EXISTS bank;

CREATE TABLE bank (
    age         INTEGER,
    job         VARCHAR(50),
    marital     VARCHAR(20),
    education   VARCHAR(20),
    "default"   VARCHAR(5),
    balance     INTEGER,
    housing     VARCHAR(5),
    loan        VARCHAR(5),
    contact     VARCHAR(20),
    day         INTEGER,
    month       VARCHAR(5),
    duration    INTEGER,
    campaign    INTEGER,
    pdays       INTEGER,
    previous    INTEGER,
    poutcome    VARCHAR(20),
    deposit     VARCHAR(5)
);

-- After creating the table, load data from the CSV:
-- In DBeaver: right-click the table > Import Data > select bank.csv
-- Or via psql:
--   \copy bank FROM 'path/to/bank.csv' CSV HEADER DELIMITER ',';

-- Verify the load
SELECT COUNT(*) AS total_rows FROM bank;
SELECT * FROM bank LIMIT 5;
