/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Creates the Silver Layer fact table used to store
cleaned and standardized banking transaction data.
The Silver layer contains validated and transformed
records ready for business analysis.
=====================================================
*/

-- =====================================================
-- Create Silver Schema (if it does not already exist)
-- =====================================================

CREATE SCHEMA IF NOT EXISTS silver;

-- =====================================================
-- Create Fact Transactions Table
-- Stores cleaned transaction records after ETL
-- =====================================================

CREATE TABLE IF NOT EXISTS silver.fact_transactions (

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

    transaction_timestamp TIMESTAMP,

    transaction_date DATE
);

-- =====================================================
-- Verify Table Structure
-- =====================================================

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'silver'
  AND table_name = 'fact_transactions';

-- =====================================================
-- Preview Sample Records
-- =====================================================

SELECT *
FROM silver.fact_transactions
LIMIT 5;