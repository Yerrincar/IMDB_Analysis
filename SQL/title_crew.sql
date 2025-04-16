--Data Cleaning and formatting of Title Crew Dataset 
SET statement_timeout = 0;


--To handle NULLs in the directors column we will take two approaches. If the column writers = 'Not Registered Writer' we will assign 'Not Registered Director', but
--if we have writers but no directors, we will assume they are the same person but the info hasn’t been updated. Ideally, the data source
--would provide this info, but that’s not the case.

UPDATE title_crew_copy 
SET directors = CASE 
WHEN writers IS NOT NULL THEN writers ELSE 'Not Registered Director' END
WHERE directors IS NULL;

--Some titles for some reason do not have a registered writer, either because the director is the writer or they are simply not registered. So,
--we will fill NULL values with 'Not Registered Writer'

UPDATE title_crew_copy
SET writers = 'Not Registered Writer'
WHERE writers IS NULL;


--We are going to replace the ID of each title and person with their actual names


SELECT * FROM title_crew_copy WHERE directors = 'Not Registered Writer';

--To replace the ID with the name, we need to use UNNEST again to split each ID into a separate row
--Initial check to ensure the update will work properly
SELECT title, STRING_AGG(ac.nombre, ',') AS nombres
FROM title_crew_copy tc
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(tc.directors, ',')) AS splits_ids(director_id)
	JOIN actor_basics_copy ac ON ac.actor_id = splits_ids.director_id
GROUP BY tc.title;

--Updating directors
UPDATE title_crew_copy AS tc
SET directors = d.nombres
FROM (
	SELECT title_id, STRING_AGG(ac.nombre, ',') AS nombres
	FROM title_crew_copy tc
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(tc.directors, ',')) AS splits_ids(director_id)
	JOIN actor_basics_copy ac ON ac.actor_id = splits_ids.director_id
	WHERE splits_ids.director_id NOT IN ('Not Registered Director', 'Not Registered Writer')
	GROUP BY tc.title_id
) AS d
WHERE tc.title_id = d.title_id;

--Updating writers
UPDATE title_crew_copy AS tc
SET writers = d.nombres
FROM (
	SELECT title_id, STRING_AGG(ac.nombre, ',') AS nombres
	FROM title_crew_copy tc
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(tc.writers, ',')) AS splits_ids(writer_id)
	JOIN actor_basics_copy ac ON ac.actor_id = splits_ids.writer_id
	WHERE splits_ids.writer_id NOT IN ('Not Registered Director', 'Not Registered Writer')
	GROUP BY tc.title_id
) AS d
WHERE tc.title_id = d.title_id; 	



UPDATE title_crew_copy AS tc
SET title_id = tb.primarytitle
FROM title_basics_copy AS tb WHERE tc.title_id = tb.title_id;

ALTER TABLE title_crew_copy RENAME COLUMN title_id TO title;

SELECT * FROM title_crew_copy LIMIT 1000;