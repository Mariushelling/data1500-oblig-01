-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller

CREATE TABLE Kunde (
  kunde_id SERIAL PRIMARY KEY,
  mobilnummer VARCHAR(15) NOT NULL,
  epost VARCHAR(100) NOT NULL,
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
  stasjon_id INTEGER NOT NULL,
  laas_nummer INTEGER NOT NULL,
  CHECK (laas_nummer > 0),
  FOREIGN KEY (stasjon_id) REFERENCES Stasjon(stasjon_id)
  );

CREATE TABLE Sykkel (
  sykkel_id SERIAL PRIMARY KEY,
  tatt_i_bruk_dato DATE NOT NULL,
  stasjon_id INTEGER,
  laas_id INTEGER,
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



-- DBA setninger (rolle: kunde, bruker: kunde_1)



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
