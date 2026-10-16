import pandas as pd
from sqlalchemy import inspect

from src.database.connection import get_engine


def load_dataframe_to_mysql(
    df,
    table_name="cafe",
    if_exists="append",
):
    """
    Load a DataFrame into an existing MySQL table.

    The database schema must be created first.
    """

    if df.empty:
        raise ValueError("The DataFrame is empty.")

    engine = get_engine()

    try:
        inspector = inspect(engine)

        if not inspector.has_table(
            table_name,
            schema="cafescope",
        ):
            raise ValueError(
                f"Table '{table_name}' does not exist. "
                "Run database/schema.sql first."
            )

        # Check that the DataFrame matches the table.
        table_columns = {
            column["name"]
            for column in inspector.get_columns(
                table_name,
                schema="cafescope",
            )
        }

        dataframe_columns = set(df.columns)

        missing_columns = (
            table_columns
            - dataframe_columns
            - {"cafe_id"}
        )

        extra_columns = (
            dataframe_columns
            - table_columns
        )

        if missing_columns or extra_columns:
            raise ValueError(
                f"Column mismatch.\n"
                f"Missing from DataFrame: {sorted(missing_columns)}\n"
                f"Unexpected in DataFrame: {sorted(extra_columns)}"
            )

        # Append the data to the existing table.
        df.to_sql(
            name=table_name,
            con=engine,
            if_exists=if_exists,
            index=False,
            chunksize=100,
            method="multi",
        )

        print(
            f"Successfully loaded {len(df)} rows "
            f"into {table_name}."
        )

    finally:
        engine.dispose()