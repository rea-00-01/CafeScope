import os
from pathlib import Path

from dotenv import load_dotenv


# Project root directory
PROJECT_ROOT = Path(__file__).resolve().parents[1]

# Data directories
DATA_DIR = PROJECT_ROOT / "data"
RAW_DATA_DIR = DATA_DIR / "raw"
INTERIM_DATA_DIR = DATA_DIR / "interim"
PROCESSED_DATA_DIR = DATA_DIR / "processed"

# Main MVP dataset
FEATURED_DATA_PATH = PROCESSED_DATA_DIR / "cafe_feature_eng.csv"


# Load environment variables from the project root
load_dotenv(PROJECT_ROOT / ".env")


# MySQL configuration
DB_HOST = os.getenv("DB_HOST", "127.0.0.1")
DB_PORT = int(os.getenv("DB_PORT", "3306"))
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME", "cafescope")