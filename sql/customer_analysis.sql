-- 1. What is the total number of customers?
SELECT
    COUNT(*) AS total_customers
FROM `customer_intelligence_raw`.`default`.`customers`;


-- 2. How many customers are there in each state?
SELECT
    state,
    COUNT(*) AS total_customers
FROM `customer_intelligence_raw`.`default`.`customers`
GROUP BY state
ORDER BY total_customers DESC;


-- 3. What is the average income by state?
SELECT
    state,
    AVG(income) AS average_income
FROM `customer_intelligence_raw`.`default`.`customers`
GROUP BY state
ORDER BY average_income DESC;


-- 4. How many customers were acquired through each acquisition channel?
SELECT
    acquisition_channel,
    COUNT(*) AS total_customers
FROM `customer_intelligence_raw`.`default`.`customers`
GROUP BY acquisition_channel
ORDER BY total_customers DESC;


-- 5. What is the average income by acquisition channel?
SELECT
    acquisition_channel,
    AVG(income) AS average_income
FROM `customer_intelligence_raw`.`default`.`customers`
GROUP BY acquisition_channel
ORDER BY average_income DESC;


-- 6. Who are the top 10 customers by income?
SELECT
    customer_id,
    signup_date,
    birth_date,
    age,
    state,
    income,
    acquisition_channel
FROM `customer_intelligence_raw`.`default`.`customers`
ORDER BY income DESC
LIMIT 10;


-- 7. Which customers from Pernambuco (PE) have an income greater than 10,000?
SELECT
    customer_id,
    signup_date,
    birth_date,
    age,
    state,
    income,
    acquisition_channel
FROM `customer_intelligence_raw`.`default`.`customers`
WHERE state = 'PE'
  AND income > 10000
ORDER BY income DESC;


-- 8. How many customers are there in each income segment?
SELECT
    CASE
        WHEN income < 3000 THEN 'low'
        WHEN income < 7000 THEN 'medium'
        ELSE 'high'
    END AS income_segment,
    COUNT(*) AS total_customers
FROM `customer_intelligence_raw`.`default`.`customers`
GROUP BY income_segment
ORDER BY total_customers DESC;