-- Silver Schema

CREATE SCHEMA IF NOT EXISTS silver;

CREATE TABLE silver.fact_transactions (

    transaction_id BIGSERIAL PRIMARY KEY,

    step INTEGER,

    transaction_type VARCHAR(20),

    amount NUMERIC(18,2),

    name_orig VARCHAR(30),

    old_balance_orig NUMERIC(18,2),

    new_balance_orig NUMERIC(18,2),

    name_dest VARCHAR(30),

    old_balance_dest NUMERIC(18,2),

    new_balance_dest NUMERIC(18,2),

    is_fraud BOOLEAN,

    is_flagged_fraud BOOLEAN,

    transaction_timestamp TIMESTAMP
);

SELECT COUNT(*) FROM bronze.transactions_raw;


TRUNCATE TABLE silver.fact_transactions RESTART IDENTITY;

SELECT COUNT(*)
FROM silver.fact_transactions;

ALTER TABLE silver.fact_transactions
ADD COLUMN transaction_date DATE;