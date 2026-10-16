CREATE DATABASE IF NOT EXISTS cafescope;
USE cafescope;

DROP TABLE IF EXISTS cafe;

CREATE TABLE cafe (
    cafe_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    url TEXT,
    location VARCHAR(100),

    dining_review_count INT,
    delivery_review_count INT,

    category VARCHAR(255),
    cuisine_offered TEXT,

    cost_for_two DECIMAL(10,2),
    avg_din_rate DECIMAL(3,2),
    avg_del_rate DECIMAL(3,2),

    is_vegeterian BOOLEAN,
    is_bar_available BOOLEAN,
    home_delivery BOOLEAN,
    offers_dining BOOLEAN,

    is_explicit_cafe BOOLEAN,
    has_cafe_type_cuisine BOOLEAN,
    has_cafe_name_signal BOOLEAN,
    is_cafescope_cafe BOOLEAN,

    price_segment VARCHAR(50),
    cuisine_count INT,
    log_dining_reviews DECIMAL(10,4),
    has_delivery_review_data BOOLEAN,

    din_rev TEXT,
    del_rev TEXT,

    popularity_segment VARCHAR(50),
    rating_segment VARCHAR(50),
    market_segment VARCHAR(100)
);