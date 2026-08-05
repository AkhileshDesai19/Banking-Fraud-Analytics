import pandas as pd

def transform_data(df: pd.DataFrame):

    print("\nStarting data transformation...")

    # Create transaction_id
    df.insert(0, "transaction_id", range(1, len(df) + 1))

    # Rename columns
    df.rename(columns={
        "nameOrig": "name_orig",
        "oldbalanceOrg": "old_balance_orig",
        "newbalanceOrig": "new_balance_orig",
        "nameDest": "name_dest",
        "oldbalanceDest": "old_balance_dest",
        "newbalanceDest": "new_balance_dest"
    }, inplace=True)

    # Customer type
    df["customer_type"] = df["name_orig"].str[0].map({
        "C": "Customer",
        "M": "Merchant"
    })

    # Fraud flags
    df["isFraud"] = df["isFraud"].astype(bool)
    df["isFlaggedFraud"] = df["isFlaggedFraud"].astype(bool)

    print("Transformation completed.")

    return df