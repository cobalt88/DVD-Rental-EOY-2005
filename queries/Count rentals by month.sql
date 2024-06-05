-- small subset to the report that displays how many rentals were made each month, might expand this out into a month over month rental report, then possibly break that down by category/genre. 

SELECT 
	COUNT(*),
to_char(rental.rental_date, 'YYYY-MM') AS date
FROM rental
GROUP BY date
ORDER BY date DESC