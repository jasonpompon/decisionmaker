CREATE DATABASE decisionmaking;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(400),
  email TEXT,
  password_digest VARCHAR(400)
);

CREATE TABLE questions (
  id SERIAL4 PRIMARY KEY,
  content TEXT,
  time TIMESTAMP,
  user_id INTEGER
);

CREATE TABLE answers (
  id SERIAL4 PRIMARY KEY,
  option TEXT,
  question_id INTEGER,
  vote INTEGER
);


CREATE TABLE user_votes (
  id SERIAL4 PRIMARY Key,
  user_id INTEGER,
  answer_id INTEGER
);
