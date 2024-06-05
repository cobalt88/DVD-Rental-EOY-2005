
SELECT 
	to_char(r.rental_date, 'YYYY-MM') AS date,
	COUNT(*) AS rentals
FROM rental AS r
	WHERE r.rental_date <= '2005-12-31'
	AND r.rental_date >= '2005-01-01'
GROUP BY date
ORDER BY date DESC