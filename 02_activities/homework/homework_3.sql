SELECT vendor_id, count(*) AS count
FROM vendor_booth_assignments
GROUP BY vendor_id;

SELECT c.customer_first_name, c.customer_last_name, SUM(cp.quantity*cost_to_customer_per_qty) AS spent
FROM customer_purchases cp
LEFT JOIN customer c
ON c.customer_id=cp.customer_id
GROUP BY c.customer_id
HAVING spent>2000
ORDER BY customer_last_name, customer_first_name;

DROP TABLE IF EXISTS new_vendor;
CREATE TEMP TABLE new_vendor AS
	SELECT *
	FROM vendor;
INSERT INTO new_vendor
VALUES(10, "Thomass Superfood Store", "Fresh Focused", "Thomas", "Rosenthal");
SELECT * FROM new_vendor;

SELECT customer_id,
	strftime('%m', market_date) AS month,
	strftime('%Y', market_date) AS year
FROM customer_purchases;

SELECT customer_id,
	SUM(quantity*cost_to_customer_per_qty) AS spent
FROM customer_purchases
WHERE strftime('%m', market_date)="04" AND strftime('%Y', market_date)="2022"
GROUP BY customer_id;
