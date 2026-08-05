/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Utility queries used to validate the ETL pipeline,
verify data loading, inspect transaction data, and
perform maintenance operations during development.
=====================================================
*/

-- =====================================================
-- Verify Available Schemas
-- =====================================================

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('bronze', 'silver', 'gold');

-- =====================================================
-- Verify Total Records in Silver Layer
-- =====================================================

SELECT COUNT(*) AS total_transactions
FROM silver.fact_transactions;

-- =====================================================
-- Verify Available Transaction Types
-- =====================================================

SELECT DISTINCT transaction_type
FROM silver.fact_transactions
ORDER BY transaction_type;

-- =====================================================
-- Transaction Type Distribution
-- =====================================================

SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM silver.fact_transactions
GROUP BY transaction_type
ORDER BY transaction_type;

-- =====================================================
-- Bronze Layer Record Count
-- =====================================================

SELECT COUNT(*) AS bronze_records
FROM bronze.transactions_raw;

-- =====================================================
-- Silver Layer Record Count
-- =====================================================

SELECT COUNT(*) AS silver_records
FROM silver.fact_transactions;

-- =====================================================
-- Validate Transaction Timestamp Range
-- =====================================================

SELECT
    MIN(transaction_timestamp) AS first_transaction,
    MAX(transaction_timestamp) AS last_transaction
FROM silver.fact_transactions;

-- =====================================================
-- Daily Transaction Volume
-- =====================================================

SELECT
    DATE(transaction_timestamp) AS transaction_date,
    COUNT(*) AS total_transactions
FROM silver.fact_transactions
GROUP BY DATE(transaction_timestamp)
ORDER BY transaction_date
LIMIT 20;

-- =====================================================
-- OPTIONAL MAINTENANCE QUERIES
-- Uncomment only when reloading the dataset.
-- =====================================================

-- Reset Bronze Layer
-- TRUNCATE TABLE bronze.transactions_raw RESTART IDENTITY;

-- Reset Silver Layer
-- TRUNCATE TABLE silver.fact_transactions RESTART IDENTITY;