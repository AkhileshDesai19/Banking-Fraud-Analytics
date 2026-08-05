/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Validation queries used to verify data loading,
table structure, and transformed records in the
Silver Layer after the ETL process.
=====================================================
*/

-- =====================================================
-- Preview Sample Transactions
-- =====================================================

SELECT *
FROM silver.fact_transactions
LIMIT 5;

-- =====================================================
-- Preview Date Dimension
-- =====================================================

SELECT *
FROM silver.dim_date
LIMIT 5;

-- =====================================================
-- Validate Transaction Timestamp Mapping
-- Ensures transaction_timestamp and transaction_date
-- are populated correctly after transformation.
-- =====================================================

SELECT
    transaction_timestamp,
    transaction_date
FROM silver.fact_transactions
LIMIT 5;

-- =====================================================
-- Validate Total Records Loaded
-- =====================================================

SELECT COUNT(*) AS total_transactions
FROM silver.fact_transactions;

-- =====================================================
-- Validate Fraud Distribution
-- =====================================================

SELECT
    is_fraud,
    COUNT(*) AS transaction_count
FROM silver.fact_transactions
GROUP BY is_fraud;

-- =====================================================
-- Validate Transaction Type Distribution
-- =====================================================

SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM silver.fact_transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;