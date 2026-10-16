import pandas as pd

from src.config import FEATURED_DATA_PATH


def load_featured_data(path=FEATURED_DATA_PATH):
    """
    Load the feature-engineered CafeScope dataset.
    """

    path = path.resolve()

    if not path.exists():
        raise FileNotFoundError(
            f"Dataset not found: {path}"
        )

    df = pd.read_csv(path)

    print("Dataset loaded successfully.")
    print("Rows:", len(df))
    print("Columns:", len(df.columns))

    return df