/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23),
       ('Gabumon', '2018-11-15', 2, TRUE, 8.00),
       ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
       ('Devimon', '2017-05-12', 5, TRUE, 11.00);

-- UPDATE
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
  ('Charmander', '2020-02-08', 0, FALSE, -11.00, NULL),
  ('Plantmon', '2021-11-15', 2, TRUE, -5.7, NULL),
  ('Squirtle', '1993-04-02', 3, FALSE, -12.13, NULL),
  ('Angemon', '2005-06-12', 1, TRUE, -45.00, NULL),
  ('Boarmon', '2005-06-07', 7, TRUE, 20.40, NULL),
  ('Blossom', '1998-10-13', 3, TRUE, 17.00, NULL),
  ('Ditto', '2022-05-14', 4, TRUE, 22.00, NULL);
