-- Q1: Revenue from each sales channel

SELECT 
  sales_channel,
  SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel;



-- Q2: Top 10 most valuable customers

SELECT 
  uid,
  SUM(amount) AS total_spent
FROM clinic_sales
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;



-- Q3: Month-wise revenue, expense, profit, status

WITH revenue AS (
  SELECT 
    strftime('%m', datetime) AS month,
    SUM(amount) AS total_revenue
  FROM clinic_sales
  GROUP BY month
),

expense AS (
  SELECT 
    strftime('%m', datetime) AS month,
    SUM(amount) AS total_expense
  FROM expenses
  GROUP BY month
)

SELECT 
  r.month,
  r.total_revenue,
  e.total_expense,
  (r.total_revenue - e.total_expense) AS profit,
  CASE 
    WHEN (r.total_revenue - e.total_expense) > 0 THEN 'Profit'
    ELSE 'Loss'
  END AS status
FROM revenue r
JOIN expense e ON r.month = e.month;



-- Q4: Most profitable clinic in each city

WITH clinic_profit AS (
  SELECT 
    c.city,
    c.cid,
    SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid = cs.cid
  LEFT JOIN expenses e ON c.cid = e.cid
  GROUP BY c.city, c.cid
),

ranked AS (
  SELECT *,
  RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
  FROM clinic_profit
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q5: Second least profitable clinic per state

WITH clinic_profit AS (
  SELECT 
    c.state,
    c.cid,
    SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid = cs.cid
  LEFT JOIN expenses e ON c.cid = e.cid
  GROUP BY c.state, c.cid
),

ranked AS (
  SELECT *,
  DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
  FROM clinic_profit
)

SELECT *
FROM ranked
WHERE rnk = 2;