CREATE TABLE cats (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,
  color VARCHAR(255) NOT NULL,
  breed VARCHAR(255) NOT NULL,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "26th and Guerrero"), (2, "Dolores and Market");

INSERT INTO
  humans (id, fname, lname, house_id)
VALUES
  (1, "Devon", "Watts", 1),
  (2, "Matt", "Rubens", 1),
  (3, "Ned", "Ruggeri", 2),
  (4, "Catless", "Human", NULL);

INSERT INTO
  cats (id, name, owner_id, color, breed)
VALUES
  (1, "Breakfast", 1, 'black', 'Persian'),
  (2, "Earl", 2, 'white', 'Maine'),
  (3, "Haskell", 3, 'black', 'Persian'),
  (4, "Markov", 3, 'brown', 'Ragdoll'),
  (5, "Stray Cat", NULL, 'black', 'Maine'),
  (6, "Breakfast", 1, 'white', 'Persian'),
  (7, "Earl2", 2, 'brown', 'Maine'),
  (8, "Haskell2", 3, 'black', 'Ragdoll'),
  (9, "Markov2", 3, 'black', 'Bengal'),
  (10, "Stray Cat", NULL, 'brown', 'Maine');
