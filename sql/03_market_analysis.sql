USE cafescope;


-- 1. Which areas have the most cafes?
SELECT
    location,
    COUNT(*) AS cafe_count
FROM cafe
WHERE location IS NOT NULL
GROUP BY location
ORDER BY cafe_count DESC;


-- 2. Compare areas by count, rating, cost and review volume
SELECT
    location,
    COUNT(*) AS cafe_count,
    ROUND(AVG(avg_din_rate), 2) AS average_rating,
    ROUND(AVG(cost_for_two), 2) AS average_cost_for_two,
    ROUND(AVG(dining_review_count), 2) AS average_dining_reviews
FROM cafe
WHERE location IS NOT NULL
GROUP BY location
ORDER BY cafe_count DESC;
--C Scheme has substantial cafe concentration and a relatively high average rating. Lal Kothi and Durgapura have fewer cafes but higher average review volumes.


-- 3. Which price segments are most common?
SELECT
    price_segment,
    COUNT(*) AS cafe_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM cafe
         WHERE price_segment IS NOT NULL),
        2
    ) AS market_share_percent
FROM cafe
WHERE price_segment IS NOT NULL
GROUP BY price_segment
ORDER BY cafe_count DESC;
--This calculates the percentage of cafes in each classified price segment.



-- 4. Compare average rating across price segments
SELECT
    price_segment,
    COUNT(*) AS cafe_count,
    ROUND(AVG(cost_for_two), 2) AS average_cost,
    ROUND(AVG(avg_din_rate), 2) AS average_rating
FROM cafe
WHERE price_segment IS NOT NULL
GROUP BY price_segment
ORDER BY average_cost;
--This calculates the percentage of cafes in each classified price segment.



-- 5. Compare vegetarian and non-vegetarian offerings
SELECT
    is_vegeterian,
    COUNT(*) AS cafe_count
FROM cafe
WHERE is_vegeterian IS NOT NULL
GROUP BY is_vegeterian;


-- 6. Compare operational offerings
SELECT
    SUM(home_delivery = TRUE) AS cafes_offering_delivery,
    SUM(offers_dining = TRUE) AS cafes_offering_dining,
    SUM(is_bar_available = TRUE) AS cafes_with_bar
FROM cafe;
--Dataset mein dining 511 aur delivery 410 options common hain, jabki bar availability 10 uncommon hai.




