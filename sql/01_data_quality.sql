USE cafescope;


-- 1. Total number of records
SELECT COUNT(*) AS total_records
FROM cafe;


-- 2. Check whether the database contains any rows
SELECT *
FROM cafe
LIMIT 10;


-- 3. Check the column definitions
DESCRIBE cafe;


-- 4. Check for missing values in important fields
SELECT
    SUM(name IS NULL) AS missing_names,
    SUM(location IS NULL) AS missing_locations,
    SUM(cost_for_two IS NULL) AS missing_costs,
    SUM(avg_din_rate IS NULL) AS missing_dining_ratings,
    SUM(dining_review_count IS NULL) AS missing_dining_reviews
FROM cafe;


-- 5. Find exact duplicate records, excluding cafe_id
SELECT
    name,
    location,
    url,
    COUNT(*) AS record_count
FROM cafe
GROUP BY name, location, url
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


-- 6. Check the cafe inclusion flag
SELECT
    is_cafescope_cafe,
    COUNT(*) AS cafe_count
FROM cafe
GROUP BY is_cafescope_cafe;


-- 7. Inspect price and rating ranges
SELECT
    MIN(cost_for_two) AS minimum_cost,
    MAX(cost_for_two) AS maximum_cost,
    MIN(avg_din_rate) AS minimum_rating,
    MAX(avg_din_rate) AS maximum_rating
FROM cafe;