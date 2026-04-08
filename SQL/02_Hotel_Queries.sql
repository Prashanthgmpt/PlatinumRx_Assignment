-- Q1: Last booked room for each user

SELECT user_id, room_no
FROM bookings b1
WHERE booking_date = (
  SELECT MAX(booking_date)
  FROM bookings b2
  WHERE b1.user_id = b2.user_id
);

-- Q2: Total billing amount for bookings in November 2021

SELECT b.booking_id,
SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', b.booking_date) = '11'
  AND strftime('%Y', b.booking_date) = '2021'
GROUP BY b.booking_id;

-- Q3: Bills in October with amount > 1000

SELECT bc.bill_id,
SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '10'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Q4: Most and least ordered item per month

WITH item_counts AS (
  SELECT 
    strftime('%m', bc.bill_date) AS month,
    i.item_name,
    SUM(bc.item_quantity) AS total_qty
  FROM booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
  GROUP BY month, i.item_name
),

ranked AS (
  SELECT *,
  RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS max_rank,
  RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS min_rank
  FROM item_counts
)

SELECT *
FROM ranked
WHERE max_rank = 1 OR min_rank = 1;

-- Q5: Second highest bill per month

WITH bill_totals AS (
  SELECT 
    bc.bill_id,
    strftime('%m', bc.bill_date) AS month,
    SUM(bc.item_quantity * i.item_rate) AS total_bill
  FROM booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
  GROUP BY bc.bill_id, month
),

ranked AS (
  SELECT *,
  DENSE_RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) AS rnk
  FROM bill_totals
)

SELECT *
FROM ranked
WHERE rnk = 2;