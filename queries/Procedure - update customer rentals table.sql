CREATE OR REPLACE FUNCTION update_rentals_report()
RETURNS TRIGGER AS $$
DECLARE
    customer_name TEXT;
    rental_month TEXT;
BEGIN
    SELECT c.first_name || ' ' || c.last_name, to_char(NEW.rental_date, 'YYYY-MM')
    INTO customer_name, rental_month
    FROM customer c
    WHERE c.customer_id = NEW.customer_id;

    IF EXISTS (SELECT 1 FROM end_of_year_rentals_report_2005 WHERE Customer = customer_name AND date_trunc('month', rental_month) = date_trunc('month', NEW.rental_date)) THEN
        EXECUTE format('UPDATE end_of_year_rentals_report_2005 SET "%s" = "%s" + 1 WHERE Customer = $1', rental_month, rental_month) USING customer_name;
    ELSE
        EXECUTE format('INSERT INTO end_of_year_rentals_report_2005 (Customer, "%s") VALUES ($1, 1)', rental_month) USING customer_name;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;