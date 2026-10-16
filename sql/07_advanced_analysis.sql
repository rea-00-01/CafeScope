USE cafescope;


-- 1. Compare each cafe's rating with its area's average rating
SELECT
    name,
    location,
    avg_din_rate,
    ROUND(area_average_rating, 2) AS area_average_rating,
    ROUND(
        avg_din_rate - area_average_rating,
        2
    ) AS rating_difference
FROM (
    SELECT
        name,
        location,
        avg_din_rate,
        AVG(avg_din_rate) OVER (
            PARTITION BY location
        ) AS area_average_rating
    FROM cafe
    WHERE location IS NOT NULL
      AND avg_din_rate IS NOT NULL
) AS area_comparison
ORDER BY rating_difference DESC;
--Calculates the average rating for each area and attaches that average to each cafe in the area.
--This is useful because comparing a cafe with its immediate competitive environment can be more meaningful than comparing it only with the citywide average.






-- 2. Rank cafes within each area by review count
SELECT
    name,
    location,
    dining_review_count,
    RANK() OVER (
        PARTITION BY location
        ORDER BY dining_review_count DESC
    ) AS popularity_rank_in_area
FROM cafe
WHERE location IS NOT NULL
  AND dining_review_count IS NOT NULL
ORDER BY location, popularity_rank_in_area;
--It assigns each cafe a rank within its own neighborhood based on dining-review count.
--Malviya Nagar ka top cafe aur Mansarovar ka top cafe independently rank hoga.
--This helps identify local competitors rather than only citywide leaders.




-- 3. Compare cafe counts and average ratings across price segments
WITH segment_summary AS (
    SELECT
        price_segment,
        COUNT(*) AS cafe_count,
        AVG(avg_din_rate) AS average_rating,
        AVG(cost_for_two) AS average_cost
    FROM cafe
    WHERE price_segment IS NOT NULL
    GROUP BY price_segment
)
SELECT
    price_segment,
    cafe_count,
    ROUND(average_rating, 2) AS average_rating,
    ROUND(average_cost, 2) AS average_cost
FROM segment_summary
ORDER BY average_cost;
--A common table expression, introduced by WITH, creates a named intermediate result that the main query can use.
--query calculates cafe counts, average ratings, and average costs by segment.
