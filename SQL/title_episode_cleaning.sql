--Data Cleaning and formatting of Title Episode Dataset
SET statement_timeout = 0;

--SELECT * FROM title_episode_copy WHERE seasonnumber IS NULL AND episodenumber IS NULL;

--Vamos a sustituir aquellos títulos de los que no disponemos información por 'Unknown Season' o 'Unknown Episode'

UPDATE title_episode_copy
SET seasonnumber = 'Unkown Season' 
WHERE seasonnumber IS NULL;

UPDATE title_episode_copy
SET episodenumber = 'Unkown Episode' 
WHERE episodenumber IS NULL;


--We are going to replace those titles for which we don't have information with 'Unknown Season' or 'Unknown Episode'
SELECT te.title_id, tb.primarytitle FROM title_episode_copy te
JOIN title_basics_copy tb ON te.title_id = tb.title_id;


UPDATE title_episode_copy AS te
SET title_id = tb.primarytitle
FROM title_basics_copy tb
WHERE te.title_id = tb.title_id;

UPDATE title_episode_copy AS te
SET parenttconst = tb.primarytitle
FROM title_basics_copy tb
WHERE te.parenttconst = tb.title_id;

