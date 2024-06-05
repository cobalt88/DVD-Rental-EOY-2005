SELECT
	category.name AS category,
	COUNT(*) AS qty
FROM rental
LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film ON inventory.film_id = film.film_id
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
	WHERE rental.rental_date < '2005-12-31'
GROUP BY category
ORDER BY qty DESC