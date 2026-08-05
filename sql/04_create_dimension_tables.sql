/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Creates the dimension tables used in the Star Schema
for Power BI reporting. The dimensions improve query
performance and support efficient analytical reporting.
=====================================================
*/

-- =====================================================
-- Create Transaction Type Dimension
-- Stores unique transaction types
-- =====================================================

CREATE TABLE IF NOT EXISTS silver.dim_transaction_type (

    transaction_type_id SERIAL PRIMARY KEY,

    transaction_type VARCHAR(20) UNIQUE

);

-- Populate Transaction Type Dimension

INSERT INTO silver.dim_transaction_type (transaction_type)

SELECT DISTINCT transaction_type
FROM silver.fact_transactions
ORDER BY transaction_type;

-- Preview Transaction Type Dimension

SELECT *
FROM silver.dim_transaction_type;

-- =====================================================
-- Create Date Dimension
-- Stores calendar attributes for time-based analysis
-- =====================================================

CREATE TABLE IF NOT EXISTS silver.dim_date (

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

-- Populate Date Dimension

INSERT INTO silver.dim_date
(
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_name,
    week
)

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

-- Preview Date Dimension

SELECT *
FROM silver.dim_date
LIMIT 5;

-- =====================================================
-- Verify Fact Table Structure
-- =====================================================

SELECT

    column_name,

    data_type

FROM information_schema.columns

WHERE table_schema = 'silver'

AND table_name = 'fact_transactions'

ORDER BY ordinal_position;