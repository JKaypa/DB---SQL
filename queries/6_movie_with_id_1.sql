SELECT
	movie.id AS movie,
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
		director.last_name,
		'photo',
		JSON_BUILD_OBJECT(
			'photo_id',
			director_photo.id,
			'name',
			director_photo.name,
			'mime_type',
			director_photo.mime_type,
			'key',
			director_photo.key,
			'url',
			director_photo.url
		)
	) AS director,
	JSONB_AGG(
		JSON_BUILD_OBJECT(
			'actor_id',
			actor.id,
			'first_name',
			actor.first_name,
			'last_name',
			actor.last_name,
			'photo',
			JSON_BUILD_OBJECT(
				'photo_id',
				actor_photo.id,
				'name',
				actor_photo.name,
				'mime_type',
				actor_photo.mime_type,
				'key',
				actor_photo.key,
				'url',
				actor_photo.url
			)
		)
	) AS actors,
	JSONB_AGG(
		JSON_BUILD_OBJECT('genre_id', genre_id, 'name', genre.name)
	) AS genres
FROM
	movie
	LEFT JOIN file AS poster ON movie.poster_id = poster.id
	LEFT JOIN person AS director ON movie.director_id = director.id
	LEFT JOIN file AS director_photo ON director.photo_id = director_photo.id
	LEFT JOIN actors_movies ON actors_movies.movie_id = movie.id
	LEFT JOIN person AS actor ON actors_movies.actor_id = actor.id
	LEFT JOIN file AS actor_photo ON actor.photo_id = actor_photo.id
	LEFT JOIN movie_genre ON movie_genre.movie_id = movie.id
	LEFT JOIN genre ON movie_genre.genre_id = genre.id
WHERE
	movie.id = 1
GROUP BY
	movie.id,
	poster.id,
	director.id,
	director_photo.id

