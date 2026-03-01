-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller

CREATE TABLE Kunde (
  kunde_id SERIAL PRIMARY KEY,
  mobilnummer VARCHAR(15) NOT NULL UNIQUE,
  epost VARCHAR(100) NOT NULL UNIQUE,
  fornavn VARCHAR(50) NOT NULL,
  etternavn VARCHAR(50) NOT NULL,
  registrert_tid TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHECK (epost LIKE '%@%')
  );

CREATE TABLE Stasjon ( 
  stasjon_id SERIAL PRIMARY KEY,
  navn VARCHAR(100) NOT NULL,
  adresse VARCHAR(100) NOT NULL
  );

CREATE TABLE Laas (
  laas_id SERIAL PRIMARY KEY,
  stasjon_id INTEGER NOT NULL UNIQUE,
  laas_nummer INTEGER NOT NULL UNIQUE,
  CHECK (laas_nummer > 0),
  FOREIGN KEY (stasjon_id) REFERENCES Stasjon(stasjon_id)
  );

CREATE TABLE Sykkel (
  sykkel_id SERIAL PRIMARY KEY,
  tatt_i_bruk_dato DATE NOT NULL,
  stasjon_id INTEGER,
  laas_id INTEGER UNIQUE,
  FOREIGN KEY (stasjon_id) REFERENCES Stasjon(stasjon_id),
  FOREIGN KEY (laas_id) REFERENCES Laas(laas_id)
  );

CREATE TABLE Utleie (
  utleie_id SERIAL PRIMARY KEY,
  kunde_id INTEGER NOT NULL,
  sykkel_id INTEGER NOT NULL,
  utlevert_tid TIMESTAMP NOT NULL,
  innlevert_tid TIMESTAMP,
  leie_sum NUMERIC (10,2) NOT NULL CHECK (leie_sum>=0),
  CHECK (innlevert_tid IS NULL OR  innlevert_tid > utlevert_tid),
  FOREIGN KEY (kunde_id) REFERENCES Kunde(kunde_id),
  FOREIGN KEY (sykkel_id) REFERENCES Sykkel(sykkel_id)
  );

-- Sett inn testdata

INSERT INTO Kunde (mobilnummer, epost, fornavn, etternavn)
VALUES
('94000011', 'anna.hansen@example.com', 'Anna', 'Hansen'),
('95000012', 'jonas.larsen@example.com', 'Jonas', 'Larsen'),
('96000013', 'emma.nilsen@example.com', 'Emma', 'Nilsen'),
('97000014', 'henrik.olsen@example.com', 'Henrik', 'Olsen'),
('98000015', 'sofia.johansen@example.com', 'Sofia', 'Johansen');

INSERT INTO Stasjon (navn, adresse)
VALUES
('Grünerløkka', 'Thorvald Meyers gate 10'),
('Majorstuen', 'Kirkeveien 64'),
('Tøyen', 'Tøyengata 2'),
('Bjørvika', 'Dronning Eufemias gate 15'),
('St. Hanshaugen', 'Ullevålsveien 47');

INSERT INTO Laas (stasjon_id, laas_nummer)
SELECT s.stasjon_id, l.nr
FROM generate_series(1,5) AS s(stasjon_id)
CROSS JOIN generate_series(1,20) AS l(nr);

INSERT INTO Sykkel (tatt_i_bruk_dato, stasjon_id, laas_id)
SELECT 
    CURRENT_DATE,
    l.stasjon_id,
    l.laas_id
FROM Laas l;

INSERT INTO Utleie (kunde_id, sykkel_id, utlevert_tid, innlevert_tid, leie_sum)
SELECT 
    (gs % 5) + 1 AS kunde_id,
    gs AS sykkel_id,
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    49.00
FROM generate_series(1,50) AS gs;


-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
