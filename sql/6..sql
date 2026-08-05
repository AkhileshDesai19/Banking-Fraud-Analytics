SELECT *
FROM silver.fact_transactions
LIMIT 5;


SELECT *
FROM silver.dim_date
LIMIT 5;

TRUNCATE TABLE silver.fact_transactions RESTART IDENTITY;

SELECT
transaction_timestamp,
transaction_date
FROM silver.fact_transactions
LIMIT 5;