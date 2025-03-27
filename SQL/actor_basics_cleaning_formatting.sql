--Data Cleaning and formatting of Actor Basics Dataset
--SELECT * FROM actor_basics_copy;
--SELECT * FROM actor_basics_copy WHERE birth_year IS NULL AND death_year IS NOT NULL;
SET statement_timeout = 0;

-- Let's see how many people has no info in the birth and death fields.info and people without
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

--Vamos a sustitur la columna knownfortitles, que contiene los ids de las películas, por el titulo de la película al que corresponde
-- Primero probamos la lógica para no modificar la tabla sin estar seguros
SELECT a.actor_id, STRING_AGG(tb.primarytitle, ',') AS titulos_conocidos
FROM actor_basics_copy a
	CROSS JOIN LATERAL UNNEST(STRING_TO_ARRAY(a.knownfortitles, ',')) AS split_ids(title_id)
	JOIN title_basics_copy tb ON tb.title_id = split_ids.title_id
GROUP BY a.actor_id;

--Una vez vemos que sale bien, hacemos el UPDATE. Vamos a realizar una subquery donde vamos a hacer uso de varias funciones:
--STRING_AGG para concatenar la lista de string con separador ','
--STRING_TO_ARRAY donde vamos a convert el string en una lista de arrays separada por ,
--Con UNNEST vamos a separar cada elemento de esa lista en filas separadas
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
--Como podemos comprobar, hay 1,631,323 registros de personas donde, no tenemos info de sus fechas, la mayoría de 
--sus profesiones están sin informar y no tienen ningún título de película con el que relacionarlos. Dicho de otro modo,
--son datos que no nos aportan nada por lo que van a ser eliminados. 

--En este caso vamos a eliminar solo las filas que tengan profesión NULL, pues de poco sirve saber que película hicieron
--sin saber su trabajo, y titulos en NULL, pues de nada nos sirve si no sabemos en que película participó.
DELETE FROM actor_basics_copy WHERE knownfortitles IS NULL OR profesion IS NULL;