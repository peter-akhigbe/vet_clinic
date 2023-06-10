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
  
-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

-- Update animals with species_id based on names
UPDATE animals
SET species_id = CASE
  WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
  ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

-- Update animals with owner_id based on owner's name
UPDATE animals
SET owner_id = CASE
  WHEN owner = 'Sam Smith' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHEN owner = 'Jennifer Orwell' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHEN owner = 'Bob' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
  WHEN owner = 'Melody Pond' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHEN owner = 'Dean Winchester' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHEN owner = 'Jodie Whittaker' THEN (SELECT id FROM owners WHERE full_name = 'Jodie Whittaker')
END;

-- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

-- Insert data for specialties
INSERT INTO specializations (vet_id, species_id) VALUES
  (1, 1),
  (3, 2),
  (3, 1),
  (4, 2);

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
  (1, 1, '2020-05-24'),
  (1, 3, '2020-07-22'),
  (2, 4, '2021-02-02'),
  (3, 2, '2020-01-05'),
  (3, 2, '2020-03-08'),
  (3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),
  (5, 4, '2021-02-24'),
  (6, 4, '2019-12-21'),
  (6, 1, '2020-08-10'),
  (6, 2, '2021-04-07'),
  (7, 3, '2019-09-29'),
  (8, 4, '2020-10-03'),
  (8, 4, '2020-11-04'),
  (9, 2, '2019-01-24'),
  (9, 2, '2019-05-15'),
  (9, 2, '2020-02-27'),
  (9, 2, '2020-08-03'),
  (10, 3, '2020-05-24'),
  (10, 1, '2021-01-11');

