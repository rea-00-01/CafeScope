# CafeScope

CafeScope is an MVP analytics project for exploring the cafe market in Jaipur. It combines Python-based data cleaning and feature engineering with a MySQL database and SQL analysis to compare cafe locations, prices, ratings, review volumes, and market segments.

The current database analysis covers 552 cafe records. The results describe the dataset, not the entire Jaipur market; missing ratings, prices, and review counts, as well as source-data coverage, limit how broadly findings should be interpreted.

## Project workflow

```text
Raw data -> cleaning -> EDA -> feature engineering -> MySQL -> SQL analysis -> business insights
```

- `data/raw/`: source datasets
- `data/interim/`: cleaned and exploratory snapshots
- `data/processed/cafe_feature_eng.csv`: engineered dataset intended for database loading
- `notebooks/`: audit, cleaning, EDA, and feature-engineering work
- `src/`: reusable Python modules for data, database, analytics, NLP, and geospatial work
- `database/`: MySQL schema and supporting SQL
- `sql/`: data-quality, market, cafe-performance, historical, geospatial, and advanced analysis queries
- `docs/`: methodology, project notes, limitations, and insight/report drafts

## Setup

Use Python 3 and MySQL. From the project root:

```bash
python3 -m venv cafe_env
source cafe_env/bin/activate
pip install -r requirements.txt
```

Create a `.env` file in the project root with your local MySQL connection settings. Do not commit this file or put credentials in source code.

```dotenv
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_local_password
DB_NAME=cafescope
```

Test the configured database connection from the project root:

```bash
PYTHONPATH=. python test_connection.py
```

## Initialize and load MySQL

For a fresh database/table, run the schema from the project root:

```bash
mysql -u root -p < database/schema.sql
```

**Warning:** `database/schema.sql` includes `DROP TABLE IF EXISTS cafe`; running it again deletes and recreates the existing `cafe` table. Back up anything you need first.

After creating the table, load the engineered CSV once:

```bash
PYTHONPATH=. python - <<'PY'
import pandas as pd
from src.database.loader import load_dataframe_to_mysql

data = pd.read_csv("data/processed/cafe_feature_eng.csv")
load_dataframe_to_mysql(data, table_name="cafe", if_exists="append")
PY
```

The loader appends records. Do not rerun it against a populated table unless you intend to add duplicate rows; recreate or clear the table deliberately before reloading.

## Run the SQL analysis

From the project root, open the MySQL client:

```bash
mysql -u root -p
```

Then run the analysis files in the MySQL prompt:

```sql
USE cafescope;
SOURCE sql/01_data_quality.sql;
SOURCE sql/02_basic_analysis.sql;
SOURCE sql/03_market_analysis.sql;
SOURCE sql/04_cafe_performance.sql;
SOURCE sql/041_final_tables.sql;
```

The remaining geospatial, historical, and advanced SQL files are available for follow-up analysis. Run them only when their required data and assumptions are available.

## Data and interpretation notes

- Check the source-data terms and permissions before sharing datasets in a public repository.
- Ratings and review counts are platform observations, not direct measures of revenue or customer satisfaction for every visitor.
- Review counts indicate accumulated activity, not review velocity; the dataset does not establish how quickly reviews were collected.
- Use minimum review thresholds when comparing ratings, and treat small-sample results as exploratory.
- Location aggregates with few cafes can be unstable; compare cafe counts and sample sizes alongside averages.
- Consult `docs/limitations.md` and `docs/methodology.md` before presenting conclusions.

## Before publishing

Confirm that the source-data terms permit redistribution of any datasets included in this repository.
