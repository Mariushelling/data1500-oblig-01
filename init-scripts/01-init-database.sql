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
  registrert_tid TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP,
  CHECK (epost LIKE '%@%')
  );


  



-- Sett inn testdata



-- DBA setninger (rolle: kunde, bruker: kunde_1)



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;
