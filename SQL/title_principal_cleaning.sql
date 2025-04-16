--Data Cleaning and Formatting of Title Principals Dataset
SET statement_timeout = 0;

UPDATE title_principals_copy tp
SET title_id = tb.primarytitle
FROM title_basics_copy tb
WHERE tp.title_id = tb.title_id;

UPDATE title_principals_copy tp
SET actor_id = ac.nombre
FROM actor_basics_copy ac
WHERE tp.actor_id = ac.actor_id;