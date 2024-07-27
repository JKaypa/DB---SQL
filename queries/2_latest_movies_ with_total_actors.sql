SELECT
	movie.id AS movie_id,
	movie.title,
	COUNT(person.id) AS total_actors
FROM
	movie
	JOIN movie_actors ON movie.id = movie_actors.movie_id
	JOIN person ON person.id = movie_actors.actor_id
WHERE 
	movie.release_date > '2019-01-01'
GROUP BY
	movie.id,
	movie.title
