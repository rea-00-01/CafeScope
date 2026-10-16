import pandas as pd
from sqlalchemy import text

from src.database.connection import get_engine


def fetch_query(sql_query, params=None):
    """
    Execute a SELECT query and return the result as a DataFrame.
    """

    engine = get_engine()

    try:
        with engine.connect() as connection:
            result = pd.read_sql_query(
                text(sql_query),
                connection,
                params=params or {},
            )

        return result

    finally:
        engine.dispose()


def get_cafe_count():
    """
    Return the number of records in the cafe table.
    """

    result = fetch_query(
        "SELECT COUNT(*) AS total_cafes FROM cafe"
    )

    return int(result.loc[0, "total_cafes"])