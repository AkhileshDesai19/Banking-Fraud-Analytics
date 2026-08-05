-- Create Gold Schema


CREATE SCHEMA IF NOT EXISTS gold;

-- First Gold View
CREATE OR REPLACE VIEW gold.kpi_summary AS

SELECT

COUNT(*) AS total_transactions,

SUM(amount) AS total_transaction_amount,

SUM(
    CASE
        WHEN is_fraud = TRUE
        THEN 1
        ELSE 0
    END
) AS fraud_transactions,

ROUND(
    100.0 *
    SUM(
        CASE
            WHEN is_fraud = TRUE THEN 1
            ELSE 0
        END
    ) / COUNT(*),
2
) AS fraud_rate,

AVG(amount) AS average_transaction_amount

FROM silver.fact_transactions;


SELECT *
FROM gold.kpi_summary;

-- Second Gold View

CREATE OR REPLACE VIEW gold.fraud_by_transaction_type AS

SELECT

transaction_type,

COUNT(*) AS total_transactions,

SUM(
    CASE
        WHEN is_fraud = TRUE
        THEN 1
        ELSE 0
    END
) AS fraud_transactions,

ROUND(
    100.0 *
    SUM(
        CASE
            WHEN is_fraud = TRUE THEN 1
            ELSE 0
        END
    ) / COUNT(*),
2
) AS fraud_rate,

SUM(amount) AS total_amount

FROM silver.fact_transactions

GROUP BY transaction_type

ORDER BY fraud_rate DESC;


SELECT *
FROM gold.fraud_by_transaction_type;

-- Daily Fraud Trend

CREATE OR REPLACE VIEW gold.daily_fraud_trend AS

SELECT

DATE(transaction_timestamp) AS transaction_date,

COUNT(*) AS total_transactions,

SUM(
CASE
WHEN is_fraud = TRUE THEN 1
ELSE 0
END
) AS fraud_transactions,

SUM(amount) AS total_amount,

SUM(
CASE
WHEN is_fraud = TRUE THEN amount
ELSE 0
END
) AS fraud_amount

FROM silver.fact_transactions

GROUP BY DATE(transaction_timestamp)

ORDER BY transaction_date;

SELECT * FROM gold.daily_fraud_trend;


-- Hourly Fraud Analysis

CREATE OR REPLACE VIEW gold.hourly_fraud_analysis AS

SELECT

EXTRACT(HOUR FROM transaction_timestamp) AS hour,

COUNT(*) AS total_transactions,

SUM(
CASE
WHEN is_fraud = TRUE THEN 1
ELSE 0
END
) AS fraud_transactions,

ROUND(
100.0 *
SUM(
CASE
WHEN is_fraud = TRUE THEN 1
ELSE 0
END
)
/ COUNT(*),
2
) AS fraud_rate

FROM silver.fact_transactions

GROUP BY hour

ORDER BY hour;


SELECT * FROM gold.hourly_fraud_analysis;


-- High Value Transactions

CREATE OR REPLACE VIEW gold.high_value_transactions AS

SELECT *

FROM silver.fact_transactions

WHERE amount > 1000000

ORDER BY amount DESC;

SELECT *
FROM gold.high_value_transactions
LIMIT 10;