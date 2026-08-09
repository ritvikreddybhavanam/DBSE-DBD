USE movie_analytics_db;

INSERT INTO directors
(first_name, last_name, birth_date, nationality, biography)
VALUES
('Christopher', 'Nolan', '1970-07-30', 'British-American',
 'Known for mind-bending science fiction films.'),

('James', 'Cameron', '1954-08-16', 'Canadian',
 'Director of Avatar and Titanic.'),

('Steven', 'Spielberg', '1946-12-18', 'American',
 'One of the most influential filmmakers in Hollywood.'),

('Quentin', 'Tarantino', '1963-03-27', 'American',
 'Known for non-linear storytelling and dialogue.');


SELECT * FROM directors;