from load_silver import load_to_silver
import pandas as pd
from sqlalchemy import create_engine
from config import config

host = config["POSTGRES"]["host"]
port = config["POSTGRES"]["port"]
database = config["POSTGRES"]["database"]
user = config["POSTGRES"]["user"]
password = config["POSTGRES"]["password"]

engine = create_engine(
    f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
)

df = pd.read_sql(
    "SELECT * FROM bronze.transactions_raw",
    engine
)

# ==========================================
# SILVER TRANSFORMATIONS
# ==========================================

# Convert integer flags to Boolean
df["is_fraud"] = df["is_fraud"].astype(bool)
df["is_flagged_fraud"] = df["is_flagged_fraud"].astype(bool)

# Create a realistic timestamp from step
base_date = pd.Timestamp("2024-01-01")

df["transaction_timestamp"] = (
    base_date +
    pd.to_timedelta(df["step"], unit="h")
)
df["transaction_date"] = df["transaction_timestamp"].dt.date


print(df.shape)

load_to_silver(df)



