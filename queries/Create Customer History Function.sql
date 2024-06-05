CREATE OR REPLACE FUNCTION create_customer_history() RETURNS void AS $$
DECLARE
    column_headers text;
    crosstab_query text;
BEGIN
    SELECT string_agg('"' || date || '" int', ', ') INTO column_headers
    FROM (SELECT DISTINCT to_char(rental_date, 'YYYY-MM') AS date FROM rental) sub;
    crosstab_query := 'CREATE TABLE customer_rental_history AS
        SELECT * 
        FROM crosstab(
            $crosstab$
            SELECT 
                c.first_name || '' '' || c.last_name AS customer,
                to_char(r.rental_date, ''YYYY-MM'') AS date,
                COUNT(*) AS rentals
            FROM rental AS r
            LEFT JOIN customer AS c ON r.customer_id = c.customer_id
            GROUP BY customer, date
            ORDER BY customer, date
            $crosstab$,
            $crosstab$
            SELECT DISTINCT to_char(rental_date, ''YYYY-MM'') AS date
            FROM rental 
            ORDER BY date
            $crosstab$
        ) AS ct (
            "Customer" text, ' || column_headers || ');';
    EXECUTE crosstab_query;
END $$ LANGUAGE plpgsql;