/*
=====================================================
Project : Banking Fraud Analytics
Author  : Akhilesh Desai
Database: PostgreSQL

Description:
Creates Gold Layer views used for business reporting
and Power BI dashboards. These views aggregate
transaction data into meaningful business KPIs and
fraud analysis metrics.
=====================================================
*/

-- =====================================================
-- Create Gold Schema
-- =====================================================

CREATE SCHEMA IF NOT EXISTS gold;

-- =====================================================
-- KPI Summary View
-- Purpose:
-- Provides executive-level KPIs including total
-- transactions, transaction amount, fraud count,
-- fraud rate, and average transaction value.
-- =====================================================

CREATE OR REPLACE VIEW gold.kpi_summary AS

SELECT

    COUNT(*) AS total_transactions,

    SUM(amount) AS total_transaction_amount,

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
        ) / COUNT(*),
        2
    ) AS fraud_rate,

    ROUND(AVG(amount),2) AS average_transaction_amount

FROM silver.fact_transactions;

-- Preview KPI Summary

SELECT *
FROM gold.kpi_summary;

-- =====================================================
-- Fraud Analysis by Transaction Type
-- Purpose:
-- Calculates transaction volume, fraud count,
-- fraud rate, and transaction amount for each
-- transaction type.
-- =====================================================

CREATE OR REPLACE VIEW gold.fraud_by_transaction_type AS

SELECT

    transaction_type,

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
        ) / COUNT(*),
        2
    ) AS fraud_rate,

    SUM(amount) AS total_amount

FROM silver.fact_transactions

GROUP BY transaction_type

ORDER BY fraud_rate DESC;

-- Preview Fraud by Transaction Type

SELECT *
FROM gold.fraud_by_transaction_type;

-- =====================================================
-- Daily Fraud Trend
-- Purpose:
-- Tracks daily transaction activity and fraud trends
-- for time-series analysis.
-- =====================================================

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

-- Preview Daily Fraud Trend

SELECT *
FROM gold.daily_fraud_trend;

-- =====================================================
-- Hourly Fraud Analysis
-- Purpose:
-- Analyzes fraud occurrence by transaction hour
-- to identify high-risk periods.
-- =====================================================

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
        ) / COUNT(*),
        2
    ) AS fraud_rate

FROM silver.fact_transactions

GROUP BY hour

ORDER BY hour;

-- Preview Hourly Fraud Analysis

SELECT *
FROM gold.hourly_fraud_analysis;

-- =====================================================
-- High Value Transactions
-- Purpose:
-- Identifies transactions exceeding 1,000,000
-- for risk assessment and manual investigation.
-- =====================================================

CREATE OR REPLACE VIEW gold.high_value_transactions AS

SELECT

    transaction_id,

    transaction_timestamp,

    transaction_type,

    amount,

    name_orig,

    name_dest,

    is_fraud

FROM silver.fact_transactions

WHERE amount > 1000000

ORDER BY amount DESC;

-- Preview High Value Transactions

SELECT *
FROM gold.high_value_transactions
LIMIT 10;