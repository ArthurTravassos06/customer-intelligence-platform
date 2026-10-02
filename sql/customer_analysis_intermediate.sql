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

-- 5. Find all customers whose income is above the overall average income.
SELECT
    customer_id,
    state,
    income
FROM customer_intelligence_raw.default.customers
WHERE income > (
    SELECT
        AVG(income)
    FROM customer_intelligence_raw.default.customers
)
ORDER BY income DESC;


-- 6. Find all customers whose income is below the overall average income.
SELECT
    customer_id,
    state,
    income
FROM customer_intelligence_raw.default.customers
WHERE income < (
    SELECT
        AVG(income)
    FROM customer_intelligence_raw.default.customers
)
ORDER BY income DESC;


-- 7. Find the customer or customers with the highest income.
SELECT
    customer_id,
    state,
    income
FROM customer_intelligence_raw.default.customers
WHERE income = (
    SELECT
        MAX(income)
    FROM customer_intelligence_raw.default.customers
);


-- 8. Find all customers whose age is above the average customer age.
SELECT
    customer_id,
    state,
    income,
    age
FROM customer_intelligence_raw.default.customers
WHERE age > (
    SELECT
        AVG(age)
    FROM customer_intelligence_raw.default.customers
);


-- 9. Find all customers who belong to states
--    where the average income is above 5,500.
SELECT
    customer_id,
    state,
    age,
    income
FROM customer_intelligence_raw.default.customers
WHERE state IN (
    SELECT
        state
    FROM customer_intelligence_raw.default.customers
    GROUP BY state
    HAVING AVG(income) > 5500
);


-- 10. Find all customers who belong to acquisition channels
--     with more than 2,000 customers.
SELECT
    customer_id,
    state,
    age,
    income,
    acquisition_channel
FROM customer_intelligence_raw.default.customers
WHERE acquisition_channel IN (
    SELECT
        acquisition_channel
    FROM customer_intelligence_raw.default.customers
    GROUP BY acquisition_channel
    HAVING COUNT(*) > 2000
);
-- 11. Find all customers whose income is NULL.
SELECT
    *
FROM customers
WHERE income IS NULL;


-- 12. Return customer_id, state and income,
--     replacing NULL income values with 0.
SELECT
    customer_id,
    state,
    income,
    COALESCE(income, 0) AS income_filled
FROM customers;


-- 13. Return customer_id and income,
--     converting income to an integer.
SELECT
    customer_id,
    income,
    CAST(income AS INT) AS income_integer
FROM customers;


-- 14. Return customer_id and signup_date,
--     converting signup_date to DATE.
SELECT
    customer_id,
    signup_date,
    CAST(signup_date AS DATE) AS signup_date_casted
FROM customers;


-- 15. Return customer_id and acquisition_channel,
--     replacing NULL acquisition channels with 'unknown'.
SELECT
    customer_id,
    acquisition_channel,
    COALESCE(acquisition_channel, 'unknown') AS acquisition_channel_filled
FROM customers;

-- 16. Return customer_id, signup_date and the year in which each customer signed up.
SELECT
    customer_id,
    signup_date,
    YEAR(signup_date) AS signup_year
FROM customers;


-- 17. Return customer_id, signup_date and the number of days since signup.
SELECT
    customer_id,
    signup_date,
    DATEDIFF(CURRENT_DATE(), signup_date) AS days_since_signup
FROM customers;


-- 18. Count how many customers signed up in each year.
SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS total_customers
FROM customers
GROUP BY signup_year
ORDER BY signup_year;


-- 19. Count how many customers signed up in each month of 2025.
SELECT
    MONTH(signup_date) AS signup_month,
    COUNT(*) AS total_customers
FROM customers
WHERE YEAR(signup_date) = 2025
GROUP BY signup_month
ORDER BY signup_month;


-- 20. Find all customers who signed up after January 1, 2026.
SELECT
    *
FROM customers
WHERE signup_date > DATE '2026-01-01'
ORDER BY signup_date;