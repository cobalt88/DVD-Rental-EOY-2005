CREATE OR REPLACE FUNCTION trigger_update_rentals()
RETURNS TRIGGER AS $$
BEGIN
    CALL update_customer_rentals_by_month(NEW.customer_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_rental_insert
AFTER INSERT ON rental
FOR EACH ROW EXECUTE FUNCTION trigger_update_rentals();