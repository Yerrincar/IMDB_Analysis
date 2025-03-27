DROP TABLE IF EXISTS actor_basics;
DROP TABLE IF EXISTS title_akas;
DROP TABLE IF EXISTS title_basics;
DROP TABLE IF EXISTS title_crew;
DROP TABLE IF EXISTS title_episode;
DROP TABLE IF EXISTS title_principals;
DROP TABLE IF EXISTS title_ratings;
DROP TABLE IF EXISTS title_episode;
/*
Para insertar los archivos se ha utilizado el comando \copy actor_basics FROM 'path' WITH (FORMAT text, DELIMITER E'\t', HEADER);
El intento inicial de hacerlo cambiando el formato primero a csv generaba problemas con la codificación generando caracteres
incorrectamente codificados. En el caso de necesitar los datos en un excel, se podrá realizar la exportación a posteriori.
*/
CREATE TABLE actor_basics(
	actor_id VARCHAR,
	nombre VARCHAR,
	birth_year VARCHAR, 
	death_year VARCHAR,
	profesion VARCHAR,
	knownForTitles VARCHAR
	);

CREATE TABLE title_akas(
	title_id VARCHAR,
	ordering INT,
	title VARCHAR,
	region VARCHAR,
	title_language VARCHAR,
	types VARCHAR,
	attributes VARCHAR,
	isOriginalTitle BOOLEAN
	);

CREATE TABLE title_basics(
	title_id VARCHAR,
	titleType VARCHAR,
	primaryTitle VARCHAR,
	originalTitle VARCHAR,
	isAdult BOOLEAN, 
	startYear VARCHAR,
	endYear VARCHAR,
	runtimeMinutes VARCHAR,
	genres VARCHAR
	);

CREATE TABLE title_crew(
	title_id VARCHAR,
	directors VARCHAR,
	writers VARCHAR
	);
	
CREATE TABLE title_episode(
	title_id VARCHAR,
	parentTconst VARCHAR,
	seasonNumber VARCHAR,
	episodeNumber VARCHAR
	);
	
CREATE TABLE title_principals(
	title_id VARCHAR,
	orderin INT,
	actor_id VARCHAR,
	category VARCHAR,
	job VARCHAR,
	characters VARCHAR
	);

CREATE TABLE title_ratings(
	title_id VARCHAR,
	averageRating FLOAT,
	numVotes INT
	);
	