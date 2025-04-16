--Data Cleaning and formatting of Actor Basics Dataset
SET statement_timeout = 0;

--Info

--SELECT * FROM title_akas_copy WHERE types IS NULL;
--SELECT DISTINCT region FROM title_akas_copy;
--SELECT DISTINCT title_language FROM title_akas_copy;
--SELECT DISTINCT types FROM title_akas_copy;

--Considering that 95% of the rows have the column 'attributes' with NULL values and that it doesn't provide significant information, 
--only a minor indication about the title that can be easily seen, we are going to remove this column.
ALTER TABLE title_akas_copy DROP COLUMN attributes;

--Given that we have 249 different regions and 108 languages, reviewing line by line which region each title belongs to and assigning the corresponding language 
--would even be a separate project, therefore we will leave it as unknown.

UPDATE title_akas_copy
SET region = 'Unkown Region' WHERE region IS NULL;

UPDATE title_akas_copy 
SET title_language = 'Unkown Language' WHERE title_language IS NULL;

UPDATE title_akas_copy 
SET types = 'Unkown Type' WHERE types IS NULL;