from sqlalchemy import URL, create_engine, text

from src.config import (
    DB_HOST,
    DB_PORT,
    DB_USER,
    DB_PASSWORD,
    DB_NAME,
)

def get_engine(database=DB_NAME):
    """
    Create a SQLAlchemy engine for the configured MySQL database.
    """
    if not DB_PASSWORD:
        raise ValueError(
            "DB_PASSWORD is missing. Set it in the project-root .env file."
        )
    connection_url = URL.create(
        drivername="mysql+pymysql",
        username=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=database,
    )
    return create_engine(
        connection_url,
        pool_pre_ping=True,
    )


def test_connection():
    """
    Test whether Python can connect to MySQL.
    """
    engine = get_engine()
    with engine.connect() as connection:
        result = connection.execute(
            text("SELECT DATABASE(), VERSION()")
        ).fetchone()
        
    print("Connected successfully!")
    print("Database:", result[0])
    print("MySQL version:", result[1])

    return True