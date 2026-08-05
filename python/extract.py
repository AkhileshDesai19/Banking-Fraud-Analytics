import boto3
import pandas as pd
from io import BytesIO
from config import config


def extract_from_s3():
    """
    Extract raw dataset from AWS S3.
    """

    bucket = config["AWS"]["bucket_name"]
    key = config["AWS"]["file_key"]

    s3 = boto3.client("s3")

    print("Connecting to AWS S3...")

    response = s3.get_object(Bucket=bucket, Key=key)

    df = pd.read_csv(BytesIO(response["Body"].read()))

    print("Data extracted successfully!")
    print(f"Rows    : {df.shape[0]}")
    print(f"Columns : {df.shape[1]}")

    return df