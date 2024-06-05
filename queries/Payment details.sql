SELECT 
*
FROM rental
	LEFT JOIN payment ON rental.rental_id = payment.rental_id AND rental.rental_date < '2005-12-31'
ORDER BY payment_date ASC 