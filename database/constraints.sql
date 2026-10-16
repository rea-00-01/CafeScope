USE cafescope;

ALTER TABLE cafe
ADD CONSTRAINT chk_cafe_cost
CHECK (
    cost_for_two IS NULL
    OR cost_for_two >= 0
);

ALTER TABLE cafe
ADD CONSTRAINT chk_cafe_dining_rating
CHECK (
    avg_din_rate IS NULL
    OR avg_din_rate BETWEEN 0 AND 5
);

ALTER TABLE cafe
ADD CONSTRAINT chk_cafe_delivery_rating
CHECK (
    avg_del_rate IS NULL
    OR avg_del_rate BETWEEN 0 AND 5
);

ALTER TABLE cafe
ADD CONSTRAINT chk_cafe_dining_reviews
CHECK (
    dining_review_count IS NULL
    OR dining_review_count >= 0
);

ALTER TABLE cafe
ADD CONSTRAINT chk_cafe_delivery_reviews
CHECK (
    delivery_review_count IS NULL
    OR delivery_review_count >= 0
);