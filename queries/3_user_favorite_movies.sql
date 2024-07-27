SELECT
	user_account.id AS user_id,
	username,
	array_agg(movie.id) movie_id
FROM
	user_account
	lEFT JOIN user_favorite_movies ON user_account.id = user_favorite_movies.user_id
	LEFT JOIN movie ON movie.id = user_favorite_movies.movie_id
GROUP BY
	user_account.id
