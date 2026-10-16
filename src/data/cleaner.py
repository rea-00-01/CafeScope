import pandas as pd


def clean_column_names(df):
    """
    Standardise column names.

    Example:
    'Average Rating' -> 'average_rating'
    """

    df = df.copy()

    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(r"\s+", "_", regex=True)
    )

    return df


def standardise_text_columns(df):
    """
    Remove unnecessary leading/trailing whitespace
    from text columns without changing missing values.
    """

    df = df.copy()

    text_columns = df.select_dtypes(
        include=["object", "string"]
    ).columns

    for column in text_columns:
        df[column] = df[column].map(
            lambda value: (
                value.strip()
                if isinstance(value, str)
                else value
            )
        )

    return df