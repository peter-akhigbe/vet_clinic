/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals
WHERE name LIKE '%mon'
  OR (date_of_birth BETWEEN '2016-01-01' AND '2019-12-31')
  OR (neutered = TRUE AND escape_attempts < 3)
  OR name IN ('Agumon', 'Pikachu')
  OR (weight_kg > 10.5)
  OR (neutered = TRUE)
  OR name != 'Gabumon'
  OR (weight_kg BETWEEN 10.4 AND 17.3);

