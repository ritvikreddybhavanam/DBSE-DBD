USE movie_analytics_db;

INSERT INTO actors
(first_name, last_name, birth_date, gender, nationality, biography)
VALUES
('Leonardo', 'DiCaprio', '1974-11-11', 'Male', 'American',
 'Academy Award-winning actor known for Inception and Titanic.'),

('Robert', 'Downey Jr.', '1965-04-04', 'Male', 'American',
 'Known for playing Iron Man in the Marvel Cinematic Universe.'),

('Keanu', 'Reeves', '1964-09-02', 'Male', 'Canadian',
 'Famous for The Matrix and John Wick series.'),

('Scarlett', 'Johansson', '1984-11-22', 'Female', 'American',
 'Known for Black Widow and Marriage Story.'),

('Christian', 'Bale', '1974-01-30', 'Male', 'British',
 'Known for The Dark Knight trilogy.');

SELECT * FROM actors;