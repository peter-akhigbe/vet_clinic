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
INSERT INTO vets(name, age, date_of_graduation)
VALUES('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Insert data for specialties
INSERT INTO specializations(species_id, vet_id)
VALUES((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

-- Insert data for visits
INSERT INTO visits(animal_id, vet_id, date)
VALUES((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May 24, 2020'),
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Jul 22, 2020'),
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Sep 29, 2019'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
