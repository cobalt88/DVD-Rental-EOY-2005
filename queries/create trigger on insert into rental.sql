CREATE TRIGGER update_customer_history_after_insert
AFTER INSERT ON rental
FOR EACH STATEMENT
EXECUTE FUNCTION call_create_customer_history();