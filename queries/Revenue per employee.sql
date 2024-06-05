SELECT 
	staff.store_id AS store,
	staff.first_name || ' ' || staff.last_name AS staff_name,
	SUM(payment.amount) AS total
	FROM payment 
LEFT JOIN staff ON payment.staff_id = staff.staff_id
	LEFT JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY store, staff_name