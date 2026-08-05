CREATE SCHEMA bronze;

CREATE SCHEMA silver;

CREATE SCHEMA gold;

SELECT COUNT(*) FROM silver.fact_transactions;

SELECT DISTINCT transaction_type
FROM silver.fact_transactions
ORDER BY transaction_type;

SELECT
    transaction_type,
    COUNT(*)
FROM silver.fact_transactions
GROUP BY transaction_type
ORDER BY transaction_type;

-- For loading a whole data of whole dataset now we were using 1000 rows only 

TRUNCATE TABLE bronze.transactions_raw RESTART IDENTITY;

SELECT COUNT(*)
FROM bronze.transactions_raw;

TRUNCATE TABLE silver.fact_transactions RESTART IDENTITY;

SELECT COUNT(*)
FROM silver.fact_transactions;

SELECT COUNT(*)
FROM bronze.transactions_raw;

SELECT
MIN(transaction_timestamp),
MAX(transaction_timestamp)
FROM silver.fact_transactions;

SELECT
DATE(transaction_timestamp),
COUNT(*)
FROM silver.fact_transactions
GROUP BY DATE(transaction_timestamp)
ORDER BY DATE(transaction_timestamp)
LIMIT 20;