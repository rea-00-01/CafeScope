USE cafescope;


-- 1. Top 10 neighborhoods by cafe count
SELECT
    location,
    COUNT(*) AS cafe_count,
    ROUND(AVG(avg_din_rate), 2) AS average_rating,
    ROUND(AVG(dining_review_count), 2) AS average_dining_reviews,
    SUM(dining_review_count) AS total_dining_reviews,
    ROUND(AVG(cost_for_two), 2) AS average_cost_for_two
FROM cafe
WHERE location IS NOT NULL
GROUP BY location
ORDER BY cafe_count DESC, average_rating DESC
LIMIT 10;
--current ordering is by cafe count, with average rating as a tiebreaker. So this is a top ten by concentration, not a universal ranking of the ten best neighborhoods.




-- 2. Exploratory cafe benchmark candidates, not a definitive "best cafes" ranking
-- Require at least 60 dining reviews to reduce small-sample rating noise.
SELECT
    name,
    location,
    avg_din_rate AS dining_rating,
    dining_review_count,
    cost_for_two
FROM cafe
WHERE avg_din_rate >= 4.0
    AND dining_review_count >= 60
ORDER BY
    dining_review_count DESC,
    avg_din_rate DESC
LIMIT 15;





-- 3. Find repeated cafe names within the same location
SELECT
    name,
    location,
    COUNT(*) AS record_count
FROM cafe
GROUP BY name, location
HAVING COUNT(*) > 1
ORDER BY record_count DESC, name;
--This is an important data-quality check.
--has duplictes



-- 4. Inspect cafes without a price segment
SELECT
    name,
    location,
    cost_for_two,
    price_segment
FROM cafe
WHERE price_segment IS NULL
ORDER BY location, name;
--identified 25 cafes with NULL price segments.
--need to determine whether they lack cost_for_two or were not classified