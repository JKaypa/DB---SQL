SELECT
	movie.id AS movie_id,
	movie.title,
	movie.release_date,
	movie.duration,
	movie.description,
	JSON_BUILD_OBJECT(
		'poster_id',
		poster.id,
		'name',
		poster.name,
		'mime_type',
		poster.mime_type,
		'key',
		poster.key,
		'url',
		poster.url
	) AS poster,
	JSON_BUILD_OBJECT(
		'director_id',
		director.id,
		'first_name',
		director.first_name,
		'last_name',
		director.last_name
	) AS director
FROM
	movie
	LEFT JOIN file AS poster ON movie.poster_id = poster.id
	LEFT JOIN person AS director ON movie.director_id = director.id
	LEFT JOIN movie_genres ON movie_genres.movie_id = movie.id
	LEFT JOIN genre ON movie_genres.genre_id = genre.id
WHERE
	movie.country_id = 1
	AND movie.release_date > '2022-01-01'
	AND movie.duration > '2 hours 15 minutes'
	AND genre.name IN ('action', 'drama')
GROUP BY
	movie.id,
	poster.id,
	director.id