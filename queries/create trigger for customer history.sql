CREATE OR REPLACE FUNCTION call_update_customer_history() RETURNS trigger AS $$
BEGIN
    -- Call the update procedure
    CALL update_customer_rentals_by_month(NEW.customer_id);
    
    -- Call the create dynamic crosstab function
    PERFORM create_customer_history();
    
    RETURN NEW;
END $$ LANGUAGE plpgsql;