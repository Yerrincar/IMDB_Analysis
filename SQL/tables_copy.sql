-- Creation of a copy for each of our tables just in case we mess up. Another recomendation is creating backups as we
-- move forward.
SET statement_timeout = 0;
DROP TABLE IF EXISTS actor_basics_copy;
DROP TABLE IF EXISTS title_akas_copy;
DROP TABLE IF EXISTS title_basics_copy;
DROP TABLE IF EXISTS title_crew_copy;
DROP TABLE IF EXISTS title_episode_copy;
DROP TABLE IF EXISTS title_principals_copy;
DROP TABLE IF EXISTS title_ratings_copy;
DROP TABLE IF EXISTS title_episode_copy;
CREATE TABLE actor_basics_copy AS TABLE actor_basics;
CREATE TABLE title_akas_copy AS TABLE title_akas;
CREATE TABLE title_basics_copy AS TABLE title_basics;
CREATE TABLE title_crew_copy AS TABLE title_crew;
CREATE TABLE title_episode_copy AS TABLE title_episode;
CREATE TABLE title_principals_copy AS TABLE title_principals;
CREATE TABLE title_ratings_copy AS TABLE title_ratings;


	