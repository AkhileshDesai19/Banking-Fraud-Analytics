from logger import logger
from sqlalchemy import create_engine
from config import config


def load_to_silver(df):

    host = config["POSTGRES"]["host"]
    port = config["POSTGRES"]["port"]
    database = config["POSTGRES"]["database"]
    user = config["POSTGRES"]["user"]
    password = config["POSTGRES"]["password"]

    engine = create_engine(
        f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
    )

    sample_size = int(config["ETL"]["sample_size"])

    if sample_size == -1:
        df_to_load = df
        print("Loading full dataset...")
    else:
        df_to_load = df.head(sample_size)
        logger.info("Loading rows into Silver Layer...")
        # print(f"Loading {sample_size:,} rows...")

    print(f"Rows being inserted: {len(df_to_load):,}")

    df_to_load.to_sql(
        name="fact_transactions",
        schema="silver",
        con=engine,
        if_exists="append",
        index=False
    )

    logger.info("Silver Load Completed")