SELECT
	director.id AS director_id,
	CONCAT(director.first_name, ' ', director.last_name) AS director_name,
	CAST(AVG(movie.budget) AS DEC(20, 2)) AS average_movies_budget
FROM
	person AS director
	JOIN movie ON movie.director_id = director.id
GROUP BY
	director.id