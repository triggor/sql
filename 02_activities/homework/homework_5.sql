SELECT DISTINCT vendor_name, product_name,
	SUM((SELECT COUNT(*) FROM customer)*5.0*original_price) AS money
FROM vendor_inventory vi
LEFT JOIN vendor v
ON vi.vendor_id=v.vendor_id
LEFT JOIN product p
ON vi.product_id=p.product_id
GROUP BY vendor_name, product_name;

DROP TABLE IF EXISTS product_units;
CREATE TABLE product_units AS 
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product
WHERE product_qty_type="unit";
INSERT INTO product_units
VALUES((SELECT MAX(product_id) FROM product)+1, "Apple Pie 2", "large", 3, "unit", CURRENT_TIMESTAMP);
SELECT * FROM product_units;

DELETE FROM product_units
WHERE product_name="Apple Pie 2";
SELECT * FROM product_units;

ALTER TABLE product_units
ADD current_quantity INT;
WITH last_date AS
	(SELECT product_id, vendor_id, MAX(market_date) AS last
	FROM vendor_inventory
	GROUP BY product_id, vendor_id),
last_quantity AS
	(SELECT vi.product_id, SUM(quantity) AS last_qty
	FROM vendor_inventory vi
	INNER JOIN last_date ld
	ON vi.product_id=ld.product_id AND vi.vendor_id=ld.vendor_id AND vi.market_date=ld.last
	GROUP BY vi.product_id)
UPDATE product_units
SET current_quantity=COALESCE((SELECT last_qty FROM last_quantity WHERE product_units.product_id=last_quantity.product_id), 0);
SELECT * FROM product_units;
