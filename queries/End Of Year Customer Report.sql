-- create a new table that is a simplified view for a report

CREATE EXTENSION IF NOT EXISTS tablefunc;

CREATE TABLE end_of_year_rentals_report_2005 AS
SELECT * 
FROM crosstab(
    $$ SELECT 
         c.first_name || ' ' || c.last_name AS customer,
         to_char(r.rental_date, 'YYYY-MM') AS date,
         COUNT(*) AS rentals
       FROM rental AS r
       LEFT JOIN customer AS c ON r.customer_id = c.customer_id
       GROUP BY customer, date
       ORDER BY customer, date $$,
    $$ VALUES 
         ('2005-01'), ('2005-02'), ('2005-03'), ('2005-04'), ('2005-05'), ('2005-06'), 
         ('2005-07'), ('2005-08'), ('2005-09'), ('2005-10'), ('2005-11'), ('2005-12') $$
) AS ct (
    "Customer" text, 
    "Jan 2005" int, "Feb 2005" int, "Mar 2005" int, 
    "Apr 2005" int, "May 2005" int, "Jun 2005" int,
    "Jul 2005" int, "Aug 2005" int, "Sep 2005" int,
    "Oct 2005" int, "Nov 2005" int, "Dec 2005" int
);