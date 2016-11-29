DROP TABLE IF EXISTS users

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Hugh', 'Jackman'), ('Bob', 'Saget'), ('Larry', 'Cucumber');

DROP TABLE IF EXISTS questions

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('What Is Life', 'this is gibberish body', (SELECT id FROM users WHERE fname = 'Hugh')),
  ('What Is Death', 'this is also gibberish body', (SELECT id FROM users WHERE fname = 'Bob')),
  ('What Is After Life', 'this is the last gibberish body', (SELECT id FROM users WHERE fname = 'Larry'));

DROP TABLE IF EXISTS question_follows

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows(follower_id, question_id)
VALUES
  (1, 1), (1, 2), (1, 3), (2, 3);

DROP TABLE IF EXISTS replies

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 1, 'this is my reply'),
  (1, 1, 2, 'you are wrong'),
  (2, NULL, 3, 'Not sure');

DROP TABLE IF EXISTS question_likes

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  liker_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  liked_question BOOLEAN DEFAULT FALSE,

  FOREIGN KEY (liker_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_likes(liker_id, question_id, liked_question)
VALUES
  (1, 1, true), (2, 1, true), (3, 1, true), (2, 2, true);
