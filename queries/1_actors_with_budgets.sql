SELECT
	actor.id AS actor_id,
	actor.first_name,
	actor.last_name,
	SUM(movie.budget) AS total_movies_budget
FROM
	person AS actor
	JOIN movie_actors ON actor.id = movie_actors.actor_id
	JOIN movie ON movie.id = movie_actors.movie_id
GROUP BY
	actor.id,
	actor.first_name,
	actor.last_name