--  Star Schema

CREATE TABLE silver.dim_transaction_type (
    transaction_type_id SERIAL PRIMARY KEY,
    transaction_type VARCHAR(20) UNIQUE
);

INSERT INTO silver.dim_transaction_type (transaction_type)
SELECT DISTINCT transaction_type
FROM silver.fact_transactions
ORDER BY transaction_type;


SELECT *
FROM silver.dim_transaction_type;

CREATE TABLE silver.dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_name VARCHAR(20),
    week INT
);

INSERT INTO silver.dim_date
(full_date, year, quarter, month, month_name, day, day_name, week)

SELECT
d::DATE,
EXTRACT(YEAR FROM d),
EXTRACT(QUARTER FROM d),
EXTRACT(MONTH FROM d),
TO_CHAR(d,'Month'),
EXTRACT(DAY FROM d),
TO_CHAR(d,'Day'),
EXTRACT(WEEK FROM d)

FROM generate_series(
'2024-01-01'::DATE,
'2024-12-31'::DATE,
INTERVAL '1 day'
) d;

SELECT * FROM silver.dim_date LIMIT 5;


SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'silver'
AND table_name = 'fact_transactions'
ORDER BY ordinal_position;



SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'silver'
  AND table_name = 'fact_transactions'
ORDER BY ordinal_position;