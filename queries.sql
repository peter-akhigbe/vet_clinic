/*Queries that provide answers to the questions from all projects.*/
-- SELECT *
-- FROM animals
-- WHERE name LIKE '%mon'
--   OR (date_of_birth BETWEEN '2016-01-01' AND '2019-12-31')
--   OR (neutered = TRUE AND escape_attempts < 3)
--   OR name IN ('Agumon', 'Pikachu')
--   OR (weight_kg > 10.5)
--   OR (neutered = TRUE)
--   OR name != 'Gabumon'
--   OR (weight_kg BETWEEN 10.4 AND 17.3);

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Dec 31, 2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction, update the animals table by setting the species column to "unspecified":
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; -- Verify changes
ROLLBACK;
SELECT * FROM animals; -- Verify rollback

-- Inside a transaction, update the animals table by setting the species column to "digimon" for animals with names ending in "mon", and set it to "pokemon" for animals without a species already set:
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals; -- Verify changes
COMMIT;
SELECT * FROM animals; -- Verify changes persist after commit

-- Inside a transaction, delete all records in the animals table, and then roll back the transaction:
BEGIN;
DELETE FROM animals;
SELECT * FROM animals; -- Verify deletion
ROLLBACK;
SELECT * FROM animals; -- Verify rollback

-- Inside a transaction, delete all animals born after Jan 1st, 2022. Create a savepoint, update the weights to be multiplied by -1, and then rollback to the savepoint.
-- Finally, update negative weights to be multiplied by -1 and commit the transaction:
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals; -- Verify changes persist after commit

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type for those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- What animals belong to Melody Pond?
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List all animals that are Pokemon.
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animals.
SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.tried_to_escape = false;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT A.name, vets.name, V.date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY V.date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT V.name, COUNT(animals.id) AS "Number Of Animals"
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets V
ON visits.vet_id = V.id
WHERE V.name = 'Stephanie Mendez'
GROUP BY V.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, visits.date
FROM animals
JOIN visits
ON visits.animal_id = animals.id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT COUNT(visits.animal_id) AS VISITS
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY VISITS DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name, vets.name, V.date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY V.date ASC LIMIT 1;

-- Details for the most recent visit: animal information, vet information, and date of visit.
SELECT animals.* AS ANIMAL_INFORMATION, vets.* AS VET_INFORMATION, visits.date
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY visits.date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS "Number Of Visits With A Vet That Did Not Specialize In That Animal's Species"
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
LEFT JOIN specializations
ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT MAX(species.name) AS "Specialty Maisy Smith Should Consider Getting"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN species
ON animals.species_id = species.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.id ORDER BY COUNT(*) DESC LIMIT 1;





