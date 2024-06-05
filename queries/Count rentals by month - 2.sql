
SELECT 
	to_char(r.rental_date, 'YYYY-MM') AS date,
	COUNT(*) AS rentals
FROM rental AS r
GROUP BY date
ORDER BY date DESC