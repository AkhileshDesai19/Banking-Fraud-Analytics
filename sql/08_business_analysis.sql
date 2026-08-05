-- business queries

-- 1. How many transactions occurred,
-- what is the total value, and what percentage were fraudulent?
-- Total Business Summary
SELECT
COUNT(*) AS total_transactions,
SUM(amount) AS total_amount,
AVG(amount) AS average_amount,
SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(
100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*),
2
) AS fraud_rate
FROM silver.fact_transactions;

-- 2. Which transaction type is most vulnerable to fraud?
-- Fraud by Transaction Type
SELECT
transaction_type,
COUNT(*) AS total_transactions,
SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(
100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*),
2
) AS fraud_rate
FROM silver.fact_transactions
GROUP BY transaction_type
ORDER BY fraud_rate DESC;


-- 3. Which fraudulent transactions caused the highest financial impact?
-- Highest Fraud Amount
SELECT
transaction_id,
transaction_type,
amount,
name_orig,
name_dest
FROM silver.fact_transactions
WHERE is_fraud = TRUE
ORDER BY amount DESC
LIMIT 10;

-- 4. Which transaction type processes the highest value?
-- Transaction Distribution
SELECT
transaction_type,
SUM(amount) AS total_amount,
AVG(amount) AS average_amount
FROM silver.fact_transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;


-- 5. During which hours is fraud most frequent?
-- Hourly Fraud Pattern
SELECT
EXTRACT(HOUR FROM transaction_timestamp) AS hour,
COUNT(*) AS transactions,
SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraud_transactions
FROM silver.fact_transactions
GROUP BY hour
ORDER BY hour;

TRUNCATE TABLE silver.fact_transactions RESTART IDENTITY;
