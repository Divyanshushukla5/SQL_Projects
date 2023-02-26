#1. Find customers who have never ordered

SELECT name FROM users 
WHERE user_id NOT IN 
(SELECT user_id FROM orders);

#2. Average Price/dish

SELECT f.f_name , AVG(price) AS 'Average price'
 FROM menu m 
 JOIN food f ON m.f_id=f.f_id
 GROUP BY m.f_id;
 
#3. Find the top restaurant in terms of the number of orders for a given month(can sort other monthwise)
-- May
SELECT r.r_name,MONTHNAME(date) AS 'MONTH',COUNT(*) AS 'orders' 
 FROM orders o 
 JOIN restaurants r
 ON o.r_id = r.r_id 
 WHERE MONTHNAME(date) LIKE "%May%" 
 GROUP BY o.r_id
 ORDER BY COUNT(*)DESC 
 LIMIT 4;

-- june
SELECT r.r_name,COUNT(*) AS 'month' 
 FROM orders o 
 JOIN restaurants r
 ON o.r_id = r.r_id 
 WHERE MONTHNAME(date) LIKE "%June%" 
 GROUP BY o.r_id
 ORDER BY COUNT(*)DESC 
 LIMIT 1;

-- july 
 SELECT r.r_name,COUNT(*) AS 'month' 
 FROM orders o 
 JOIN restaurants r
 ON o.r_id = r.r_id 
 WHERE MONTHNAME(date) LIKE "%July%" 
 GROUP BY o.r_id
 ORDER BY COUNT(*)DESC 
 LIMIT 4;
#4. restaurants with monthly sales greater than x (any amount)
 SELECT r.r_name , SUM(amount) AS 'revenue'
 FROM orders o 
 JOIN restaurants r 
 USING (r_id)
 WHERE MONTHNAME(date) LIKE "%June%" 
 GROUP BY o.r_id 
 HAVING revenue > 500;
 
#5. Show all orders with order details for a particular customer in a particular date range

-- Name base sorting
SELECT o.order_id,r.r_name,f.f_name
FROM orders o
JOIN restaurants r
ON r.r_id=o.r_id
JOIN order_details od
USING (order_id)
JOIN food f 
ON f.f_id=od.f_id
WHERE user_id=(SELECT user_id FROM users WHERE name LIKE "%Ankit%" )
 AND (date >'2022-06-10' AND date <'2022-07-10');

-- ID base sorting
SELECT o.order_id,r.r_name,f.f_name
FROM orders o
JOIN restaurants r
ON r.r_id=o.r_id
JOIN order_details od
USING (order_id)
JOIN food f 
ON f.f_id=od.f_id
WHERE user_id=3
 AND( date between'2022-06-10' AND '2022-07-10');
 
#6. Find restaurants with max repeated customers (loyal customers)
SELECT r.r_name , COUNT(*) AS 'Loyal_customers'
FROM   (
		SELECT r_id , user_id, COUNT(*) AS 'Visits'
		FROM orders
        GROUP BY r_id , user_id 
        HAVING visits>1
        ) t
JOIN restaurants r
ON r.r_id = t.r_id
GROUP BY t.r_id
ORDER BY loyal_customers DESC LIMIT 4;

#7. Month Over Month Revenue of swigy
SELECT MONTHNAME(date) AS 'MONTH', SUM(amount) AS 'Revenue'
	FROM orders
	GROUP BY MONTH
	ORDER BY MONTH(date);

#8. Month over month  growth_rate of swiggy
SELECT MONTH ,((Revenue-previous)/previous)*100 AS 'GROWTH_RATE'FROM (
WITH saless AS
(
	SELECT MONTHNAME(date) AS 'MONTH', SUM(amount) AS 'Revenue'
	FROM orders
	GROUP BY MONTH
	ORDER BY MONTH(date)

)
SELECT MONTH,Revenue,LAG(Revenue,1) OVER(ORDER BY Revenue)AS Previous FROM saless
)z;

#9. Customers - favorite food
WITH temp AS 
(
	SELECT o.user_id,od.f_id,COUNT(*) AS 'Frequency'
    FROM orders o
    JOIN order_details od
    ON o.order_id=od.order_id
    GROUP BY o.user_id,od.f_id
)
SELECT u.name,f.f_name,t1.frequency FROM temp t1
JOIN users u 
ON u.user_id=t1.user_id
JOIN food f
ON f.f_id=t1.f_id
WHERE t1.frequency =(
	SELECT MAX(frequency)
    FROM temp t2
    WHERE t2.user_id=t1.user_id
)