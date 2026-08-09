USE movie_analytics_db;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    username VARCHAR(50) NOT NULL UNIQUE,

    email VARCHAR(100) NOT NULL UNIQUE,

    password VARCHAR(255) NOT NULL,

    phone VARCHAR(15),

    profile_image VARCHAR(255),

    bio TEXT,

    role ENUM('USER', 'ADMIN') DEFAULT 'USER',

    is_verified BOOLEAN DEFAULT FALSE,

    status ENUM('ACTIVE', 'BLOCKED') DEFAULT 'ACTIVE',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE users;

CREATE TABLE directors (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    birth_date DATE,

    nationality VARCHAR(50),

    biography TEXT,

    profile_image VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE directors;

CREATE TABLE actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    birth_date DATE,

    gender ENUM('Male','Female','Other'),

    nationality VARCHAR(50),

    biography TEXT,

    profile_image VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE actors;


CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,

    genre_name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

DESCRIBE genres;


CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(255) NOT NULL,

    description TEXT,

    release_date DATE,

    runtime INT,

    language VARCHAR(50),

    country VARCHAR(100),

    budget DECIMAL(15,2),

    revenue DECIMAL(15,2),

    imdb_rating DECIMAL(3,1),

    average_rating DECIMAL(3,1) DEFAULT 0.0,

    poster_url VARCHAR(255),

    backdrop_url VARCHAR(255),

    trailer_url VARCHAR(255),

    director_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_movies_director
        FOREIGN KEY (director_id)
        REFERENCES directors(director_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DESCRIBE movies;

SHOW CREATE TABLE movies;


CREATE TABLE movie_genres (

    movie_genre_id INT AUTO_INCREMENT PRIMARY KEY,

    movie_id INT NOT NULL,

    genre_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_movie_genres_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_movie_genres_genre
        FOREIGN KEY (genre_id)
        REFERENCES genres(genre_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT uq_movie_genre
        UNIQUE(movie_id, genre_id)

);

DESCRIBE movie_genres;

SHOW CREATE TABLE movie_genres;