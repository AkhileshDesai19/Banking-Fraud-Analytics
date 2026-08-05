from extract import extract_from_s3
from validate import validate_data
from load import load_to_bronze


def main():

    df = extract_from_s3()

    validate_data(df)

    load_to_bronze(df)


if __name__ == "__main__":
    main()