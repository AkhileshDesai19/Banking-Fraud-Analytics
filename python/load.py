from sqlalchemy import create_engine
from config import config
import time
import traceback


def load_to_bronze(df):

    try:

        print("\nStarting Bronze Load...")

        start_time = time.time()

        host = config["POSTGRES"]["host"]
        port = config["POSTGRES"]["port"]
        database = config["POSTGRES"]["database"]
        user = config["POSTGRES"]["user"]
        password = config["POSTGRES"]["password"]
        table = config["POSTGRES"]["table"]
        schema = config["POSTGRES"]["schema"]

        engine = create_engine(
            f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
        )

        df = df.rename(columns={
            "type": "transaction_type",
            "nameOrig": "name_orig",
            "oldbalanceOrg": "old_balance_orig",
            "newbalanceOrig": "new_balance_orig",
            "nameDest": "name_dest",
            "oldbalanceDest": "old_balance_dest",
            "newbalanceDest": "new_balance_dest",
            "isFraud": "is_fraud",
            "isFlaggedFraud": "is_flagged_fraud"
        })

        df.to_sql(
            name=table,
            schema=schema,
            con=engine,
            if_exists="append",
            index=False
        )

        end_time = time.time()

        print("✅ Bronze Load Completed")
        print(f"Rows Loaded : {len(df):,}")
        print(f"Time Taken  : {round(end_time-start_time,2)} seconds")

    except Exception:
        traceback.print_exc()