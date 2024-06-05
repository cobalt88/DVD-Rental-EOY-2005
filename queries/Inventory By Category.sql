SELECT
	c.name AS category_name,
	COUNT(i.inventory_id) AS category_count,
	ROUND((COUNT(i.inventory_id) * 100.0 / total.total_inventory), 2) AS percentage_of_total_inventory
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