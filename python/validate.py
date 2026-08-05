import pandas as pd

def validate_data(df: pd.DataFrame):
    print("\n" + "=" * 60)
    print("DATA VALIDATION REPORT")
    print("=" * 60)

    # Shape
    print(f"\nRows    : {df.shape[0]:,}")
    print(f"Columns : {df.shape[1]}")

    # Missing Values
    print("\nMissing Values")
    print(df.isnull().sum())

    # Duplicate Rows
    duplicates = df.duplicated().sum()
    print(f"\nDuplicate Rows : {duplicates:,}")

    # Data Types
    print("\nData Types")
    print(df.dtypes)

    # Fraud Distribution
    print("\nFraud Distribution")
    print(df["isFraud"].value_counts())

    # Transaction Types
    print("\nTransaction Types")
    print(df["type"].value_counts())

    # Amount Statistics
    print("\nTransaction Amount Statistics")
    print(df["amount"].describe())

    print("\nValidation Completed Successfully.")

    return True