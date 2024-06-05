CREATE OR REPLACE PROCEDURE update_customer_rentals_by_month(new_customer_id int)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customer_rentals_by_month (customer, date, rentals)
    SELECT 
        c.first_name || ' ' || c.last_name AS customer,
        to_char(NOW(), 'YYYY-MM') AS date, -- Assume we're updating for the current month
        COUNT(*) AS rentals
    FROM rental AS r
    LEFT JOIN customer AS c ON r.customer_id = c.customer_id
    WHERE c.customer_id = new_customer_id
    GROUP BY customer, date
    ON CONFLICT (customer, date) DO UPDATE 
    SET rentals = EXCLUDED.rentals;

    RAISE NOTICE 'Update completed successfully.';
END;
$$;