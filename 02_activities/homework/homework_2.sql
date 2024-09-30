SELECT *
FROM customer;

SELECT *
FROM customer
ORDER BY customer_last_name ASC, customer_first_name ASC
LIMIT 10;

SELECT *
FROM customer_purchases
WHERE product_id BETWEEN 4 AND 9;

SELECT *, quantity*cost_to_customer_per_qty*1.0 AS price
FROM customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

SELECT product_id, product_name, 
	CASE product_qty_type
		WHEN "unit" THEN "unit"
		ELSE "bulk"
	END prod_qty_type_condensed
FROM product;

SELECT product_id, product_name, 
	CASE product_qty_type
		WHEN "unit" THEN "unit"
		ELSE "bulk"
	END prod_qty_type_condensed,
	CASE LOWER(product_name) LIKE "%pepper%"
	WHEN TRUE THEN 1
	ELSE 0
	END pepper_flag
FROM product;

SELECT *
FROM vendor v
INNER JOIN vendor_booth_assignments vba
ON v.vendor_id=vba.vendor_id
ORDER BY vendor_name, market_date;
