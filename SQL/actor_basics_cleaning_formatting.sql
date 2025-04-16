--Data Cleaning and formatting of Actor Basics Dataset
--SELECT * FROM actor_basics_copy;
--SELECT * FROM actor_basics_copy WHERE birth_year IS NULL AND death_year IS NOT NULL;
SET statement_timeout = 0;

-- Let's see how many people has no info in the birth and death fields, and people without
WITH birth_info AS(
	SELECT * FROM actor_basics_copy a
	WHERE a.birth_year IS NULL AND a.death_year IS NOT NULL	
)
SELECT FROM no_birth_info;
--Both NULL = 13,622,005
--Still Alive = 415,140
--Dead = 226,439
--No Birth Info = 15,182

UPDATE actor_basics_copy 
SET birth_year='No Birth Info', 
	 death_year='No Death Info' 
	 WHERE birth_year IS NULL 
	 AND death_year IS NULL;
	 
UPDATE actor_basics_copy 
SET birth_year='No Birth Info'
	 WHERE birth_year IS NULL 
	 AND death_year IS NOT NULL;
	 
UPDATE actor_basics_copy
SET death_year='Still Alive'
WHERE birth_year IS NOT NULL
AND death_year IS NULL;

SELECT * FROM title_basics_copy WHERE endyear IS NOT NULL ORDER BY startyear DESC;

--We are going to replace the knownfortitles column, which contains movie IDs, with the movie titles they correspond to
-- First we test the logic to avoid modifying the table without being sure
SELECT a.actor_id, STRING_AGG(tb.primarytitle, ',') AS titulos_conocidos
FROM actor_basics_copy a
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(a.knownfortitles, ',')) AS split_ids(title_id)
	JOIN title_basics_copy tb ON tb.title_id = split_ids.title_id
GROUP BY a.actor_id;

--Once we see it works fine, we perform the UPDATE. We will perform a subquery using several functions:
--STRING_AGG to concatenate the list of strings with ',' as separator
--STRING_TO_ARRAY to convert the string into a list of arrays separated by ','
--With UNNEST we split each element of the list into separate rows
UPDATE actor_basics_copy AS a
SET knownfortitles = t.titulos_conocidos
FROM (
	SELECT actor_id, STRING_AGG(tb.primarytitle, ',') AS titulos_conocidos
	FROM actor_basics_copy
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(knownfortitles, ',')) AS split_ids(title_id)
	JOIN title_basics_copy tb ON tb.title_id = split_ids.title_id
	GROUP BY actor_id)
	AS t
	WHERE a.actor_id = t.actor_id;
	
SELECT * FROM actor_basics_copy WHERE knownfortitles IS NULL;
--As we can see, there are 1,631,323 records of people for whom we have no info about dates, most of their
--professions are missing and they have no movie titles to relate them to. In other words,
--these are records that add no value and will be removed.

--In this case we will only delete rows with NULL profession, because knowing the movie they worked on
--without knowing their role is of little use, and those with NULL titles, because it's useless if we don't know in which movie they participated.
DELETE FROM actor_basics_copy WHERE knownfortitles IS NULL OR profesion IS NULL;