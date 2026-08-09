USE movie_analytics_db;

INSERT INTO movie_genres
(movie_id, genre_id)
VALUES

(1,10),   -- Interstellar → Sci-Fi
(1,5),    -- Interstellar → Drama

(2,10),   -- Inception → Sci-Fi
(2,11),   -- Inception → Thriller

(3,2),    -- Avatar → Adventure
(3,10),   -- Avatar → Sci-Fi

(4,5),    -- Titanic → Drama
(4,9);    -- Titanic → Romance

SELECT * FROM movie_genres;

SELECT
    m.title,
    g.genre_name
FROM movie_genres mg
JOIN movies m
    ON mg.movie_id = m.movie_id
JOIN genres g
    ON mg.genre_id = g.genre_id
ORDER BY m.title;