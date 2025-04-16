--Data Cleaning and formatting of Title Basics Dataset 
SET statement_timeout = 0;
SELECT DISTINCT titletype FROM title_basics_copy;
SELECT * FROM title_basics_copy WHERE endyear IS NULL AND titletype ILIKE 'tv%';

-- The column endyear indicates the year a title ended. This contains 99% NULL values since it only applies to series. We will handle it accordingly.
UPDATE title_basics_copy
SET endyear = 'Serie not finished or on going' 
WHERE endyear IS NULL AND titletype ILIKE '%serie%';

UPDATE title_basics_copy
SET endyear = 'Not applicable' 
WHERE endyear IS NULL AND titletype NOT ILIKE '%serie%';

SELECT * FROM title_basics_copy WHERE startyear IS NULL;

-- Out of 1,424,829 titles with no start year info, 1,245,685 are TV series episodes. It’s understandable to lack the start year since
-- it should be considered the same as the series, but for very long seasons this could vary, so we will mark it as 'Not applicable'
UPDATE title_basics_copy
UPDATE title_basics_copy
SET startyear = 'Not applicable'
WHERE startyear IS NULL AND titletype ILIKE '%episode%';

UPDATE title_basics_copy 
SET startyear = 'Unkown Start Year'
WHERE startyear IS NULL AND titletype NOT ILIKE '%episode%';

-- Approximately 75% of runtimes are NULL. We could consider using an LLM API to fill this in, provided the info is available online,
-- but many are simply not. Due to limited budget for a powerful API and since this is not the goal of the project, we will fill it with 'Unkown/Not Updated Duration'.
UPDATE title_basics_copy 
SET runtimeminutes = 'Unkown/Not Updated Duration'
WHERE runtimeminutes IS NULL;

-- Filling NULLs in genres with 'Unkown Genres'
UPDATE title_basics_copy
SET genres = 'Unkown Genres'
WHERE genres IS NULL;


