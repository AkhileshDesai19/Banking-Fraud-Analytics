/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Creates the Bronze Layer table used to store raw
banking transaction data. The Bronze layer contains
raw data exactly as received from the source without
any business transformations.
=====================================================
*/

-- =====================================================
-- Create Bronze Schema (if it does not already exist)
-- =====================================================

CREATE SCHEMA IF NOT EXISTS bronze;

-- =====================================================
-- Create Raw Transactions Table
-- Stores unprocessed banking transaction records
-- =====================================================

CREATE TABLE IF NOT EXISTS bronze.transactions_raw (

    step INTEGER,

    transaction_type VARCHAR(20),

    amount NUMERIC(18,2),

    name_orig VARCHAR(30),

    old_balance_orig NUMERIC(18,2),

    new_balance_orig NUMERIC(18,2),

    name_dest VARCHAR(30),

    old_balance_dest NUMERIC(18,2),

    new_balance_dest NUMERIC(18,2),

    is_fraud INTEGER,

    is_flagged_fraud INTEGER

);

-- =====================================================
-- Verify Table Structure
-- =====================================================

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'bronze'
  AND table_name = 'transactions_raw';

-- =====================================================
-- Preview Sample Records
-- =====================================================

SELECT *
FROM bronze.transactions_raw
LIMIT 5;