USE movie_analytics_db;

INSERT INTO genres (genre_name, description)
VALUES
('Action', 'Movies with exciting sequences and combat.'),
('Adventure', 'Movies involving exploration and journeys.'),
('Comedy', 'Movies intended to entertain with humor.'),
('Crime', 'Movies based on criminal activities.'),
('Drama', 'Movies focusing on emotional storytelling.'),
('Fantasy', 'Movies featuring magical or supernatural elements.'),
('Horror', 'Movies designed to frighten audiences.'),
('Mystery', 'Movies involving investigations and suspense.'),
('Romance', 'Movies centered around love stories.'),
('Sci-Fi', 'Movies based on science and futuristic concepts.'),
('Thriller', 'Movies filled with suspense and excitement.');

SELECT * FROM genres;