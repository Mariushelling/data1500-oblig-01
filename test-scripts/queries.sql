-- ============================================================================
-- TEST-SKRIPT FOR OBLIG 1
-- ============================================================================

-- Oppgave 5.1
SELECT * FROM Sykkel;

-- Oppgave 5.2
SELECT etternavn, fornavn, mobilnummer
FROM Kunde
ORDER BY etternavn ASC;

-- Oppgave 5.3
SELECT *
FROM Sykkel
WHERE tatt_i_bruk_dato > '2026-02-26';

-- Oppgave 5.4
SELECT COUNT(*) AS antall_kunder
FROM Kunde;

-- Oppgave 5.5
SELECT 
    k.kunde_id,
    k.fornavn,
    k.etternavn,
    COUNT(u.utleie_id) AS antall_utleier
FROM Kunde k
LEFT JOIN Utleie u ON k.kunde_id = u.kunde_id
GROUP BY k.kunde_id, k.fornavn, k.etternavn
ORDER BY k.kunde_id;

-- Oppgave 5.6
SELECT 
    k.kunde_id,
    k.fornavn,
    k.etternavn
FROM Kunde k
LEFT JOIN Utleie u ON k.kunde_id = u.kunde_id
WHERE u.utleie_id IS NULL;

-- Oppgave 5.7
SELECT 
    s.sykkel_id,
    s.tatt_i_bruk_dato
FROM Sykkel s
LEFT JOIN Utleie u ON s.sykkel_id = u.sykkel_id
WHERE u.utleie_id IS NULL;

-- Oppgave 5.8
SELECT 
    u.utleie_id,
    u.sykkel_id,
    k.fornavn,
    k.etternavn,
    u.utlevert_tid
FROM Utleie u
JOIN Kunde k ON u.kunde_id = k.kunde_id
WHERE u.innlevert_tid IS NULL
  AND u.utlevert_tid < NOW() - INTERVAL '1 day';

Noen spørringer kan gi 0 rader med dagens testdata, men spørringene er forsatt korrekte og kjører uten feil.
