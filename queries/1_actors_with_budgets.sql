SELECT
	actor.id AS actor_id,
	actor.first_name,
	actor.last_name,
	SUM(movie.budget) AS total_movie_budget
FROM
	person AS actor
	JOIN actors_movies ON actor.id = actors_movies.actor_id
	JOIN movie ON movie.id = actors_movies.movie_id
GROUP BY
	actor.id,
	actor.first_name,
	actor.last_name