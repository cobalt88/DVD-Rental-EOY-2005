WITH
	inventory_count AS (
		SELECT
			c.name AS category_name,
			COUNT(i.inventory_id) AS category_count,
			ROUND(
				(
					COUNT(i.inventory_id) * 100.0 / total.total_inventory
				),
				2
			) AS percentage_of_total_inventory
		FROM
			inventory i
			JOIN film_category fc ON i.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id,
			(
				SELECT
					COUNT(inventory_id) AS total_inventory
				FROM
					inventory
			) AS total
		GROUP BY
			c.name,
			total.total_inventory
		ORDER BY
			percentage_of_total_inventory DESC
	),
	rental_count AS (
		SELECT
			category.name AS category,
			COUNT(*) AS qty
		FROM
			rental
			LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
			LEFT JOIN film ON inventory.film_id = film.film_id
			LEFT JOIN film_category ON film.film_id = film_category.film_id
			LEFT JOIN category ON film_category.category_id = category.category_id
		WHERE
			rental.rental_date < '2005-12-31'
		GROUP BY
			category
		ORDER BY
			qty DESC
	)
SELECT
	rc.category,
	rc.qty AS rental_qty,
	ic.category_count AS inventory_qty,
	ROUND(CAST(rc.qty AS NUMERIC) / ic.category_count, 2) AS performance
FROM
	rental_count AS rc
	LEFT JOIN inventory_count AS ic ON rc.category = ic.category_name
ORDER BY
	performance DESC