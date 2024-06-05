SELECT 
	inventory.film_id,
	COUNT(rental.inventory_id),
	film.title,
	film.release_year
FROM inventory
	LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id 
	LEFT JOIN film ON inventory.film_id = film.film_id
GROUP BY inventory.film_id, film.title, film.release_year
ORDER BY count DESC