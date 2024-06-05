SELECT 
*
FROM rental
	LEFT JOIN payment ON rental.rental_id = payment.rental_id
ORDER BY payment_date ASC 