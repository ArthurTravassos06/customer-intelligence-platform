-- 1. Create a CTE that classifies customers into income segments
--    and calculate the average income for each segment.
WITH customer_segments AS (
    SELECT
        customer_id,
        state,
        income,
        CASE
            WHEN income < 3000 THEN 'low'
            WHEN income < 7000 THEN 'medium'
            ELSE 'high'
        END AS income_segment
    FROM customer_intelligence_raw.default.customers
)

SELECT
    income_segment,
    AVG(income) AS average_income
FROM customer_segments
GROUP BY income_segment
ORDER BY average_income DESC;


-- 2. Create a CTE containing only customers from PE
--    and calculate their average income.
WITH customers_pe AS (
    SELECT
        customer_id,
        state,
        income
    FROM customer_intelligence_raw.default.customers
    WHERE state = 'PE'
)

SELECT
    state,
    AVG(income) AS average_income
FROM customers_pe
GROUP BY state;


-- 3. Create a CTE containing customers with income above 10,000
--    and count how many customers belong to each state.
WITH customers_high_income AS (
    SELECT
        customer_id,
        income,
        state
    FROM customer_intelligence_raw.default.customers
    WHERE income > 10000
)

SELECT
    state,
    COUNT(*) AS total_customers
FROM customers_high_income
GROUP BY state
ORDER BY total_customers DESC;


-- 4. Create a CTE that classifies customers into age groups:
--    18-29, 30-39, 40-49, 50-59 and 60+
--    Then count the number of customers in each age group.
WITH customer_age_groups AS (
    SELECT
        customer_id,
        state,
        income,
        age,
        CASE
            WHEN age BETWEEN 18 AND 29 THEN '18-29'
            WHEN age BETWEEN 30 AND 39 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            WHEN age BETWEEN 50 AND 59 THEN '50-59'
            ELSE '60+'
        END AS age_group
    FROM customer_intelligence_raw.default.customers
)

SELECT
    age_group,
    COUNT(*) AS total_customers
FROM customer_age_groups
GROUP BY age_group
ORDER BY total_customers DESC;