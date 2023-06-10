/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

\c vet_clinic

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(5, 2)
);

-- Add a column species of type string to your animals table.
ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

-- Create the owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

-- Create the species table
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Modify the animals table
ALTER TABLE animals
  DROP COLUMN species,
  ADD COLUMN species_id INTEGER REFERENCES species(id),
  ADD COLUMN owner_id INTEGER REFERENCES owners(id);


