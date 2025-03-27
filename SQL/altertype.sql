/*
Algunas columnas de ciertas tablas tienen el valor \N que puede indicar que una película aún no tiene fecha de finalización, que un corto no tiene escritores y solo director que hace todo o simplemente
son valores nulos. Por el momento para insertar los datos vamos a cambiar ciertos tipos a VARCHAR para poder tener todo y ya luego decidir que hacer con este tipo de valores
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