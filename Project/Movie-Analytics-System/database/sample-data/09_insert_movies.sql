USE movie_analytics_db;

INSERT INTO movies
(
title,
description,
release_date,
runtime,
language,
country,
budget,
revenue,
imdb_rating,
average_rating,
poster_url,
backdrop_url,
trailer_url,
director_id
)
VALUES

(
'Interstellar',
'A science fiction film about space exploration.',
'2014-11-07',
169,
'English',
'USA',
165000000.00,
701800000.00,
8.7,
0.0,
'images/posters/interstellar.jpg',
'images/backgrounds/interstellar.jpg',
'https://youtu.be/zSWdZVtXT7E',
1
),

(
'Inception',
'A thief steals secrets through dream-sharing technology.',
'2010-07-16',
148,
'English',
'USA',
160000000.00,
839000000.00,
8.8,
0.0,
'images/posters/inception.jpg',
'images/backgrounds/inception.jpg',
'https://youtu.be/YoHD9XEInc0',
1
),

(
'Avatar',
'Humans explore the planet Pandora.',
'2009-12-18',
162,
'English',
'USA',
237000000.00,
2923706026.00,
7.9,
0.0,
'images/posters/avatar.jpg',
'images/backgrounds/avatar.jpg',
'https://youtu.be/5PSNL1qE6VY',
2
),

(
'Titanic',
'A love story aboard the Titanic.',
'1997-12-19',
194,
'English',
'USA',
200000000.00,
2264162353.00,
7.9,
0.0,
'images/posters/titanic.jpg',
'images/backgrounds/titanic.jpg',
'https://youtu.be/kVrqfYjkTdQ',
2
);

SELECT * FROM movies;

SELECT
    m.movie_id,
    m.title,
    CONCAT(d.first_name, ' ', d.last_name) AS director
FROM movies m
JOIN directors d
ON m.director_id = d.director_id;