/*
Some columns in certain tables contain the value \N, which may indicate that a movie doesn't yet have an end date, 
a short film has no writers and only a director who does everything, or simply represent null values. 
For now, in order to insert the data, we will change certain types to VARCHAR to keep everything, 
and later decide what to do with this kind of values.
*/
ALTER TABLE title_basics
  ALTER COLUMN endYear
  TYPE VARCHAR
  USING endYear::VARCHAR;
;

ALTER TABLE title_basics
  ALTER COLUMN runtimeMinutes
  TYPE VARCHAR
  USING runtimeMinutes::VARCHAR;
;
ALTER TABLE title_basics
  ALTER COLUMN startYear
  TYPE VARCHAR
  USING startYear::VARCHAR;
;
ALTER TABLE title_episode
  ALTER COLUMN seasonNumber
  TYPE VARCHAR
  USING seasonNumber::VARCHAR;
;
ALTER TABLE title_episode
  ALTER COLUMN episodeNumber
  TYPE VARCHAR
  USING episodeNumber::VARCHAR;
;