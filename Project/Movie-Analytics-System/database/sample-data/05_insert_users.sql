USE movie_analytics_db;

INSERT INTO users
(first_name, last_name, username, email, password, phone, role)
VALUES
('Admin', 'User', 'admin', 'admin@example.com', 'admin123', '9876543210', 'ADMIN'),

('John', 'Doe', 'johndoe', 'john@example.com', 'john123', '9876543211', 'USER'),

('Priya', 'Sharma', 'priya', 'priya@example.com', 'priya123', '9876543212', 'USER'),

('Rahul', 'Verma', 'rahul', 'rahul@example.com', 'rahul123', '9876543213', 'USER');

SELECT * FROM users;