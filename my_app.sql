CREATE DATABASE decisionmaking;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(400),
  email TEXT,
  password_digest VARCHAR(400)
);


CREATE TABLE questions (
  id SERIAL4 PRIMARY KEY,
  content TEXT
);


-- Manually inserting a question in the Database
INSERT INTO questions (content) VALUES ('What laptop should I buy for web development?');
