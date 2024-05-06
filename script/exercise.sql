DROP DATABASE IF EXISTS exercise;

CREATE DATABASE exercise;

\connect exercise; 

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_user_id ON messages(user_id);

INSERT INTO users (username, email, password) VALUES
    ('user1', 'user1@example.com', 'password1'),
    ('user2', 'user2@example.com', 'password2'),
    ('user3', 'user3@example.com', 'password3'),
    ('user4', 'user4@example.com', 'password4'),
    ('new_username', 'new_email@example.com', 'new_password');

INSERT INTO messages (user_id, content) VALUES
    (1, 'This is my first message'),
    (1, 'This is my second message'),
    (2, 'This is a message from user2'),
    (3, 'Message from user3'),
    (4, 'Message from user4'),
    (5, 'Another message from new_username');

UPDATE users
SET username = 'new_username'
WHERE id = 1;

DELETE FROM messages
WHERE id = 2;

SELECT u.username, m.content, m.created_at
FROM messages AS m
INNER JOIN users AS u ON m.user_id = u.id
WHERE u.username = 'new_username';

DELETE FROM users
WHERE id = 1;

EXPLAIN ANALYZE SELECT u.username, m.content, m.created_at
FROM messages AS m
INNER JOIN users AS u ON m.user_id = u.id
WHERE u.username = 'new_username';