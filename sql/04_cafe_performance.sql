USE cafescope;


-- 1. Cafes with the highest dining-review counts
SELECT
    name,
    location,
    avg_din_rate,
    dining_review_count,
    cost_for_two
FROM cafe
WHERE dining_review_count IS NOT NULL
ORDER BY dining_review_count DESC
LIMIT 20;


-- 2. Exploratory high-rating shortlist with a minimum review sample
-- Require at least 60 dining reviews; this is not a definitive ranking.
SELECT
    name,
    location,
    avg_din_rate,
    dining_review_count
FROM cafe
WHERE avg_din_rate IS NOT NULL
    AND dining_review_count >= 60
ORDER BY avg_din_rate DESC, dining_review_count DESC
LIMIT 20;


-- 3. Compare rating and popularity by price segment
SELECT
    price_segment,
    COUNT(*) AS cafe_count,
    ROUND(AVG(avg_din_rate), 2) AS average_rating,
    ROUND(AVG(dining_review_count), 2) AS average_dining_reviews
FROM cafe
WHERE price_segment IS NOT NULL
GROUP BY price_segment
ORDER BY average_rating DESC;
--This adds another dimension to the price-segment analysis.
--Premium cafes have higher average ratings and review volumes in this dataset. However, the premium segment has only 35 cafes, compared with 197 budget cafes.



-- 4. Find highly rated cafes with relatively few reviews
-- Thresholds are explicitly defined for this exploratory query.
SELECT
    name,
    location,
    avg_din_rate,
    dining_review_count,
    cost_for_two
FROM cafe
WHERE avg_din_rate >= 4.0
  AND dining_review_count IS NOT NULL
  AND dining_review_count <= 37
ORDER BY avg_din_rate DESC, dining_review_count ASC;


-- 5. Compare average ratings across areas
--requires at least 5 cafes in the area to be included in the comparison.
SELECT
    location,
    COUNT(*) AS cafe_count,
    ROUND(AVG(avg_din_rate), 2) AS average_rating,
    ROUND(AVG(dining_review_count), 2) AS average_reviews
FROM cafe
WHERE location IS NOT NULL
GROUP BY location
HAVING COUNT(*) >= 5
ORDER BY average_rating DESC;