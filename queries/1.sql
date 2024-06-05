CREATE TABLE customer_rentals_by_month AS
SELECT 
	c.first_name || ' ' || c.last_name AS customer,
	to_char(r.rental_date, 'YYYY-MM') AS date,
	COUNT(*) AS rentals
FROM rental AS r
LEFT JOIN customer AS c ON r.customer_id = c.customer_id
GROUP BY customer, date
ORDER BY customer DESC