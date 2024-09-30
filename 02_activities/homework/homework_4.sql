SELECT 
product_name || ', ' || coalesce(product_size, '') || ' (' || coalesce(product_qty_type, "unit") || ')'
FROM product;

SELECT *,
	dense_rank () OVER (PARTITION BY customer_id ORDER BY market_date) visit
FROM customer_purchases;

SELECT *
FROM (SELECT *,
		dense_rank () OVER (PARTITION BY customer_id ORDER BY market_date DESC) visit
	FROM customer_purchases)
WHERE visit=1;

SELECT DISTINCT customer_id, product_id,
	 COUNT () OVER (PARTITION BY customer_id, product_id ORDER BY customer_id, product_id) purchased
FROM customer_purchases;

SELECT *,
	CASE INSTR(product_name, ' - ')
		WHEN 0 THEN NULL
		ELSE SUBSTR(product_name, INSTR(product_name, ' - ')+3)
		END description
FROM product;

WITH total_sales AS
	(SELECT market_date, SUM(quantity*cost_to_customer_per_qty) AS tot_sales
	FROM customer_purchases
	GROUP BY market_date)
SELECT *
FROM total_sales
WHERE tot_sales=(SELECT MAX(tot_sales) FROM total_sales)
UNION
SELECT *
FROM total_sales
WHERE tot_sales=(SELECT MIN(tot_sales) FROM total_sales);
