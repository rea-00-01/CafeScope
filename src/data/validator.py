import pandas as pd


REQUIRED_COLUMNS = [
    "name",
    "location",
    "cost_for_two",
    "avg_din_rate",
    "dining_review_count",
    "is_cafescope_cafe",
]


def validate_cafe_data(df):
    """
    Validate the minimum requirements for the CafeScope dataset.
    """

    errors = []

    # 1. Required columns
    missing_columns = [
        column
        for column in REQUIRED_COLUMNS
        if column not in df.columns
    ]

    if missing_columns:
        errors.append(
            f"Missing required columns: {missing_columns}"
        )

    if errors:
        raise ValueError("\n".join(errors))

    # 2. Cafe names should not be missing
    if df["name"].isna().any():
        errors.append("Missing cafe names detected.")

    # 3. Cost should not be negative
    if (df["cost_for_two"].dropna() < 0).any():
        errors.append("Negative cost_for_two values detected.")

    # 4. Dining ratings should be within the expected range
    invalid_ratings = (
        df["avg_din_rate"].notna()
        & ~df["avg_din_rate"].between(0, 5)
    )

    if invalid_ratings.any():
        errors.append("Invalid dining ratings detected.")

    # 5. Review counts should not be negative
    for column in [
        "dining_review_count",
        "delivery_review_count",
    ]:
        if column in df.columns:
            if (df[column].dropna() < 0).any():
                errors.append(
                    f"Negative values found in {column}."
                )

    if errors:
        raise ValueError("\n".join(errors))

    print("Data validation passed.")

    return True