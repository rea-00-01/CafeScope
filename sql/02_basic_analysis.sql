USE cafescope;


-- 1. Total cafes
SELECT COUNT(*) AS total_cafes
FROM cafe;
--Result: 552

-- 2. Number of cafes by area
SELECT
    location,
    COUNT(*) AS cafe_count
FROM cafe
WHERE location IS NOT NULL
GROUP BY location
ORDER BY cafe_count DESC;
--Interpretation: Malviya Nagar and Mansarovar have the largest cafe concentrations in my dataset.


-- 3. Average rating across the dataset
SELECT
    ROUND(AVG(avg_din_rate), 2) AS average_dining_rating
FROM cafe;
--Result: 3.51


-- 4. Average cost for two
SELECT
    ROUND(AVG(cost_for_two), 2) AS average_cost_for_two
FROM cafe;
--Result: ₹415.65


-- 5. Most highly rated cafes
SELECT
    name,
    location,
    avg_din_rate,
    dining_review_count
FROM cafe
WHERE avg_din_rate IS NOT NULL
ORDER BY avg_din_rate DESC
LIMIT 20;
--Results include:
--- Tapri Central: 4.9, 3 reviews.
--- Zolocrust: 4.9, 1 review.
--- Curious Life Coffee Roasters: 4.7, 879 reviews.
--This exposes an important analytical issue.
--A cafe with one review and a rating of 4.9 has a very different evidence base from one with hundreds of reviews and a rating of 4.7.
--Sirf rating dekhkar cafe ko best bolna misleading ho sakta hai. Review count bhi dekhna padega.



-- 6. Cafes with the highest dining-review counts
SELECT
    name,
    location,
    dining_review_count
FROM cafe
WHERE dining_review_count IS NOT NULL
ORDER BY dining_review_count DESC
LIMIT 20;


-- 7. Distribution of price segments
SELECT
    price_segment,
    COUNT(*) AS cafe_count
FROM cafe
WHERE price_segment IS NOT NULL
GROUP BY price_segment
ORDER BY cafe_count DESC;
--The percentages use 527 cafes because 25 have a NULL price segment.
--Budget and mid-range together account for 404 of 527 classified cafes, or 76.66%.