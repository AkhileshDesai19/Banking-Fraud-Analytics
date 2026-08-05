-- Bronze Schema
CREATE TABLE IF NOT EXISTS bronze.transactions_raw (
    step INTEGER,
    type VARCHAR(50),
    amount NUMERIC(18,2),
    nameOrig VARCHAR(30),
    oldbalanceOrg NUMERIC(18,2),
    newbalanceOrig NUMERIC(18,2),
    nameDest VARCHAR(30),
    oldbalanceDest NUMERIC(18,2),
    newbalanceDest NUMERIC(18,2),
    isFraud INTEGER,
    isFlaggedFraud INTEGER
); 

TRUNCATE TABLE bronze.transactions_raw;

SELECT * FROM bronze.transactions_raw LIMIT 5;

SELECT column_name
FROM information_schema.columns
WHERE table_schema='bronze'
AND table_name='transactions_raw';

DROP TABLE bronze.transactions_raw;

CREATE TABLE bronze.transactions_raw (
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